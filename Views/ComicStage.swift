import SwiftUI
import UIKit

struct ComicLettering: View {
    let text: String
    let voice: ComicVoice

    var body: some View {
        Text(text)
            .font(voice == .balloon ? Typeface.italic(16) : Typeface.display(15))
            .foregroundStyle(Color.black)
            .multilineTextAlignment(voice == .balloon ? .center : .leading)
            .minimumScaleFactor(0.72)
            .lineLimit(4)
            .padding(.horizontal, voice == .balloon ? 12 : 10)
            .padding(.vertical, voice == .balloon ? 8 : 7)
            .frame(
                maxWidth: voice == .balloon ? nil : .infinity,
                alignment: voice == .balloon ? .center : .leading
            )
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: voice == .balloon ? 22 : 0, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: voice == .balloon ? 22 : 0, style: .continuous)
                    .stroke(Color.black, lineWidth: voice == .balloon ? 2 : 1.6)
            )
    }
}

struct ComicPagePanel: View {
    let beat: ComicBeat
    let language: AppLanguage

    var body: some View {
        ZStack(alignment: beat.voice == .balloon ? .bottom : .topLeading) {
            Color.black
            Image(beat.asset)
                .resizable()
                .scaledToFit()
            ComicLettering(text: beat.caption.t(language), voice: beat.voice)
                .padding(8)
                .frame(
                    maxWidth: .infinity,
                    alignment: beat.voice == .balloon ? .center : .leading
                )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .clipped()
        .contentShape(Rectangle())
        .overlay(Rectangle().stroke(Color.black, lineWidth: 3))
    }
}

struct ComicBoard: View {
    let beats: [ComicBeat]
    let language: AppLanguage

    var body: some View {
        GeometryReader { geo in
            let g: CGFloat = 8
            let w = geo.size.width
            let h = geo.size.height
            Group {
                switch beats.count {
                case 0:
                    Color.white
                case 1:
                    tile(beats[0], w, h)
                case 2:
                    VStack(spacing: g) {
                        tile(beats[0], w, (h - g) / 2)
                        tile(beats[1], w, (h - g) / 2)
                    }
                case 3:
                    VStack(spacing: g) {
                        tile(beats[0], w, (h - g) * 0.38)
                        HStack(spacing: g) {
                            tile(beats[1], (w - g) * 0.36, (h - g) * 0.62)
                            tile(beats[2], (w - g) * 0.64, (h - g) * 0.62)
                        }
                    }
                default:
                    let tileHeight = (h - g * CGFloat(beats.count - 1)) / CGFloat(beats.count)
                    VStack(spacing: g) {
                        ForEach(beats) { beat in
                            tile(beat, w, tileHeight)
                        }
                    }
                }
            }
        }
        .background(Color.white)
        .clipped()
        .contentShape(Rectangle())
    }

    private func tile(_ beat: ComicBeat, _ width: CGFloat, _ height: CGFloat) -> some View {
        ComicPagePanel(beat: beat, language: language)
            .frame(width: width, height: height)
    }
}

/// Fills a proposed frame without letting `scaledToFill` inflate the parent layout.
struct CroppedImage: View {
    let name: String
    var contentMode: ContentMode = .fill

    var body: some View {
        Color.clear
            .overlay {
                Image(name)
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
            }
            .clipped()
            .contentShape(Rectangle())
    }
}

struct ComicPanel: View {
    let asset: String
    var caption: String? = nil
    var bloodCaption: Bool = false
    var minHeight: CGFloat = 160
    var contentMode: ContentMode = .fill

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            CroppedImage(name: asset, contentMode: contentMode)
                .frame(maxWidth: .infinity)
                .frame(height: minHeight)
            if let caption, !caption.isEmpty {
                Text(caption)
                    .font(Typeface.body(15))
                    .foregroundStyle(bloodCaption ? Noir.blood : Noir.void)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(12)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Noir.paper)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .clipShape(Rectangle())
        .overlay(Rectangle().stroke(Color.white.opacity(0.85), lineWidth: 2))
        .shadow(color: Noir.blood.opacity(0.25), radius: 0, x: 3, y: 3)
    }
}

struct BlindsOverlay: View {
    var body: some View {
        Canvas { context, size in
            let step: CGFloat = 7
            var y: CGFloat = 0
            while y < size.height {
                var path = Path()
                path.addRect(CGRect(x: 0, y: y, width: size.width, height: 1.1))
                context.fill(path, with: .color(Color.white.opacity(0.035)))
                y += step
            }
        }
        .allowsHitTesting(false)
        .ignoresSafeArea()
    }
}

struct StageBackground: View {
    var image: String = "OfficeNight"
    /// Heavy ink so body copy never sits on hatching.
    var dim: Double = 0.78

    var body: some View {
        Rectangle()
            .fill(Noir.void)
            .ignoresSafeArea()
            .overlay {
                CroppedImage(name: image)
                .overlay(Color.black.opacity(dim))
                .overlay { BlindsOverlay() }
            }
            .clipped()
            .ignoresSafeArea()
            .allowsHitTesting(false)
    }
}

/// UIKit paging so a finger swipe actually turns comic pages.
struct HorizontalPager<Page: View>: UIViewControllerRepresentable {
    let pageCount: Int
    @Binding var selection: Int
    @ViewBuilder var page: (Int) -> Page

    func makeCoordinator() -> Coordinator {
        Coordinator(selection: $selection)
    }

    func makeUIViewController(context: Context) -> UIPageViewController {
        let controller = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal
        )
        controller.dataSource = context.coordinator
        controller.delegate = context.coordinator
        controller.view.backgroundColor = .white
        context.coordinator.install(pageCount: pageCount, page: page)
        let start = context.coordinator.clamped(selection)
        if let current = context.coordinator.controller(at: start) {
            controller.setViewControllers([current], direction: .forward, animated: false)
        }
        DispatchQueue.main.async {
            context.coordinator.tuneScroll(controller)
        }
        return controller
    }

    func updateUIViewController(_ controller: UIPageViewController, context: Context) {
        context.coordinator.selection = $selection
        context.coordinator.install(pageCount: pageCount, page: page)
        context.coordinator.tuneScroll(controller)
        guard !context.coordinator.isTransitioning else { return }
        let target = context.coordinator.clamped(selection)
        let current = controller.viewControllers?.first.flatMap { context.coordinator.index(of: $0) }
        if current != target, let next = context.coordinator.controller(at: target) {
            controller.setViewControllers(
                [next],
                direction: target >= (current ?? target) ? .forward : .reverse,
                animated: current != nil
            )
        }
    }

    final class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        var selection: Binding<Int>
        var isTransitioning = false
        private var hosts: [Int: UIHostingController<Page>] = [:]
        private var count = 0

        init(selection: Binding<Int>) {
            self.selection = selection
        }

        func clamped(_ index: Int) -> Int {
            min(max(index, 0), max(count - 1, 0))
        }

        func install(pageCount: Int, page: (Int) -> Page) {
            count = pageCount
            for index in 0..<pageCount {
                let root = page(index)
                if let host = hosts[index] {
                    host.rootView = root
                } else {
                    let host = UIHostingController(rootView: root)
                    host.sizingOptions = []
                    host.safeAreaRegions = []
                    host.view.backgroundColor = .white
                    host.view.clipsToBounds = true
                    host.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                    hosts[index] = host
                }
            }
            hosts.keys.filter { $0 >= pageCount }.forEach { hosts.removeValue(forKey: $0) }
        }

        func controller(at index: Int) -> UIViewController? { hosts[index] }

        func index(of controller: UIViewController) -> Int? {
            hosts.first { $0.value === controller }?.key
        }

        func tuneScroll(_ page: UIPageViewController) {
            for subview in page.view.subviews {
                guard let scroll = subview as? UIScrollView else { continue }
                scroll.delaysContentTouches = false
                scroll.canCancelContentTouches = true
                scroll.isPagingEnabled = true
                scroll.alwaysBounceHorizontal = true
            }
        }

        func pageViewController(
            _ pageViewController: UIPageViewController,
            viewControllerBefore viewController: UIViewController
        ) -> UIViewController? {
            guard let index = index(of: viewController), index > 0 else { return nil }
            return hosts[index - 1]
        }

        func pageViewController(
            _ pageViewController: UIPageViewController,
            viewControllerAfter viewController: UIViewController
        ) -> UIViewController? {
            guard let index = index(of: viewController), index + 1 < count else { return nil }
            return hosts[index + 1]
        }

        func pageViewController(
            _ pageViewController: UIPageViewController,
            willTransitionTo pendingViewControllers: [UIViewController]
        ) {
            isTransitioning = true
        }

        func pageViewController(
            _ pageViewController: UIPageViewController,
            didFinishAnimating finished: Bool,
            previousViewControllers: [UIViewController],
            transitionCompleted completed: Bool
        ) {
            isTransitioning = false
            guard completed,
                  let visible = pageViewController.viewControllers?.first,
                  let index = index(of: visible)
            else { return }
            selection.wrappedValue = index
        }
    }
}
