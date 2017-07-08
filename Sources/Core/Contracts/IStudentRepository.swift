public protocol IStudentRepository {
    func getBy(id: Int) -> Student
    func save(student: Student)
}
