//
//  PeopleDetailView.swift
//  MazeApp
//
//  Created by Yuri on 26/04/22.
//

import SwiftUI

struct PeopleDetailView<ViewModel>: View where ViewModel: PeopleViewModelProtocol {
    @ObservedObject var model: ViewModel

    var body: some View {
        if model.isLoading {
            ProgressView()
                .scaleEffect(4)
        } else {
            VStack {
                PeopleDetailHeaderView(model: model.buildHeaderModel())
                if model.shows.count > 1 {
                    PeopleShowsKnowForView(shows: model.shows) { model.presentShowDetail(show: $0) }
                }
                Spacer()
            }
            .background(Color.defaultBackground)
        }
    }
}
