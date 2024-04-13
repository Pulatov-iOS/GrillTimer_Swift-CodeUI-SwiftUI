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
    @Published var cookingTime: Int {
        didSet {
            remainingSeconds = cookingTime * 60
        }
    }
    @Published var sizeMeat: Int = 4
    @Published var grillTemperature: Int = 2
    @Published var meatTemperature: Int = 20
    @Published var isMarinade = false {
        didSet {
            calculateCookingTime()
        }
    }
    @Published var isTimerRunning = false
    @Published var remainingTime = ""
    @Published var saveFavoriteDishResult: SaveResult = .success
    
    // MARK: - Private Properties
    private var coreDataManager: CoreDataManager
    private var timer: Timer?
    private var remainingSeconds = 0 {
        didSet {
            remainingTime = secondsToTimeString(remainingSeconds)
        }
    }
    private var cancellables = Set<AnyCancellable>()
    
    init(dish: DishDTO, coreDataManager: CoreDataManager) {
        self.dish = dish
        self.coreDataManager = coreDataManager
        cookingTime = dish.averageCookingTime
        remainingTime = secondsToTimeString(dish.averageCookingTime * 60)
        
        bind()
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
    
    func startTimer() {
        self.remainingTime = secondsToTimeString(remainingSeconds)
        
        guard !isTimerRunning else { return }
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            if remainingSeconds > 0 {
                remainingSeconds -= 1
                self.remainingTime = secondsToTimeString(remainingSeconds)
            } else {
                self.stopTimer()
            }
        }
        isTimerRunning = true
    }

    func stopTimer() {
        timer?.invalidate()
        isTimerRunning = false
    }
    
    func saveCurrentDish(_ favoriteDishName: String) {
        let favoriteDish = DishDTO(id: dish.id, meatType: dish.meatType, dishType: dish.dishType, averageCookingTime: dish.averageCookingTime, cookingTime: dish.cookingTime, favoriteName: favoriteDishName, averageFavoriteCookingTime: cookingTime, sizeMeat: self.sizeMeat, grillTemperature: self.grillTemperature, meatTemperature: self.meatTemperature, isMarinade: self.isMarinade)
        coreDataManager.saveDish(favoriteDish)
    }
 
    private func calculateCookingTime() {
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
    
    private func secondsToTimeString(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }
    
    private func bind() {
        coreDataManager.successDishSaveSubject
            .sink { [weak self] result in
                self?.saveFavoriteDishResult = result
            }
            .store(in: &cancellables)
    }
}
