//
//  ShowDetailsView.swift
//  MazeApp
//
//  Created by Yuri on 25/04/22.
//

import SwiftUI

struct ShowDetailsView<ViewModel>: View where ViewModel: ShowDetailViewModelProtocol {
    @ObservedObject var model: ViewModel
    
    var body: some View {
        if model.isLoading {
            ProgressView()
                .scaleEffect(4)
        } else {
            ScrollView {
                VStack {
                    ShowHeaderView(model: model.buildHeaderViewModel())
                        .frame(height: 250)
                    InfoView(model: model.buildInfoViewModel())
                    ForEach(model.seasons) {
                        SeasonView(season: $0, onEpisodeSelect: { episode in
                            model.presentEpisodeDetails(episode)
                        })
                    }
                }
            }
            .background(Color.defaultBackground)
        }
    }
}
