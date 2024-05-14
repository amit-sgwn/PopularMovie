//
//  ContentView.swift
//  PopularMovie
//
//  Created by Amit Kumar on 13/05/24.
//

import SwiftUI

struct MovieListPage: View {
    @ObservedObject var viewModel: MovieListViewModel
    
    var body: some View {
        TabView {
            MovieListView(movies: viewModel.latestMovie, title: "Latest Movies")
                .tabItem {
                    Label("Latest", systemImage: "flame")
                }
            
            MovieListView(movies: viewModel.popularMovies, title: "Popular Movies")
                .tabItem {
                    Label("Popular", systemImage: "star")
                }
        }
        .navigationTitle("Movies")
        .onAppear {
            viewModel.fetchLatestMovies()
            viewModel.fetchPopularMovies()
        }
    }
}

