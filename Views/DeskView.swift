import SwiftUI

struct DeskView: View {
    @EnvironmentObject private var store: GameStore
    @EnvironmentObject private var soundtrack: Soundtrack
    var body: some View {
        ZStack(alignment: .topTrailing) {
            StageBackground(image: "DeskFolders", dim: 0.82)
            ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        InkPlate {
                            Text(Canon.firm(store.language))
                                .font(Typeface.mono(12))
                                .foregroundStyle(Noir.paper)
                            Text(Canon.address(store.language))
                                .font(Typeface.mono(11))
                                .foregroundStyle(Noir.paperDim)
                            Text(Canon.fiction(store.language))
                                .font(Typeface.mono(11))
                                .foregroundStyle(Noir.mist)
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 8)

                        InkPlate {
                            MetersColumn(meters: store.meters, language: store.language)
                        }
                        .padding(.horizontal, 16)

                        deskHero

                        Button {
                            store.openBible()
                        } label: {
                            HStack(spacing: 10) {
                                Image(systemName: "person.3.sequence")
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(Copy.s(
                                        store.language,
                                        pl: "Obsada — biblia wizualna",
                                        en: "Cast — visual bible"
                                    ))
                                    .fixedSize(horizontal: false, vertical: true)
                                    Text(Copy.s(
                                        store.language,
                                        pl: "Iglica, Chropot, Irena — zanim otworzysz teczkę",
                                        en: "Iglica, Chropot, Irena — before you open a file"
                                    ))
                                    .font(Typeface.body(13))
                                    .foregroundStyle(Noir.paperDim)
                                    .fixedSize(horizontal: false, vertical: true)
                                }
                                Spacer(minLength: 0)
                                Image(systemName: "chevron.right")
                            }
                            .font(Typeface.mono(14))
                            .foregroundStyle(Noir.paper)
                            .padding(14)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Noir.ink)
                            .overlay(Rectangle().stroke(Noir.blood, lineWidth: 2))
                        }
                        .buttonStyle(.plain)
                        .padding(.horizontal, 16)

                        VStack(spacing: 10) {
                            ForEach(store.allLessons) { lesson in
                                FolderCard(lesson: lesson)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 40)
                    }
                    .frame(maxWidth: 840)
                    .frame(maxWidth: .infinity)
            }
            HStack(spacing: 2) {
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
            .padding(.trailing, 8)
            .padding(.top, 2)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .clipped()
    }

    private var deskHero: some View {
        ComicPanel(asset: "MecenasPOV", minHeight: 200)
            .padding(.horizontal, 16)
    }
}

struct FolderCard: View {
    @EnvironmentObject private var store: GameStore
    let lesson: Lesson

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            ZStack {
                CroppedImage(name: lesson.hero)
                    .frame(width: 72, height: 96)
                if let mark = store.stamp(for: lesson) {
                    WaxStamp(verdict: mark.verdict, language: store.language)
                        .scaleEffect(0.72)
                }
            }
            .frame(width: 72, height: 96)
            .clipped()
            .overlay(Rectangle().stroke(Noir.paperDim, lineWidth: 2))
            .onTapGesture { store.open(lesson) }
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 8) {
                    Text(String(format: "%02d", lesson.order))
                        .font(Typeface.mono(11))
                        .foregroundStyle(Noir.paperDim)
                    if lesson.tone == .probono {
                        Text("PRO BONO")
                            .font(Typeface.mono(10))
                            .foregroundStyle(Noir.paper)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Noir.blood)
                    }
                    if let mark = store.stamp(for: lesson) {
                        Text(mark.verdict.label(store.language))
                            .font(Typeface.mono(10))
                            .foregroundStyle(mark.verdict == .sound ? Noir.void : Noir.paper)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(mark.verdict == .sound ? Noir.paper : Noir.blood)
                    }
                }
                Text(lesson.title.t(store.language))
                    .font(Typeface.display(20))
                    .foregroundStyle(.white)
                    .lineLimit(2)
                    .minimumScaleFactor(0.7)
                    .fixedSize(horizontal: false, vertical: true)
                Text(lesson.subtitle.t(store.language))
                    .font(Typeface.mono(12))
                    .foregroundStyle(Noir.paper)
                    .lineLimit(2)
                    .minimumScaleFactor(0.75)
                Text(lesson.deadline.t(store.language))
                    .font(Typeface.body(13))
                    .foregroundStyle(Noir.blood)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .contentShape(Rectangle())
            .onTapGesture { store.open(lesson) }
            VStack(spacing: 12) {
                Button {
                    store.openAwareness(lesson)
                } label: {
                    Image(systemName: "info.circle")
                        .font(.title2)
                        .foregroundStyle(Noir.paper)
                        .frame(width: 44, height: 44)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .accessibilityLabel(Copy.s(
                    store.language,
                    pl: "Briefing kancelaryjny",
                    en: "Firm briefing"
                ))
                Image(systemName: store.stamp(for: lesson) == nil ? "folder.fill" : "checkmark.seal.fill")
                    .foregroundStyle(
                        store.stamp(for: lesson)?.verdict == .unsound ? Noir.blood : Noir.paper
                    )
            }
            .padding(.top, 4)
        }
        .padding(12)
        .background(Noir.ink)
        .overlay(Rectangle().stroke(Color.white.opacity(0.45), lineWidth: 1))
        .contentShape(Rectangle())
        .opacity(store.stamp(for: lesson) == nil ? 1 : 0.92)
    }
}

struct WaxStamp: View {
    let verdict: DecisionVerdict
    let language: AppLanguage

    var body: some View {
        Text(verdict.label(language))
            .font(Typeface.mono(8))
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
