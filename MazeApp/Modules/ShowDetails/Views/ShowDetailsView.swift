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
            //Without the geometry reader, the image may extend beyond edges on portrait
            ScrollView {
                VStack {
                    ShowHeaderView(model: model.headerViewModel)
                        .frame(height: 250)
                    ShowInfoView(model: model.infoViewModel)
                }
            }
            
        }
    }
}
