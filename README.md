 
## MVC (Model-View-Controller)

* Model: Contains a data structure for representing objects in the application such as User, Product, or Event.

* View: Contains parts related to various types of display, such as the login screen, product list screen, or product details screen.

* Controller: handles data and display, for example pulling user information from a database and displaying it on the screen.

Usage:
* Suitable for projects that have clear division of duties and controls between data (Model), display (View), and control operations (Controller).
* Works well for simple and not very complicated projects.


## MVVM ( Model-View-ViewModel )
* Model: Contains a data structure for representing objects in the application such as User, Product, or Event.

* View: Displays things like layouts for user information, and other UI elements.

* ViewModel: directly manipulates the state and display of the View, such as checking data before displaying, formatting data so that the View can display properly.

Usage:
* Suitable for projects that involve working with complex data. ViewModel is used as a way to manage and transform data so that View can display it appropriately.
* Efficient in working with complex UIs and with frequently updated data.

## MVP ( Model-View-Presenter )
* Model: Contains a data structure for representing objects in the application such as User, Product, or Event.

* View: Displays and interacts with the user, such as a subscription form, home page, or settings window.

* Presenter: Handles responses from users. and process information, for example, checking settings, updating screen information.

Usage:
* Suitable for projects where the duties of displaying data and managing data are clearly separated.
* Presenter is used as a communication channel between Model and View without creating a direct connection between View and Model.

## VIPER ( View-Interactor-Presenter-Entity-Routing )
* View: Display and interact with the user. which is not responsible for data processing.

* Interactor: is responsible for dealing with data and business transactions, such as retrieving data from a server, managing data or interacting with a database.

* Presenter: Manages the display and processing of data, such as setting data formats for display, directly controlling processing.

* Entity: A data structure for representing objects in an application. Used as a database or data representative.

* Routing: Handles transitions and navigation between screens, such as creating navigation routes and navigating through screens.


Usage:
* Suitable for projects that are complex and important for testing. (testability) by dividing duties into layers in work
* Each section is independent and connected through an interface.
