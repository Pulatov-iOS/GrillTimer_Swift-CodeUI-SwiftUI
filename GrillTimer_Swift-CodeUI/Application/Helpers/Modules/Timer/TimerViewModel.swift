//
//  TimerViewModel.swift
//  GrillTimer_Swift-CodeUI
//
//  Created by Alexander on 12.04.24.
//

import UIKit
import Combine

final class TimerViewModel: ObservableObject {
    
    // MARK: - Public Properties
    @Published var grillTemperatureString: String = NSLocalizedString("App.Timer.GrillTemperature.Middle", comment: "")
    @Published var dish: DishDTO
    @Published var cookingTime: Int
    @Published var sizeMeat: Int = 4
    @Published var grillTemperature: Int = 2
    @Published var meatTemperature: Int = 20
    @Published var isMarinade = false {
        didSet {
            calculateCookingTime()
        }
    }
    
    init(dish: DishDTO) {
        self.dish = dish
        cookingTime = dish.averageCookingTime
    }
    
    // MARK: - Methods
    func getGrillTemperatureString()  {
        switch grillTemperature {
        case 1:
            grillTemperatureString = NSLocalizedString("App.Timer.GrillTemperature.Low", comment: "")
        case 2:
            grillTemperatureString = NSLocalizedString("App.Timer.GrillTemperature.Middle", comment: "")
        case 3:
            grillTemperatureString = NSLocalizedString("App.Timer.GrillTemperature.High", comment: "")
        default:
            grillTemperatureString = NSLocalizedString("App.Timer.GrillTemperature.Middle", comment: "")
        }
    }
    
    func changedSizeMeat(sizeMeat: Int) {
        self.sizeMeat = sizeMeat
        calculateCookingTime()
    }
    
    func changedGrillTemperature(grillTemperature: Int) {
        self.grillTemperature = grillTemperature
        getGrillTemperatureString()
        calculateCookingTime()
    }
    
    func changedMeatTemperature(meatTemperature: Int) {
        self.meatTemperature = meatTemperature
        calculateCookingTime()
    }
    
    func changedIsMarinade(isMarinade: Bool) {
        self.isMarinade = isMarinade
        calculateCookingTime()
    }
    
    func calculateCookingTime() {
        var time = dish.averageCookingTime
        
        switch sizeMeat {
        case 2:
            time -= 4
        case 3:
            time -= 2
        case 5...:
            time += sizeMeat - 4
        default:
            time += 0
        }
        
        switch grillTemperature {
        case 1:
            time += 3
        case 3:
            time -= 3
        default:
            time += 0
        }
        
        switch meatTemperature {
        case ..<11:
            time += 2
        case 11..<16:
            time += 1
        case 22...:
            time -= 1
        default:
            time += 0
        }
       
        if isMarinade {
            time += 1
        }
        
        cookingTime = time
    }
}
