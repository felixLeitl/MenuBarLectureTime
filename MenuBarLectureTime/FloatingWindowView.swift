//
//  FloatingWindowView.swift
//  MenuBarLectureTime
//
//  Created by Felix Leitl on 22.05.25.
//

import SwiftUI

struct FloatingWindowView: View {
    
    @State private var showConfig: Bool = false
    @Environment(\.dismiss) private var closeWindow
    
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Button{
                        closeWindow()
                    } label: {
                        Image(systemName: "xmark.circle")
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
    FloatingWindowView()
}
