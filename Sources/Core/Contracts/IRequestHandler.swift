public protocol IRequestHandler {
    associatedtype TRequest = IRequest
    associatedtype TResponse
    
    func handle(message: TRequest) -> TResponse
}
