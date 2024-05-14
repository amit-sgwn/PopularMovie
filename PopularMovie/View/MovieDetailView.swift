//
//  MovieDetailView.swift
//  PopularMovie
//
//  Created by Amit Kumar on 14/05/24.
//

import Foundation
import SwiftUI


struct MovieDetailView: View {
    @ObservedObject var viewModel: MovieDetailViewModel
    
    var body: some View {
        if let movieDetail = viewModel.movieDetail, let movie = viewModel.movieDetail {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // Movie Poster Image
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
                    
                    HStack(alignment: .center) {
                        Text(movie.title)
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer().frame(width: 40)
                        // Add your progress view here
                        CircularProgressBar(percentage: (movie.voteAverage/10)*100, lineWidth: 5, radius: 30)
                            .frame(width: 60, height: 60)
                        
                    }
                    .frame(height: 100)
                    .padding()
                    
                    Divider()
                        .background(Color.softLightGray)
                    
                    // Movie Details
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Text("Release Date: \(movie.releaseDate)")
                        Text("Rating: \(movie.voteAverage)")
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Overview:")
                                .font(.headline)
                            Text(movie.overview)
                                .multilineTextAlignment(.leading)
                                .fixedSize(horizontal: false, vertical: true) // Allow the text to wrap
                        }
                        
                    }
                    .padding()
                    .cornerRadius(10)
                    .shadow(color: .gray, radius: 3, x: 0, y: 2)
                    
                }
                
                .padding(.bottom, 20)
            }
            .foregroundColor(.white)
            .background(Color.lightSlateGray)
            .navigationTitle(movie.title)
        } else {
            ProgressView()
        }
    }
}


