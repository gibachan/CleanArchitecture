public class RequestCourseRegistrationInteractor: IRequestHandler {
    public typealias TRequest = CourseRegistrationRequestMessage
    public typealias TResponse = CourseRegistrationResponseMessage
    
    private let _studentRepository: IStudentRepository
    private let _courseRepository: ICourseRepository
    private let _authService: IAuthService
    
    public init(authService: IAuthService, studentRepository: IStudentRepository, courseRepository: ICourseRepository) {
        _authService = authService
        _studentRepository = studentRepository
        _courseRepository = courseRepository
    }

    public func handle(message: CourseRegistrationRequestMessage) -> CourseRegistrationResponseMessage {
        // student must be logged into system
        if (!_authService.isAuthenticated()) {
            return CourseRegistrationResponseMessage(success: false, errors: nil, message: "Operation failed, not authenticated.")
        }
        
        // get the student
        let student = _studentRepository.getBy(id: message.studentId)
 
        // save off any failures
        var errors = [String]()
        
        for c in message.selectedCourseCodes {
            let course = _courseRepository.getBy(code: c)
            if (!student.RegisterFor(course: course)) {
                errors.append("unable to register for \(course.code)")
            }
        }

        _studentRepository.save(student: student);
        
        return CourseRegistrationResponseMessage(success: errors.isEmpty, errors: errors)
    }
}
