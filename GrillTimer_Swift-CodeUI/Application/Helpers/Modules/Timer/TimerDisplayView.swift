//
//  TimerDisplayView.swift
//  GrillTimer_Swift-CodeUI
//
//  Created by Alexander on 13.04.24.
//

import SwiftUI

struct TimerDisplayView: View {
    
    // MARK: - Public Properties
    @EnvironmentObject var viewModel: TimerViewModel
    
    @Binding var isSaveDish: Bool
    @State var favoriteDishName = ""
    
    var body: some View {
        VStack {
            ZStack {
                if isSaveDish && viewModel.dish != nil {
                    VStack {
                        HStack {
                            TextField(NSLocalizedString("App.TimerDisplay.TextFieldPlaceholder", comment: ""), text: $favoriteDishName)
                                .padding()
                                .frame(width: 230, height: 50)
                                .background(Color(UIColor(resource: .Color.Main.backgroundItem)))
                                .cornerRadius(10)
                            
                                .padding(.leading, 20)
                           
                            Spacer()
                            
                            Button(action: {
                                if favoriteDishName != "" {
                                    viewModel.saveCurrentDish(favoriteDishName)
                                    favoriteDishName = ""
                                    isSaveDish.toggle()
                                }
                            }) {
                                VStack{
                                    Text(NSLocalizedString("App.TimerDisplay.SaveButton", comment: ""))
                                        .font(.init(UIFont.manrope(ofSize: 20, style: .medium)))
                                        .foregroundStyle(Color(UIColor(resource: .Color.Main.text)))
                                }
                                .frame(width: 100, height: 50)
                                .background(Color(UIColor(resource: .Color.Timer.buttonBackground)))
                                .cornerRadius(10)
                            }
                            .padding(.trailing)
                        }
                        
                        Spacer()
                    }
                }
                
                VStack {
                    Image(uiImage: UIImage(resource: .Image.Timer.timer))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                        .padding(.top, 121)
                    
                    HStack {
                        Button(action: {
                            viewModel.changeTimerTime(-60)
                        }) {
                            VStack{
                                Text("-")
                                    .font(.init(UIFont.manrope(ofSize: 25, style: .bold)))
                                    .foregroundStyle(Color(UIColor(resource: .Color.Main.text)))
                            }
                            .frame(width: 50, height: 50)
                            .background(Color(UIColor(resource: .Color.Main.backgroundItem)))
                            .cornerRadius(10)
                        }
                        .padding()
                        .disabled(viewModel.minusRemainingSeconds <= 60)
                        
                        Text(viewModel.remainingTime)
                            .font(.init(UIFont.manrope(ofSize: 30, style: .bold)))
                            .foregroundStyle(Color(UIColor(resource: .Color.Main.text)))
                     
                        Button(action: {
                            viewModel.changeTimerTime(60)
                        }) {
                            VStack{
                                Text("+")
                                    .font(.init(UIFont.manrope(ofSize: 25, style: .bold)))
                                    .foregroundStyle(Color(UIColor(resource: .Color.Main.text)))
                            }
                            .frame(width: 50, height: 50)
                            .background(Color(UIColor(resource: .Color.Main.backgroundItem)))
                            .cornerRadius(10)
                        }
                        .padding()
                    }
                    
                    VStack {
                        Button(action: {
                            if viewModel.isTimerRunning {
                                viewModel.stopTimer(isTappedButton: true, isScreenDisappears: false)
                            } else {
                                viewModel.startTimer()
                            }
                        }) {
                            VStack{
                                if viewModel.isTimerRunning && viewModel.remainingTime != "00:00" {
                                    Text(NSLocalizedString("App.Timer.StopButton", comment: ""))
                                        .font(.init(UIFont.manrope(ofSize: 25, style: .bold)))
                                        .foregroundStyle(Color(UIColor(resource: .Color.Main.text)))
                                } else {
                                    Text(NSLocalizedString("App.Timer.StartButton", comment: ""))
                                        .font(.init(UIFont.manrope(ofSize: 25, style: .bold)))
                                        .foregroundStyle(Color(UIColor(resource: .Color.Main.text)))
                                }
                            }
                            .frame(width: 140, height: 50)
                            .background(Color(UIColor(resource: .Color.Timer.buttonBackground)))
                            .cornerRadius(10)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 5)
                    Spacer()
                }
            }
            .alert(isPresented: Binding<Bool>(
                get: { self.viewModel.saveFavoriteDishResult == .success || self.viewModel.saveFavoriteDishResult == .error },
                set: { _ in }
            )) {
                Alert(
                    title: Text(NSLocalizedString("App.TimerDisplay.AlertTitle", comment: "")),
                    message: {
                        if self.viewModel.saveFavoriteDishResult == .success {
                            return Text(NSLocalizedString("App.TimerDisplay. AlertMessage.Success", comment: ""))
                        } else {
                            return Text(NSLocalizedString("App.TimerDisplay. AlertMessage.Error", comment: ""))
                        }
                    }(),
                    dismissButton: .default(Text(NSLocalizedString("App.TimerDisplay. AlertButton", comment: "")), action: {
                        viewModel.saveFavoriteDishResult = .none
                      })
                )
            }
        }
    }
}

#Preview {
    TimerDisplayView(isSaveDish: .constant(false))
}
