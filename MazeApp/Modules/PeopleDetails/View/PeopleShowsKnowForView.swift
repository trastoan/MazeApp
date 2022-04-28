//
//  PeopleDetailShowsView.swift
//  MazeApp
//
//  Created by Yuri on 27/04/22.
//

import SwiftUI

struct PeopleShowsKnowForView: View {
    var shows: [Show]
    var didSelectShow: ((Show) -> Void)?

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Know For")
                .font(.title)
                .bold()
                .padding([.leading], 18)
            ScrollView(.horizontal) {
                HStack(spacing: 10) {
                    ForEach(shows, id: \.self) { show in
                        ZStack(alignment: .bottomLeading) {
                            LazyImage(url: URL(string: show.image?.medium ?? ""))
                                .clipped()
                            Color.black.opacity(0.4)
                            Text(show.name)
                                .font(.body)
                                .bold()
                                .foregroundColor(.white)
                                .padding(5)
                        }
                        .onTapGesture {
                            didSelectShow?(show)
                        }
                        .frame(width: 155, height: 220)
                    }
                }
            }
            .padding([.leading], 18)
        }
    }
}
