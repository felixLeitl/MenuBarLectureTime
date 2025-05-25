//
//  TransparentBackground.swift
//  MenuBarLectureTime
//
//  Created by Felix Leitl on 22.05.25.
//

import SwiftUI

struct TransparentWindowModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(WindowAccessor { window in
                guard let window else { return }
                window.backgroundColor = .clear
                window.titleVisibility = .hidden
                window.hasShadow = true
                window.collectionBehavior = [.canJoinAllApplications]
                window.isMovableByWindowBackground = true
                window.titleVisibility = .hidden
                window.titlebarAppearsTransparent = true
                window.standardWindowButton(.closeButton)?.isHidden = true
                window.standardWindowButton(.miniaturizeButton)?.isHidden = true
                window.standardWindowButton(.zoomButton)?.isHidden = true
                window.styleMask.remove(.titled)
                window.level = .statusBar
            })
            .background(VisualEffectBlur())
    }
}

struct VisualEffectBlur: NSViewRepresentable {
    func makeNSView(context: Context) -> NSVisualEffectView {
        let view = NSVisualEffectView()
        view.material = .hudWindow
        view.blendingMode = .behindWindow
        view.state = .active
        return view
    }
    
    func updateNSView(_ nsView: NSVisualEffectView, context: Context) {}
}

struct WindowAccessor: NSViewRepresentable {
    var callback: (NSWindow?) -> Void
    
    func makeNSView(context: Context) -> NSView {
        let view = NSView()
        DispatchQueue.main.async {
            self.callback(view.window)
        }
        return view
    }
    
    func updateNSView(_ nsView: NSView, context: Context) {}
}
