import Foundation

/// Files produced for one report. All live in the app's temporary directory and
/// leave the device only through the system share sheet.
struct ReportFiles: Equatable {
    var pdf: URL
    var registerCSV: URL
    var lessonsCSV: URL
    var json: URL

    var all: [URL] { [pdf, registerCSV, lessonsCSV, json] }
    var csv: [URL] { [registerCSV, lessonsCSV] }
}

enum ReportExporter {
    static var directory: URL {
        FileManager.default.temporaryDirectory.appendingPathComponent("EmployerReport", isDirectory: true)
    }

    static func baseName(for report: TrainingReport) -> String {
        let shortId = report.reportId.uuidString.prefix(8).lowercased()
        return "CzerwonaTeczka-raport-\(report.completionDate)-\(shortId)"
    }

    static func write(_ report: TrainingReport, pdf: Data) throws -> ReportFiles {
        let fm = FileManager.default
        try? fm.removeItem(at: directory)
        try fm.createDirectory(at: directory, withIntermediateDirectories: true)
        let base = baseName(for: report)
        let files = ReportFiles(
            pdf: directory.appendingPathComponent("\(base).pdf"),
            registerCSV: directory.appendingPathComponent("\(base).csv"),
            lessonsCSV: directory.appendingPathComponent("\(base)_lekcje.csv"),
            json: directory.appendingPathComponent("\(base).json")
        )
        try pdf.write(to: files.pdf, options: .atomic)
        try Data(ReportCSV.register(report).utf8).write(to: files.registerCSV, options: .atomic)
        try Data(ReportCSV.lessons(report).utf8).write(to: files.lessonsCSV, options: .atomic)
        try ReportJSON.encode(report).write(to: files.json, options: .atomic)
        return files
    }
}
