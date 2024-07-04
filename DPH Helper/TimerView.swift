//
//  TimerView.swift
//  DPH Helper
//
//  Created by Bruce Elliott on 7/4/24.
//

import SwiftUI

struct TimerView: View {
    
    //Sets up publisher that tracks every second
    @State var timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    //sets future time to an hour from today's time
    let futureDate: Date = Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? Date()
    
    
    @State var showTimerSettings = false
    @State var currentDate: Date = Date()
    
    //format date to only show 2-digit minute and 2-digit second.  not sure this works in a TextView.  pretty sure it doesnt actually.
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateFormat = "mm:ss"
        
        return formatter
    }
    @State var sixty:Double = 60
    @State var totalSecondsElapsed:Double = 0
    @State var secondsSinceLastAlert: Double = 0
    @State var currentSecondsElapsed: Double = 0
    @State var alertsWorked = 0
    @State var alertsRemaining = 0
    @State var finishedText: String? = nil
    @State var initialMinutes = 60
    @State var initialSeconds = 00
    @State var setMin:Double = 0
    @State var setSec:Double = 0
    @State var minutes = 59
    @State var seconds = 59
    @State var min: Int = 0
    @State var sec: Int = 0
    @State var desiredDPH = 4
    @State var timeRemaining: String = ""
    @State var timeRemaining2: Double = 3600
    @State var timeElapsed = 0
    @State var timeInterval: String = ""
    @State var intervalInSeconds: Double = 0
    @State var hourInSeconds: Double = 3600
    @State var currentIntervalTime: Double = 0
    @State var initialInvervalTime: Double = 0
    @State var initialTime: String = ""
    @State var zeroAlertShowing = false
    @State var timerIsRunning = false
    @State private var congratsAlertShowing = false
    @State private var sorryAlertShowing = false
    @State var lastIntervalTime:Double = 0
    @State var currentTimeBank: Double = 0
    @State var remainingTimeBank: Double = 0
    @State var totalSecondsElapsed2: Double = 0
    
    
    //Updates big interval timer when "NEXT" is pressed
    func updateInterval() {
        //capture how many seconds have passed since hitting button
        currentSecondsElapsed = secondsSinceLastAlert
        //add those seconds to the total seconds elapsed
        totalSecondsElapsed += currentSecondsElapsed
        //reset seconds counter
        secondsSinceLastAlert = 0
        
        //get current time interval in seconds
        currentIntervalTime = convertMinutesToSeconds(minutes: min, seconds: sec)
        
        //subtract it from last time interval in seconds to get time elapsed
        let alertCompletionTime = currentSecondsElapsed
        
        //subtract alert completion time from current timebank to get remaining time
        remainingTimeBank = currentTimeBank - alertCompletionTime
        
        //subtrack a completed alert
        alertsRemaining -= 1
        
        if alertsRemaining > 0 {
            //divide remaining time by remaining alerts to get new timeinterval
            let remainingSeconds = remainingTimeBank / Double(alertsRemaining)
            
            
            
            //convert seconds to minutes
            convertSecondsToMinutes(seconds: remainingSeconds)
        } else {
            stopTimer()
            congratsAlertShowing = true
        }
        
        lastIntervalTime = currentIntervalTime
        currentTimeBank = remainingTimeBank
        
    }
    
    //converts minutes to seconds
    func convertMinutesToSeconds(minutes: Int, seconds: Int) -> Double {
        //convert whole minutes to seconds
        let min2 = Double(min) * sixty
        let totalTimeInSecs = min2 + Double(sec)
        
        return totalTimeInSecs
    }
    
    //conversts seconds to minutes
    func convertSecondsToMinutes(seconds: Double) {
        //convert seconds to minutes then break apart
        min = Int(seconds / sixty)
        
        //Extract decimal from minutes to convert to seconds
        let minHolder = (seconds / sixty)
        let secHolder = minHolder.truncatingRemainder(dividingBy: 1)
        
        //Convert seconds extraction to it's proper time equivalent format
        sec = Int(secHolder * 60)
        
    }
    
    //converts seconds to minutes and displays them as string
    func convertSecondstoMinutesAndDisplay(seconds: Double) -> String {
        let x = Int(seconds / sixty)
        
        //Extract decimal from minutes to convert to seconds
        let minHolder = (seconds / sixty)
        let secHolder = minHolder.truncatingRemainder(dividingBy: 1)
        
        //Convert seconds extraction to it's proper time equivalent format
        let y = Int(secHolder * 60)
        
        let z = (String(format: "%02d", x)) + ":" + (String(format: "%02d", y))
        
        return z
    }
    
    //stops timer
    func stopTimer() {
        timerIsRunning = false
    }
    
    //resets timer and all variables
    func resetEverything() {
        sixty = 60
        totalSecondsElapsed = 0
        secondsSinceLastAlert = 0
        alertsWorked = 0
        alertsRemaining = 0
        finishedText = "You did it!"
        initialMinutes = 0
        initialSeconds = 0
        setMin = 0
        setSec = 0
        minutes = 59
        seconds = 59
        min = 0
        sec = 0
        desiredDPH = 4
        timeRemaining = ""
        timeRemaining2 = 3600
        timeElapsed = 0
        timeInterval = ""
        intervalInSeconds = 0
        hourInSeconds = 3600
        currentIntervalTime = 0
        initialInvervalTime = 0
        initialTime = ""
        zeroAlertShowing = false
        timerIsRunning = false
        lastIntervalTime = 0
        currentTimeBank = 0
        remainingTimeBank = 0
        totalSecondsElapsed2  = 0
        getCalculatedInterval()
    }
    
    //Uses selection of desiredDPH to initially set timer interval on appear, before timer is started
    func getCalculatedInterval() {
        //        setMinutes = sixty / Double(desiredDPH) // get minutes and seconds (ie: 6.66)
        //        setSeconds = setMinutes.truncatingRemainder(dividingBy: 1) // separate seconds from minutes (ie: .66)
        //        sec = Int(setSeconds * 60) // convert seconds to time representation (ie: 40 seconds)
        //        min = Int(setMinutes) //convert minutes and seconds to Int so only minutes remain
        //Convert total calculated time interval to seconds
        initialInvervalTime = hourInSeconds / Double(desiredDPH)
        
        //Get how many whole minutes are in intervalTime
        min = Int(initialInvervalTime / sixty)
        
        //Extract decimal from minutes to convert to seconds
        let minHolder = (initialInvervalTime / sixty)
        let secHolder = minHolder.truncatingRemainder(dividingBy: 1)
        
        //Convert seconds extraction to it's proper time equivalent format
        sec = Int(secHolder * 60)
        
        initialTime = (String(min) + ":" + String(sec)) //Convert to string and display time
        
        //Track last time interval (in seconds)so we can tell the difference
        lastIntervalTime = initialInvervalTime
        currentTimeBank = hourInSeconds
        alertsRemaining = desiredDPH
    }
    
    
    func updateTimeRemaining(){
        //Gets time from now until an hour from now
        let remaining = Calendar.current.dateComponents([.minute, .second], from: Date(), to: futureDate)
        //let hour = remaining.hour ?? 0
        let minutes = remaining.minute ?? 0
        let seconds = remaining.second ?? 0
        timeRemaining = String(format: "%02d", minutes) + ":" + String(format: "%02d", seconds)
        if timerIsRunning {
            if min >= 0 {
                if sec > 0 {
                    sec -= 1
                } else if sec == 0 && min != 0 {
                    min -= 1
                    sec = 59
                } else {
                    sec = 00
                    
                }
            }
        }
        if timerIsRunning && totalSecondsElapsed2 != 3600 {
            secondsSinceLastAlert += 1
            totalSecondsElapsed2 += 1
        }
        
        if alertsWorked != desiredDPH {
            timeRemaining2 = hourInSeconds - totalSecondsElapsed2
            
            if timeRemaining2 <= 0 {
                
                if timerIsRunning {
                    stopTimer()
                    sorryAlertShowing = true
                }
            }
        }
        // min -= 1
        //sec -= 1
    }
    
    var body: some View {
        
        VStack {
            
            //Settings at the top
            HStack {
                
                Button(action: {
                    resetEverything()
                }, label: {
                    Text("Stop/Reset")
                        .font(.title)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    //Image(systemName: "stop.circle.fill")
                        .foregroundColor(.customblue)
                    //.scaleEffect(2)
                    //.padding(.horizontal)
                })
                .padding(.horizontal)
                
                Spacer()
                Button {
                    showTimerSettings = true
                    resetEverything()
                } label: {
                    Image(systemName: "gearshape.fill")
                        .foregroundColor(.customblue)
                        .scaleEffect(2)
                }
                .padding(.horizontal)
                .sheet(isPresented: $showTimerSettings, onDismiss: {
                    getCalculatedInterval()
                }, content: {
                    TimerSettingsView(desiredDPH: $desiredDPH, showTimerSettings: $showTimerSettings, zeroAlertShowing: $zeroAlertShowing)
                })
            }
            
            //Display selected decision count
            Text("Alerts worked: \(alertsWorked)")
                .font(.system(size: 100, weight: .semibold))
                .foregroundStyle(.black)
                .lineLimit(1)
                .minimumScaleFactor(0.1)
                .padding()
            if timerIsRunning {
                if totalSecondsElapsed > 3000 {
                    Text("Time left to hit DPH goal: " + convertSecondstoMinutesAndDisplay(seconds: timeRemaining2) )
                        .foregroundStyle(.red)
                        .bold()//timeElapsed
                } else {
                    Text("Time left to hit DPH goal: " + convertSecondstoMinutesAndDisplay(seconds: timeRemaining2))
                }
            }
            
            Spacer()
            
            //Display Timer
            Text(String(format: "%02d", min) + ":" + String(format: "%02d", sec))
                .font(.system(size:200))
                .fontWeight(.heavy)
                .multilineTextAlignment(.center)
                .foregroundStyle(.black)
                //.lineSpacing(-80)
                //.kerning(-1)
                .lineLimit(1)
                .minimumScaleFactor(0.1)
                .bold()
                .padding()
//                .font(.system(size: 100, weight: .semibold, design: .rounded))
//                .foregroundStyle(.black)
//                .lineLimit(1)
//                .minimumScaleFactor(0.1)
//                .padding()
            
            //            Text(String(format: "%02d", initialMinutes) + ":" + String(format: "%02d", initialSeconds))
            //                .font(.system(size: 100, weight: .semibold, design: .rounded))
            //                .foregroundStyle(.black)
            //                .lineLimit(1)
            //                .minimumScaleFactor(0.1)
            //                .padding()
            
            Spacer()
            
            //Display big start button
            
            Button {
                if alertsWorked == 0 && timerIsRunning == false {
                    //Start timer
                    timerIsRunning = true
                    //print("\(min)" + ":" + "\(sec)")
                    
                    
                } else if timerIsRunning == true && alertsWorked == 0 {
                   // print("\(min)" + ":" + "\(sec)")
                    updateInterval()
                    alertsWorked += 1
                    //recalculate interval
                    //start timer again
                } else if alertsWorked == desiredDPH || min > Int(sixty) {
                        //resetEverything()
                        //show completion sheet with stats
                    } else {
                        //print("\(min)" + ":" + "\(sec)")
                        updateInterval()
                        alertsWorked += 1
                    }

            } label: {
                ZStack {
                    
                    if timerIsRunning == false {
                        Circle()
                            .stroke(.orange, lineWidth: 10)
                            .fill(.red)
                            .frame(width: 250)
                        Text("START")
                            .foregroundStyle(.white)
                            .font(.largeTitle)
                            .bold()
                    } else {
                        Circle()
                            .stroke(.yellow, lineWidth: 10)
                            .fill(.green)
                            .frame(width: 250)
                        Text("NEXT")
                            .foregroundStyle(.white)
                            .font(.largeTitle)
                            .bold()
                    }
                }
            }
            .alert(isPresented: $congratsAlertShowing) {
                Alert(title: Text("YOU DID IT!"), message: Text("\nGood job doing \(desiredDPH) alerts this hour. \nKeep up the good work!"), dismissButton: .default(Text("OK")))
            }
            
            //Continue to show how long person has been working alert even if Timer stops
            if timerIsRunning {
                if secondsSinceLastAlert > 600 {
                    Text("Time spent on current alert: " + convertSecondstoMinutesAndDisplay(seconds: secondsSinceLastAlert))//timeElapsed
                        .foregroundStyle(.red)
                        .bold()//timeElapsed
                        .padding(.top, 40)
                } else {
                    Text("Time spent on current alert: " + convertSecondstoMinutesAndDisplay(seconds: secondsSinceLastAlert))
                        .padding(.top, 40)
                }
            }
            
            Spacer()
                .alert(isPresented: $sorryAlertShowing) {
                    Alert(title: Text("TIME'S UP!"), message: Text("\nUnfortunately, you only completed \(alertsWorked) out of \(desiredDPH) alerts this hour...but that's still something to be proud of! Keep up the good work!"), dismissButton: .default(Text("OK")))
                }
            
        }
        .onReceive(timer, perform: { _ in
            updateTimeRemaining()
        })
        .onAppear(perform: {
            if !timerIsRunning {
                getCalculatedInterval()
            }
        })


        
    }
}

#Preview {
    TimerView()
}
