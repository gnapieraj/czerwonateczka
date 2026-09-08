import SwiftUI

struct DeskView: View {
    @EnvironmentObject private var store: GameStore
    @State private var eveningOnly = true

    var body: some View {
        ZStack {
            StageBackground(image: "DeskFolders")
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ScreenChrome(
                        title: Copy.s(store.language, pl: "Biurko mecenasa", en: "Counsel’s desk"),
                        onTrailing: { store.openSettings() }
                    ) {
                        EmptyView()
                    }
                    .padding(.bottom, -8)

                    Text(Copy.s(
                        store.language,
                        pl: "Deszcz za żaluzją. Jeden stempel waży więcej niż przegrana na wokandzie.",
                        en: "Rain behind the blinds. One stamp weighs more than a loss on the docket."
                    ))
                    .font(Typeface.body(16))
                    .foregroundStyle(Noir.paper)
                    .padding(.horizontal, 16)

                    Text(Canon.addressPL)
                        .font(Typeface.mono(11))
                        .foregroundStyle(Noir.mist)
                        .padding(.horizontal, 16)
                    Text(Canon.firmPL)
                        .font(Typeface.mono(11))
                        .foregroundStyle(Noir.paperDim)
                        .padding(.horizontal, 16)
                    Text(Canon.fictionPL)
                        .font(Typeface.mono(10))
                        .foregroundStyle(Noir.mist)
                        .padding(.horizontal, 16)

                    MetersColumn(meters: store.meters, language: store.language)
                        .padding(.horizontal, 16)

                    Picker("", selection: $eveningOnly) {
                        Text(Copy.s(store.language, pl: "Wieczór z mecenasem", en: "Evening with counsel")).tag(true)
                        Text(Copy.s(store.language, pl: "Cała wokanda (\(store.allLessons.count))", en: "Full docket (\(store.allLessons.count))")).tag(false)
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal, 16)

                    Text(Copy.s(
                        store.language,
                        pl: "Trzy teczki na spotkanie: cytat, głos, PDF. Ta sama kancelaria, te same twarze.",
                        en: "Three files for the meeting: cite, voice, PDF. Same firm, same faces."
                    ))
                    .font(Typeface.mono(11))
                    .foregroundStyle(Noir.mist)
                    .padding(.horizontal, 16)

                    deskHero

                    let pack = eveningOnly ? store.demoLessons : store.allLessons
                    VStack(spacing: 10) {
                        ForEach(pack) { lesson in
                            FolderCard(lesson: lesson)
                                .onTapGesture { store.open(lesson) }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 28)

                    HStack(spacing: 16) {
                        Button(Copy.s(store.language, pl: "Źródła", en: "Sources")) { store.openSources() }
                        Button(Copy.s(store.language, pl: "Biblia wizualna", en: "Visual bible")) { store.openBible() }
                    }
                    .font(Typeface.mono(12))
                    .foregroundStyle(Noir.paper)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 40)
                }
                .frame(maxWidth: 840)
                .frame(maxWidth: .infinity)
            }
        }
    }

    private var deskHero: some View {
        ZStack(alignment: .bottomLeading) {
            Image("MecenasPOV")
                .resizable()
                .scaledToFill()
                .frame(height: 168)
                .clipped()
            LinearGradient(colors: [.clear, .black.opacity(0.8)], startPoint: .top, endPoint: .bottom)
            VStack(alignment: .leading, spacing: 4) {
                Text(Copy.s(store.language, pl: "TY — BEZ TWARZY", en: "YOU — NO FACE"))
                    .font(Typeface.mono(10))
                    .foregroundStyle(Noir.blood)
                Text(Copy.s(
                    store.language,
                    pl: "Ręce na aktach. Pieczęć pęka. Za oknem PKiN.",
                    en: "Hands on the file. The seal cracks. The Palace outside."
                ))
                .font(Typeface.body(14))
                .foregroundStyle(.white)
            }
            .padding(12)
        }
        .overlay(Rectangle().stroke(Color.white.opacity(0.7), lineWidth: 2))
        .padding(.horizontal, 16)
    }
}

struct FolderCard: View {
    @EnvironmentObject private var store: GameStore
    let lesson: Lesson

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(lesson.exhibit.leadCast.asset)
                .resizable()
                .scaledToFill()
                .frame(width: 64, height: 84)
                .clipped()
                .overlay(Rectangle().stroke(lesson.demo ? Noir.blood : Noir.paperDim, lineWidth: 2))
            VStack(alignment: .leading, spacing: 4) {
                Text(String(format: "%02d", lesson.order))
                    .font(Typeface.mono(11))
                    .foregroundStyle(Noir.mist)
                Text(lesson.title.t(store.language))
                    .font(Typeface.display(22))
                    .foregroundStyle(.white)
                Text(lesson.subtitle.t(store.language))
                    .font(Typeface.mono(12))
                    .foregroundStyle(Noir.paperDim)
                Text(lesson.deadline.t(store.language))
                    .font(Typeface.body(13))
                    .foregroundStyle(Noir.blood)
            }
            Spacer(minLength: 0)
            Image(systemName: "folder.fill")
                .foregroundStyle(lesson.demo ? Noir.blood : Noir.paper)
                .padding(.top, 8)
        }
        .padding(12)
        .background(Color.black.opacity(0.55))
        .overlay(Rectangle().stroke(Color.white.opacity(0.35), lineWidth: 1))
    }
}
