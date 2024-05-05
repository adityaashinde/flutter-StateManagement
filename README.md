# flutter-StateManagement

State Management in flutter

# Overview of State Management

- Managing and maintaining the data within the application is known as state management.
- Effective state managemment ensures that the application behaves correctly and consistently in response to user interactions and system events.

- State management becomes crucial in complex applications where data needs to be shared across multiple Screens or widgets, updated dynamically, and synchronized with the user interface.

- In flutter there are 2 types of states in flutter
  1). Ephemeral State
  2). App State

## Ephemeral State

- The Ephemeral State is the state you can neatly contain in a single widget. It is also referred to as the local State.

- We can change the Ephemeral state using the setState(), but you will need the Stateful Widget.

- This state is used for the local variables of the given screen i.e. if your varibales are only used on that particular screen and are not passed to any of the other Screens.

## App State

- If we want to share the state across many parts of our app tehn the App State is used.

- Ex: The shopping cart infoin an e-commerce application, Login/Signup Info

- There are various ways available to maintain the App State

1. Inherited Widget

2. Provider (inspired by Inherited Widget)

3. Riverpod (The next version of Provider)

4. GetX
   
5. BLoC (Business Logic Component), etc

- There are 18 different options for the App State management recognized by Flutter.

# Provider

- The Provider is the Flutter package which is the wrapper around the Inherited Widget.
- The Provider package can be used to manage the state of the app.
  
- If we have an application in which we have multiple screens we need to pass the data from one screen to another without passing it into the constructor of the screens In this case we can use Provider.
  
- We will keep the provider as the first widget tree so it can be accessed throughout the widget tree.

## Types of Provider

1. Provider  

2. ChangeNotifierProvider

3. ProxyProvider

4. ChangeNotifierProxyProvider

5. FutureProvider

6. StreamProvider

7. ListnableProvider

8. ValueListnableProvider

### Key Terms in Provider

1. MultiProvider

2. ChangeNotifier

3. Consumer
