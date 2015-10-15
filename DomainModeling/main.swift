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
    func convert(money: Money, currency: Currency) -> Money {
        
        if(money.currency == currency) {
            
            return money
            
        } else {
            
            switch(money.currency, currency) {
                
            case(.USD, .GBP):
                
                return Money(amount: money.amount * 0.5, currency: currency)
                
            case(.USD, .EUR):
                
                return Money(amount: money.amount * 1.5, currency: currency)
                
            case(.USD, .CAN):
                
                return Money(amount: money.amount * 1.25, currency: currency)
                
            case(.GBP, .USD):
                
                return Money(amount: money.amount * 2, currency: currency)
                
            case(.GBP, .EUR):
                
                return Money(amount: money.amount * 3, currency: currency)
                
            case(.GBP, .CAN):
                
                return Money(amount: money.amount * 2.5, currency: currency)
                
            case(.EUR, .USD):
                
                return Money(amount: money.amount * 2 / 3, currency: currency)
                
            case(.EUR, .GBP):
                
                return Money(amount: money.amount / 3, currency: currency)
                
            case(.EUR, .CAN):
                
                return Money(amount: money.amount * 5 / 6, currency: currency)
                
            case(.CAN, .USD):
                
                return Money(amount: money.amount * 0.8, currency: currency)
                
            case(.CAN, .GBP):
                
                return Money(amount: money.amount * 0.4, currency: currency)
                
            case(.CAN, .EUR):
                
                return Money(amount: money.amount * 1.2, currency: currency)
                
            default:
                
                print("Input Error")
                
                return money
                
            }
            
        }
        
    }
    
    // Array Add
    func add(moneys: [Money]) -> Money {
        
        var amount = 0.0
        
        var money = Money(amount: 0.0, currency: .USD)
        
        for index in 0...moneys.count - 1{
            
            money = convert(moneys[index], currency: .USD)
            
            amount = amount + money.amount
            
        }
        
        return Money(amount: amount, currency: .USD)
        
    }
    
    //Array Subtract
    func sub(moneys: [Money]) -> Money {
        
        var totleAmount = moneys[0].amount
        
        var amount = 0.0
        
        var money = Money(amount: 0.0, currency: .USD)
        
        for index in 0...moneys.count - 1{
            
            money = convert(moneys[index], currency: .USD)
            
            if(index == 0){
                
                amount = 0
                
            } else {
                
                amount = money.amount
            }
            
            totleAmount = totleAmount - amount
            
        }
        
        return Money(amount: totleAmount, currency: .USD)
        
    }
    
}

// Unit Test: Money Convert
var currentMoney = Money(amount: 60, currency: .EUR)

var convertMoney = currentMoney.convert(currentMoney, currency: .USD)

print(convertMoney.amount, convertMoney.currency)

// Unit Test: Money Add
var money = Money(amount:0, currency:.USD)

var totleMoney = money.add([Money(amount: 3, currency: .USD), Money(amount: 9, currency: .EUR), Money(amount: 5, currency: .CAN)])

print(totleMoney.amount, totleMoney.currency)

// Unit Test: Money Subtract
totleMoney = money.sub([Money(amount: 3, currency: .USD), Money(amount: 9, currency: .EUR), Money(amount: 5, currency: .CAN)])

print(totleMoney.amount, totleMoney.currency)


// Job
class Job {
    
    var title: String
    
    var salary: Money
    
    init(currentTitle: String, currentSalary: Money) {
        
        title = currentTitle
        
        salary = currentSalary
        
    }
    
    func calculateIncome(hour: Double) -> Money {
        
        return Money(amount: salary.amount * hour, currency: salary.currency)
    }
    
    func raise(percentage: Double) -> Money {
        
        return Money(amount: salary.amount * (1 + percentage), currency: salary.currency)

    }
}

//Unit Test: Job CalculateIncome
var job1 = Job(currentTitle: "engineer", currentSalary: Money(amount:20, currency: .USD))

var moneyPerHour = job1.calculateIncome(1500)

print(moneyPerHour.amount, moneyPerHour.currency)

//Unit Test: Job Raise
var job2 = Job(currentTitle: "engineer", currentSalary: Money(amount:50000, currency: .USD))

var nextYearMoney = job2.raise(0.20)

print(nextYearMoney.amount, nextYearMoney.currency)


class Person {
    
    var firstName: String
    
    var lastName: String
    
    var age: Int
    
    var job: Job?
    
    var spouse: Person?
    
    //    init(first: String, last: String, currentAge: Int, currentJob: Job) {
    //
    //        firstName = first
    //
    //        lastName = last
    //
    //        age = currentAge
    //
    //        job ＝; currentJob!
    //    }
    
    init(first: String, last: String, currentAge: Int) {
        
        firstName = first
        
        lastName = last
        
        age = currentAge
    }
    
    func toString() -> String {
        return job!.title
    }
    
    
    
}
//Family






