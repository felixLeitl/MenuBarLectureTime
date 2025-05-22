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

    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Button{
                        openWindow(id: "FloatingWindow")
                    } label: {
                        Image(systemName: "macwindow.badge.plus")
                    }
                    Spacer()
                    Button {
                        showConfig.toggle()
                    } label: {
                        Image(systemName: "clock.arrow.trianglehead.counterclockwise.rotate.90")
                    }
                }
                Spacer()
            }
            .padding()
            ContentView()
        }
    }
}

#Preview {
    MenubarView()
}
