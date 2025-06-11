//
//  MenubarView.swift
//  MenuBarLectureTime
//
//  Created by Felix Leitl on 22.05.25.
//

import SwiftUI

struct MenubarView: View {
    
    @Environment(\.openWindow) private var openWindow
    @AppStorage("showConfig") private var showConfig: Bool = false
    @AppStorage("lectureBeginning") private var lectureBeginning: Int = 15
    @AppStorage("lectureDuration") private var lectureDuration: Int = 90
    @AppStorage("showRemainingTime") var showRemainingTime: Bool = true
    
    var body: some View {
        ZStack{
            VStack{
                HStack{
//                    GlassEffectContainer{
                        Button{
                            openWindow(id: "FloatingWindow")
                        } label: {
                            Image(systemName: "macwindow.badge.plus")
                        }
//                        .glassEffect()
                        .buttonSizing(.flexible)
                        .buttonBorderShape(.capsule)
                        
                        Spacer()
                        Button {
                            showConfig.toggle()
                        } label: {
                            Image(systemName: "clock.arrow.trianglehead.counterclockwise.rotate.90")
                        }
//                        .glassEffect()
                        .buttonSizing(.flexible)
                        .buttonBorderShape(.capsule)
//                    }
                }
                Spacer()
            }
            .padding()
            VStack{
                ContentView()
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
        }
    }
}

#Preview {
    MenubarView()
}
