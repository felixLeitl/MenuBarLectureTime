//
//  AppIntent.swift
//  MenuBarLectureTime
//
//  Created by Felix Leitl on 13.06.25.
//

import SwiftUI
import AppIntents

struct OpenWindowInent: AppIntent{
    @Environment(\.openWindow) private var openWindow
    static let title = LocalizedStringResource("OpenWindow")
    static let description = IntentDescription("Opens floating window")
    
    @MainActor
    func perform() async throws -> some IntentResult {
        openWindow(id: "FloatingWindow")
        return .result()
    }
}

// TODO: finish change settings with enums: https://developer.apple.com/videos/play/wwdc2022/10032

//struct ChangeSettingsIntent: AppIntent{
//    static let title = LocalizedStringResource("ChangeSettings")
//    static let description = IntentDescription("Changes app settings")
//    
//    @MainActor
//    func perform() async throws -> some IntentResult {
//        return .result()
//    }
//}
