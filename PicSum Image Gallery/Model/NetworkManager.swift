//
//  NetworkManager.swift
//  ImageGallarySwiftUI
//
//  Created by Amin Pourgol on 8/8/23.
//

import Foundation

class NetworkManager: ObservableObject {

    @Published var posts: [Results] = []

    func fetchData() {
        if let url = URL(string: "https://picsum.photos/v2/list?page=2&limit=20") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode([Results].self, from: safeData)
                            DispatchQueue.main.async {
                                self.posts = results
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
