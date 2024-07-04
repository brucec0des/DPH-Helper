//
//  StylishCalcView.swift
//  DPH Helper
//
//  Created by Bruce Elliott on 7/4/24.
//

import SwiftUI

struct StylishCalcView: View {
    @State private var goalDPH: String = ""
    @State private var totalDecisionHours: String = ""
    @State private var plannedHoursWorkingToday: String = ""
    @State private var totalDecisionCount: String = ""
    @State private var totalAccountsWorkedToday: String = ""
    @State private var remainingWorkHoursToday: String = ""
    @State private var originalRemainingHours: String = ""
    @State private var showAlert = false
    @State private var showSheet = false
    @State var answer: Int = 0
    @State var answer2: Double = 5
    @State var answer3: String = "Error"
    @State private var sum1: Double = 0
    @State private var sum2: Double = 0
    @State private var sum3: Double = 0
    @State private var sum4: Double = 0
    @State private var sumx: Double = 0
    @State private var invalidNumber1 = 0
    @State private var invalidNumber2 = 0
    @State private var invalidNumber3 = 0
    @State private var invalidNumber4 = 0
    @State private var invalidNumber5 = 0
    @State private var invalidNumber6 = 0
    @State var questionState: Int = 0
    private let dotAppearance = UIPageControl.appearance()
    enum FocusableField: Hashable {
        case goalDPH
        case totalDecisionHours
        case plannedHoursWorkingToday
        case totalDecisionCount
        case totalAccountsWorkedToday
        case remainingWorkHoursToday
    }
    @FocusState private var focus: FocusableField?
    
    var body: some View {
        ZStack {
            Color.red
                .ignoresSafeArea()
            Circle()
                .scale(2)
                .foregroundStyle(.customblue)
            Circle()
                .scale(1.8)
                .foregroundStyle(.white)
            ScrollView {
                VStack {
                    
                    Spacer()
                    
                    Image(systemName: "number.square.fill")
                        .foregroundStyle(.red)
                        .scaleEffect(1.5)
                        .font(.largeTitle)
                        .padding(.top, 100)
                        .padding(.bottom, 10)
                    
                    Text("DPH Calculator")
                        .font(.largeTitle)
                        .bold()
                        .padding(.bottom, 25)
                }
                
                VStack {
                    
                    TabView (selection: $questionState) {
                        question1
                            .tag(0)
                        question2
                            .tag(1)
                        question3
                            .tag(2)
                        question4
                            .tag(3)
                        question5
                            .tag(4)
                        question6
                            .tag(5)
                    }
                    .animation(.easeInOut, value: questionState)
                    .frame(height: 350)
                    .tabViewStyle(PageTabViewStyle())
                    .onAppear {
                        dotAppearance.currentPageIndicatorTintColor = .customblue
                        dotAppearance.pageIndicatorTintColor = .gray
                    }
                    
                    
                    //                bottomButton
                    
//                    Spacer()
//                    Spacer()
//                    Spacer()
//                    Spacer()
                    
                }
                .onTapGesture {
                    hideKeyboard()
                }
                .padding(.horizontal, 15)
                .sheet(isPresented: $showSheet) {
                    
                    
                    if answer2 < Double(goalDPH)! {
                        
                        DPHGuideSheetView(answer: $answer, showSheet: $showSheet, goalDPH: $goalDPH)
                        
                        
                        
                    } else {
                        
                        HigherDPHSheetView(answer3: $answer3, answer2: $answer2, showSheet: $showSheet, goalDPH: $goalDPH)
                            //.padding()
                        
                    }
                }
                //                .alert(isPresented: $showAlert) {
                //                    Alert(title: Text("Error:"), message: Text("No field can contain spaces or be left blank. Use '0' in place of nothing. Correct any typos and resubmit."), dismissButton: .default(Text("OK")))
                //                }
                //.scrollDismissesKeyboard(.interactively)
                
            }
            .scrollDismissesKeyboard(.immediately)
        }
    }
    
    private func calculateTodaysHourlyDPHGoal() {
        
        //sum1 = Double(totalDecisionHours)!
        sumx = Double(totalDecisionHours)! + Double(plannedHoursWorkingToday)!
        sum2 = Double(totalDecisionCount)! + Double(totalAccountsWorkedToday)!
        sum3 = Double(goalDPH)! * sumx
        sum4 = sum3 - sum2
        if remainingWorkHoursToday == "0" {
            originalRemainingHours = remainingWorkHoursToday
            remainingWorkHoursToday = "1"
        }
        answer = Int(sum4 / Double(remainingWorkHoursToday)!)
        //showSheet = true
        
    }
    
    
    func calculateExistingDPH() -> String {
        
        sumx = Double(plannedHoursWorkingToday)! - Double(remainingWorkHoursToday)!
        sum1 = Double(totalDecisionHours)! + sumx
        sum2 = Double(totalDecisionCount)! + Double(totalAccountsWorkedToday)!
        //sum3 = Double(goalDPH)! * sum1 - sum2
        if sum1 == 0 {
            sum1 = 1
        }
        answer2 = sum2 / sum1
        //print("answer2 is: " + String(answer2))
        answer3 = String(format: "%.2f", answer2)
        //print("answer3 is: " + answer3)
        return answer3
        
    }
    
    func validateAnswer(answer:String) -> Bool {
        if answer.contains(" ") || answer.isEmpty {
            switch questionState {
            case 0:
                invalidNumber1 = 2
                return false
            case 1:
                invalidNumber2 = 2
                return false
            case 2:
                invalidNumber3 = 2
                return false
            case 3:
                invalidNumber4 = 2
                return false
            case 4:
                invalidNumber5 = 2
                return false
            default:
                invalidNumber6 = 2
                return false
            }
        } else {
            invalidNumber1 = 0
            invalidNumber2 = 0
            invalidNumber3 = 0
            invalidNumber4 = 0
            invalidNumber5 = 0
            invalidNumber6 = 0
            return true
        }
    }
    
    func validateData(goalDPH:String, totalDecisionHours:String, totalDecisionCount:String, plannedHoursWorkingToday:String, totalAccountsWorkedToday:String, remainingWorkingHoursToday:String) -> Bool {
        if goalDPH.contains(" ") {
            invalidNumber1 = 2
            return true
        } else if totalDecisionHours.contains(" ") || totalDecisionHours.isEmpty {
            invalidNumber2 = 2
            return true
        } else if totalDecisionCount.contains(" ") || totalDecisionCount.isEmpty {
            invalidNumber3 = 2
            return true
        } else if plannedHoursWorkingToday.contains(" ") || plannedHoursWorkingToday.isEmpty{
            invalidNumber4 = 2
            return true
        } else if totalAccountsWorkedToday.contains(" ") || totalAccountsWorkedToday.isEmpty{
            invalidNumber5 = 2
            return true
        } else if remainingWorkHoursToday.contains(" ") || remainingWorkingHoursToday.isEmpty{
            invalidNumber6 = 2
            return true
        } else {
            invalidNumber1 = 0
            invalidNumber2 = 0
            invalidNumber3 = 0
            invalidNumber4 = 0
            invalidNumber5 = 0
            invalidNumber6 = 0
            return false
        }
    }
    
    func resetData() {
        
        goalDPH = ""
        totalDecisionHours = ""
        plannedHoursWorkingToday = ""
        totalDecisionCount = ""
        totalAccountsWorkedToday = ""
        remainingWorkHoursToday = ""
        originalRemainingHours = ""
        showAlert = false
        showSheet = false
        answer = 0
        answer2 = 5
        answer3 = "Error"
        sum1 = 0
        sum2  = 0
        sum3 = 0
        sum4 = 0
        sumx = 0
        invalidNumber1 = 0
        invalidNumber2 = 0
        invalidNumber3 = 0
        invalidNumber4 = 0
        invalidNumber5 = 0
        invalidNumber6 = 0
        questionState = 0
        
    }
    
    
}

extension StylishCalcView {
    
    private var bottomButton: some View {
        
        VStack {
            HStack {
                Button(action:{
                    
                    switch questionState {
                        
                    case 0:
                        if validateAnswer(answer: goalDPH) {
                            questionState += 1
                        }
                    case 1:
                        if validateAnswer(answer: totalDecisionHours) {
                            questionState += 1
                        }
                    case 2:
                        if validateAnswer(answer: totalDecisionCount) {
                            questionState += 1
                        }
                    case 3:
                        if validateAnswer(answer: plannedHoursWorkingToday) {
                            questionState += 1
                        }
                    case 4:
                        if validateAnswer(answer: totalAccountsWorkedToday) {
                            questionState += 1
                        }
                    default:
                        if validateAnswer(answer: remainingWorkHoursToday) {
                            if !validateData(goalDPH: goalDPH, totalDecisionHours: totalDecisionHours, totalDecisionCount: totalDecisionCount, plannedHoursWorkingToday: plannedHoursWorkingToday, totalAccountsWorkedToday: totalAccountsWorkedToday, remainingWorkingHoursToday: remainingWorkHoursToday) {
                                
                                
                                calculateTodaysHourlyDPHGoal()
                                answer3 = calculateExistingDPH()
                                
                                //                                print(answer2)
                                //                                print(answer3)
                                //                                print(answer)
                                showSheet = true
                                
                            } else {
                                showAlert = true
                            }
                        }
                    }
                    
                }) {
                    if questionState < 5 {
                        Text("Next")
                            .bold()
                            .padding(.horizontal, 60)
                            .padding(.vertical, 3.0)
                    } else {
                        Text("Calculate")
                            .bold()
                            .padding(.horizontal, 60)
                            .padding(.vertical, 3.0)
                    }
                }
                .foregroundStyle(.white)
                .frame(width: 225, height: 50)
                .background(Color.customblue)
                .cornerRadius(10)
                .padding(.vertical)
                .scrollDismissesKeyboard(.interactively)
                
                
                if questionState == 5 {
                    Button(action: {
                        
                        resetData()
                        
                    }, label: {
                        Text("Reset")
                            .bold()
                            .padding(.horizontal, 10)
                            .padding(.vertical, 3.0)
                    })
                    .foregroundStyle(.black)
                    .frame(width: 75, height: 50)
                    .background(Color.red)
                    .cornerRadius(10)
                }
                
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error:"), message: Text("No field can contain spaces or be left blank. Use '0' in place of nothing. Correct any typos and resubmit."), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    private var question1: some View {
        ZStack {
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                .foregroundStyle(.white)
            
            
            VStack {
//                Spacer()
                Text("What is your desired DPH?")
                    .font(.title2)
                    .bold()
                    .lineLimit(2)
                    .minimumScaleFactor(0.1)
                //.padding(.bottom, 0)
                    .multilineTextAlignment(.center)
                if invalidNumber1 == 2 {
                    Text("Field cannot contain spaces or be left blank")
                        .foregroundStyle(.red)
                        .padding(.top, 1)
                }
                
                TextField("Enter Goal DPH", text: $goalDPH)
                    .focused($focus, equals: .goalDPH)
                    .padding()
                    .foregroundStyle(.black)
                    .frame(width: 300, height: 60)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    .border(.red, width: CGFloat(invalidNumber1))
                    .keyboardType(.decimalPad)
                //.border(.red, width: CGFloat(wrongPassword))
                    .scrollDismissesKeyboard(.interactively)
                    //.padding(.bottom)
                
                
                
                //Spacer()
                bottomButton
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    focus = .goalDPH
                }
            }
            .padding(.bottom, 50)
            
        }
        
    }
    
    private var question2: some View {
        ZStack {
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                .foregroundStyle(.white)
            
            VStack {
//                Spacer()
                Text("How many total hours have you worked this month?")
                    .font(.title2)
                    .bold()
                    .lineLimit(2)
                    .minimumScaleFactor(0.1)
                //.padding(.bottom, -20)
                    .multilineTextAlignment(.center)
                if invalidNumber2 == 2 {
                    Text("Field cannot contain spaces or be left blank")
                        .foregroundStyle(.red)
                        .padding(.top, 1)
                    
                }
                
                TextField("Enter Total Decision Hours (MTD):", text: $totalDecisionHours)
                    .focused($focus, equals: .totalDecisionHours)
                    .padding()
                    .foregroundStyle(.black)
                    .frame(width: 300, height: 60)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    .border(.red, width: CGFloat(invalidNumber2))
                    .keyboardType(.decimalPad)
                //.border(.red, width: CGFloat(wrongPassword))
                    .scrollDismissesKeyboard(.interactively)
                //.padding(.bottom)
            
            //Spacer()
            bottomButton
        }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    focus = .totalDecisionHours
                }
            }
        .padding(.bottom, 50)
        }
    }
    
    private var question3: some View {
        ZStack {
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                .foregroundStyle(.white)
            
            VStack {
//                Spacer()
                Text("How many total accounts have you worked this month?")
                    .font(.title2)
                    .bold()
                    .lineLimit(2)
                    .minimumScaleFactor(0.1)
                //.padding(.bottom, -20)
                    .multilineTextAlignment(.center)
                if invalidNumber3 == 2 {
                    Text("Field cannot contain spaces or be left blank")
                        .foregroundStyle(.red)
                        .padding(.top, 1)
                }
                
                TextField("Enter Total Decision Count (MTD):", text: $totalDecisionCount)
                    .focused($focus, equals: .totalDecisionCount)
                    .padding()
                    .foregroundStyle(.black)
                    .frame(width: 300, height: 60)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    .border(.red, width: CGFloat(invalidNumber3))
                    .keyboardType(.decimalPad)
                    .scrollDismissesKeyboard(.interactively)
                //.padding(.bottom)
            
            //Spacer()
            bottomButton
        }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    focus = .totalDecisionCount
                }
            }
        .padding(.bottom, 50)
        }
    }
    
    private var question4: some View {
        ZStack {
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                .foregroundStyle(.white)
            
            VStack {
//                Spacer()
                Text("How many hours are you scheduled for today?")
                    .font(.title2)
                    .bold()
                    .lineLimit(2)
                    .minimumScaleFactor(0.1)
                //.padding(.bottom, -20)
                    .multilineTextAlignment(.center)
                if invalidNumber4 == 2 {
                    Text("Field cannot contain spaces or be left blank")
                        .foregroundStyle(.red)
                        .padding(.top, 1)
                }
                
                TextField("Enter # of Hours Working Today:", text: $plannedHoursWorkingToday)
                    .focused($focus, equals: .plannedHoursWorkingToday)
                    .padding()
                    .foregroundStyle(.black)
                    .frame(width: 300, height: 60)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    .border(.red, width: CGFloat(invalidNumber4))
                    .keyboardType(.decimalPad)
//                    .padding(.bottom)
                    .scrollDismissesKeyboard(.interactively)
                //.padding(.bottom)
            
            //Spacer()
            bottomButton
        }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    focus = .plannedHoursWorkingToday
                }
            }
        .padding(.bottom, 50)
        }
        
    }
    
    private var question5: some View {
        ZStack {
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                .foregroundStyle(.white)
            
            VStack {
//                Spacer()
                Text("How many accounts have you already worked today?")
                    .font(.title2)
                    .bold()
                    .lineLimit(2)
                    .minimumScaleFactor(0.1)
                //.padding(.bottom, -20)
                    .multilineTextAlignment(.center)
                if invalidNumber5 == 2 {
                    Text("Field cannot contain spaces or be left blank")
                        .foregroundStyle(.red)
                        .padding(.top, 1)
                }
                
                TextField("Enter # of accounts worked today:", text: $totalAccountsWorkedToday)
                    .focused($focus, equals: .totalAccountsWorkedToday)
                    .padding()
                    .foregroundStyle(.black)
                    .frame(width: 300, height: 60)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    .border(.red, width: CGFloat(invalidNumber5))
                    .keyboardType(.decimalPad)
//                    .padding(.bottom)
                    .scrollDismissesKeyboard(.interactively)
                //.padding(.bottom)
            
            //Spacer()
            bottomButton
        }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    focus = .totalAccountsWorkedToday
                }
            }
        .padding(.bottom, 50)
        }
        
    }
    
    private var question6: some View {
        ZStack {
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                .foregroundStyle(.white)
            
            VStack {
//                Spacer()
                Text("How many more hours are remaining in your shift today?")
                    .font(.title2)
                    .bold()
                    .lineLimit(2)
                    .minimumScaleFactor(0.1)
                //.padding(.bottom, -20)
                    .multilineTextAlignment(.center)
                if invalidNumber6 == 2 {
                    Text("Field cannot contain spaces or be left blank")
                        .foregroundStyle(.red)
                        .padding(.top, 1)
                    
                }
                
                TextField("Enter today's remaining hours:", text: $remainingWorkHoursToday)
                    .focused($focus, equals: .remainingWorkHoursToday)
                    .padding()
                    .foregroundStyle(.black)
                    .frame(width: 300, height: 60)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    .border(.red, width: CGFloat(invalidNumber6))
                    .keyboardType(.decimalPad)
                    .padding(.bottom)
                   .scrollDismissesKeyboard(.interactively)
                //.padding(.bottom)
            
            //Spacer()
            bottomButton
        }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    focus = .remainingWorkHoursToday
                }
            }
        .padding(.bottom, 50)
            
        }
        
    }
    
}

#Preview {
    StylishCalcView()
}
