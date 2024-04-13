//
//  TimerView.swift
//  GrillTimer_Swift-CodeUI
//
//  Created by Alexander on 12.04.24.
//

import SwiftUI

struct TimerView: View {
    
    // MARK: - Public Properties
    @EnvironmentObject var viewModel: TimerViewModel

    // MARK: - Private Properties
    @State private var isStartView = true
    
    var body: some View {
        VStack {
            
            ZStack {
                Text(NSLocalizedString("App.Timer.NavigationTitle", comment: ""))
                    .font(.init(UIFont.manrope(ofSize: 25, style: .bold)))
                    .foregroundStyle(Color(UIColor(resource: .Color.Main.text)))
                
                HStack {
                    Spacer()
                    Button(action: {
                        isStartView.toggle()
                    }, label: {
                        Image(systemName: "timer")
                            .resizable()
                            .frame(width: 27.5, height: 27.5)
                            .foregroundColor(Color(UIColor(resource: .Color.Main.text)))
                    })
                    .frame(width: 55, height: 55)
                    .background(Circle().foregroundColor(Color(UIColor(resource: .Color.Main.backgroundItem))))
                    .padding(.trailing, 17)
                }
            }
            .padding(.top, 17)
            
            if isStartView {
                SettingsTimerView()
            }
            Spacer()
        }
        .background(Color(UIColor(resource: .Color.Main.background)))
        .environmentObject(viewModel)
    }
}

#Preview {
    TimerView()
}
