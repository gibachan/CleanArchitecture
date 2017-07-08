public class CourseRegistrationResponseMessage: ResponseMessage {
    public var errors: [String]?
    
    public init(success: Bool, errors: [String]?, message: String? = nil) {
        super.init(success: success, message: message)
        self.errors = errors
    }
}
