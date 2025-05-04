//
//  SettingsView.swift
//  MenuBarLectureTime
//
//  Created by Felix Leitl on 04.05.25.
//

import SwiftUI
import ServiceManagement

struct SettingsView: View {
    var body: some View {
        TabView{
            TimeSettings()
                .tabItem{
                    Label("Time", systemImage: "clock")
                }
            ViewSwttings()
                .tabItem{
                    Label("View", systemImage: "eye")
                }
            LoginView()
                .tabItem{
                    Label("Login Item", systemImage: "shield.lefthalf.filled.trianglebadge.exclamationmark")
                }
        }
    }
    
    private struct TimeSettings: View {
        @AppStorage("lectureBeginning") var lectureBeginning: Int = 15
        @AppStorage("lectureDuration") var lectureDuration: Int = 90
        var body: some View {
            VStack{
                Picker("Duration", selection: $lectureDuration){
                    Text("90 min").tag(90)
                    Text("120 min").tag(120)
                }
                .pickerStyle(.segmented)
                if(lectureDuration == 90){
                    Picker("Start time", selection: $lectureBeginning) {
                        Text("0").tag(0)
                        Text("15").tag(15)
                        Text("30").tag(30)
                    }
                    .pickerStyle(.segmented)
                }
            }
            .padding()
        }
    }
    private struct ViewSwttings: View {
        @AppStorage("showAppicon") var showAppicon: Bool = true
        @AppStorage("showRemainingTime") var showRemainingTime: Bool = true
        var body: some View {
            VStack(alignment: .trailing){
//                Toggle("Show Appicon", isOn: $showAppicon)
//                    .toggleStyle(.switch)
//                Toggle("Show Remaining Time", isOn: $showRemainingTime)
//                    .toggleStyle(.switch)
                Picker("Show time", selection: $showRemainingTime){
                    Text("Remaining").tag(true)
                    Text("Done").tag(false)
                }
                .pickerStyle(.segmented)
            }
            .padding()
        }
    }
    
    private struct LoginView: View {
        @State private var isSet: Bool = false

            var body: some View {
                VStack {
                    Button(action: {
                        toggleLoginItem()
                    }) {
                        Text(isSet ? "Unregister Login Item" : "Register Login Item")
                    }
                }
                .padding()
                .onAppear {
                    isSet = SMAppService.mainApp.status == .enabled
                }
            }

            private func toggleLoginItem() {
                do {
                    if isSet {
                        try SMAppService.mainApp.unregister()
                        isSet = false
                    } else {
                        try SMAppService.mainApp.register()
                        isSet = true
                    }
                } catch {
                    print("Failed to toggle login item: \(error)")
                }
            }
    }
}

#Preview {
    SettingsView()
}
