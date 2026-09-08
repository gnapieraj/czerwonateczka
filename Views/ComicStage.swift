import SwiftUI

struct ComicPanel: View {
    let asset: String
    let caption: String
    var bloodCaption: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Image(asset)
                .resizable()
                .scaledToFill()
                .frame(minHeight: 140)
                .clipped()
                .overlay(alignment: .bottomLeading) {
                    LinearGradient(colors: [.clear, .black.opacity(0.75)], startPoint: .center, endPoint: .bottom)
                }
                .overlay(alignment: .bottomLeading) {
                    Text(caption)
                        .font(Typeface.mono(11))
                        .foregroundStyle(bloodCaption ? Noir.blood : Noir.paper)
                        .padding(8)
                }
        }
        .clipShape(Rectangle())
        .overlay(Rectangle().stroke(Color.white.opacity(0.85), lineWidth: 2))
        .shadow(color: Noir.blood.opacity(0.25), radius: 0, x: 3, y: 3)
    }
}

struct ComicStrip: View {
    let lesson: Lesson
    let language: AppLanguage

    var body: some View {
        let lead = lesson.exhibit.leadCast
        let second = lesson.exhibit.secondCast
        VStack(alignment: .leading, spacing: 6) {
            Text(Copy.s(language, pl: "PLAN SZÓSTY — WARSZAWA", en: "SIXTH PANEL — WARSAW"))
                .font(Typeface.mono(10))
                .foregroundStyle(Noir.blood)
                .tracking(2)
            ViewThatFits(in: .horizontal) {
                HStack(spacing: 6) {
                    ComicPanel(asset: "OfficeNight", caption: Canon.windowPL)
                    ComicPanel(asset: lead.asset, caption: lead.name(language), bloodCaption: true)
                    if let second {
                        ComicPanel(asset: second.asset, caption: second.name(language))
                    }
                }
                VStack(spacing: 6) {
                    ComicPanel(asset: "OfficeNight", caption: Canon.addressPL)
                    HStack(spacing: 6) {
                        ComicPanel(asset: lead.asset, caption: lead.name(language), bloodCaption: true)
                        if let second {
                            ComicPanel(asset: second.asset, caption: second.name(language))
                        }
                    }
                    .frame(height: 200)
                }
            }
            .frame(minHeight: 180, maxHeight: 280)
        }
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

    var body: some View {
        ZStack {
            Noir.void
            Image(image)
                .resizable()
                .scaledToFill()
                .overlay(Color.black.opacity(0.55))
            BlindsOverlay()
        }
        .ignoresSafeArea()
    }
}
