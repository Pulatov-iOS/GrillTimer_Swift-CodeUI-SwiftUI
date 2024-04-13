//
//  SettingsTimerView.swift
//  GrillTimer_Swift-CodeUI
//
//  Created by Alexander on 12.04.24.
//

import SwiftUI

struct SettingsTimerView: View {
    
    // MARK: - Public Properties
    @EnvironmentObject var viewModel: TimerViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Text(NSLocalizedString("App.Dishes.Dish.\(viewModel.dish.dishType.prefix(1).capitalized)\(viewModel.dish.dishType.dropFirst())", comment: "") + ": " + NSLocalizedString("App.Dishes.Meat.\(viewModel.dish.meatType.prefix(1).capitalized)\(viewModel.dish.meatType.dropFirst())", comment: ""))
                    .font(.init(UIFont.manrope(ofSize: 18, style: .medium)))
                    .foregroundStyle(Color(UIColor(resource: .Color.Timer.text)))
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(UIColor(resource: .Color.Main.backgroundItem)))
                            .frame(width: 200, height: 40)
                    )
            }
            .frame(maxWidth: .infinity)
            .padding(.top, -20)
            .padding(.bottom, 15)
            
            // First Slider
            Text(NSLocalizedString("Add.Timer.SizeMeat", comment: "") + ":")
                .font(.init(UIFont.manrope(ofSize: 18, style: .medium)))
                .foregroundStyle(Color(UIColor(resource: .Color.Main.text)))
                .multilineTextAlignment(.leading)
                .padding(.leading, 20)
            
            HStack(spacing: 0) {
                Slider(value: Binding(get: {
                    Double(viewModel.sizeMeat)
                }, set: {
                    viewModel.changedSizeMeat(sizeMeat: Int($0))
                }), in: 2...8, step: 1)
                
                Text("\(viewModel.sizeMeat) " + NSLocalizedString("Add.Timer.UnitSizeMeat", comment: ""))
                    .font(.init(UIFont.manrope(ofSize: 18, style: .medium)))
                    .foregroundStyle(Color(UIColor(resource: .Color.Main.text)))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(UIColor(resource: .Color.Main.backgroundItem)))
                            .frame(width: 100, height: 40)
                    )
            }
        
            .padding(.leading, 40)
            
            // Second Slider
            Text(NSLocalizedString("App.Timer.GrillTemperature", comment: "") + ":")
                .font(.init(UIFont.manrope(ofSize: 18, style: .medium)))
                .foregroundStyle(Color(UIColor(resource: .Color.Main.text)))
                .multilineTextAlignment(.leading)
                .padding(.top)
                .padding(.leading, 20)
            
            HStack(spacing: 0) {
                Slider(value: Binding(get: {
                    Double(viewModel.grillTemperature)
                }, set: {
                    viewModel.changedGrillTemperature(grillTemperature: Int($0))
                }), in: 1...3, step: 1)
                
                Text(viewModel.grillTemperatureString)
                    .font(.init(UIFont.manrope(ofSize: 18, style: .medium)))
                    .foregroundStyle(Color(UIColor(resource: .Color.Main.text)))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(UIColor(resource: .Color.Main.backgroundItem)))
                            .frame(width: 100, height: 40)
                    )
            }
        
            .padding(.leading, 40)
            
            // Third Slider
            Text(NSLocalizedString("App.Timer.MeatTemperature", comment: "") + ":")
                .font(.init(UIFont.manrope(ofSize: 18, style: .medium)))
                .foregroundStyle(Color(UIColor(resource: .Color.Main.text)))
                .multilineTextAlignment(.leading)
                .padding(.top)
                .padding(.leading, 20)
            
            HStack(spacing: 0) {
                Slider(value: Binding(get: {
                    Double(viewModel.meatTemperature)
                }, set: {
                    viewModel.changedMeatTemperature(meatTemperature: Int($0))
                }), in: 0...25, step: 1)
                
                Text("\(viewModel.meatTemperature) °C")
                    .font(.init(UIFont.manrope(ofSize: 18, style: .medium)))
                    .foregroundStyle(Color(UIColor(resource: .Color.Main.text)))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(UIColor(resource: .Color.Main.backgroundItem)))
                            .frame(width: 100, height: 40)
                    )
            }
         
            .padding(.leading, 40)
            
            // Fourth
            HStack(alignment: .center) {
                Text(NSLocalizedString("App.Timer.PresenceMarinade", comment: "") + ":")
                    .font(.init(UIFont.manrope(ofSize: 18, style: .medium)))
                    .foregroundStyle(Color(UIColor(resource: .Color.Main.text)))
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 20)
              
                Picker("", selection: $viewModel.isMarinade) {
                    Text(NSLocalizedString("App.Timer.No", comment: "")).tag(false)
                    Text(NSLocalizedString("App.Timer.Yes", comment: "")).tag(true)
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 140)
                .padding(.trailing, 40)
            }
            .padding(.top, 10)
           
            HStack(alignment: .center, spacing: 0) {
                HStack {
                    Text("\(viewModel.cookingTime) " + NSLocalizedString("App.Timer.Min", comment: ""))
                        .font(.init(UIFont.manrope(ofSize: 30, style: .bold)))
                        .foregroundStyle(Color(UIColor(resource: .Color.Main.text)))
                }
                .padding(.top, 45)
                
                Image(uiImage: UIImage(resource: .Image.TabBar.centerItemDisabled))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 180, height: 180)
            }
            .frame(maxWidth: .infinity)
            .padding(.top, -20)
            
            VStack {
                Button(action: {
                    
                }) {
                    VStack{
                        Text(NSLocalizedString("App.Timer.StartButton", comment: ""))
                            .font(.init(UIFont.manrope(ofSize: 25, style: .bold)))
                            .foregroundStyle(Color(UIColor(resource: .Color.Main.text)))
                    }
                    .frame(width: 140, height: 50)
                    .background(Color(UIColor(resource: .Color.Timer.buttonBackground)))
                    .cornerRadius(10)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 5)
        }
        .padding(.top, 15)
        
        Spacer()
    }
}

#Preview {
    SettingsTimerView()
}
