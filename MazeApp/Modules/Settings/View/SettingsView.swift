//
//  SettingsView.swift
//  MazeApp
//
//  Created by Yuri on 27/04/22.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject private var model: SettingsViewModel

    init(with model: SettingsViewModel) {
        self.model = model
    }

    var body: some View {
        List {
            Section("Security") {
                Toggle("Activate app protection", isOn: $model.guardEnabled)
                    .tint(.appMainColor)
                if model.guardEnabled {
                    Button {
                        Task { await model.changeBiometricStatus() }
                    } label: {
                        Text("\(model.biometricsEnabled ? "Disable" : "Enable") Biometrics")
                    }
                    Button {
                        model.registerNewPin()
                    } label: {
                        Text("Change passcode")
                    }
                }
            }
        }
    }
}
