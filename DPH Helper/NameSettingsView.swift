//
//  NameSettingsView.swift
//  DPH Helper
//
//  Created by Bruce Elliott on 7/4/24.
//

import SwiftUI

struct NameSettingsView: View {
    
    @AppStorage("username") var userName: String = ""
    @AppStorage("enrolled") var enrolled: Bool = false
    @Binding var showNameSettings: Bool
    @State var badName2: Int = 0
    @State var spaceInName: Bool = false
    
    var body: some View {
        VStack {
            
            HStack {
                Spacer()
                Button {
                    showNameSettings = false
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
                Text("User Settings")
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.leading)
                    .padding()
                Spacer()
            }
            
            Text("Enter first name only:")
                .font(.title)
                .padding(.bottom, 0)
                .multilineTextAlignment(.center)
            
            TextField("Enter your first name only", text: $userName)
                .padding()
                .foregroundStyle(.black)
                .frame(width: 300, height: 50)
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
                .border(.red, width: CGFloat(badName2))
                .padding(.bottom)
                .scrollDismissesKeyboard(.interactively)
                .onSubmit {
                    enrolled = true
                }
            Button(action:{
                if userName == "" || userName.contains(" ") {
                    spaceInName = true
                } else {
                    showNameSettings = false
                }
            }) {
                Text("Submit")
                    .padding(.horizontal, 120.0)
                    .padding(.vertical, 3.0)
            }
            .foregroundStyle(.white)
            .frame(width: 300, height: 50)
            .background(Color.customblue)
            .cornerRadius(10)
            .alert(isPresented: $spaceInName) {
                Alert(title: Text("Error:"), message: Text("Your name cannot be blank or contain spaces"), dismissButton: .default(Text("OK")))
                

            }
            
            
            Spacer()
            
        }
        //.navigationTitle("Ti
    }
}

#Preview {
    HomeView()
}
