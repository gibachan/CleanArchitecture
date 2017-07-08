public class ResponseMessage {
    public var success: Bool
    public var message: String?
    
    init(success: Bool, message: String?) {
        self.success = success
        self.message = message
    }
}
