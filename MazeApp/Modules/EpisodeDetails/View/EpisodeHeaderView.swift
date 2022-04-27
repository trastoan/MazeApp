//
//  EpisodeHeaderView.swift
//  MazeApp
//
//  Created by Yuri on 26/04/22.
//

import SwiftUI

struct EpisodeHeaderView: View {
    var model: EpisodeHeaderViewModel

    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .bottomLeading) {
                LazyImage(url: model.poster)
                    .frame(maxWidth: proxy.size.width)
                    .frame(height: proxy.size.height)
                    .clipped()
                Color.black.opacity(0.3)
                VStack(alignment: .leading, spacing: 5) {
                    Text(model.number)
                        .font(.title)
                        .bold()
                    Text(model.title)
                        .font(.title2)
                }
                .foregroundColor(.white)
                .padding()
            }
        }
    }
}
