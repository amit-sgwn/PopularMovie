//
//  MoviewList.swift
//  PopularMovie
//
//  Created by Amit Kumar on 14/05/24.
//

import SwiftUI



struct MovieListView: View {
    var movies: [Movie]
    var title: String
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(movies) { movie in
                        NavigationLink(destination: MovieDetailView(viewModel: MovieDetailViewModel(movieID: movie.id))) {
                            MoviewRow(movie: movie)
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal, 0)
                            // Explicitly control padding
                        }
                        .buttonStyle(PlainButtonStyle()) // Remove any button-like styling
                        .padding(.vertical, 0) // Remove vertical padding between rows
                    }
                }
            }
            .navigationTitle(title)
            .edgesIgnoringSafeArea(.all) // Extend content to the edges if needed
        }
    }
}

