#  Weather app

## Configuring the Project

1. The project using Pods as Dependency Manager. If you have not using Pods before please install following link: https://cocoapods.org/

2. Run pod install to setup with dependencies

3. Run Weather.xcworkspace

4. Configure the Team if you want to run it on real device. No need for simulator

5. Run the application


## Application Architecture

1. Application using two main layers: Presentation Layer and BusinessLayer

2. Presentation Layer using MVP(Model-View-Interactor)  to handles application logic, relating the how user interact with the UI, UI logic is handled by viewcontroller, and Interactor is the coordinator between the View and BusinessLayer 

3. Business Layer contains logic about how app communicates with open weather API using WeatherServices

Image illustates how everything works together
Inline-style: 
![alt text]("https://github.com/thanhpn91/OpenWeatherApp/Resources/Application_architecture.png" "Application Architecture")

Folder structures:
Inline-style: 
![alt text]("https://github.com/thanhpn91/OpenWeatherApp/Resources/Application_architecture.png" "Application Architecture")

## Check list

- [x] Using swift as programming language
- [x] MVP as application architecture
- [x] Complete the UI
- [x] Unit test for SearchViewController & SearchInteractor(presenter)
- [x] Handle Error 
- [x] HTTP request using URLSession, with cache mechanism supported by URLCache 
- [x] To change font size of items, the display is scale according to font size
- [x] Application using SnapKit  to layout view programmatically







