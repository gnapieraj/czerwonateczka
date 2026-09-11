import SwiftUI

struct ComicIntroView: View {
    @EnvironmentObject private var store: GameStore
    let lesson: Lesson
    @State private var pageIndex: Int

    init(lesson: Lesson) {
        self.lesson = lesson
        let requestedPage = ProcessInfo.processInfo.arguments
            .first(where: { $0.hasPrefix("--comic-page=") })
            .flatMap { Int($0.dropFirst("--comic-page=".count)) } ?? 1
        _pageIndex = State(initialValue: requestedPage == 2 ? 1 : 0)
    }

    private var beats: [ComicBeat] { lesson.beats }
    private var pages: [[ComicBeat]] {
        let pageSize = beats.count <= 4 ? 2 : 3
        return stride(from: 0, to: beats.count, by: pageSize).map { start in
            Array(beats[start ..< min(start + pageSize, beats.count)])
        }
    }

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack(spacing: 0) {
                header
                    .zIndex(2)
                if beats.isEmpty {
                    emptyFallback
                } else {
                    comicPager
                    pageNumber
                }
                footer
                    .zIndex(2)
            }
        }
        .onAppear {
            if beats.isEmpty {
                store.openDossier(lesson)
            }
        }
        .onChange(of: lesson.id) {
            pageIndex = 0
        }
    }

    private var header: some View {
        HStack(alignment: .center, spacing: 12) {
            Button {
                store.back()
            } label: {
                HStack(spacing: 6) {
                    Image(systemName: "chevron.left")
                        .font(.title3.weight(.semibold))
                    Text(Copy.s(store.language, pl: "Wstecz", en: "Back"))
                        .font(Typeface.mono(13))
                }
                .foregroundStyle(Color.black)
                .padding(.horizontal, 10)
                .frame(minWidth: 88, minHeight: 44, alignment: .leading)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .zIndex(3)
            VStack(alignment: .leading, spacing: 2) {
                Text("CZERWONA TECZKA")
                    .font(Typeface.mono(10))
                    .foregroundStyle(Noir.blood)
                    .tracking(2)
                Text(lesson.title.t(store.language))
                    .font(Typeface.display(20))
                    .foregroundStyle(Color.black)
                    .lineLimit(2)
                    .minimumScaleFactor(0.7)
                    .fixedSize(horizontal: false, vertical: true)
            }
            Spacer(minLength: 0)
            if lesson.tone == .probono {
                Text("PRO BONO")
                    .font(Typeface.mono(10))
                    .foregroundStyle(Color.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 6)
                    .background(Noir.blood)
            }
        }
        .padding(.horizontal, 14)
        .padding(.top, 8)
        .padding(.bottom, 6)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .contentShape(Rectangle())
    }

    private var pageNumber: some View {
        Text("— \(String(format: "%02d", lesson.order)) · \(pageIndex + 1)/\(max(pages.count, 1)) —")
            .font(Typeface.mono(12))
            .foregroundStyle(Color.black)
            .frame(maxWidth: .infinity)
            .padding(.bottom, 4)
    }

    private var footer: some View {
        HStack(spacing: 10) {
            if pageIndex > 0 {
                pageButton(
                    Copy.s(store.language, pl: "Poprzednia", en: "Previous"),
                    systemImage: "chevron.left"
                ) {
                    goToPage(pageIndex - 1)
                }
            }

            if pageIndex < pages.count - 1 {
                pageButton(
                    Copy.s(store.language, pl: "Dalej", en: "Next"),
                    systemImage: "chevron.right",
                    imageOnRight: true
                ) {
                    goToPage(pageIndex + 1)
                }
            } else {
                Button {
                    store.openDossier(lesson)
                } label: {
                    Text(Copy.s(store.language, pl: "Otwórz teczkę", en: "Open the file"))
                        .font(Typeface.mono(14))
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity)
                        .padding(14)
                        .background(Noir.blood)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 14)
        .padding(.bottom, 16)
        .background(Color.white)
    }

    private var comicPager: some View {
        HorizontalPager(pageCount: pages.count, selection: $pageIndex) { index in
            ComicBoard(beats: pages[index], language: store.language)
                .padding(10)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .contentShape(Rectangle())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .accessibilityElement(children: .contain)
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .increment:
                goToPage(pageIndex + 1)
            case .decrement:
                goToPage(pageIndex - 1)
            default:
                break
            }
        }
    }

    private func goToPage(_ index: Int) {
        let clamped = min(max(index, 0), max(pages.count - 1, 0))
        guard clamped != pageIndex else { return }
        pageIndex = clamped
    }

    private func pageButton(
        _ title: String,
        systemImage: String,
        imageOnRight: Bool = false,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if !imageOnRight {
                    Image(systemName: systemImage)
                }
                Text(title)
                if imageOnRight {
                    Image(systemName: systemImage)
                }
            }
            .font(Typeface.mono(14))
            .foregroundStyle(Color.white)
            .frame(maxWidth: .infinity)
            .padding(14)
            .background(Noir.void)
        }
        .buttonStyle(.plain)
    }

    private var emptyFallback: some View {
        Text(lesson.context.t(store.language))
            .font(Typeface.body(16))
            .foregroundStyle(Color.black)
            .padding(24)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}
