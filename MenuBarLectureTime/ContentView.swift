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
    @State private var lectureEnded: Bool = false
    @State private var confettiToggle: Bool = false
    @AppStorage("showConfig") private var showConfig: Bool = false
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @AppStorage("lectureBeginning") private var lectureBeginning: Int = 15
    @AppStorage("lectureDuration") private var lectureDuration: Int = 90
    @AppStorage("showRemainingTime") var showRemainingTime: Bool = true

    @Environment(\.openWindow) private var openWindow
    
    var body: some View {
//        ZStack{
//            VStack{
//                HStack{
//                    Button{
//                        openWindow(id: "FloatingWindow")
//                    } label: {
//                        Image(systemName: "macwindow.badge.plus")
//                    }
//                    Spacer()
//                    Button {
//                        showConfig.toggle()
//                    } label: {
//                        Image(systemName: "clock.arrow.trianglehead.counterclockwise.rotate.90")
//                    }
//                }
//                Spacer()
//            }
//            .padding()
            VStack {
                Text(timeText()).onReceive(timer) { input in
                    time = input.timeIntervalSince1970
                    confettiToggle = formatedTime(time).fireConfetti
                }
                ProgressView(value: showRemainingTime ? 1 - timePercentage() : timePercentage())
                    .confettiCannon(trigger: $confettiToggle)
                if(showConfig){
                    Divider()
                    Picker("Duration", selection: $lectureDuration){
                        Text("90 min").tag(90)
                        Text("120 min").tag(120)
                    }
                    .pickerStyle(.segmented)
                        Picker("Start time", selection: $lectureBeginning) {
                            Text("0").tag(0)
                            Text("15").tag(15)
                            Text("30").tag(30)
                        }
                        .pickerStyle(.segmented)
                        .disabled(lectureDuration == 120)
                }
            }
            .padding()
//        }
    }
    
    func formatedTime(_ time: TimeInterval) -> (time: Int, isLecture: Bool, fireConfetti: Bool) {
        let totalSeconds = Int(time)
        let minutes = (totalSeconds / 60) % 60
        //TODO: check the added time
        let hours = (totalSeconds / 3600) % 24
        
        var isLecture: Bool
        var fireConfetti: Bool = false
        
        var timeToGO: Int = 0
        if(lectureDuration == 90){
            if hours%2==0 {
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
                    if minutes == 60 - (30 - lectureBeginning) && lectureEnded == false{
                        fireConfetti = true
                    }
                    timeToGO = (60 - minutes) + lectureBeginning
                    isLecture = false
                }
            }
        } else {
            isLecture = true
            if hours%2==0 {
                if minutes == 0 {
                    fireConfetti = true
                }
                timeToGO = 120 - minutes
            } else {
                timeToGO = 60 - minutes
            }
        }
        
        return (timeToGO, isLecture, fireConfetti)
    }
    
    func timeText() -> String {
        let (timeToGO, isLecture, _) = formatedTime(time)
        return (isLecture ? "Time 'til end: " : "Time 'til beginning: ") + String(timeToGO) + " min "
    }
    
    func timePercentage() -> Double {
        let (timeToGO, isLecture, _) = formatedTime(time)
        return isLecture ? Double(timeToGO)/Double(lectureDuration) : Double(timeToGO)/30.0
    }
}

#Preview {
    ContentView()
}
