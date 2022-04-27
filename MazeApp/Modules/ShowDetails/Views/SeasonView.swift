//
//  SeasonView.swift
//  MazeApp
//
//  Created by Yuri on 26/04/22.
//

import SwiftUI

struct SeasonView: View {
    var season: Season
    var onEpisodeSelect: (Episode) -> Void

    @State var isExpanded = false

    var body: some View {
        VStack(alignment: .leading) {
            HeaderView(isExpanded: $isExpanded, name: "Season \(season.number)")
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        isExpanded.toggle()
                    }
                }
            if isExpanded {
                ForEach(season.episodes) { episode in
                    EpisodeCell(episode: episode)
                        .onTapGesture { onEpisodeSelect(episode) }
                }
            }
            Divider()
        }
        .padding([.leading, .trailing])
    }
}

struct HeaderView: View {
    @Binding var isExpanded: Bool
    var name: String

    var body: some View {
        HStack {
            Text(name)
                .font(.title)
                .bold()
            Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
            Spacer()
        }
        .padding()
        .background(Color.defaultCardColor)
        .cornerRadius(5)
    }
}

struct EpisodeCell: View {
    var episode: Episode

    var body: some View {
        HStack {
            LazyImage(url: URL(string: episode.image?.medium ?? ""))
                .frame(width: 100, height: 80)
                .clipped()
            VStack(alignment: .leading) {
                Text(String(format: "S%02d | E%02d", episode.season, episode.number))
                    .font(.title2)
                    .bold()
                Text(episode.name)
                    .font(.subheadline)
            }
            Spacer()
        }
        .background(Color.defaultCardColor)
        .cornerRadius(5)
    }
}
