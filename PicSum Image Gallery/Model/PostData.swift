//
//  PostData.swift
//  ImageGallarySwiftUI
//
//  Created by Amin Pourgol on 8/8/23.
//

import Foundation

struct Results: Decodable, Identifiable {
    let id: String
    let author: String
    let width: Int
    let height: Int
    let url: String
    let download_url: String
}
