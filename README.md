#  Weather app

## Configuring the Project

1. The project using Pods as Dependency Manager. If you have not using Pods before please install following link: https://cocoapods.org/

2. Run Weather.xcworkspace

3. Configure the Team if you want to run it on real device. No need for simulator

4. Run the application


## Application Architecture

1. Application using two main layers: Presentation Layer and BusinessLayer

2. Presentation Layer using MVP(Model-View-Presenter)  to handles application logic, relating the how user interact with the UI, UI logic is handled by viewcontroller, and presenter is the coordinator between the View and BusinessLayer 

3. In this project, Business Layer contains logic about how app communicates with open weather API using WeatherServices


## Check list

1. Using swift as programming language
2. MVP as application architecture
3. Complete the UI
4. Unit test for SearchViewController & SearchInteractor(presenter)
6. Handle Error 
7. HTTP request using URLSession, with cache mechanism supported by URLCache 
8. To change font size of items, the display is scale according to font size
10. Application using SnapKit  to layout view programmatically







