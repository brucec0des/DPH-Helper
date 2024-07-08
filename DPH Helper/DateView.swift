//
//  DateView.swift
//  DPH Helper
//
//  Created by Bruce Harper on 7/8/24.
//

import SwiftUI

struct DateView: View {
    
    let currentDate = Date()
    let oneHourInSeconds: TimeInterval = 3600
    
    var body: some View {
        
        ZStack {
            Color.red
                .ignoresSafeArea()
            Circle()
                .scale(1.7)
                .foregroundStyle(.customblue)
            Circle()
                .scale(1.35)
                .foregroundStyle(.white)
            
            VStack {
                Spacer()
                Image(systemName: "calendar")
                    .font(.largeTitle)
                    .foregroundStyle(.red)
                    .scaleEffect(1.5)
                    .padding(.bottom, 3)
                Text("Date Helper")
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 25)
                Text("60 Days Ago:")
                    .font(.title)
                Text(getPastDate().formatted(date: .numeric, time: .omitted))
                    .font(.largeTitle)
                    .lineLimit(1)
                    .bold()
                    .padding(.bottom, 25)

                Text("Today's Date:")
                    .font(.title)
                Text(Date.now.formatted(date: .numeric, time: .omitted))
                    .font(.largeTitle)
                    .lineLimit(1)
                    .bold()
                    .padding(.bottom, 25)

                Text("60 Days From Today:")
                    .font(.title)
                Text(getFutureDate().formatted(date: .numeric, time: .omitted))
                    .font(.largeTitle)
                    .lineLimit(1)
                    .bold()
                    .padding(.bottom, 25)
                Spacer()
            }
            
        }
        
    }
    
    func getPastDate() -> Date {
        
        let sixtyDaysAgo = currentDate - (oneHourInSeconds * 24 * 60)
        
        return sixtyDaysAgo
        
    }
    
    func getFutureDate() -> Date {
        
        let sixtyDaysAhead = currentDate + (oneHourInSeconds * 24 * 60)
        
        return sixtyDaysAhead
        
    }
    
}

#Preview {
    DateView()
}
