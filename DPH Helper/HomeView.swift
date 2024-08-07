//
//  HomeView.swift
//  DPH Helper
//
//  Created by Bruce Elliott on 7/4/24.
//

import SwiftUI
import PhotosUI

struct HomeView: View {
    
    @AppStorage("username") var userName: String = ""
    @AppStorage("enrolled") var enrolled: Bool = false
    @State var showNameSettings = false
    @State var pageIndex: Int = 0
    @StateObject var viewModel = ProfilePicViewModel()
    @StateObject var affirmationModel = AffirmationsViewModel()

    
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
                VStack (spacing: 0) {
                    
                    Image("profilepic")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        //.clipShape(.circle)
                        .frame(width: 100)
                        .padding(.top, 110.0)

                    
                    
                    Text("Hello, \n\(userName.capitalized)")
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
                        //ADD POSITIVE AFFIRMATIONS ARRAY HERE
                        Text(affirmationModel.newAffirmation())
                            .font(.title3)
                            .multilineTextAlignment(.center)
                            .lineLimit(1)
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
