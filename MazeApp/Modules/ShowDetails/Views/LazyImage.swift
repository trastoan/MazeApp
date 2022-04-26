//
//  AsyncImage.swift
//  MazeApp
//
//  Created by Yuri on 25/04/22.
//

import SwiftUI
import Nuke
import AVFAudio

struct LazyImage: View {
    let url: URL?
    @StateObject private var fetcher = FetchImage()
    @State private var errorOccured = false

    init(url: URL?) {
        self.url = url
    }

    var body: some View {
        ZStack {
            Rectangle().fill(Color.clear)
            ProgressView()
            if !fetcher.isLoading && fetcher.image == nil {
                Image("NoPoster")
                    .resizable()
                    .scaledToFill()
            } else {
                fetcher.view?
                    .resizable()
                    .scaledToFill()
            }
        }
        .onAppear { fetcher.load(url) }
        .onDisappear { fetcher.reset() }
        .onChange(of: url, perform: { fetcher.load($0) })
    }
}
