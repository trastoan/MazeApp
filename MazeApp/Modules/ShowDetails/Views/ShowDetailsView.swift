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
            //Without proxy it behaves in a strange way
            GeometryReader { proxy in
                ScrollView {
                    ZStack(alignment: .bottomLeading) {
                        LazyImage(url: model.backgroundImage)
                            .frame(maxWidth: proxy.size.width)
                            .frame(height: 250)
                            .clipped()
                        Color.black.opacity(0.3)
                        LazyImage(url: model.posterImage)
                            .frame(width: 120, height: 171)
                            .clipped()
                            .offset(x: 36, y: -20)
                    }
                }
            }
            .edgesIgnoringSafeArea([.leading,.trailing])
        }
        }
}

struct ShowDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let mock = Show(id: 0, name: "Show Teste", image: nil, genres: [], summary: nil, status: nil, schedule: Show.Schedule(time: "", days: []))
        return ShowDetailsView(model: ShowDetailViewModel(show: mock))
    }
}
