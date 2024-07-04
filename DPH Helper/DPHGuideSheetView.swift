//
//  DPHGuideSheetView.swift
//  DPH Helper
//
//  Created by Bruce Elliott on 7/4/24.
//

import SwiftUI

struct DPHGuideSheetView: View {
    
    @Binding var answer: Int
    @Binding var showSheet: Bool
    @Binding var goalDPH: String
    
    var body: some View {
        VStack {
            
            HStack {
                Spacer()
                Button {
                    showSheet = false
                } label: {
                    Image(systemName: "x.circle.fill")
                        .foregroundColor(.red)
                        .scaleEffect(2)
                }
                .padding()
            }
            Spacer()
            
            Text("You need to work:")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            
            Text(String(answer))
                .foregroundStyle(.red)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .scaleEffect(3)
                .padding(.vertical, 50)
                .multilineTextAlignment(.center)
            
            Text("accounts every hour today for your DPH to be \(goalDPH) on the scoreboard tomorrow")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            Spacer()
        }
        .padding()
    }
}

#Preview {
    StylishCalcView()
}
