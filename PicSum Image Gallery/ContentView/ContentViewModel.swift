//
//  ContentViewModel.swift
//  PicSum Image Gallery
//
//  Created by Amin Pourgol on 9/24/23.
//

import Foundation

class ContentViewModel: ObservableObject {
    private let networkManager = NetworkManager()
    @Published var posts: [Results] = []

    func retrieveData() {
        networkManager.fetchData { (results) in
            if let results = results {
                // Use the results array here
                self.posts = results
                print (results)
            } else {
                // Handle the error case here
                print("error")
            }
        }
    }
}
