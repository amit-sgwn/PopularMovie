//
//  MovieListVM.swift
//  PopularMovie
//
//  Created by Amit Kumar on 13/05/24.
//

import Foundation
import RevDevNetworkSDK
import Foundation
import Combine

class MovieListViewModel: ObservableObject {
    @Published var latestMovie: [Movie] = []
    @Published var popularMovies: [Movie] = []
    @Published var popularMovieList: MovieList? = nil  // Holds the full response
    @Published var errorMessage: String?

    let service: NetworkServiceProtocol

    init(service: NetworkServiceProtocol = NetworkService()) {
        self.service = service
    }
    
    func fetchLatestMovies() {
        let urlString = "\(Config.baseURL)/movie/latest?api_key=\(Config.apiKey)"
        
        guard let url = URL(string: urlString) else {
            self.errorMessage = "Invalid URL for latest movies"
            return
        }

        let headers = ["Authorization": "Bearer YOUR_AUTH_TOKEN",
                       "Content-Type": "application/json",
                       "User-Agent": "YourApp/1.0"]

        service.fetchData(url: url, headers: headers) { (result: Result<Movie, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let movie):
                    self.latestMovie.append(movie) //= movie
                case .failure(let error):
                    self.errorMessage = "Failed to fetch latest movies: \(error.localizedDescription)"
                    print("Error:", error)
                }
            }
        }
    }
    
    func fetchPopularMovies() {
        let urlString = "\(Config.baseURL)/movie/popular?api_key=\(Config.apiKey)"
        
        guard let url = URL(string: urlString) else {
            self.errorMessage = "Invalid URL for popular movies"
            return
        }

        let headers = ["Authorization": "Bearer YOUR_AUTH_TOKEN",
                       "Content-Type": "application/json",
                       "User-Agent": "YourApp/1.0"]

        service.fetchData(url: url, headers: headers) { (result: Result<MovieList, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let movieList):
                    self.popularMovieList = movieList  // Store the full movie list object
                    self.popularMovies = movieList.results  // Store only the movies
                case .failure(let error):
                    self.errorMessage = "Failed to fetch popular movies: \(error.localizedDescription)"
                    print("Error:", error)
                }
            }
        }
    }
}


struct Config {
    static let apiKey = "909594533c98883408adef5d56143539"
    static let baseURL = URL(string: "https://api.themoviedb.org/3")!
}

class MovieDetailViewModel: ObservableObject {
    @Published var movieDetail: MovieDetail?
    private let movieID: Int
    private let networkService: NetworkService
    
    init(movieID: Int, networkService: NetworkService = NetworkService()) {
        self.movieID = movieID
        self.networkService = networkService
        fetchMovieDetail()
    }
    
    private func fetchMovieDetail() {
        let urlString = "\(Config.baseURL)/movie/\(movieID)?api_key=\(Config.apiKey)"
        guard let url = URL(string: urlString) else { return }
        let headers = ["Authorization": "Bearer YOUR_AUTH_TOKEN",
                       "Content-Type": "application/json",
                       "User-Agent": "YourApp/1.0"]
        
        networkService.fetchData(url: url, headers: headers) {  [weak self] (result: Result<MovieDetail, Error>) in
            switch result {
            case .success(let movieDetail):
                DispatchQueue.main.async {
                    self?.movieDetail = movieDetail
                }
            case .failure(let error):
                print("Error fetching movie detail: \(error)")
            }
        }
   
    }
}
