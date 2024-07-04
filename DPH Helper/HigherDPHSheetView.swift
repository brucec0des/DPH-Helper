//
//  HigherDPHSheetView.swift
//  DPH Helper
//
//  Created by Bruce Elliott on 7/4/24.
//

import SwiftUI

struct HigherDPHSheetView: View {
    
    @Binding var answer3: String
    @Binding var answer2: Double
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
            
            Text("Your DPH is currently:")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            
            Text(answer3)
                .foregroundStyle(.red)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .scaleEffect(3)
                .padding(.vertical, 50)
                .multilineTextAlignment(.center)
            
            Text("which is already the same or higher than your goal DPH of \(goalDPH).  Please go back and enter a higher DPH goal")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            Spacer()
        }
    }
}

#Preview {
    StylishCalcView()
}
