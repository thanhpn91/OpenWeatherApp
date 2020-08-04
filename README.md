#  Weather app

## Configuring the Project

1. The project using Pods as Dependency Manager. If you have not using Pods before please install following link: https://cocoapods.org/

2. Run pod install to setup with dependencies

3. Run Weather.xcworkspace

4. Configure the Team if you want to run it on real device. No need for simulator

5. Run the application


## Application Architecture

- Application using two main layers: Presentation Layer and BusinessLayer

- Presentation Layer using MVP(Model-View-Interactor)  to handle application logic, relating the how users interact with the UI, viewController is passively received action from users , also from view lifecycle, then pass action to interactor.

- Interactor on the other hands, will decide what to do next, whether it should get data from remote server or persistance store, preparing the display data. We do not use the business model for displaying, data should be parse into intermediate form such as display data, which contains enough information to display. The interactor then call the view to display new informations, error, or loading state.

-  Business Layer contains the business logic, which can be grouped into modules we can named it services. It also contains support modules such as network request, cache mechanism.

- For this application we can have one service called weather services which handle logic relating to weather. For larger project, more services can be introduced. An facade pattern can be use to reduce the complexity working with many services. Facade can wrap all services inside, and allow two or more services communicate with each others.

### Image illustates how everything works together
![Image of Application architecture](https://github.com/thanhpn91/OpenWeatherApp/blob/master/Resources/Application_architecture.png)

### Folder structures:

![Image of Folder structures](https://github.com/thanhpn91/OpenWeatherApp/blob/master/Resources/Folder_structures.png)

## Check list

- [x] Using swift as programming language
- [x] MVP as application architecture
- [x] Complete the UI
- [x] Unit test for SearchViewController & SearchInteractor(presenter)
- [x] Handle Error 
- [x] HTTP request using URLSession, with cache mechanism supported by URLCache 
- [x] To change font size of items, the display is scale according to font size
- [x] Application using SnapKit  to layout view programmatically







