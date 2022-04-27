//
//  EpisodeDetailsView.swift
//  MazeApp
//
//  Created by Yuri on 26/04/22.
//

import SwiftUI


struct EpisodeDetailsView: View {
    var model: EpisodeDetailsViewModelProtocol

    var body: some View{
        VStack {
            EpisodeHeaderView(model: model.buildHeaderModel())
                .frame(height: 250)
            ShowInfoView(model: model.buildInfoModel())
            Spacer()
        }
        .background(Color.defaultBackground)
    }
}