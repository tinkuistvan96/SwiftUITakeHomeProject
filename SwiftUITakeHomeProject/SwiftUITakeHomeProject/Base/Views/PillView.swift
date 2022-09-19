//
//  PillView.swift
//  SwiftUITakeHomeProject
//
//  Created by Tinku István on 2022. 09. 19..
//

import SwiftUI

struct PillView: View {
    let id: Int
    
    var body: some View {
        Text("#\(id)")
            .font(
                .system(.caption, design: .rounded)
                .bold()
            )
            .foregroundColor(.white)
            .padding(.vertical, 4)
            .padding(.horizontal, 9)
            .background(Theme.pill, in: Capsule())
    }
}

struct PillView_Previews: PreviewProvider {
    static var previews: some View {
        PillView(id: 0)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
