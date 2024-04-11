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
    @State private var sizeMeat: Int = 4
    
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
                VStack(alignment: .leading) {
                    Text(NSLocalizedString("Add.Timer.SizeMeat", comment: "") + ":")
                        .font(.init(UIFont.manrope(ofSize: 18, style: .medium)))
                        .foregroundStyle(Color(UIColor(resource: .Color.Main.text)))
                        .multilineTextAlignment(.leading)
                        .padding(.leading, 15)
                    
                    Slider(value: Binding(get: {
                        Double(sizeMeat)
                    }, set: {
                        sizeMeat = Int($0)
                    }), in: 2...8, step: 1)
                        .padding(.horizontal, 15)
                    
                    Text("\(sizeMeat) " + NSLocalizedString("Add.Timer.UnitSizeMeat", comment: ""))
                        .font(.init(UIFont.manrope(ofSize: 18, style: .medium)))
                        .foregroundStyle(Color(UIColor(resource: .Color.Main.text)))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(
                             RoundedRectangle(cornerRadius: 20)
                                .fill(Color(UIColor(resource: .Color.Main.backgroundItem)))
                                .frame(width: 100, height: 40)
                         )
                        .padding(.top, 7)
                        
                }
                .padding(.top, 15)
            }
            Spacer()
        }
        .background(Color(UIColor(resource: .Color.Main.background)))
    }
}

#Preview {
    TimerView()
}
