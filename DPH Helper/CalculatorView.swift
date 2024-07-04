//
//  CalculatorView.swift
//  DPH Helper
//
//  Created by Bruce Elliott on 7/4/24.
//

import SwiftUI

struct CalculatorView: View {
    @State private var goalDPH: String = ""
    @State private var totalDecisionHours: String = ""
    @State private var plannedHoursWorkingToday: String = ""
    @State private var totalDecisionCount: String = ""
    @State private var totalAccountsWorkedToday: String = ""
    @State private var remainingWorkHoursToday: String = ""
    @State private var showAlert = false
    @State private var answer: Int = 0
    @State private var sum1: Double = 0
    @State private var sum2: Double = 0
    @State private var sum3: Double = 0
    
    var body: some View {
        ZStack {
            VStack {
                Form {
                    Section(header: Text("Calculate Hourly Goal")) {
                        TextField("Enter your goal DPH:", text: $goalDPH)
                            .keyboardType(.decimalPad)
                        TextField("Enter your Total Decision Hours (MTD):", text: $totalDecisionHours)
                            .keyboardType(.decimalPad)
                        TextField("Enter hours you're working today:", text: $plannedHoursWorkingToday)
                            .keyboardType(.decimalPad)
                        TextField("Enter Total Decision count (MTD)", text: $totalDecisionCount)
                            .keyboardType(.decimalPad)
                        TextField("Enter total accounts worked today:", text: $totalAccountsWorkedToday)
                            .keyboardType(.decimalPad)
                        TextField("Enter today's remaining work hours:", text: $remainingWorkHoursToday)
                            .keyboardType(.decimalPad)
                    }
                    
                    Button(action: {
                        calculateTodaysHourlyDPHGoal()
                    }) {
                        Text("Calculate Today's Hourly DPH Goal")
                    }
                }
                //.scrollDismissesKeyboard(.interactively)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Today's hourly DPH goal:"), message: Text("You need to work \(answer) accounts every hour today for your DPH to be \(goalDPH) tomorrow"), dismissButton: .default(Text("OK")))
                    
                }
            }
        }
    }
    
    private func calculateTodaysHourlyDPHGoal() {
        
        sum1 = Double(totalDecisionHours)! + Double(plannedHoursWorkingToday)!
        sum2 = Double(totalDecisionCount)! + Double(totalAccountsWorkedToday)!
        sum3 = Double(goalDPH)! * sum1 - sum2
        answer = Int(sum3 / Double(remainingWorkHoursToday)!)
        showAlert = true
        
    }
}

#Preview {
    CalculatorView()
}
