import SwiftUI
import UIKit

struct ComicLettering: View {
    let text: String
    let voice: ComicVoice

    var body: some View {
        Text(text)
            .font(voice == .balloon ? Typeface.italic(20) : Typeface.display(20))
            .foregroundStyle(Color.black)
            .lineSpacing(4)
            .multilineTextAlignment(voice == .balloon ? .center : .leading)
            .lineLimit(6)
            .fixedSize(horizontal: false, vertical: true)
            .padding(.horizontal, voice == .balloon ? 14 : 12)
            .padding(.vertical, voice == .balloon ? 12 : 10)
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

/// A thought balloon: the situation sits in the bubble, two circles mark it as a thought.
struct ComicThought: View {
    let text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(text)
                .font(Typeface.body(18))
                .foregroundStyle(Color.black)
                .lineSpacing(4)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, 16)
                .padding(.vertical, 14)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 26, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 26, style: .continuous)
                        .stroke(Color.black, lineWidth: 2)
                )
            VStack(alignment: .leading, spacing: 4) {
                Circle().fill(Color.white).frame(width: 14, height: 14)
                    .overlay(Circle().stroke(Color.black, lineWidth: 2))
                Circle().fill(Color.white).frame(width: 8, height: 8)
                    .overlay(Circle().stroke(Color.black, lineWidth: 2))
                    .padding(.leading, 16)
            }
            .padding(.leading, 18)
        }
    }
}

struct ComicPagePanel: View {
    let beat: ComicBeat
    let language: AppLanguage
    /// Phone: the caption sits outside the plate so it does not cover the drawing.
    var letteringOutside: Bool = false
    /// Inside a fixed frame the picture takes the space left after the words.
    var fillsFrame: Bool = false
    var preparing: Bool = false

    var body: some View {
        Group {
            if letteringOutside {
                outside
            } else {
                overlaid
            }
        }
        .frame(maxWidth: .infinity, maxHeight: letteringOutside && !fillsFrame ? nil : .infinity)
        .clipped()
        .contentShape(Rectangle())
        .overlay(Rectangle().stroke(Color.black, lineWidth: 3))
    }

    private var overlaid: some View {
        ZStack {
            Color.black
            Image(beat.asset)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            VStack {
                if beat.voice != .balloon {
                    lettering
                        .padding(8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer(minLength: 0)
                } else {
                    Spacer(minLength: 0)
                    lettering
                        .padding(8)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
        }
        .overlay(alignment: .topTrailing) {
            if preparing { preparingFlag.padding(8) }
        }
    }

    private var outside: some View {
        VStack(spacing: 0) {
            if beat.voice != .balloon {
                lettering
                    .padding(.horizontal, 8)
                    .padding(.top, 8)
                    .padding(.bottom, 6)
            }
            Color.black
                .overlay {
                    Image(beat.asset)
                        .resizable()
                        .aspectRatio(contentMode: fillsFrame ? .fill : .fit)
                }
                .aspectRatio(fillsFrame ? nil : 16 / 9, contentMode: .fit)
                .frame(maxWidth: .infinity, maxHeight: fillsFrame ? .infinity : nil)
                .clipped()
                .overlay(alignment: .topTrailing) {
                    if preparing { preparingFlag.padding(8) }
                }
            if beat.voice == .balloon {
                lettering
                    .padding(.horizontal, 8)
                    .padding(.top, 6)
                    .padding(.bottom, 8)
            }
        }
        .background(Color.black)
    }

    private var lettering: some View {
        ComicLettering(text: beat.caption.t(language), voice: beat.voice)
    }

    private var preparingFlag: some View {
        Text(Copy.s(language, pl: "W PRZYGOTOWANIU", en: "IN PREPARATION"))
            .font(Typeface.mono(11))
            .foregroundStyle(Noir.paper)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Noir.blood)
    }
}

struct ComicBoard: View {
    let beats: [ComicBeat]
    let language: AppLanguage
    /// Landscape iPad: two 16:9 plates stacked become a thin strip. Place them side by side.
    var sideBySide: Bool = false
    /// Phone: plates keep a 16:9 frame and the words sit outside them.
    var fitsContent: Bool = false
    /// Words sit above or below the plate, inside a frame that already has a height.
    var letteringOutside: Bool = false
    var preparing: Bool = false

    var body: some View {
        if fitsContent {
            VStack(spacing: 8) {
                ForEach(beats) { beat in
                    ComicPagePanel(beat: beat, language: language, letteringOutside: true, preparing: preparing)
                }
            }
            .frame(maxWidth: .infinity, alignment: .top)
        } else {
            fitted
        }
    }

    private var fitted: some View {
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
                case 2 where sideBySide:
                    HStack(spacing: g) {
                        tile(beats[0], (w - g) / 2, h)
                        tile(beats[1], (w - g) / 2, h)
                    }
                case 2:
                    VStack(spacing: g) {
                        tile(beats[0], w, (h - g) / 2)
                        tile(beats[1], w, (h - g) / 2)
                    }
                case 3 where sideBySide:
                    HStack(spacing: g) {
                        let tileWidth = (w - g * 2) / 3
                        tile(beats[0], tileWidth, h)
                        tile(beats[1], tileWidth, h)
                        tile(beats[2], tileWidth, h)
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
        ComicPagePanel(
            beat: beat,
            language: language,
            letteringOutside: letteringOutside,
            fillsFrame: letteringOutside,
            preparing: preparing
        )
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
    /// Full 16:9 plate. A fixed height crops or letterboxes these drawings.
    var plateRatio: CGFloat? = nil
    var preparing: Bool = false
    var language: AppLanguage = .polish

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Group {
                if let plateRatio {
                    Color.clear
                        .aspectRatio(plateRatio, contentMode: .fit)
                        .overlay {
                            Image(asset)
                                .resizable()
                                .scaledToFill()
                        }
                        .clipped()
                        .overlay(alignment: .topTrailing) {
                            if preparing { preparingFlag.padding(8) }
                        }
                } else {
                    CroppedImage(name: asset, contentMode: contentMode)
                        .frame(maxWidth: .infinity)
                        .frame(height: minHeight)
                }
            }
            if let caption, !caption.isEmpty {
                Text(caption)
                    .font(Typeface.body(20))
                    .lineSpacing(4)
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

    private var preparingFlag: some View {
        Text(Copy.s(language, pl: "W PRZYGOTOWANIU", en: "IN PREPARATION"))
            .font(Typeface.mono(11))
            .foregroundStyle(Noir.paper)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Noir.blood)
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
    var image: String = "Gabinet"
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
