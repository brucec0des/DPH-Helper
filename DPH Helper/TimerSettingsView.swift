//
//  TimerSettingsView.swift
//  DPH Helper
//
//  Created by Bruce Elliott on 7/4/24.
//

import SwiftUI

struct TimerSettingsView: View {
    
    @Binding var desiredDPH: Int
    @Binding var showTimerSettings: Bool
    @Binding var zeroAlertShowing: Bool
    
    var body: some View {
        VStack {
            
            HStack {
                Spacer()
                Button {
                    showTimerSettings = false
                } label: {
                    Image(systemName: "x.circle.fill")
                        .foregroundColor(.red)
                        .scaleEffect(2)
                        .padding(.top, 20)
                        .padding(.trailing, 10)
                }
                .padding(.horizontal)
            }
            
            HStack {
                Text("Timer Settings")
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.leading)
                    .padding()
                Spacer()
            }
            
            Text("Select the number of accounts you need to do this hour:")
                .font(.title)
                .padding(.bottom, -20)
                .multilineTextAlignment(.center)
            
            
            Picker("Set desired DPH: ", selection: $desiredDPH) {
                
                ForEach(0..<101) {
                    Text("\($0)")
                        .font(.system(size: 40, weight: .heavy))
                }
                
            }
            .pickerStyle(.wheel)
            .scaleEffect(2)
            .frame(height: 400)
            
            if desiredDPH == 1 {
                Text("Current selection: \(desiredDPH) alert per hour")
            } else if desiredDPH == 0 {
                Text("Invalid selection. Pick a higher number.")
                    .foregroundStyle(.red)
            } else {
                Text("Current selection: \(desiredDPH) alerts per hour")
            }
            
            Button(action:{
                if desiredDPH == 0 {
                    zeroAlertShowing = true
                } else {
                    showTimerSettings = false
                }
            }) {
                Text("Submit")
                    .font(.title)
                    .bold()
                    .padding(.horizontal, 100.0)
                    .padding(.vertical, 14.0)
            }
            .foregroundStyle(.white)
            .frame(width: 300, height: 75)
            .background(Color.red)
            .cornerRadius(10)
            .padding(.top, 20)
            .alert(isPresented: $zeroAlertShowing) {
                Alert(title: Text("Error:"), message: Text("You cannot work 0 alerts this hour. \nYou have to select at least 1."), dismissButton: .default(Text("OK")))
                

            }
            
            
            Spacer()
            
        }
        //.navigationTitle("Timer Settings")
    }
}

#Preview {
    TimerView()
}
