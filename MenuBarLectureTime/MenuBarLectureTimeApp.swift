//
//  MenuBarLectureTimeApp.swift
//  MenuBarLectureTime
//
//  Created by Felix Leitl on 30.04.25.
//

import SwiftUI

@main
struct MenuBarLectureTimeApp: App {
    var body: some Scene {
        
        let _ = NSApplication.shared.setActivationPolicy(.prohibited)

        MenuBarExtra("Lecture Countdown", systemImage: "studentdesk") {
            ContentView()
        }
        .menuBarExtraStyle(.window)
        Settings{
            SettingsView()
                .frame(width: 300, height: 100)
        }
        
    }
}
