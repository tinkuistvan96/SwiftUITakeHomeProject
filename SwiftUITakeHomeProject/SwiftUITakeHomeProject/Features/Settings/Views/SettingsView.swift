//
//  SettingsView.swift
//  SwiftUITakeHomeProject
//
//  Created by Tinku István on 2022. 09. 21..
//

import SwiftUI

struct SettingsView: View {
    @AppStorage(UserDefaultKeys.isHapticsOn) private var isHapticsOn: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                Toggle("Haptic Feedback", isOn: $isHapticsOn)
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
