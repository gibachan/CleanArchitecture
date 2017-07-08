import Core

class StudentRepository: IStudentRepository {
    fileprivate var student = Student()

    func getBy(id: Int) -> Student {
        return student
    }
    
    func save(student: Student) {
        self.student = student
    }
}
