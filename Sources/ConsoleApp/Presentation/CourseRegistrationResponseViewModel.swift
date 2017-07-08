class CourseRegistrationResponseViewModel {
    public private(set) var success: Bool
    public private(set) var resultMessage: String
    
    init(success: Bool, resultMessage: String) {
        self.success = success
        self.resultMessage = resultMessage
    }
}
