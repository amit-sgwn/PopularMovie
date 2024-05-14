//
//  CircularProgreeBar.swift
//  PopularMovie
//
//  Created by Amit Kumar on 14/05/24.
//

import Foundation
import SwiftUI


struct CircularProgressBar: View {
    let percentage: Double
    let lineWidth: CGFloat
    let radius: CGFloat
    
    var body: some View {
            ZStack {
                Circle()
                    .fill(Color(red: 13/255, green: 18/255, blue: 33/255)) // Set background color
                    .frame(width: radius * 2, height: radius * 2)
                Circle()
                    .stroke(lineWidth: lineWidth)
                    .opacity(0.3)
                
                Circle()
                    .trim(from: 0.0, to: CGFloat(percentage / 100))
                    .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                    .foregroundColor(gradientColor())
                    .rotationEffect(Angle(degrees: -90))
                    .animation(.easeInOut)
                   
                
                Text("\(Int(percentage))%")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(.white)
                
            }
            .frame(width: radius * 2, height: radius * 2)
            
    }
    
        private func gradientColor() -> Color {
            let percent = percentage / 100
            let red = (1 - percent) * 0.8 // Adjust the factor for red
            let green = percent * 0.8 // Adjust the factor for green
            return Color(red: red, green: green, blue: 0)
        }
}


