//
//  MovieRowView.swift
//  PopularMovie
//
//  Created by Amit Kumar on 14/05/24.
//

import Foundation
import SwiftUI

struct MoviewRow: View {
    var movie: Movie

    var body: some View {
            VStack(spacing: 0) {
                if let backdropURL = ImageURLProvider.backdropURL(backdropPath: movie.posterPath) {
                    AsyncImage(url: backdropURL) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .edgesIgnoringSafeArea(.top)
                        case .failure:
                            Image(systemName: "photo") // Placeholder image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 300)
                        case .empty:
                            ProgressView()
                                .frame(height: 300)
                        @unknown default:
                            EmptyView()
                        }
                    }
                }

                
                Spacer().frame(height: 10) // Add Spacer
                CircularProgressBar(percentage: (movie.voteAverage/10)*100, lineWidth: 4, radius: 30)
                    .offset(x: -130,y: -45)
                    
                HStack {
                    VStack(alignment: .leading,spacing: 5) {
                        Text(movie.originalTitle)
                            .font(.title)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                            .fontWeight(.bold)
                        Text(movie.overview)
                            .font(.body)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding([.leading], 30)
                    .padding([.bottom], 20)
                    Spacer()
                }
                Spacer()
            }
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
