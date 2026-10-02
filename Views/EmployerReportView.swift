import PDFKit
import SwiftUI
import UIKit

/// "Raport dla pracodawcy": local PDF + CSV + JSON, shared only through the system sheet.
struct EmployerReportView: View {
    @EnvironmentObject private var store: GameStore
    @Environment(\.horizontalSizeClass) private var horizontal

    @State private var scope: ReportScope?
    @State private var cached: CachedReport?
    @State private var preview: PreviewItem?
    @State private var share: ShareItem?
    @State private var linkedInURL: URL?
    @State private var exportError: String?

    private var lang: AppLanguage { store.language }

    private var currentScope: ReportScope? {
        scope ?? store.defaultReportScope ?? store.reportScopes.first
    }

    private var evaluation: PassEvaluation? {
        currentScope.map { store.evaluate($0) }
    }

    private var canExport: Bool {
        (evaluation?.passed ?? false) && store.reportForm.hasRequiredFields
    }

    var body: some View {
        ZStack {
            StageBackground()
            VStack(spacing: 0) {
                ScreenChrome(
                    title: Copy.s(lang, pl: "Raport dla pracodawcy", en: "Report for your employer"),
                    kicker: Copy.s(lang, pl: "DOWÓD UKOŃCZENIA", en: "PROOF OF COMPLETION"),
                    onBack: { store.back() },
                    backCaption: Copy.s(lang, pl: "Wstecz", en: "Back")
                ) { EmptyView() }

                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        introPlate
                        scopePicker
                        if let evaluation {
                            statusPlate(evaluation)
                        }
                        formPlate
                        actionsPlate
                        footerPlate
                        Color.clear.frame(height: 32)
                    }
                    .frame(maxWidth: ReadingMeasure.column(horizontal))
                    .frame(maxWidth: .infinity)
                    .padding(.top, 16)
                }
                .scrollDismissesKeyboard(.interactively)
            }
        }
        .sheet(item: $preview) { item in
            PDFPreviewSheet(data: item.data, url: item.url, title: item.title, language: lang)
        }
        .sheet(item: $share) { item in
            ShareSheet(items: item.urls)
        }
        .alert(
            Copy.s(lang, pl: "Nie udało się zapisać plików", en: "Could not write the files"),
            isPresented: Binding(get: { exportError != nil }, set: { if !$0 { exportError = nil } })
        ) {
            Button("OK", role: .cancel) { exportError = nil }
        } message: {
            Text(exportError ?? "")
        }

        .confirmationDialog(
            Copy.s(lang, pl: "Dodaj certyfikat na LinkedIn", en: "Add certification on LinkedIn"),
            isPresented: Binding(get: { linkedInURL != nil }, set: { if !$0 { linkedInURL = nil } }),
            titleVisibility: .visible
        ) {
            Button(Copy.s(lang, pl: "Otwórz LinkedIn", en: "Open LinkedIn")) {
                if let linkedInURL { UIApplication.shared.open(linkedInURL) }
                linkedInURL = nil
            }
            Button(Copy.s(lang, pl: "Udostępnij odznakę PNG", en: "Share badge PNG")) {
                withFiles { files, _ in shareFiles([files.badge]) }
                linkedInURL = nil
            }
            Button(Copy.s(lang, pl: "Anuluj", en: "Cancel"), role: .cancel) { linkedInURL = nil }
        } message: {
            Text(Copy.s(
                lang,
                pl: "LinkedIn otworzy formularz Licenses & Certifications. Dołącz odznakę PNG (certyfikat ukończenia) — wygląda jak dyplom, nie jak znak zakazu. Pola w formularzu mogą wymagać ręcznego potwierdzenia.",
                en: "LinkedIn opens the Licenses & Certifications form. Attach the badge PNG (completion certificate) — diploma look, not a prohibition sign. Form fields may need manual confirmation."
            ))
        }
        .onChange(of: store.reportForm) { _, _ in cached = nil }
        .onChange(of: store.stamps) { _, _ in cached = nil }
        .onChange(of: store.language) { _, _ in cached = nil }
    }

    // MARK: Sections

    private var introPlate: some View {
        InkPlate {
            Text(Copy.s(
                lang,
                pl: "Lokalny PDF dla HR/IOD, do tego CSV (szablon rejestru szkoleń) i JSON (automatyzacja przypomnień). Pliki powstają na telefonie. Nic nie wychodzi samo — udostępniasz je przez systemowy arkusz, np. do Mail lub Plików.",
                en: "A local PDF for HR/DPO, plus CSV (training register template) and JSON (reminder automation). Files are generated on the phone. Nothing is sent on its own — you share them through the system sheet, e.g. Mail or Files."
            ))
            .font(Typeface.body(18))
            .foregroundStyle(Noir.paper)
            .lineSpacing(4)
            .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.horizontal, 16)
    }

    private var scopePicker: some View {
        VStack(alignment: .leading, spacing: 8) {
            kicker(Copy.s(lang, pl: "ZAKRES RAPORTU", en: "REPORT SCOPE"))
            ForEach(store.reportScopes) { candidate in
                let evaluation = store.evaluate(candidate)
                Button {
                    scope = candidate
                    cached = nil
                } label: {
                    HStack(alignment: .top, spacing: 12) {
                        Image(systemName: currentScope == candidate ? "largecircle.fill.circle" : "circle")
                            .font(.title3)
                            .foregroundStyle(currentScope == candidate ? Noir.blood : Noir.paperDim)
                            .frame(width: 28)
                        VStack(alignment: .leading, spacing: 2) {
                            Text(candidate.title(lang, lessons: store.lessons))
                                .font(Typeface.body(20))
                                .foregroundStyle(.white)
                            Text(scopeSummary(evaluation))
                                .font(Typeface.body(16))
                                .foregroundStyle(evaluation.passed ? Noir.paper : Noir.paperDim)
                        }
                        Spacer(minLength: 0)
                        Image(systemName: evaluation.passed ? "checkmark.seal.fill" : "hourglass")
                            .foregroundStyle(evaluation.passed ? Noir.blood : Noir.paperDim)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
            }
        }
        .padding(16)
        .background(Noir.ink)
        .padding(.horizontal, 16)
    }

    private func statusPlate(_ evaluation: PassEvaluation) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                kicker(evaluation.passed
                    ? Copy.s(lang, pl: "ZALICZONE", en: "PASSED")
                    : Copy.s(lang, pl: "JESZCZE NIE", en: "NOT YET"))
                Spacer()
                Text("\(evaluation.soundCount)/\(evaluation.lessonCount) · \(evaluation.percentSound)%")
                    .font(Typeface.mono(18))
                    .foregroundStyle(evaluation.passed ? Noir.paper : Noir.paperDim)
            }
            Text(Copy.s(
                lang,
                pl: "Próg: ≥ \(PassPolicy.thresholdPercent)% nocy z werdyktem TRAFNE (tu: min. \(evaluation.requiredSound) z \(evaluation.lessonCount)). Liczy się ostatni werdykt po przejrzanym briefingu. Każda noc w zakresie musi mieć stempel.",
                en: "Threshold: ≥ \(PassPolicy.thresholdPercent)% of nights with a SOUND verdict (here: at least \(evaluation.requiredSound) of \(evaluation.lessonCount)). The last verdict after its briefing counts. Every night in scope needs a stamp."
            ))
            .font(Typeface.body(16))
            .foregroundStyle(Noir.paperDim)
            .lineSpacing(3)
            .fixedSize(horizontal: false, vertical: true)

            if !evaluation.passed {
                if !evaluation.unstamped.isEmpty {
                    missingLine(
                        Copy.s(lang, pl: "Bez stempla", en: "No stamp"),
                        evaluation.unstamped
                    )
                }
                if !evaluation.unbriefed.isEmpty {
                    missingLine(
                        Copy.s(lang, pl: "Briefing do przejrzenia", en: "Briefing to read"),
                        evaluation.unbriefed
                    )
                }
                if evaluation.allStamped, evaluation.allBriefed, evaluation.missingSound > 0 {
                    missingLine(
                        Copy.s(
                            lang,
                            pl: "Poniżej progu — brakuje \(evaluation.missingSound) × TRAFNE. Zagraj ponownie z wokandy",
                            en: "Below threshold — \(evaluation.missingSound) more SOUND needed. Replay from the docket"
                        ),
                        evaluation.belowThreshold
                    )
                }
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Noir.ink)
        .overlay(Rectangle().stroke(evaluation.passed ? Noir.blood : Color.white.opacity(0.28), lineWidth: 1))
        .padding(.horizontal, 16)
    }

    private func missingLine(_ label: String, _ lessons: [Lesson]) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label.uppercased())
                .font(Typeface.mono(14))
                .foregroundStyle(Noir.blood)
                .tracking(1)
            ForEach(lessons) { lesson in
                Text(String(format: "%02d", lesson.order) + " · " + lesson.title.t(lang))
                    .font(Typeface.body(16))
                    .foregroundStyle(Noir.paper)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }

    private var formPlate: some View {
        VStack(alignment: .leading, spacing: 12) {
            kicker(Copy.s(lang, pl: "NA DYPLOMIE", en: "ON THE DIPLOMA"))
            field(
                Copy.s(lang, pl: "Imię i nazwisko (wymagane)", en: "Full name (required)"),
                text: $store.reportForm.employeeName,
                contentType: .name
            )
            field(
                Copy.s(lang, pl: "Nazwa organizacji", en: "Organisation"),
                text: $store.reportForm.organization,
                contentType: .organizationName
            )
            Text(Copy.s(
                lang,
                pl: "Dane zostają na telefonie i trafiają tylko do plików, które sam(a) udostępnisz. Język dyplomu: \(lang == .polish ? "polski" : "angielski") (wg języka gry).",
                en: "Data stays on the phone and goes only into the files you share yourself. Diploma language: \(lang == .polish ? "Polish" : "English") (follows the game language)."
            ))
            .font(Typeface.body(16))
            .foregroundStyle(Noir.paperDim)
            .lineSpacing(3)
            .fixedSize(horizontal: false, vertical: true)
        }
        .padding(16)
        .background(Noir.ink)
        .padding(.horizontal, 16)
    }

    private func field(_ label: String, text: Binding<String>, contentType: UITextContentType, keyboard: UIKeyboardType = .default) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(Typeface.mono(14))
                .foregroundStyle(Noir.paperDim)
            TextField("", text: text)
                .font(Typeface.body(20))
                .foregroundStyle(.white)
                .textContentType(contentType)
                .keyboardType(keyboard)
                .textInputAutocapitalization(keyboard == .emailAddress ? .never : .words)
                .autocorrectionDisabled(keyboard == .emailAddress)
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .background(Noir.void)
                .overlay(Rectangle().stroke(Color.white.opacity(0.28), lineWidth: 1))
        }
    }

    private var actionsPlate: some View {
        VStack(alignment: .leading, spacing: 12) {
            kicker(Copy.s(lang, pl: "PLIKI", en: "FILES"))
            if !canExport {
                Text(blockedReason)
                    .font(Typeface.body(16))
                    .foregroundStyle(Noir.paperDim)
                    .lineSpacing(3)
                    .fixedSize(horizontal: false, vertical: true)
            }
            actionButton(Copy.s(lang, pl: "Podgląd PDF", en: "Preview PDF"), system: "doc.richtext", primary: true) {
                withFiles { files, report in
                    preview = PreviewItem(data: report.pdf, url: files.pdf, title: ReportExporter.baseName(for: report.report))
                }
            }
            actionButton(Copy.s(lang, pl: "Udostępnij PDF", en: "Share PDF"), system: "square.and.arrow.up") {
                withFiles { files, _ in shareFiles([files.pdf]) }
            }
            actionButton(Copy.s(lang, pl: "Eksport CSV (rejestr szkoleń)", en: "Export CSV (training register)"), system: "tablecells") {
                withFiles { files, _ in shareFiles(files.csv) }
            }
            actionButton(Copy.s(lang, pl: "Eksport JSON (przypomnienia)", en: "Export JSON (reminders)"), system: "curlybraces") {
                withFiles { files, _ in shareFiles([files.json]) }
            }
            actionButton(Copy.s(lang, pl: "Udostępnij komplet", en: "Share everything"), system: "square.and.arrow.up.on.square") {
                withFiles { files, _ in shareFiles(files.all) }
            }
            actionButton(Copy.s(lang, pl: "Udostępnij odznakę (PNG)", en: "Share badge (PNG)"), system: "rosette") {
                withFiles { files, _ in shareFiles([files.badge]) }
            }
            actionButton(Copy.s(lang, pl: "Dodaj do LinkedIn", en: "Add to LinkedIn"), system: "link") {
                withFiles { _, report in
                    if LinkedInCertification.addToProfileURL(for: report.report) != nil {
                        linkedInURL = LinkedInCertification.addToProfileURL(for: report.report)
                    }
                }
            }
            if !ReportVerify.isPublicRegistryLive {
                Text(Copy.s(
                    lang,
                    pl: "Odznaka i deeplink LinkedIn działają offline. Publiczna weryfikacja (colgante.pl/verify, wariant A bez imienia) jest w przygotowaniu — nie twierdzimy, że już działa.",
                    en: "The badge and LinkedIn deeplink work offline. Public verify (colgante.pl/verify, variant A without the name) is not live yet — we do not claim it works."
                ))
                .font(Typeface.body(15))
                .foregroundStyle(Noir.paperDim)
                .lineSpacing(3)
                .fixedSize(horizontal: false, vertical: true)
            }
            if let cached {
                Text("reportId: \(cached.report.reportId.uuidString)")
                    .font(Typeface.mono(14))
                    .foregroundStyle(Noir.paperDim)
                    .textSelection(.enabled)
            }
        }
        .padding(16)
        .background(Noir.ink)
        .padding(.horizontal, 16)
    }

    private var blockedReason: String {
        guard let evaluation else {
            return Copy.s(lang, pl: "Brak lekcji w zakresie.", en: "No lessons in scope.")
        }
        if !evaluation.passed {
            return Copy.s(
                lang,
                pl: "Pliki odblokują się, gdy wybrany zakres przejdzie próg. Dyplom UKOŃCZONO nie powstaje poniżej progu.",
                en: "Files unlock once the selected scope passes the threshold. No COMPLETED diploma is issued below it."
            )
        }
        return Copy.s(lang, pl: "Wpisz imię i nazwisko do dyplomu.", en: "Enter the full name for the diploma.")
    }

    private var footerPlate: some View {
        InkPlate {
            Text(ReportBuilder.disclaimer(lang))
                .font(Typeface.body(16))
                .foregroundStyle(Noir.paperDim)
                .lineSpacing(3)
                .fixedSize(horizontal: false, vertical: true)
            Text(Copy.s(
                lang,
                pl: "Bez automatycznej wysyłki. Bez konta. Bez analityki. Werdykty per noc są tylko w CSV/JSON dla HR — nie na dyplomie.",
                en: "No automatic sending. No account. No analytics. Per-night verdicts live only in the HR CSV/JSON — not on the diploma."
            ))
            .font(Typeface.body(16))
            .foregroundStyle(Noir.paperDim)
            .lineSpacing(3)
            .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.horizontal, 16)
    }

    // MARK: Pieces

    private func kicker(_ text: String) -> some View {
        Text(text)
            .font(Typeface.mono(16))
            .foregroundStyle(Noir.blood)
            .tracking(1)
    }

    private func scopeSummary(_ evaluation: PassEvaluation) -> String {
        if evaluation.passed {
            return Copy.s(lang, pl: "\(evaluation.soundCount)/\(evaluation.lessonCount) TRAFNE — gotowe do raportu", en: "\(evaluation.soundCount)/\(evaluation.lessonCount) SOUND — ready to report")
        }
        if !evaluation.unstamped.isEmpty {
            return Copy.s(lang, pl: "Bez stempla: \(evaluation.unstamped.count) z \(evaluation.lessonCount)", en: "Unstamped: \(evaluation.unstamped.count) of \(evaluation.lessonCount)")
        }
        if !evaluation.unbriefed.isEmpty {
            return Copy.s(lang, pl: "Briefing do przejrzenia: \(evaluation.unbriefed.count)", en: "Briefings to read: \(evaluation.unbriefed.count)")
        }
        return Copy.s(lang, pl: "\(evaluation.soundCount)/\(evaluation.lessonCount) TRAFNE — brakuje \(evaluation.missingSound)", en: "\(evaluation.soundCount)/\(evaluation.lessonCount) SOUND — \(evaluation.missingSound) short")
    }

    private func actionButton(_ title: String, system: String, primary: Bool = false, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 10) {
                Image(systemName: system)
                Text(title)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer(minLength: 0)
            }
            .font(Typeface.mono(20))
            .foregroundStyle(primary ? Color.white : Noir.void)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 14)
            .padding(.horizontal, 16)
            .background(primary ? Noir.blood : Noir.paper)
            .opacity(canExport ? 1 : 0.35)
        }
        .buttonStyle(.plain)
        .disabled(!canExport)
    }

    // MARK: Report lifecycle

    /// One report (one `reportId`) per set of inputs; every file shares it.
    private func currentReport() -> CachedReport? {
        guard let evaluation, canExport else { return nil }
        if let cached, cached.scope == evaluation.scope { return cached }
        var config = ReportConfig.free
        config.language = lang
        let report = ReportBuilder.make(evaluation: evaluation, allLessons: store.lessons, form: store.reportForm, config: config)
        let pdf = ReportPDF.render(report)
        let badge = ReportBadge.render(report)
        let fresh = CachedReport(scope: evaluation.scope, report: report, pdf: pdf, badge: badge)
        cached = fresh
        return fresh
    }

    private func withFiles(_ body: (ReportFiles, CachedReport) -> Void) {
        guard let report = currentReport() else { return }
        do {
            let files = try ReportExporter.write(report.report, pdf: report.pdf, badge: report.badge)
            body(files, report)
        } catch {
            exportError = error.localizedDescription
        }
    }

    private func shareFiles(_ urls: [URL]) {
        share = ShareItem(urls: urls)
    }
}

// MARK: - State items

private struct CachedReport {
    var scope: ReportScope
    var report: TrainingReport
    var pdf: Data
    var badge: Data
}

private struct PreviewItem: Identifiable {
    let id = UUID()
    var data: Data
    var url: URL
    var title: String
}

private struct ShareItem: Identifiable {
    let id = UUID()
    var urls: [URL]
}

// MARK: - PDF preview

private struct PDFPreviewSheet: View {
    let data: Data
    let url: URL
    let title: String
    let language: AppLanguage
    @Environment(\.dismiss) private var dismiss
    @State private var sharing = false

    var body: some View {
        NavigationStack {
            PDFKitView(data: data)
                .ignoresSafeArea(edges: .bottom)
                .navigationTitle(title)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button(Copy.s(language, pl: "Zamknij", en: "Close")) { dismiss() }
                    }
                    ToolbarItem(placement: .primaryAction) {
                        Button {
                            sharing = true
                        } label: {
                            Label(Copy.s(language, pl: "Udostępnij", en: "Share"), systemImage: "square.and.arrow.up")
                        }
                    }
                }
        }
        .sheet(isPresented: $sharing) {
            ShareSheet(items: [url])
        }
    }
}

private struct PDFKitView: UIViewRepresentable {
    let data: Data

    func makeUIView(context: Context) -> PDFView {
        let view = PDFView()
        view.autoScales = true
        view.displayMode = .singlePageContinuous
        view.backgroundColor = UIColor(white: 0.12, alpha: 1)
        view.document = PDFDocument(data: data)
        return view
    }

    func updateUIView(_ view: PDFView, context: Context) {}
}

// MARK: - Share sheet

/// System share sheet. The user picks the destination; the app never sends anything itself.
struct ShareSheet: UIViewControllerRepresentable {
    let items: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: items, applicationActivities: nil)
    }

    func updateUIViewController(_ controller: UIActivityViewController, context: Context) {}
}
