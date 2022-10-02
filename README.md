# Currency

Currency is an iOS currency converter app developed using Swift

## Usage
- Click on one of the numbers to edit a currency value. Values of other currencies will be automatically adjusted.
- Click plus button to add new currency.
- Swipe left to delete.
- Pull down to refresh data.

## Design Patterns
### VIPER Architectural Pattern
I decided to use VIPER for this project as it provides a clean separation of responsibilities. This provides high reusability and makes it easier to do unit testing. The classes are also generally less bulky compared to MVC and MVVM.

1. View: consists of ViewControllers and TableViewCells. Views notify the Presenter when user actions are detected and the Presenter will trigger UI updates when new data is received.
2. Interactor: manages data updates. It has a Requester for requesting new data from the server and a Storage that handles saving and fetching Entities from File Manager.
3. Presenter: bridges communication between View and Interactor. It consists of methods that listen to changes from either side.
4. Entity: consists of a passive data model.
5. Router: handles navigation.

### Delegate Pattern
I used this pattern to listen to user actions on UITextView and UIPickerView.

### Singleton Pattern
I created the Presenter as a Singleton to make it easily accessible by either the Views, Interactor, or Router. Another way of accessing the Presenter will be to add it as a property in all of these classes. However, it can easily create bugs. The property may be accessed before being set and if different Presenter instances are added to different classes, updates from those classes might not be conveyed properly.

## Further Development
Currently, the project only consists of a single page and hence it's not yet necessary to create protocols to bridge each VIPER component. However, if the project gets developed further I would add these protocols to conform to the Dependency Inversion principle which provides higher reusability.
