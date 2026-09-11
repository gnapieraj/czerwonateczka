import SwiftUI

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
        GeometryReader { geo in
            ZStack(alignment: beat.voice == .balloon ? .bottom : .topLeading) {
                Color.black
                Image(beat.asset)
                    .resizable()
                    .scaledToFit()
                    .frame(width: geo.size.width, height: geo.size.height)
                ComicLettering(text: beat.caption.t(language), voice: beat.voice)
                    .padding(8)
                    .frame(
                        maxWidth: .infinity,
                        alignment: beat.voice == .balloon ? .center : .leading
                    )
            }
        }
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

struct ComicPanel: View {
    let asset: String
    var caption: String? = nil
    var bloodCaption: Bool = false
    var minHeight: CGFloat = 160

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Image(asset)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .frame(height: minHeight)
                .clipped()
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
        ZStack {
            Noir.void
            Image(image)
                .resizable()
                .scaledToFill()
                .overlay(Color.black.opacity(dim))
            BlindsOverlay()
        }
        .ignoresSafeArea()
    }
}
