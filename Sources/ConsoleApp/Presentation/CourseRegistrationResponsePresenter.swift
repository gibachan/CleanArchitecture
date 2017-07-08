import Core

class CourseRegistrationResponsePresenter {
    func handle(responseMessage: CourseRegistrationResponseMessage) -> CourseRegistrationResponseViewModel {
        if (responseMessage.success) {
            return CourseRegistrationResponseViewModel(success: true, resultMessage: "Course registration successful!")
        }
        
        var message = "Failed to register course(s)¥n"
        for e in responseMessage.errors ?? [] {
            message += (e + "¥n")
        }
        return CourseRegistrationResponseViewModel(success: false, resultMessage: message)
    }
}
