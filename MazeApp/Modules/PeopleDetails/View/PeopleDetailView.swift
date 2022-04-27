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
                HStack(alignment: .bottom) {
                    LazyImage(url: model.poster)
                        .frame(width: 120, height: 171)
                        .clipped()
                    Text(model.name)
                        .font(.title)
                        .bold()
                    Spacer()
                }
                .padding([.leading, .trailing], 18)
                .padding([.top], 10)
                if model.shows.count > 1 {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Know For")
                            .font(.title)
                            .bold()
                            .padding([.leading], 18)
                        ScrollView(.horizontal) {
                            HStack(spacing: 10) {
                                ForEach(model.shows, id: \.self) { show in
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
                                        model.presentShowDetail(show: show)
                                    }
                                    .frame(width: 155, height: 220)
                                }
                            }
                        }
                        .padding([.leading], 18)
                    }
                }
                Spacer()
            }
            .background(Color.defaultBackground)
        }
    }
}
