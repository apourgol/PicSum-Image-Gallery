//
//  NetworkManager.swift
//  ImageGallarySwiftUI
//
//  Created by Amin Pourgol on 8/8/23.
//

import Foundation

class NetworkManager: ObservableObject {

    func fetchData(completion: @escaping ([Results]?) -> Void) {
        if let url = URL(string: "https://picsum.photos/v2/list?page=2&limit=20") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                    completion(nil)
                    return
                }

                if let safeData = data {
                    let decoder = JSONDecoder()
                    do {
                        let results = try decoder.decode([Results].self, from: safeData)
                        DispatchQueue.main.async {
                            completion(results)
                        }
                    } catch {
                        print("Error decoding JSON: \(error)")
                        completion(nil)
                    }
                }
            }
            task.resume()
        }
    }
}
