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
    Page(name: "Confused?", description: "Are you struggling to work accounts efficiently or having issues adapting to our ever-changing work environment?", image: "image1", tag: 1),
        Page(name: "Frustrated?", description: "Are you often disappointed in where you rank on the scoreboard?", image: "image2", tag: 2),
        Page(name: "Burnt out?", description: "Do hours fly by where you weren't as productive as you could have been?", image: "image3", tag: 3),
        Page(name: "Introducing: DPH Helper", description: "A new app designed to help you leverage best practices to boost your productivity, accuracy, and efficiency! Level the playing field in just three easy steps!", image: "image4", tag: 4),
        Page(name: "1. LEARN", description: "Follow the flowcharts to learn how to work any alert in your queue in the most efficient way.", image: "image5", tag: 5),
        Page(name: "2. PLAN", description: "Demystify your DPH! Calculate the exact number of alerts you need to work every hour to get/stay above waterline.", image: "image6", tag: 6),
        Page(name: "3. EXECUTE", description: "Plug that target DPH into the SmartTimer to have it dynamically show you exactly how much time you have to work each alert to achieve your goal!", image: "image7", tag: 7),
    Page(name: "Succeed Together.", description: "Gain confidence in knowing you can keep up with your peers - no matter how often the goal post moves!", image: "image8", tag: 8),
        Page(name: "Ready to get started?", description: "Sign up below to start your journey.", image: "image9", tag: 9),]
    
}

