//
//  EpisodeDetailsView.swift
//  MazeApp
//
//  Created by Yuri on 26/04/22.
//

import SwiftUI

struct EpisodeDetailsView: View {
    var model: EpisodeDetailsViewModelProtocol

    var body: some View {
        VStack {
            EpisodeHeaderView(model: model.buildHeaderModel())
                .frame(height: 250)
            InfoView(model: model.buildInfoModel())
        }
        .background(Color.defaultBackground)
        .cornerRadius(10)
        .frame(maxHeight: .infinity, alignment: .top)
    }
}
