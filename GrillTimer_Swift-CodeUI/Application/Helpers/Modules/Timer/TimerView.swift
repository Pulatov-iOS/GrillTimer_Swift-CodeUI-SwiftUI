import SwiftUI

struct TimerView: View {
    
    // MARK: - Public Properties
    @EnvironmentObject var viewModel: TimerViewModel

    // MARK: - Private Properties
    @State private var isStartView = true
    @State private var isSaveDish = false
    
    var body: some View {
        
        VStack {
            ZStack {
                Text(NSLocalizedString("App.Timer.NavigationTitle", comment: ""))
                    .font(.init(UIFont.manrope(ofSize: 25, style: .bold)))
                    .foregroundStyle(Color(UIColor(resource: .Color.Main.text)))
                
                if viewModel.dish != nil {
                    HStack {
                        if isStartView {
                            Spacer()
                            
                            Button(action: {
                                isStartView.toggle()
                            }, label: {
                                VStack {
                                    Image(systemName: "timer")
                                        .resizable()
                                        .frame(width: 27.5, height: 27.5)
                                        .foregroundColor(Color(UIColor(resource: .Color.Main.text)))
                                }
                                .frame(width: 55, height: 55)
                            })
                            .frame(width: 55, height: 55)
                            .background(Circle().foregroundColor(Color(UIColor(resource: .Color.Main.backgroundItem))))
                            .padding(.trailing, 17)
                        } else {
                            Button(action: {
                                isStartView.toggle()
                            }, label: {
                                VStack {
                                    Image(systemName: "arrow.left")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(Color(UIColor(resource: .Color.Main.text)))
                                }
                                .frame(width: 55, height: 55)
                            })
                            .frame(width: 55, height: 55)
                            .background(Circle().foregroundColor(Color(UIColor(resource: .Color.Main.backgroundItem))))
                            .padding(.leading)
                            .padding(.trailing, 17)
                            
                            Spacer()
                            
                            Button(action: {
                                isSaveDish.toggle()
                            }, label: {
                                VStack {
                                    if !isSaveDish {
                                        Image(systemName: "plus")
                                            .resizable()
                                            .frame(width: 22, height: 22)
                                            .foregroundColor(Color(UIColor(resource: .Color.Main.text)))
                                    } else {
                                        Image(systemName: "xmark")
                                            .resizable()
                                            .frame(width: 18, height: 18)
                                            .foregroundColor(Color(UIColor(resource: .Color.Main.text)))
                                    }
                                }
                                .frame(width: 55, height: 55)
                            })
                            .frame(width: 55, height: 55)
                            .background(Circle().foregroundColor(Color(UIColor(resource: .Color.Main.backgroundItem))))
                            .padding(.trailing, 17)
                        }
                    }
                }
            }
            .padding(.top, 17)
            
            if isStartView {
                SettingsTimerView(isStartView: $isStartView)
            } else {
                TimerDisplayView(isSaveDish: $isSaveDish)
            }
            
            Spacer()
        }
        .background(Color(UIColor(resource: .Color.Main.background)))
        .environmentObject(viewModel)
        .onAppear {
            if viewModel.dish?.currentTime != nil || viewModel.dish == nil {
                isStartView.toggle()
            }
        }
        .onDisappear {
            viewModel.stopTimer(isTappedButton: false, isScreenDisappears: true)
        }
    }
}

#Preview {
    TimerView()
}
