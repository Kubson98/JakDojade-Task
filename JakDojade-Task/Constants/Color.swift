//
//  Color.swift
//  JakDojade-Task
//
//  Created by Jakub Sędal on 19/04/2024.
//

import SwiftUI

extension Color {
    struct JakDojadeColors {
        static var background: Color { return Color(red: 243/255, green: 243/255, blue: 243/255, opacity: 255) }
        static var positive: Color { return Color(red: 10/255, green: 159/255, blue: 106/255, opacity: 1) }
        static var primaryBlack: Color { return Color(red: 48/255, green: 48/255, blue: 48/255, opacity: 1) }
        static var primaryWhite: Color { return Color(red: 255/255, green: 255/255, blue: 255/255, opacity: 1) }
        static var navBarColor: Color { return Color(red: 40/255, green: 38/255, blue: 65/255, opacity: 1) }
        static var shadowColor: Color {
            return Color(
                UIColor(
                    red: 0,
                    green: 0,
                    blue: 0,
                    alpha: 0.05)
            )
        }
    }
}
