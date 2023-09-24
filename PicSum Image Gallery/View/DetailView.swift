//
//  DetailView.swift
//  ImageGallarySwiftUI
//
//  Created by Amin Pourgol on 8/7/23.
//

import SwiftUI

struct DetailView: View {

    @State private var showDetails = false
    @State private var isFavorited = false

    let url: String?
    let authorName: String?
    let idNumber: String?
    let imgWidth: Int?
    let imgHeight: Int?

    var body: some View {
        VStack {
            VStack {
                Text("The PicSum Art Gallery presents:")
                    .font(.largeTitle)
                    .foregroundColor(Color.black)
                AsyncImage(url: URL(string: url ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(25)
                } placeholder: {
                    // Placeholder view while the image is being loaded
                    Color.black
                }
            }
            .padding(.bottom, 50)

            RoundedRectangle(cornerRadius: 25)
                .foregroundColor(Color.gray)
                .cornerRadius(10)
                .frame(height: 50)
                .overlay(Button(action: {
                withAnimation {
                    showDetails.toggle()
                }
            }) {
                HStack {
                    Image(systemName: "chevron.right.circle.fill")
                        .rotationEffect(.degrees(showDetails ? 90 : 0))
                        .foregroundColor(Color.white)
                    Text("Show More Details")
                        .foregroundColor(Color.white)
                }
            })

            if showDetails {
                ZStack {
                    VStack(alignment: .leading, spacing: 15) {
                        Label(authorName ?? "", systemImage: "heart.fill")
                            .foregroundColor(Color.red)
                            .font(.body)
                        Label("ArtID: \(idNumber ?? "N/A")" , systemImage: "bookmark.fill")
                            .foregroundColor(Color.black)
                            .font(.body)
                        if let width = imgWidth, let height = imgHeight {
                            let widthStr = String(width)
                            let heightStr = String(height)
                            Label("\(widthStr)x\(heightStr)", systemImage: "ruler.fill")
                                .foregroundColor(Color.blue)
                                .font(.body)
                        }
                    }
                    .transition(.slide)
                }
                .frame(maxWidth: .infinity)
                .edgesIgnoringSafeArea(.all)
            }
            Spacer()
            VStack() {
                Text("*Made with SwiftUI")
                    .font(.footnote)
                    .foregroundColor(Color.black)

            Spacer()

            Button(action: {
                isFavorited = !isFavorited

                let dbManager = DBManager()
                dbManager.addData(idValue: self.idNumber!, urlValue: self.url!, nameValue: self.authorName!)

            }) {
                Label("", systemImage: isFavorited ? "heart.fill" : "heart")
                    .foregroundColor(Color.red)
            }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        .padding()
        .background(Color.white)
    }
}


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(url: "https://fastly.picsum.photos/id/18/2500/1667.jpg?hmac=JR0Z_jRs9rssQHZJ4b7xKF82kOj8-4Ackq75D_9Wmz8",
                   authorName: "Jon Snow",
                   idNumber: "11",
                    imgWidth: 5000,
                    imgHeight: 3333)
    }
}
