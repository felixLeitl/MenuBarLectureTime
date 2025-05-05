//
//  ContentView.swift
//  MenuBarLectureTime
//
//  Created by Felix Leitl on 30.04.25.
//

import SwiftUI
import Foundation
import ConfettiSwiftUI

struct ContentView: View {
    @State private var time = Date().timeIntervalSince1970
    @State private var confettiState: Bool = false
    @State private var confettiLaunched: Bool = false
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @AppStorage("lectureBeginning") private var lectureBeginning: Int = 15
    @AppStorage("lectureDuration") private var lectureDuration: Int = 90
    @AppStorage("showRemainingTime") var showRemainingTime: Bool = true

    
    var body: some View {
        VStack {
            Text(timeText()).onReceive(timer) { input in
                time = input.timeIntervalSince1970
            }
            ProgressView(value: showRemainingTime ? 1 - timePercentage() : timePercentage())
                .confettiCannon(trigger: $confettiState)
        }
        .padding()
    }
    
    func formatedTime(_ time: TimeInterval) -> (time: Int, isLecture: Bool) {
        let totalSeconds = Int(time)
        let minutes = (totalSeconds / 60) % 60
        //TODO: check the added time
        let hours = (totalSeconds / 3600 + 2) % 24
        
        var isLecture: Bool
        
        var timeToGO: Int = 0
        if(lectureDuration == 90){
            if hours%2==0 {
                if confettiLaunched {
                    confettiLaunched = false
                }
                if minutes < lectureBeginning {
                    timeToGO = lectureBeginning - minutes
                    isLecture = false
                } else {
                    timeToGO = lectureDuration - (minutes - lectureBeginning)
                    isLecture = true
                }
            } else {
                if minutes < 60 - (30 - lectureBeginning) {
                    timeToGO = 60 - minutes - (30 - lectureBeginning)
                    isLecture = true
                } else {
                    if !confettiLaunched {
                        confettiLaunched = true
                        confettiState.toggle()
                    }
                    timeToGO = (60 - minutes) + lectureBeginning
                    isLecture = false
                }
            }
        } else {
            isLecture = true
            if hours%2==0 {
                timeToGO = 120 - minutes
            } else {
                timeToGO = 60 - minutes
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
        return isLecture ? Double(timeToGO)/Double(lectureDuration) : Double(timeToGO)/30.0
    }
}

#Preview {
    ContentView()
}
