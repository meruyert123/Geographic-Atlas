# Geographic-Atlas

## Description
This is an iOS test assignment for the STRONG TEAM Summer Internship. The goal is to develop a Geographic Atlas iPhone application that allows users to learn more about world countries, browse a list of countries grouped by parts of the world, and view detailed information about any country.

## Application usage
You can go through scrollable list of all the world countries grouped by parts of the world.

Each element in the list able to switch between expanded/collapsed states when the user taps on the element.

By tapping the “Learn more” button in the expanded element state, screen will provide the detailed information of the currently selected country. 

## Getting started
## Installing and running the app
To install and run the app, follow these steps:
1. Clone the repository to your local machine using the following command:
```
$ git clone https://github.com/meruyert123/Geographic-Atlas.git
```
2. Open the project in Xcode by double-clicking the .xcodeproj file.
3. Select a simulator or a connected device from the Xcode toolbar.
4. Click the "Run" button (or press Cmd+R) to build and run the app on the selected device.
5. The app should now launch on the simulator or connected device you selected.

## Architecture
This project follows the MVVM (Model-View-ViewModel) architecture pattern. The MVVM pattern separates the user interface (view) from the business logic (view model) and the data (model) to improve code organization, reusability, and testability.
### Components
• Models: Contains the data structures or entities used in the application. These models encapsulate the data and business logic related to them.

• Views: Responsible for presenting the user interface. Views in SwiftUI are defined using a declarative syntax and can be composed hierarchically to build complex UIs.

• Components: Reusable UI elements or widgets that can be used across different views. Components encapsulate specific functionality or UI design and can be composed within views.

• Data: Handles data retrieval, storage, and manipulation. This layer may include services, repositories, or APIs for managing data operations.

• View Models: Acts as intermediaries between the views and the data. View models expose data and methods that views can bind to and interact with. They retrieve data from the data layer, perform any required transformations or computations, and update the views accordingly.


## Advanced
1. Use SwiftUI only
2. Use “skeleton views” for all the elements while API requests are performed
3. Make the expand/collapse feature for CountriesList animated, with no UI bugs
4. Add the images caching and reuse them from cache
5. Use “nice” naming
6. Write safe code, leave no possibility of crashes
7. Make the “Capital coordinates” latitude + longitude value on the CountryDetails screen tappable;




Great job! 

