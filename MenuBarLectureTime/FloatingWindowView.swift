//
//  FloatingWindowView.swift
//  MenuBarLectureTime
//
//  Created by Felix Leitl on 22.05.25.
//

import SwiftUI

struct FloatingWindowView: View {
    
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
