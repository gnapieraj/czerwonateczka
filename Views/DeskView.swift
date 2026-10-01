import SwiftUI

struct DeskView: View {
    @EnvironmentObject private var store: GameStore
    @EnvironmentObject private var soundtrack: Soundtrack
    var body: some View {
        ZStack {
            StageBackground(image: "Biurko", dim: 0.82)
            GeometryReader { proxy in
                let wide = proxy.size.width > 1000
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        deskTools
                        if wide {
                            HStack(alignment: .top, spacing: 20) {
                                VStack(alignment: .leading, spacing: 16) {
                                    habitStrip
                                        .padding(.horizontal, 16)
                                    seasonChoice
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                VStack(alignment: .leading, spacing: 16) {
                                    todayCTA
                                    wokandaList
                                }
                                .frame(maxWidth: .infinity, alignment: .topLeading)
                            }
                        } else {
                            habitStrip
                                .padding(.horizontal, 16)
                            seasonChoice
                            todayCTA
                            wokandaList
                        }
                    }
                    .frame(maxWidth: wide ? 1180 : 840)
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .clipped()
    }

    private var deskTools: some View {
        HStack(spacing: 2) {
            Button {
                store.openHowToPlay()
            } label: {
                HStack(spacing: 6) {
                    Image(systemName: "list.number")
                        .font(.body)
                    Text(Copy.s(store.language, pl: "Jak czytać grę", en: "How to read"))
                        .font(Typeface.mono(16))
                        .lineLimit(1)
                        .minimumScaleFactor(0.75)
                }
                .foregroundStyle(Noir.paper)
                .padding(.horizontal, 8)
                .frame(minHeight: 44)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .accessibilityLabel(Copy.s(
                store.language,
                pl: "Jak czytać grę",
                en: "How to read the game"
            ))

            Button {
                store.openBible()
            } label: {
                Image(systemName: "person.3.sequence")
                    .font(.body)
                    .foregroundStyle(Noir.paper)
                    .frame(width: 44, height: 44)
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .accessibilityLabel(Copy.s(
                store.language,
                pl: "Obsada — biblia wizualna",
                en: "Cast — visual bible"
            ))

            Spacer(minLength: 8)

            Button {
                soundtrack.toggleMuted()
            } label: {
                Image(systemName: soundtrack.isMuted ? "speaker.slash.fill" : "speaker.wave.2.fill")
                    .font(.body)
                    .foregroundStyle(soundtrack.isMuted ? Noir.blood : Noir.paper)
                    .frame(width: 44, height: 44)
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .accessibilityLabel(Copy.s(
                store.language,
                pl: soundtrack.isMuted ? "Włącz muzykę" : "Wycisz muzykę",
                en: soundtrack.isMuted ? "Unmute music" : "Mute music"
            ))
            Button {
                store.openSettings()
            } label: {
                Image(systemName: "gearshape")
                    .font(.body)
                    .foregroundStyle(Noir.paper)
                    .frame(width: 44, height: 44)
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .accessibilityLabel(Copy.s(
                store.language,
                pl: "Ustawienia",
                en: "Settings"
            ))
        }
        .padding(.leading, 8)
        .padding(.trailing, 8)
        .padding(.top, 4)
    }

    private var seasonLessons: [Lesson] {
        store.seasonSections.first { $0.id == store.selectedSeasonId }?.lessons ?? []
    }

    private var seasonHabits: [DocketHabit] {
        let ids = Set(seasonLessons.map(\.id))
        return DocketHabit.all.filter { ids.contains($0.lessonId) }
    }

    private var habitStrip: some View {
        let habits = seasonHabits
        let earned = habits.filter { habit in
            store.lessons.first { $0.id == habit.lessonId }.flatMap { store.stamp(for: $0) } != nil
        }.count
        return VStack(alignment: .leading, spacing: 6) {
            HStack(alignment: .firstTextBaseline) {
                Text(Copy.s(store.language, pl: "NAWYKI", en: "HABITS"))
                    .font(Typeface.mono(13))
                    .tracking(1.4)
                    .foregroundStyle(Noir.blood)
                Spacer(minLength: 8)
                Text("\(earned) / \(habits.count)")
                    .font(Typeface.mono(13))
                    .foregroundStyle(Noir.paperDim)
            }
            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible(), spacing: 4, alignment: .leading), count: 4),
                alignment: .leading,
                spacing: 4
            ) {
                ForEach(habits) { habit in
                    habitMark(habit)
                }
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Noir.ink)
        .overlay(Rectangle().stroke(Color.white.opacity(0.28), lineWidth: 1))
    }

    private var seasonChoice: some View {
        Color.clear
            .aspectRatio(16 / 9, contentMode: .fit)
            .overlay {
                HStack(spacing: 0) {
                    seasonHalf(
                        id: "0",
                        image: "SezonMecenas",
                        eyebrow: Copy.s(store.language, pl: "SEZON 0", en: "SEASON 0"),
                        name: Copy.s(store.language, pl: "Mecenas", en: "Counsel")
                    )
                    Rectangle()
                        .fill(Noir.blood)
                        .frame(width: 3)
                    seasonHalf(
                        id: "1",
                        image: "SezonAplikant",
                        eyebrow: Copy.s(store.language, pl: "SEZON 1", en: "SEASON 1"),
                        name: Copy.s(store.language, pl: "Aplikant", en: "Associate")
                    )
                }
            }
            .clipShape(Rectangle())
            .overlay(Rectangle().stroke(Color.white.opacity(0.85), lineWidth: 2))
            .shadow(color: Noir.blood.opacity(0.25), radius: 0, x: 3, y: 3)
            .padding(.horizontal, 16)
            .accessibilityElement(children: .contain)
    }

    private func seasonHalf(id: String, image: String, eyebrow: String, name: String) -> some View {
        let selected = store.selectedSeasonId == id
        return Button {
            store.selectSeason(id)
        } label: {
            ZStack(alignment: .bottomLeading) {
                CroppedImage(name: image)
                if !selected {
                    Color.black.opacity(0.52)
                }
                VStack(alignment: .leading, spacing: 2) {
                    Text(eyebrow)
                        .font(Typeface.mono(12))
                        .tracking(1.6)
                        .foregroundStyle(Noir.blood)
                    Text(name)
                        .font(Typeface.display(26))
                        .foregroundStyle(Noir.paper)
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    LinearGradient(
                        colors: [.clear, .black.opacity(selected ? 0.88 : 0.72)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel(Copy.s(
            store.language,
            pl: "\(eyebrow), \(name)",
            en: "\(eyebrow), \(name)"
        ))
        .accessibilityAddTraits(selected ? .isSelected : [])
    }

    private var wokandaList: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(Copy.s(store.language, pl: "WOKANDA", en: "DOCKET"))
                .font(Typeface.mono(16))
                .tracking(2)
                .foregroundStyle(Noir.paperDim)
                .padding(.horizontal, 16)
                .padding(.top, 4)

            if let section = store.seasonSections.first(where: { $0.id == store.selectedSeasonId }) {
                Text(section.title.t(store.language).uppercased())
                    .font(Typeface.mono(14))
                    .tracking(1.5)
                    .foregroundStyle(Noir.blood)
                    .padding(.horizontal, 16)
                    .padding(.top, 8)

                VStack(spacing: 10) {
                    ForEach(section.lessons) { lesson in
                        FolderCard(lesson: lesson)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 40)
            }
        }
    }

    @ViewBuilder
    private var todayCTA: some View {
        let next = seasonLessons.first { store.stamp(for: $0) == nil }
        if let today = next, store.canPlay(today) {
            Button {
                store.open(today)
            } label: {
                VStack(alignment: .leading, spacing: 8) {
                    Text(Copy.s(store.language, pl: "TEJ NOCY", en: "TONIGHT"))
                        .font(Typeface.mono(16))
                        .tracking(2)
                        .foregroundStyle(Noir.blood)
                    Text(today.title.t(store.language))
                        .font(Typeface.display(32))
                        .foregroundStyle(Noir.paper)
                        .lineSpacing(4)
                        .fixedSize(horizontal: false, vertical: true)
                    Text(Copy.s(
                        store.language,
                        pl: "Otwórz teczkę →  ·  \(store.streak) z rzędu",
                        en: "Open the file →  ·  \(store.streak) in a row"
                    ))
                    .font(Typeface.body(20))
                    .foregroundStyle(Noir.paper)
                    .fixedSize(horizontal: false, vertical: true)
                }
                .padding(18)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Noir.ink)
                .overlay(Rectangle().stroke(Noir.blood, lineWidth: 3))
            }
            .buttonStyle(.plain)
            .padding(.horizontal, 16)
        } else if next != nil {
            VStack(alignment: .leading, spacing: 8) {
                Text(Copy.s(store.language, pl: "ZAMKNIĘTE", en: "CLOSED"))
                    .font(Typeface.mono(16))
                    .tracking(2)
                    .foregroundStyle(Noir.blood)
                Text(Copy.s(
                    store.language,
                    pl: "Ten sezon otwiera się po ostatniej nocy poprzedniego.",
                    en: "This season opens after the last night of the one before it."
                ))
                .font(Typeface.body(20))
                .foregroundStyle(Noir.paper)
                .fixedSize(horizontal: false, vertical: true)
            }
            .padding(18)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Noir.ink)
            .overlay(Rectangle().stroke(Color.white.opacity(0.28), lineWidth: 1))
            .padding(.horizontal, 16)
        } else if !seasonLessons.isEmpty {
            VStack(alignment: .leading, spacing: 8) {
                Text(Copy.s(store.language, pl: "SEZON ZAMKNIĘTY", en: "SEASON CLOSED"))
                    .font(Typeface.mono(16))
                    .tracking(2)
                    .foregroundStyle(Noir.blood)
                Text(Copy.s(
                    store.language,
                    pl: "Wszystkie noce tego sezonu mają stempel. Druga połowa obrazu prowadzi dalej.",
                    en: "Every night in this season is stamped. The other half of the picture leads on."
                ))
                .font(Typeface.body(20))
                .foregroundStyle(Noir.paper)
                .fixedSize(horizontal: false, vertical: true)
            }
            .padding(18)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Noir.ink)
            .overlay(Rectangle().stroke(Color.white.opacity(0.28), lineWidth: 1))
            .padding(.horizontal, 16)
        }
    }

    private func habitMark(_ habit: DocketHabit) -> some View {
        let verdict = store.lessons.first { $0.id == habit.lessonId }.flatMap { store.stamp(for: $0)?.verdict }
        let ink: Color = switch verdict {
        case .sound: Noir.paper
        case .unsound: Noir.blood
        case .incomplete: Noir.paperDim
        case nil: Noir.mist
        }
        return HStack(spacing: 4) {
            RoundedRectangle(cornerRadius: 1)
                .fill(verdict == nil ? Color.clear : ink)
                .overlay(RoundedRectangle(cornerRadius: 1).stroke(ink, lineWidth: 1))
                .frame(width: 9, height: 9)
            Text(habit.name.t(store.language).uppercased())
                .font(Typeface.mono(11))
                .foregroundStyle(ink)
                .lineLimit(1)
                .minimumScaleFactor(0.65)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(minHeight: 18)
    }
}

struct FolderCard: View {
    @EnvironmentObject private var store: GameStore
    let lesson: Lesson

    private var isCurrent: Bool { store.isCurrentNight(lesson) }
    private var isLocked: Bool { !store.canPlay(lesson) }
    private var isDone: Bool { store.stamp(for: lesson) != nil }

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            ZStack {
                CroppedImage(name: lesson.hero)
                    .frame(width: 72, height: 96)
                if let mark = store.stamp(for: lesson) {
                    WaxStamp(verdict: mark.verdict, language: store.language)
                        .scaleEffect(0.72)
                }
                if isLocked {
                    Color.black.opacity(0.45)
                    Image(systemName: "lock.fill")
                        .font(.title2)
                        .foregroundStyle(Noir.paperDim)
                }
            }
            .frame(width: 72, height: 96)
            .clipped()
            .overlay(Rectangle().stroke(Noir.paperDim, lineWidth: 1))
            .onTapGesture { playIfAllowed() }
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 8) {
                    Text(String(format: "%02d", lesson.order))
                        .font(Typeface.mono(16))
                        .foregroundStyle(Noir.paperDim)
                    if lesson.tone == .probono {
                        Text("PRO BONO")
                            .font(Typeface.mono(16))
                            .foregroundStyle(Noir.paper)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Noir.blood)
                    }
                    if let mark = store.stamp(for: lesson) {
                        Text(mark.verdict.label(store.language))
                            .font(Typeface.mono(16))
                            .foregroundStyle(mark.verdict == .sound ? Noir.void : Noir.paper)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(mark.verdict == .sound ? Noir.paper : Noir.blood)
                    } else if isCurrent {
                        Text(Copy.s(store.language, pl: "NA BIURKU", en: "ON THE DESK"))
                            .font(Typeface.mono(16))
                            .foregroundStyle(Noir.void)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Noir.paper)
                    } else if isLocked {
                        Text(Copy.s(store.language, pl: "ZAMKNIĘTE", en: "LOCKED"))
                            .font(Typeface.mono(16))
                            .foregroundStyle(Noir.paperDim)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .overlay(Rectangle().stroke(Noir.paperDim, lineWidth: 1))
                    }
                }
                Text(lesson.title.t(store.language))
                    .font(Typeface.display(26))
                    .foregroundStyle(Noir.paperDim)
                    .lineSpacing(4)
                    .lineLimit(3)
                    .minimumScaleFactor(0.9)
                    .fixedSize(horizontal: false, vertical: true)
                Text(lesson.subtitle.t(store.language))
                    .font(Typeface.mono(18))
                    .foregroundStyle(Noir.paperDim)
                    .lineSpacing(4)
                    .fixedSize(horizontal: false, vertical: true)
                Text(lesson.deadline.t(store.language))
                    .font(Typeface.body(18))
                    .foregroundStyle(Noir.paperDim)
                    .lineSpacing(4)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .contentShape(Rectangle())
            .onTapGesture { playIfAllowed() }
            VStack(spacing: 12) {
                if !isLocked {
                    Button {
                        store.openAwareness(lesson)
                    } label: {
                        Image(systemName: "info.circle")
                            .font(.title2)
                            .foregroundStyle(Noir.paperDim)
                            .frame(width: 44, height: 44)
                            .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel(Copy.s(
                        store.language,
                        pl: "Briefing kancelaryjny",
                        en: "Firm briefing"
                    ))
                }
                Image(systemName: isLocked ? "lock.fill" : (isDone ? "checkmark.seal.fill" : "folder.fill"))
                    .foregroundStyle(
                        store.stamp(for: lesson)?.verdict == .unsound ? Noir.blood : Noir.paperDim
                    )
            }
            .padding(.top, 4)
        }
        .padding(16)
        .background(Noir.ink)
        .overlay(Rectangle().stroke(Color.white.opacity(0.25), lineWidth: 1))
        .contentShape(Rectangle())
        .opacity(isLocked ? 0.42 : 0.88)
        .allowsHitTesting(!isLocked)
        .accessibilityAddTraits(isLocked ? .isStaticText : .isButton)
    }

    private func playIfAllowed() {
        guard store.canPlay(lesson) else { return }
        store.open(lesson)
    }
}

struct WaxStamp: View {
    let verdict: DecisionVerdict
    let language: AppLanguage

    var body: some View {
        Text(verdict.label(language))
            .font(Typeface.mono(16))
            .tracking(0.6)
            .foregroundStyle(verdict == .sound ? Noir.void : Color.white)
            .padding(.horizontal, 5)
            .padding(.vertical, 4)
            .background(verdict == .sound ? Noir.paper : Noir.blood)
            .overlay(Rectangle().stroke(verdict == .sound ? Noir.void : Color.white, lineWidth: 1.5))
            .rotationEffect(.degrees(-14))
            .shadow(color: Color.black.opacity(0.45), radius: 0, x: 1, y: 1)
            .accessibilityHidden(true)
    }
}
