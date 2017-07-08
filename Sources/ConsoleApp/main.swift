import Core
import Rainbow

let authService = AuthService()
let courseRepository = CourseRepository()
let studentRepository = StudentRepository()

let courses = courseRepository.getAll()

var userInput = ""

while true {
//    Console.BackgroundColor = ConsoleColor.Black;
//    Console.ForegroundColor = ConsoleColor.White;
    print("Course Registration".black.onWhite)
    print()
    
    for c in courses {
        print("\(c.code) - \(c.description) - Starts: \(c.startDate)".black.onWhite)
    }
    
    print()
    print()
    print("Course Registration".black.onWhite)
    
    userInput = readLine() ?? "quit"
    if userInput == "quit" {
        break
    }
    
    if !courses.contains(where: { (c) -> Bool in
        return c.code == userInput
    }) {
        print("The code you entered is no acceptable".red.onWhite)
        continue
    }
    
    //*************************************************************************************************
    // Here we're connecting our app framework layer with our Use Case Interactors
    // This would typically go in a Controller Action in an MVC context or ViewModel in MVVM etc.
    //*************************************************************************************************
    // 1. instantiate Course Registration Use Case injecting Gateways implemented in this layer
    let courseRegistraionRequestUseCase = RequestCourseRegistrationInteractor(authService: authService, studentRepository: studentRepository, courseRepository: courseRepository)
    
    // 2. create the request message passing with the target student id and a list of selected course codes
    let useCaseRequestMessage = CourseRegistrationRequestMessage(studentId: 1, selectedCourseCodes: [userInput.uppercased()])
    
    // 3. call the use case and store the response
    let responseMessage = courseRegistraionRequestUseCase.handle(message: useCaseRequestMessage)
    
    // 4. use a Presenter to convert the use case response to a user friendly ViewModel
    let courseRegistraionResponsePresenter = CourseRegistrationResponsePresenter()
    let vm = courseRegistraionResponsePresenter.handle(responseMessage: responseMessage)
    
    print("\u{001B}[2J") // Clear console
    
    // render results
    print()
    if (vm.success) {
        print(vm.resultMessage.green.onWhite)
    } else {
        print(vm.resultMessage.red.onWhite)
    }
    print()
}

