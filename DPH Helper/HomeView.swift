//
//  HomeView.swift
//  DPH Helper
//
//  Created by Bruce Elliott on 7/4/24.
//

import SwiftUI

struct HomeView: View {
    
    @AppStorage("username") var userName: String = ""
    @AppStorage("enrolled") var enrolled: Bool = false
    @State var showNameSettings = false
    @State var pageIndex: Int = 0
    //@State var badName: Int
   // @State var zeroAlertShowing: Bool
    
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
                
                HStack {
                    
                    Button(action: {
                        enrolled = false
                        goToZero()
                    }, label: {
                        Image(systemName: "questionmark.circle")
                            //.font(.title)
                            //.fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.white)
                            .scaleEffect(1.5)
                    })
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    Button {
                        showNameSettings = true
                    } label: {
                        Image(systemName: "gearshape")
                            .foregroundColor(.white)
                            .scaleEffect(1.5)
                    }
                    .padding(.horizontal)
                    .sheet(isPresented: $showNameSettings, onDismiss: {
                        //DISMISS SHEET ACTION
                    }, content: {
                        NameSettingsView(showNameSettings: $showNameSettings)
                    })
                }
                
                Spacer()
                VStack {
                    Image("logo2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100)
                        .padding(.top, 100.0)
                    
                    
                    
                    Text("Hello, \n\(userName)")
                        .font(.system(size:80))
                        .fontWeight(.heavy)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.black)
                        .lineSpacing(-80)
                        .kerning(-1)
                        .bold()
                        .padding()
                        .lineLimit(2)
                        .minimumScaleFactor(0.1)
                    
                    HStack {
                        Image(systemName: "bubble.left.and.exclamationmark.bubble.right.fill")
                            .foregroundStyle(.red)
                        Text("You have a meeting at 3:00 PM")
                            .font(.title3)
                            .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                    }
                }
                Spacer()
                Spacer()
                Spacer()
                Spacer()
 
                
                
            }
            
        }
        
    }
    
    func goToZero() {
        pageIndex = 0
    }
}

#Preview {
    MainView()
}