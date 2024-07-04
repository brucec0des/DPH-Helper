//
//  PageModel.swift
//  DPH Helper
//
//  Created by Bruce Elliott on 7/4/24.
//

import Foundation

struct Page: Identifiable, Equatable, Hashable {
    let id = UUID()
    var name: String
    var description: String
    var image: String
    var tag: Int

    static var samplePage = Page(name: "Title Example", description: "This is a sample description for the purpose of debugging", image: "image0", tag: 0)
    
    static var samplePages: [Page] = [Page(name: "Welcome", description: "Click \"Begin\" to learn how this app can help you hit your metrics.", image: "image0", tag: 0),
    Page(name: "Frustrated?", description: "Are you often disappointed in where you rank on the scoreboard?", image: "image2", tag: 1),
        Page(name: "Burnt out?", description: "Do hours fly by where you weren't as productive as you could have been?", image: "image3", tag: 2),
        Page(name: "Introducing: DPH Helper", description: "A new app designed to help boost your productivity! Level the playing field in just three easy steps!", image: "image4", tag: 3),
        Page(name: "1. PLAN", description: "Demystify your DPH! Calculate the exact number of alerts you need to work every hour to get/stay above waterline.", image: "image6", tag: 4),
        Page(name: "2. EXECUTE", description: "Plug that target DPH into the SmartTimer to have it dynamically show you exactly how much time you have to work each alert to achieve your goal!", image: "image7", tag: 5),
    Page(name: "3. SUCCEED TOGETHER", description: "Gain confidence in knowing you can keep up with your peers - no matter how often the goal post moves!", image: "image8", tag: 6),
        Page(name: "Ready to get started?", description: "Sign up below to start your journey.", image: "image9", tag: 7),]
    
}

