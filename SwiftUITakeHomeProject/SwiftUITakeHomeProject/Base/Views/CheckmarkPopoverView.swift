//
//  CheckmarkPopoverView.swift
//  SwiftUITakeHomeProject
//
//  Created by Tinku István on 2022. 09. 20..
//

import SwiftUI

struct CheckmarkPopoverView: View {
    var body: some View {
        Symbols.checkmark
            .font(
                .system(.largeTitle, design: .rounded)
                .bold()
            )
            .padding()
            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

struct CheckmarkPopoverView_Previews: PreviewProvider {
    static var previews: some View {
        CheckmarkPopoverView()
            .previewLayout(.sizeThatFits)
    }
}
