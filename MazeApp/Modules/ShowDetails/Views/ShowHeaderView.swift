//
//  ShowHeaderView.swift
//  MazeApp
//
//  Created by Yuri on 26/04/22.
//

import SwiftUI

struct ShowHeaderView<ViewModel>: View where ViewModel: ShowHeaderViewModelProtocol {
    var model: ViewModel

    var body: some View {
        GeometryReader { proxy in
            VStack {
                ZStack(alignment: .bottomLeading) {
                    LazyImage(url: model.backgroundImage)
                        .frame(maxWidth: proxy.size.width)
                        .frame(height: proxy.size.height)
                        .clipped()
                    Color.black.opacity(0.4)
                    HStack(alignment: .bottom) {
                        LazyImage(url: model.posterImage)
                            .frame(width: 120, height: 171)
                            .clipped()
                            .shadow(color: .white, radius: 3)
                        VStack(alignment: .leading) {
                            Text("Status: \(model.status)")
                            Text("\(getSeasonLabel()) - \(model.network)")
                            Text(model.genres)
                        }
                        .font(Font.system(.headline))
                        .foregroundColor(.white)
                    }
                    .padding([.leading], 18)
                    .offset(y: -20)
                }
            }
        }
    }

    func getSeasonLabel() -> String {
        return "\(model.numberOfSeasons) Season\(model.numberOfSeasons > 1 ? "s" : "")"
    }
}
