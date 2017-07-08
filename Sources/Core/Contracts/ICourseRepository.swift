public protocol ICourseRepository {
    func getBy(code: String) -> Course
    func getAll() -> [Course]
}
