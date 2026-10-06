import SwiftUI

struct SourcesView: View {
    @EnvironmentObject private var store: GameStore
    @Environment(\.horizontalSizeClass) private var horizontal
    var sourceIds: [String]? = nil

    var body: some View {
        ZStack {
            StageBackground()
            VStack(spacing: 0) {
                HStack(spacing: 12) {
                    Button { store.back() } label: {
                        HStack(spacing: 6) {
                            Image(systemName: "chevron.left")
                            Text(Copy.s(store.language, pl: "Wstecz", en: "Back"))
                                .font(Typeface.mono(18))
                        }
                        .foregroundStyle(Noir.paper)
                        .frame(minWidth: 88, minHeight: 44, alignment: .leading)
                    }
                    .buttonStyle(.plain)
                    Text(Copy.s(store.language, pl: "Skąd tematy", en: "Where the nights come from"))
                        .font(Typeface.display(28))
                        .lineSpacing(4)
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundStyle(Noir.paper)
                    Spacer(minLength: 0)
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(Noir.ink)

                ScrollView {
                    VStack(alignment: .leading, spacing: 14) {
                        InkPlate {
                            Text(Copy.s(
                                store.language,
                                pl: "Noce opisują codzienne zagrożenia w pracy biura — w duchu materiałów o świadomości bezpieczeństwa, takich jak newsletter SANS OUCH!. Nie opierają się na konkretnych wydaniach i ich nie cytują. Sceny, nazwiska i kancelaria Colgante są fikcją. To nie jest porada prawna.",
                                en: "The nights cover everyday office threats, in the spirit of security-awareness material such as the SANS OUCH! newsletter. They are not based on, or quoted from, specific issues. The scenes, names and Colgante firm are fiction. This is not legal advice."
                            ))
                            .font(Typeface.body(22))
                            .foregroundStyle(Noir.paper)
                            .lineSpacing(8)
                            .fixedSize(horizontal: false, vertical: true)
                        }
                        .padding(.horizontal, 16)
                        Link(destination: URL(string: "https://www.sans.org/newsletters/ouch")!) {
                            Text("sans.org/newsletters/ouch")
                                .font(Typeface.mono(20))
                                .foregroundStyle(Noir.paper)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(18)
                                .background(Noir.ink)
                                .overlay(Rectangle().stroke(Noir.blood, lineWidth: 1))
                        }
                        .padding(.horizontal, 16)
                    }
                    .frame(maxWidth: ReadingMeasure.column(horizontal))
                    .frame(maxWidth: .infinity)
                    .padding(.top, 16)
                }
            }
        }
    }
}
