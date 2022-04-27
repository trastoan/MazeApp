//
//  PeopleDetailHeaderView.swift
//  MazeApp
//
//  Created by Yuri on 27/04/22.
//

import SwiftUI

struct PeopleDetailHeaderView: View {
    var model: PeopleDetailHeaderViewModel

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            LazyImage(url: model.poster)
                .alignmentGuide(.top) { $0[.top] + 50 }
                .frame(maxWidth: .infinity, maxHeight: 350, alignment: .top)
                .clipped()
            LinearGradient(colors: [.clear,.black.opacity(0.8)], startPoint: .top, endPoint: .bottom)
            VStack(alignment: .leading){
                Text(model.name)
                    .font(.title)
                    .bold()
                Text(model.country)
                    .font(.headline)
                    .bold()
                Text("Age \(model.age == nil ? "Unknow" : "\(model.age!)")")
                    .font(.headline)
                    .bold()
            }
            .padding([.leading, .trailing, .bottom], 18)
        }
        .frame(height: 350)
    }
}
