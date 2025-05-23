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
        
        let _ = NSApplication.shared.setActivationPolicy(.accessory)

        MenuBarExtra("Lecture Countdown", systemImage: "studentdesk") {
            MenubarView()
        }
        .menuBarExtraStyle(.window)
        
        Window("Floating Window", id: "FloatingWindow"){
            FloatingWindowView()
                .modifier(TransparentWindowModifier())
                .onAppear{
                    NSApp.activate(ignoringOtherApps: true)
                }
        }
        .windowStyle(.hiddenTitleBar)
        .windowBackgroundDragBehavior(.enabled)
        .windowLevel(.floating)
        
        Settings{
            SettingsView()
                .frame(width: 300, height: 100)
                .onAppear {
                    NSApp.activate(ignoringOtherApps: true)
                }
        }
        .windowLevel(.floating)
    }
}
