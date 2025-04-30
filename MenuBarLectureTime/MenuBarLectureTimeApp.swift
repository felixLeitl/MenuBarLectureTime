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
        MenuBarExtra("Lecture Countdown", systemImage: "studentdesk") {
            ContentView()
        }
        .menuBarExtraStyle(.window)
        //TODO: Shortcut for settings and quit
    }
}
