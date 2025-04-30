//
//  ContentView.swift
//  MenuBarLectureTime
//
//  Created by Felix Leitl on 30.04.25.
//

import SwiftUI
import Foundation

struct ContentView: View {
    @State private var time = Date().timeIntervalSince1970
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        
    
    var body: some View {
        VStack {
            Text(timeText()).onReceive(timer) { input in
                time = input.timeIntervalSince1970
            }
            ProgressView(value: 1 - timePercentage())
        }
        .padding()
    }
    
    func formatedTime(_ time: TimeInterval) -> (time: Int, isLecture: Bool) {
        let totalSeconds = Int(time)
        let minutes = (totalSeconds / 60) % 60
        //TODO: check the added time
        let hours = (totalSeconds / 3600 + 2) % 24
        
        var isLecture = hours%2==0
        if isLecture && minutes < 15 {
            isLecture = false
        } else if !isLecture && minutes < 45 {
            isLecture = true
        }
        
        var timeToGO: Int = 0
        if hours%2==0 {
            if minutes < 15 {
                timeToGO = 15 - minutes
            } else {
                timeToGO = 90 - (minutes - 15)
            }
        } else {
            if minutes < 45 {
                timeToGO = 45 - minutes
            } else {
                timeToGO = 30 - (minutes - 45)
            }
        }
        
        return (timeToGO, isLecture)
    }
    
    func timeText() -> String {
        let (timeToGO, isLecture) = formatedTime(time)
        return (isLecture ? "Time 'til end: " : "Time 'til begining: ") + String(timeToGO) + " min "
    }
    
    func timePercentage() -> Double {
        let (timeToGO, isLecture) = formatedTime(time)
        return isLecture ? Double(timeToGO)/90.0 : Double(timeToGO)/30.0
    }
}

#Preview {
    ContentView()
}
