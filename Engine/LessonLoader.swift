import Foundation

enum LessonLoaderError: Error {
    case missingFile
    case emptyPack
}

enum LessonLoader {
    static func load(from bundle: Bundle = .main) throws -> [Lesson] {
        guard let url = bundle.url(forResource: "Lessons", withExtension: "json") else {
            throw LessonLoaderError.missingFile
        }
        let data = try Data(contentsOf: url)
        let lessons = try JSONDecoder().decode([Lesson].self, from: data)
        if lessons.isEmpty { throw LessonLoaderError.emptyPack }
        return lessons.sorted { $0.order < $1.order }
    }
}
