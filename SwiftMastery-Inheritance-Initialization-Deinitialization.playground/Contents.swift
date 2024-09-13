import Foundation

/*:
 # 🚀 Mastering Swift Inheritance, Initialization & Deinitialization: Essential Concepts for Advanced Developers

 ## Introduction
 Understanding **inheritance**, **initialization**, and **deinitialization** in Swift is crucial for building advanced, scalable iOS applications. In this blog, we’ll explore these concepts through the lens of an Indian stock market app, making it more relatable and practical for developers.

 This note was written by Amitesh Mani Tiwari. If you have any questions, feel free to reach out at:
 amiteshmanitiwari1997@gmail.com
*/

//: ## 1. Inheritance in Swift

// Inheritance allows one class to inherit properties and methods from another class.
// Here’s an example of how a Stock class can be used to manage different types of Indian stocks.
class Stock {
    var ticker: String
    var price: Double
    
    init(ticker: String, price: Double) {
        self.ticker = ticker
        self.price = price
    }
    
    func description() -> String {
        return "\(ticker): ₹\(price)"
    }
}

// Subclassing Stock to create a specific type of stock, like an Indian Tech Stock.
class TechStock: Stock {
    var companyName: String
    
    init(ticker: String, price: Double, companyName: String) {
        self.companyName = companyName
        super.init(ticker: ticker, price: price)
    }
    
    override func description() -> String {
        return "\(companyName) (\(ticker)): ₹\(price)"
    }
}

let tcsStock = TechStock(ticker: "TCS", price: 3500.0, companyName: "Tata Consultancy Services")
print(tcsStock.description())
// Output: Tata Consultancy Services (TCS): ₹3500.0

// Explanation: The `TechStock` class inherits from `Stock` and overrides its `description()` method to include the company name, specific to Indian companies like TCS.

//: ## 2. Initialization in Swift

// Initializers ensure that all stored properties of a class or struct have valid values when an object is created.

//: ### a. Designated Initializers
class Portfolio {
    var stockList: [Stock]
    
    // Designated initializer
    init(stocks: [Stock]) {
        self.stockList = stocks
    }
    
    func portfolioValue() -> Double {
        return stockList.reduce(0) { $0 + $1.price }
    }
}

let stock1 = Stock(ticker: "RELIANCE", price: 2400.0)
let stock2 = Stock(ticker: "INFY", price: 1600.0)
let portfolio = Portfolio(stocks: [stock1, stock2])
print("Portfolio Value: ₹\(portfolio.portfolioValue())")
// Output: Portfolio Value: ₹4000.0

// Explanation: The `Portfolio` class initializes with an array of stocks and calculates the total portfolio value.

//: ### b. Convenience Initializers

// Convenience initializers provide alternative ways to initialize a class.
class Investor {
    var name: String
    var portfolio: Portfolio?
    
    // Designated initializer
    init(name: String) {
        self.name = name
    }
    
    // Convenience initializer
    convenience init(name: String, stocks: [Stock]) {
        self.init(name: name)
        self.portfolio = Portfolio(stocks: stocks)
    }
}

let investor = Investor(name: "Amitesh", stocks: [stock1, stock2])
print("\(investor.name)'s Portfolio Value: ₹\(investor.portfolio?.portfolioValue() ?? 0)")
// Output: Amitesh's Portfolio Value: ₹4000.0

// Explanation: The convenience initializer allows us to create an `Investor` with stocks without needing to manually create the `Portfolio` first.

//: ## 3. Deinitialization in Swift

// Deinitializers are called when a class instance is deallocated to release resources or perform cleanup.

class Broker {
    var name: String
    var activeClients: Int
    
    init(name: String, activeClients: Int) {
        self.name = name
        self.activeClients = activeClients
        print("\(name) is handling \(activeClients) clients.")
    }
    
    // Deinitializer
    deinit {
        print("\(name) is no longer handling clients.")
    }
}

// Creating and deallocating a Broker instance
var broker: Broker? = Broker(name: "Satyendra", activeClients: 15)
broker = nil
// Output: Satyendra is no longer handling clients.

// Explanation: When `broker` is set to `nil`, the `deinit` method is called, releasing the broker from handling clients.

//: ## 4. Failable Initializers

// Failable initializers return `nil` when initialization fails.
class StockMarketApp {
    var userFunds: Double
    
    init?(funds: Double) {
        if funds < 0 {
            return nil
        }
        self.userFunds = funds
    }
}

let validUser = StockMarketApp(funds: 10000)
let invalidUser = StockMarketApp(funds: -5000) // Initialization fails and returns nil

// Explanation: If a user tries to enter negative funds, the initialization fails and returns `nil`.

//: ## 5. Final Classes and Methods

// Marking a class or method as `final` prevents it from being subclassed or overridden.
final class NSE {
    static let totalFunds = 50000000.0
    
    final func showFunds() {
        print("Total NSE Funds: ₹\(NSE.totalFunds)")
    }
}

let nse = NSE()
nse.showFunds()
// Output: Total NSE Funds: ₹50000000.0

// Explanation: The `NSE` class and `showFunds` method cannot be subclassed or overridden, ensuring stability for core functionalities.

//: ## 6. Property Observers

// Property observers allow you to monitor changes to a property’s value.
class StockValue {
    var price: Double = 1000.0 {
        willSet {
            print("The stock price will change to ₹\(newValue)")
        }
        didSet {
            print("The stock price changed from ₹\(oldValue) to ₹\(price)")
        }
    }
}

let stockValue = StockValue()
stockValue.price = 1200.0
stockValue.price = 1500.0

// Explanation: Property observers `willSet` and `didSet` are used to monitor the changes in stock price, similar to how real-time price updates work in stock market apps.

//: ## 7. Mutating Methods in Structs

// Mutating methods in structs can modify the properties of the struct.
struct StockTransaction {
    var stockName: String
    var sharesBought: Int
    
    mutating func updateShares(_ count: Int) {
        sharesBought += count
    }
}

var transaction = StockTransaction(stockName: "Infosys", sharesBought: 10)
transaction.updateShares(5)
print("Updated shares for \(transaction.stockName): \(transaction.sharesBought) shares")

// Explanation: `updateShares` is a mutating method that changes the `sharesBought` property of the `StockTransaction` struct. Mutating methods are essential when modifying properties within a struct.

//: ## 8. Choosing Between Structs and Classes

// Structs are value types, and classes are reference types. Choose based on whether you need shared state or independent instances.
struct StockLocation {
    var latitude: Double
    var longitude: Double
}

var bseLocationA = StockLocation(latitude: 18.929, longitude: 72.8355)
var bseLocationB = bseLocationA // Deep copy, separate instances
bseLocationB.latitude = 19.075

print("BSE Location A: \(bseLocationA.latitude), \(bseLocationA.longitude)")
print("BSE Location B: \(bseLocationB.latitude), \(bseLocationB.longitude)")

// Explanation: `StockLocation` is a struct, so `bseLocationA` and `bseLocationB` are independent instances. Modifying `bseLocationB` does not affect `bseLocationA`.

class SEBI {
    var rule: String = "Regulate"
}

let sebiA = SEBI()
let sebiB = sebiA // Shallow copy, shared reference

sebiB.rule = "Deregulate"
print("SEBI A Rule: \(sebiA.rule)")
print("SEBI B Rule: \(sebiB.rule)")

// Explanation: `SEBI` is a class, so `sebiA` and `sebiB` share the same instance. Modifying `sebiB` also affects `sebiA`.

