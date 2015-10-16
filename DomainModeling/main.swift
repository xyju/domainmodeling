//
//  main.swift
//  DomainModeling
//
//  Created by Xiangyu Ju on 10/15/15.
//  Copyright © 2015 Xiangyu Ju. All rights reserved.
//

import Foundation

enum Currency {
    
    case USD
    
    case GBP
    
    case EUR
    
    case CAN
    
}

// Money
struct Money {
    
    var amount: Double
    
    var currency: Currency
    
    //Convert
    func convert(convertCurrency: Currency) -> Money {
        
        if(currency == convertCurrency) {
            
            return self
            
        } else {
            
            switch(currency, convertCurrency) {
                
            case(.USD, .GBP):
                
                return Money(amount: amount * 0.5, currency: convertCurrency)
                
            case(.USD, .EUR):
                
                return Money(amount: amount * 1.5, currency: convertCurrency)
                
            case(.USD, .CAN):
                
                return Money(amount: amount * 1.25, currency: convertCurrency)
                
            case(.GBP, .USD):
                
                return Money(amount: amount * 2, currency: convertCurrency)
                
            case(.GBP, .EUR):
                
                return Money(amount: amount * 3, currency: convertCurrency)
                
            case(.GBP, .CAN):
                
                return Money(amount: amount * 2.5, currency: convertCurrency)
                
            case(.EUR, .USD):
                
                return Money(amount: amount * 2 / 3, currency: convertCurrency)
                
            case(.EUR, .GBP):
                
                return Money(amount: amount / 3, currency: convertCurrency)
                
            case(.EUR, .CAN):
                
                return Money(amount: amount * 5 / 6, currency: convertCurrency)
                
            case(.CAN, .USD):
                
                return Money(amount: amount * 0.8, currency: convertCurrency)
                
            case(.CAN, .GBP):
                
                return Money(amount: amount * 0.4, currency: convertCurrency)
                
            case(.CAN, .EUR):
                
                return Money(amount: amount * 1.2, currency: convertCurrency)
                
            default:
                
                print("Input Error")
                
                return self
                
            }
            
        }
        
    }
    
    // Array Add
    func add(moneys: [Money]) -> Money {
        
        var amount = 0.0
        
        for index in 0...moneys.count - 1{
            
            amount = amount + moneys[index].convert(moneys[0].currency).amount
            
        }
        
        return Money(amount: amount, currency: moneys[0].currency)
        
    }
    
    //Array Subtract
    func sub(moneys: [Money]) -> Money {
        
        var amount = moneys[0].amount
        
        for index in 1...moneys.count - 1{
            
            amount = amount - moneys[index].convert(moneys[0].currency).amount
            
        }
        
        return Money(amount: amount, currency: moneys[0].currency)
        
    }
    
}

// Unit Test: Money Convert
var currentMoney1 = Money(amount: 60, currency: .EUR)

var convertMoney1 = currentMoney1.convert(.USD)

print(convertMoney1.amount, convertMoney1.currency)

var currentMoney2 = Money(amount: 30, currency: .CAN)

var convertMoney2 = currentMoney2.convert(.EUR)

print(convertMoney2.amount, convertMoney2.currency)

// Unit Test: Money Add
var money = Money(amount:3, currency:.EUR)

var totleMoney1 = money.add([Money(amount: 3, currency: .USD), Money(amount: 9, currency: .EUR), Money(amount: 5, currency: .CAN)])

print(totleMoney1.amount, totleMoney1.currency)

var totleMoney2 = money.add([Money(amount: 32, currency: .USD), Money(amount: 99, currency: .EUR), Money(amount: 52, currency: .CAN)])

print(totleMoney2.amount, totleMoney2.currency)

// Unit Test: Money Subtract
var totleMoney3 = money.sub([Money(amount: 3, currency: .USD), Money(amount: 9, currency: .EUR), Money(amount: 5, currency: .CAN)])

print(totleMoney3.amount, totleMoney3.currency)

var totleMoney4 = money.sub([Money(amount: 33, currency: .EUR), Money(amount: 99, currency: .GBP), Money(amount: 52, currency: .CAN)])

print(totleMoney4.amount, totleMoney4.currency)


// Job
enum Per{
    
    case hour
    
    case year
}


struct Salary{
    
    var money: Money
    
    var per: Per
}


class Job {
    
    var title: String
    
    var salary: Salary
    
    init(currentTitle: String, currentSalary: Salary) {
        
        title = currentTitle
        
        salary = currentSalary
        
    }
    
    func calculateIncome(hours: Double) -> Money {
        
        if salary.per == .hour {
            
            return Money(amount: salary.money.amount * hours, currency: salary.money.currency)
            
        }
        
        return salary.money
        
    }
    
    func raise(percentage: Double) -> Salary {
        
        return Salary(money: Money(amount: salary.money.amount * (1 + percentage),currency: salary.money.currency), per: salary.per)

    }
    
}

//Unit Test: Job CalculateIncome
var job1 = Job(currentTitle: "Engineer", currentSalary: Salary(money: Money(amount: 30, currency: .USD), per: .hour))

var moneyPerYear1 = job1.calculateIncome(2500)

print(moneyPerYear1.amount, moneyPerYear1.currency)

var job2 = Job(currentTitle: "Doctor", currentSalary: Salary(money: Money(amount: 150000, currency: .CAN), per: .year))

var moneyPerYear2 = job2.calculateIncome(1500)

print(moneyPerYear2.amount, moneyPerYear2.currency)

//Unit Test: Job Raise
var salary1 = job1.raise(0.2)

print(salary1.money.amount, salary1.money.currency, salary1.per)

var salary2 = job2.raise(0.2)

print(salary2.money.amount, salary2.money.currency, salary2.per)


//Person
class Person {
    
    var firstName: String
    
    var lastName: String
    
    var age: Int
    
    var job: Job?
    
    var spouse: Person?
    
    init(first: String, last: String, age: Int, job: Job?, spouse: Person?) {
        
        firstName = first
        
        lastName = last
        
        self.age = age
        
        self.job = job
        
        self.spouse = spouse
        
        if self.age < 16{
            
            if self.job != nil{
                
                self.job = nil
                
                print("The person cannot have a job!")
                
            }
            
        }
        
        if self.age < 18{
            
            if self.spouse != nil{
                
                self.spouse = nil
                
                print("The person cannot have a spouse!")
                
            }
        }
    }
    
    func toString() {
        
        print("FirstName:" , self.firstName , "LastName:" , self.lastName , "Age:" ,self.age, "Job Title:" , self.job!.title, "Job Salary:", self.job!.salary.money.amount, self.job!.salary.money.currency, "Per:", self.job!.salary.per)
        
        if self.spouse != nil{
            
            print("Spouse:")
            
            self.spouse!.toString()
        } else {
            
            print("Spouse: N/A")
            
        }
    }
    
}

// Unit Test: Person toString()
var person1 = Person(first: "Xiangyu", last: "Ju", age: 25, job: job1, spouse: nil)

print("Person 1:")

person1.toString()

var person2 = Person(first: "Lily", last: "Joe", age: 23, job: job1, spouse: nil)

var person3 = Person(first: "Zixuan", last: "Wang", age: 23, job: job2, spouse: person2)

print("Person 3:")

person3.toString()

//Unit Test: If the Person is under age 16, they cannot have a job
var person4 = Person(first: "Zixuan", last: "Wang", age: 12, job: job2, spouse: nil)

//Unit Test: If the Person is under age 18, they cannot have a spouse
var person5 = Person(first: "Zixuan", last: "Wang", age: 17, job: job2, spouse: person1)


//Family
class Family{
    
    var members:[Person]
    
    init(members: [Person]) {
        
        self.members = members
        
        var isFamily = false
        
        for index in 0...self.members.count - 1 {
            
            if self.members[index].age > 21{
                
                isFamily = true
                
            }
        }
        
        if !isFamily{
            
            print("The family is not legal!")
            
        }
    }
    
    func householdIncome() -> Money{
        
        var moneys = [Money]()
        
        for index in 0...members.count - 1{
            
            if members[index].job != nil{
                
                moneys.append(members[index].job!.salary.money)
            }
        }
        
        return (members[0].job?.salary.money.add(moneys))!
        
    }
    
    func haveChild() -> Family{
        
        self.members.append(Person(first:"N/A", last: "N/A", age:0, job: nil, spouse: nil))
        
        return self
        
    }
}

// Unit Test

// var job1 = Job(currentTitle: "Engineer", currentSalary: Salary(money: Money(amount: 30, currency: .USD), per: .hour))

// var job2 = Job(currentTitle: "Doctor", currentSalary: Salary(money: Money(amount: 150000, currency: .CAN), per: .year))

// var person1 = Person(first: "Xiangyu", last: "Ju", age: 25, job: job1, spouse: nil)

// var person2 = Person(first: "Lily", last: "Joe", age: 23, job: job1, spouse: nil)

// var person3 = Person(first: "Zixuan", last: "Wang", age: 23, job: job2, spouse: person2)

// Unit Test: Family HouseholdIncome
var family1 = Family(members: [person1, person2, person3])

print("Family1 HouseholdIncome:", family1.householdIncome().amount, family1.householdIncome().currency)

var family2 = Family(members: [person3, person2])

print("Family2 HouseholdIncome:", family2.householdIncome().amount, family2.householdIncome().currency)

// Unit Test: Family HaveChild
print("Family1 MembersCount:", family1.members.count)

family1.haveChild()

print("Family1 MembersCount After HaveChild():", family1.members.count)






