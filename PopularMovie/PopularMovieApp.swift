//
//  PopularMovieApp.swift
//  PopularMovie
//
//  Created by Amit Kumar on 13/05/24.
//

import SwiftUI

@main
struct PopularMovieApp: App {
    var body: some Scene {
        WindowGroup {
            MovieListPage(viewModel: MovieListViewModel())
        }
    }
}
