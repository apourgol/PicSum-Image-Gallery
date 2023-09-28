//
//  ContentView.swift
//  ImageGallarySwiftUI
//
//  Created by Amin Pourgol on 8/7/23.
//

import SwiftUI

struct ContentView: View {
    //init ViewModel here
    @ObservedObject var viewModel = ContentViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.posts) { post in
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
                                .frame(width: 50, height: 50)
                                .cornerRadius(10)
                        }
                        VStack(alignment: .leading, spacing: 3){
                            Text(post.author)
                            Text(post.id)
                                .font(.caption)
                        }
                    }
                }
            }
            .navigationBarTitle("title")
        }
        .onAppear {
            viewModel.retrieveData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
