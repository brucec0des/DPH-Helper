//
//  PageView.swift
//  DPH Helper
//
//  Created by Bruce Elliott on 7/4/24.
//

import SwiftUI

struct PageView: View {
    
    var page: Page
    
    var body: some View {

        ZStack {
            Rectangle()
                .fill(.white)
                .ignoresSafeArea()
            
            VStack (spacing: 20) {
                Image("\(page.image)")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .cornerRadius(30)
                
                Text(page.name)
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.customblue)
                
                Text(page.description)
                    .font(.body)
                    .frame(width: 300)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.black)
                
            }
            .onTapGesture {
                hideKeyboard()
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
}

#Preview {
    PageView(page: Page.samplePage)
}
