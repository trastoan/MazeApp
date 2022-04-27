//
//  ShowInfoView.swift
//  MazeApp
//
//  Created by Yuri on 26/04/22.
//

import SwiftUI

struct ShowInfoView: View {
    var model: ShowInfoViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            VStack(alignment: .leading) {
                Text("Summary")
                    .font(.title)
                    .bold()
                    .padding([.bottom], 10)
                Text(model.summary)
                    .font(.callout)
            }
            if model.hasAdditionalInfo {
                HStack(alignment: .center) {
                    Image(systemName: "calendar")
                    Text("\(model.days) at \(model.time)")
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text("\(model.rating)")
                    Spacer()
                }
            }
        }
        .padding()
    }
}
