public class CourseRegistrationRequestMessage: IRequest {
    public private(set) var studentId: Int
    public private(set) var selectedCourseCodes: [String]
    
    public init(studentId: Int, selectedCourseCodes: [String]) {
        self.studentId = studentId
        self.selectedCourseCodes = selectedCourseCodes
    }
}
