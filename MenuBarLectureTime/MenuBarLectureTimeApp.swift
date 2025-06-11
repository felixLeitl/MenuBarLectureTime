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
        
//        let _ = NSApplication.shared.setActivationPolicy(.accessory)

        MenuBarExtra("Lecture Countdown", systemImage: "studentdesk") {
            MenubarView()
        }
        .menuBarExtraStyle(.window)
        
        Window("Floating Window", id: "FloatingWindow"){
            FloatingWindowView()
                .modifier(TransparentWindowModifier())
                .ignoresSafeArea(.container, edges: .top)
                .onAppear{
                    NSApp.activate(ignoringOtherApps: true)
                }
//                .toolbarVisibility(.hidden, for: .windowToolbar)
//                .contentShape(RoundedRectangle(cornerRadius: 12))
//                .clipShape(RoundedRectangle(cornerRadius: 12))
                .frame(width: 300, height: 100)
                .fixedSize(horizontal: false, vertical: false)
                .glassEffect()
        }
        .windowStyle(.hiddenTitleBar)
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
