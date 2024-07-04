//
//  AffirmationsViewModel.swift
//  DPH Helper
//
//  Created by Bruce Elliott on 7/4/24.
//

import Foundation

class AffirmationsViewModel: ObservableObject {
    
    func newAffirmation() -> String {
        
        let affirmations = ["It's a great day to have a great day!", "You can do this! Make today count!", "Believe you can & you're halfway there!", "Failure is just success in progress!", "Your only limit is your mind!", "Mistakes are proof you're trying!", "Be a warrior, not a worrier!", "Make each day your masterpiece!", "Happiness is an inside job!", "Never give up on yourself!"]
        
        let todaysQuote = affirmations.randomElement()!
        
        return todaysQuote
        
    }
    
}
