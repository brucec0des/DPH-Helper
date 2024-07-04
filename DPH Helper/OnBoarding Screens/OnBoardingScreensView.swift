//
//  OnBoardingScreensView.swift
//  DPH Helper
//
//  Created by Bruce Elliott on 7/4/24.
//

import SwiftUI

struct OnboardingScreensView: View {
    
    @State private var pageIndex = 0
    private let pages: [Page] = Page.samplePages
    private let dotAppearance = UIPageControl.appearance()
    
    var body: some View {
        
        TabView(selection: $pageIndex) {
            ForEach(pages) { page in
                VStack {
                    Spacer()
                    PageView(page: page)
                    Spacer()
                    if page == pages.last {
                        Button("Sign up!", action: goToZero)
                            .padding()
                            .padding(.horizontal, 35)
                            .background(.customblue)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 25, style: .circular))
                    } else if page == pages.first {
                        Button("Begin", action: incrementPage)
                            .padding()
                            .padding(.horizontal, 35)
                            .background(.customblue)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 25, style: .circular))
                    } else {
                        Button("Next", action: incrementPage)
                            .padding()
                            .padding(.horizontal, 35)
                            .background(.customblue)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 25, style: .circular))
                    }
                    Spacer()
                }
                .tag(page.tag)
            }

        }
        .animation(.easeInOut, value: pageIndex)
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .interactive))
        .onAppear {
            dotAppearance.currentPageIndicatorTintColor = .customblue
            dotAppearance.pageIndicatorTintColor = .gray
        }
        
    }
    
    func incrementPage() {
        pageIndex += 1
    }
    
    func goToZero() {
        pageIndex = 0
    }
}

#Preview {
    OnboardingScreensView()
}
