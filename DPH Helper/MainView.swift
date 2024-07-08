//
//  MainView.swift
//  DPH Helper
//
//  Created by Bruce Elliott on 7/4/24.
//

import SwiftUI

struct MainView: View {
    
//    init() {
//      UITabBar.appearance().backgroundColor = UIColor.white
//    }
    @State private var password = ""
    @State private var wrongPassword = 0
    @State private var showingLoggedInScreen = false
    @State var isLoggedIn = true
    @State var pageIndex: Int = 0
    @State private var badName = 0
    private let pages: [Page] = Page.samplePages
    private let dotAppearance = UIPageControl.appearance()
    @AppStorage("enrolled") var enrolled: Bool = false
    @AppStorage("username") var userName: String = ""
    
    
    var body: some View {
        
        //IF YOU DIDN'T DO THE ONBOARDING, DO IT
        if !enrolled {
            TabView(selection: $pageIndex) {
                ForEach(pages) { page in
                    VStack {
                        Spacer()
                        PageView(page: page)
                        Spacer()
                        if page == pages.last {
                            Text("Enter your first name:")
                                .font(.headline)
                            if badName == 2 {
                                Text("Name cannot be blank")
                                    .foregroundStyle(.red)
                            }
                            TextField("Enter your first name only", text: $userName)
                                .padding()
                                .foregroundStyle(.black)
                                .frame(width: 300, height: 50)
                                .background(Color.black.opacity(0.05))
                                .cornerRadius(10)
                                .border(.red, width: CGFloat(badName))
                                .onSubmit {
                                    enroll()
                                }
                            Button {
                                enroll()

                            } label: {
                                HStack {
                                    Text("Sign Up")
                                }
                                .contentShape(Rectangle())
                                .padding()
                                .padding(.horizontal, 35)
                                .background(.customblue)
                                .foregroundStyle(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 25, style: .circular))
                            }
                            .buttonStyle(.plain)
                            .padding(.top, 20)
                            .padding(.bottom, 75)
                        } else if page == pages.first {
                            Button {
                                incrementPage()

                            } label: {
                                HStack {
                                    Text("Begin")
                                }
                                .contentShape(Rectangle())
                                .padding()
                                .padding(.horizontal, 35)
                                .background(.customblue)
                                .foregroundStyle(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 25, style: .circular))
                            }
                            .buttonStyle(.plain)
                            .padding(.top, 20)
                            .padding(.bottom, 75)
                        } else {
                            Button {
                                incrementPage()

                            } label: {
                                HStack {
                                    Text("Next")
                                }
                                .contentShape(Rectangle())
                                .padding()
                                .padding(.horizontal, 35)
                                .background(.customblue)
                                .foregroundStyle(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 25, style: .circular))
                            }
                            .buttonStyle(.plain)
                            .padding(.top, 20)
                            .padding(.bottom, 75)
                        }
                        Spacer()
                    }
                    .onTapGesture {
                        hideKeyboard()
                    }
                    .padding(.bottom, 50)
                    .tag(page.tag)
                }

            }
            .animation(.easeInOut, value: pageIndex)
            .tabViewStyle(.page)
            .onTapGesture {
                hideKeyboard()
            }
            .indexViewStyle(.page(backgroundDisplayMode: .interactive))
            .onAppear {
                dotAppearance.currentPageIndicatorTintColor = .customblue
                dotAppearance.pageIndicatorTintColor = .gray
            }
            //IF YOU DID DO THE ONBOARDING, SHOW THE PASSWORD SCREEN
        } else {
            
            if !isLoggedIn {
                
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
                        Image("logo2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100)
                            .padding(.top, -70.0)
                        Text("Enter Password")
                            .font(.largeTitle)
                            .foregroundStyle(.black)
                            .bold()
                            .padding()
                        if wrongPassword == 2 {
                            Text("Wrong Password")
                                .foregroundStyle(.red)
                        }
                        SecureField("Password", text: $password)
                            .padding()
                            .foregroundStyle(.black)
                            .frame(width: 300, height: 50)
                            .background(Color.black.opacity(0.05))
                            .cornerRadius(10)
                            .border(.red, width: CGFloat(wrongPassword))
                            .scrollDismissesKeyboard(.interactively)
                            .onSubmit {authenticateUser(password: password)}
                        Button(action:{authenticateUser(password: password)}) {
                            Text("Login")
                                .padding(.horizontal, 120.0)
                                .padding(.vertical, 3.0)
                        }
                        .foregroundStyle(.white)
                        .frame(width: 300, height: 50)
                        .background(Color.customblue)
                        .cornerRadius(10)
                        //                    .navigationDestination(isPresented: $showingLoggedInScreen) { MainView().navigationBarBackButtonHidden(true)
                        //                    }
                        
                    }
                    .onTapGesture {
                        hideKeyboard()
                    }
                    
                }
                .onTapGesture {
                    hideKeyboard()
                }
                .preferredColorScheme(.light)
                
            }
            //IF YOU LOGGED IN SUCCESSFULLY, SHOW THE HOME SCREEN
            else {
                
                TabView {
                    Group {
                        HomeView()
                            .badge(1)
                            .tabItem {
                                Label("Home", systemImage: "house.fill")
                            }
                        
//                        DashboardView()
//                            .tabItem {
//                                Label("Flowchart", systemImage: "flowchart")
//                            }
                        
                        StylishCalcView()
                            .tabItem {
                                Label("Calculator", systemImage: "number.square.fill")
                            }
                        
                        TimerView()
                            .tabItem {
                                Label("Timer", systemImage: "stopwatch")
                            }
                        
                        DateView()
                            .tabItem {
                                Label("Dates", systemImage: "calendar")
                            }
                        
                        //                    StatsView()
                        //                        .tabItem {
                        //                            Label("Stats", systemImage: "chart.bar.xaxis")
                        //                        }
                    }
                    .toolbarBackground(.visible, for: .tabBar)
                    .toolbarBackground(.white, for: .tabBar)
                    .preferredColorScheme(.light)
                }
            }
        }
    }
    
    func incrementPage() {
        pageIndex += 1
    }
    
    func goToZero() {
        pageIndex = 0
    }
    
    func authenticateUser(password: String) {
        if password == "lemondrop" {
            wrongPassword = 0
            isLoggedIn = true
        } else {
            wrongPassword = 2
        }
    }
    
    func enroll() {
        if userName == "" || userName.contains(" ") {
            enrolled = false
            badName = 2
        } else {
            enrolled = true
            badName = 0
            goToZero()
        }
    }
    
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

#Preview {
    MainView()
}
