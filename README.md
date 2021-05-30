# Adichallenge

## Description


The first screen will be a list of products, we need to show the product image and some other info that comes back from the API (product name, description, and price). When clicking on an element from the first screen we should move to the detail screen, where we will see a bigger image and bigger information and also the reviews we've for that product. On the detail screen, we need to allow the user to write reviews for that specific product and to trigger an API call to save that information in the system. 

## Guidelines

* App resilience
* App stability
* Testing
* App Architecture
* Ul/UX

## Architecture

My decision for the architecture has been use MVVM. The reason behind that is that I am familiar with it and since the models from the API doesn't require high amount of modification in terms of getting presented, I didn't chose an approach as it could be VIPER or VIP. 

## Design patterns
Factory pattern in order to create dependencies in a way that can easily be tested.

Coordinator pattern for handling the navigation.

## Modularisation

I decoupled the app with Domain and Network layer. I have used Swift Package Manager for that, and the reason behind it, it's because it's the Apple native solution and I did want to experiment with it.

## Frameworks used

* **RxSwift & RxCocoa:** Benefits from RxSwift and RxCocoa are multiples as simplified Asynchronous declative code and multithreading, therefore you endup having a cleaner and more readable code and architecture. Allows composability. It's multi platform, which means if you learn it in Swift you will be able to use it in any other of the other languages that supports it (http://reactivex.io/languages.html). It's open source which means that has a huge community behind it, which means that likelihood of not being up to date it's unlikely. The downsides of this framework, which it's possible that will easily integrate all over the place in your aapp, are learning process at the beginning it's going to seem rough, but worth it on my opinion. Since you will be working with asynchronous code it might lead to memory leaks if not handled properly. Last one is debugging, usually has a big stack trace which make it sometimes hard to find the issue.

* **PKHUD:** I have used it for the loader. I didn't want to necessarily spend so many time on creating a loader since UI was important but not critical. I have had experience with this framework and it has really nice and easy integration.

* **SwiftLint & Swiftformat:** I have used it for giving format to code and be consistent all over the places with the styling.

* **RxTest & RxBlocking:** I have used them to test the stream of events generated for the views.

* **Kingfisher:** I have used it to load the images from the URL, used mainly because of being handy, not because it's solves a big problem.

## Improvements

The duration of the assingment was 3 days, and I thought I would have more time to do work on it but due to I had to work that's what I have accomplished so far and those are the following improvements that I would like to introduce.

### Database

For simplicity, I have stored the data to UserDefaults but definitiely this is not the place to store such data. I would move the database to **Realm** or **CoreData**.

### Reachability

Due to limitation of time, I didn't implement reachability but I would be more than happy to be able to discuss it during the interview the way that I would implement it. It's going to be awesome and really easy! Since I have stored everything on a "database", from the UseCase I will verify if there is Network connection, and if there is not, I would return the products or data that I have stored on the database. All transparent to the ViewModel!

### Monitoring

I would like to also add monitoring for the errors. For now I have added assertionFailures and debugPrints, which are definitely not the tool to go. We can also discuss further on the interview how this could be done properly.

### Localization

We could also introduce some localization since we are expecting people from all over the world using this wonderful App!

### Code reusability

I have tried to go as faster as I could coding, but I have seen that there is a lot of code that could be reused over some of my cells configuration and so on. Let's discuss it later on!

### Testability

I have introduced tests mostly for one of the most complext viewModels for the products list, in order to give you an idea how it will be the rest of the tests, but we can discuss any other scene that you would like to see tests on it!

Would be convinient to test the data contracts in order to make sure that we are on track with backenders.

Definitely, I would love to introduce some snapshot testing or UI testing!

## Snapshots

<img width="300" alt="Screenshot 2021-05-04 at 11 28 23" src="https://user-images.githubusercontent.com/12100457/120098797-2b141d80-c138-11eb-8e7c-4e7a1eacd763.png">
<img width="300" alt="Screenshot 2021-05-04 at 11 28 23" src="https://user-images.githubusercontent.com/12100457/120098799-2d767780-c138-11eb-9a2c-ca63c0d55fa8.png">
<img width="300" alt="Screenshot 2021-05-04 at 11 28 23" src="https://user-images.githubusercontent.com/12100457/120098800-2ea7a480-c138-11eb-9819-bd337c85c8fe.png">
<img width="300" alt="Screenshot 2021-05-04 at 11 28 23" src="https://user-images.githubusercontent.com/12100457/120098801-2fd8d180-c138-11eb-9329-a253c5c1fe4c.png">

