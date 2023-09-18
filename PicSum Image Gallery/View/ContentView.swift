//
//  ContentView.swift
//  ImageGallarySwiftUI
//
//  Created by Amin Pourgol on 8/7/23.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var networkManager = NetworkManager()

    var body: some View {
        NavigationView {
            List(networkManager.posts) { post in
                NavigationLink(destination: DetailView(url: post.download_url, authorName: post.author, idNumber: post.id, imgWidth: post.width, imgHeight: post.height)) {
                    HStack {
                        AsyncImage(url: URL(string: post.download_url)) { image in
                            image
                                .resizable()
                                .frame(width: 50, height: 50)
                                .cornerRadius(10)
                        } placeholder: {
                            // Placeholder view while the image is being loaded
                            Color.white
                        }
                        VStack(alignment: .leading, spacing: 3){
                            Text(post.author)
                            Text(post.id)
                                .font(.caption)
                        }
                    }
                }
            }
            .navigationBarTitle("PicSum Image Gallery")
        }
        .onAppear {
            self.networkManager.fetchData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
