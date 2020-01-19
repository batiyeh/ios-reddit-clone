# StockX Interview Task

Reddit Post Viewer

Built using MVVM + Coordinators. For network requests I chose to go with a starting a basic URL session wrapper using RxSwift's Observables rather than something like Alamofire. I unit tested much of what I could and included a small UI test using a pattern we used at Ford (UITestFactory). Ideally I would have written a solution for mocking network calls for the UI tests but unfortunately I ran out of time before I could do so. Thanks for taking the time to review the project!


## Installation

3rd party libraries were installed using cocoapods:

1. Install cocoapods if not already installed using `brew install cocoapods` 

2. Then run `pod install` in the project's root directory.
