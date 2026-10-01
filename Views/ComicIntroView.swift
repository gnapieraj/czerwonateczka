import SwiftUI

struct ComicIntroView: View {
    @EnvironmentObject private var store: GameStore
    @Environment(\.horizontalSizeClass) private var sizeClass
    let lesson: Lesson
    @State private var pageIndex: Int

    init(lesson: Lesson) {
        self.lesson = lesson
        _pageIndex = State(initialValue: Self.launchPageIndex(for: lesson.id))
    }

    /// `--comic-page=2` opens the second page only for the lesson named in `--lesson=`.
    /// Later nights, including „Następna noc”, always start on the comic.
    static func launchPageIndex(for lessonID: String, arguments: [String] = ProcessInfo.processInfo.arguments) -> Int {
        let launchedLesson = arguments
            .first(where: { $0.hasPrefix("--lesson=") })
            .map { String($0.dropFirst("--lesson=".count)) }
        guard launchedLesson == lessonID else { return 0 }
        let requested = arguments
            .first(where: { $0.hasPrefix("--comic-page=") })
            .flatMap { Int($0.dropFirst("--comic-page=".count)) } ?? 1
        return requested == 2 ? 1 : 0
    }

    private var beats: [ComicBeat] { lesson.beats }
    private var pages: [[ComicBeat]] {
        let pageSize = beats.count <= 4 ? 2 : 3
        return stride(from: 0, to: beats.count, by: pageSize).map { start in
            Array(beats[start ..< min(start + pageSize, beats.count)])
        }
    }

    var body: some View {
        GeometryReader { geo in
            let wide = geo.size.width > geo.size.height
            ZStack {
                Color.white.ignoresSafeArea()
                VStack(spacing: 0) {
                    header
                        .zIndex(2)
                    if beats.isEmpty {
                        emptyFallback
                    } else if sizeClass == .compact {
                        phonePager()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        pageNumber
                    } else {
                        comicPager(sideBySide: wide)
                            .frame(maxHeight: .infinity)
                            .layoutPriority(wide || !isClosingPage ? 1 : 0)
                        if isClosingPage {
                            Group {
                                if wide {
                                    plotText
                                        .fixedSize(horizontal: false, vertical: true)
                                        .frame(maxWidth: .infinity, maxHeight: 168, alignment: .topLeading)
                                        .clipped()
                                } else {
                                    plot(compact: false)
                                }
                            }
                            .layoutPriority(wide ? 2 : 1)
                            .padding(.horizontal, 14)
                            .padding(.top, 4)
                        }
                        pageNumber
                            .layoutPriority(2)
                    }
                    footer
                        .layoutPriority(2)
                        .zIndex(2)
                }
            }
            .frame(width: geo.size.width, height: geo.size.height, alignment: .top)
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
                        .font(Typeface.mono(18))
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
                    .font(Typeface.mono(16))
                    .foregroundStyle(Noir.blood)
                    .tracking(1)
                Text(lesson.title.t(store.language))
                    .font(Typeface.display(24))
                    .foregroundStyle(Color.black)
                    .lineSpacing(2)
                    .lineLimit(3)
                    .minimumScaleFactor(0.9)
                    .fixedSize(horizontal: false, vertical: true)
            }
            Spacer(minLength: 0)
            if lesson.tone == .probono {
                Text("PRO BONO")
                    .font(Typeface.mono(16))
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

    private var isPhone: Bool { sizeClass == .compact }

    /// On the phone the situation is its own page after the panels.
    private var contextPageIndex: Int { pages.count }

    private var showingContext: Bool {
        isPhone && !pages.isEmpty && pageIndex >= contextPageIndex
    }

    private var lastPageIndex: Int {
        if isPhone, !pages.isEmpty { return contextPageIndex }
        return max(pages.count - 1, 0)
    }

    private var isClosingPage: Bool {
        !pages.isEmpty && pageIndex >= pages.count - 1 && !showingContext
    }

    /// Situation the player needs before the choice. Lives with the strip, not on the decision board.
    /// In landscape the plates take the spare height; the text stays a short band and scrolls if it does not fit.
    private func plot(compact: Bool) -> some View {
        ViewThatFits(in: .vertical) {
            plotText
            ScrollView {
                plotText
            }
        }
        .frame(maxHeight: compact ? 132 : 250, alignment: .top)
    }

    private var plotText: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(lesson.deadline.t(store.language))
                .font(Typeface.mono(15))
                .foregroundStyle(Noir.blood)
                .fixedSize(horizontal: false, vertical: true)
            Text(lesson.context.t(store.language))
                .font(Typeface.body(17))
                .foregroundStyle(Color.black)
                .lineSpacing(3)
                .fixedSize(horizontal: false, vertical: true)
            Text(lesson.innerVoice.t(store.language))
                .font(Typeface.body(17))
                .foregroundStyle(Color.black)
                .lineSpacing(3)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var pageNumber: some View {
        let count = isPhone ? pages.count + 1 : max(pages.count, 1)
        let current = min(pageIndex, max(count - 1, 0)) + 1
        return Text("— \(String(format: "%02d", lesson.order)) · \(current)/\(max(count, 1)) —")
            .font(Typeface.mono(16))
            .foregroundStyle(Color.black)
            .frame(maxWidth: .infinity)
            .padding(.bottom, 4)
    }

    private var footer: some View {
        HStack(spacing: 10) {
            if isPhone, showingContext {
                pageButton(
                    Copy.s(store.language, pl: "Komiks", en: "Comic"),
                    systemImage: "chevron.left"
                ) {
                    goToPage(pages.count - 1)
                }
                decisionButton
            } else if isPhone, pageIndex > 0, pageIndex < pages.count - 1 {
                pageButton(
                    Copy.s(store.language, pl: "Poprzednia", en: "Previous"),
                    systemImage: "chevron.left"
                ) {
                    goToPage(pageIndex - 1)
                }
                nextComicButton
            } else if isPhone, pageIndex > 0 {
                pageButton(
                    Copy.s(store.language, pl: "Poprzednia", en: "Previous"),
                    systemImage: "chevron.left"
                ) {
                    goToPage(pageIndex - 1)
                }
                contextButton
            } else if isPhone, pageIndex < pages.count - 1 {
                nextComicButton
            } else if isPhone {
                contextButton
            } else if pageIndex > 0 {
                pageButton(
                    Copy.s(store.language, pl: "Poprzednia", en: "Previous"),
                    systemImage: "chevron.left"
                ) {
                    goToPage(pageIndex - 1)
                }
                if pageIndex < pages.count - 1 {
                    nextComicButton
                } else {
                    decisionButton
                }
            } else if pageIndex < pages.count - 1 {
                nextComicButton
            } else {
                decisionButton
            }
        }
        .padding(.horizontal, 14)
        .padding(.bottom, 16)
        .background(Color.white)
    }

    private var contextButton: some View {
        pageButton(
            Copy.s(store.language, pl: "Kontekst", en: "Context"),
            systemImage: "chevron.right",
            imageOnRight: true
        ) {
            goToPage(contextPageIndex)
        }
    }

    private var nextComicButton: some View {
        pageButton(
            Copy.s(store.language, pl: "Dalej", en: "Next"),
            systemImage: "chevron.right",
            imageOnRight: true
        ) {
            goToPage(pageIndex + 1)
        }
    }

    private var decisionButton: some View {
        Button {
            store.openDossier(lesson)
        } label: {
            Text(Copy.s(store.language, pl: "Decyzja", en: "Decide"))
                .font(Typeface.mono(20))
                .foregroundStyle(Color.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 18)
                .padding(.horizontal, 16)
                .background(Noir.blood)
        }
        .buttonStyle(.plain)
    }

    private func comicPager(sideBySide: Bool) -> some View {
        HorizontalPager(pageCount: pages.count, selection: $pageIndex) { index in
            ComicBoard(beats: pages[index], language: store.language, sideBySide: sideBySide, preparing: lesson.artPending)
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

    private func phonePager() -> some View {
        HorizontalPager(pageCount: pages.count + 1, selection: $pageIndex) { index in
            Group {
                if index < pages.count {
                    ComicBoard(
                        beats: pages[index],
                        language: store.language,
                        letteringOutside: true,
                        preparing: lesson.artPending
                    )
                    .padding(8)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    contextPage
                }
            }
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

    private var contextPage: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                Text(lesson.deadline.t(store.language))
                    .font(Typeface.mono(15))
                    .foregroundStyle(Noir.blood)
                    .lineSpacing(3)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.white)
                    .overlay(Rectangle().stroke(Color.black, lineWidth: 1.6))
                ComicThought(text: lesson.context.t(store.language))
                ComicThought(text: lesson.innerVoice.t(store.language))
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }

    private func goToPage(_ index: Int) {
        let clamped = min(max(index, 0), lastPageIndex)
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
            .font(Typeface.mono(20))
            .foregroundStyle(Color.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 18)
            .padding(.horizontal, 16)
            .background(Noir.void)
        }
        .buttonStyle(.plain)
    }

    private var emptyFallback: some View {
        Text(lesson.context.t(store.language))
            .font(Typeface.body(22))
            .lineSpacing(6)
            .foregroundStyle(Color.black)
            .padding(24)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}
