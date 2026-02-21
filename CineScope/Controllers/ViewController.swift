//
//  ViewController.swift
//  CineScope
//
//  Created by Semih TAKILAN on 23.12.2025.
//


import UIKit
import Kingfisher

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var categories: [MovieCategory] = []
    let imageBaseURL = "https://image.tmdb.org/t/p/w200"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // Header Kaydı
        collectionView.register(SectionHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: SectionHeaderView.reuseIdentifier)
        
        // Layout Ayarı
        collectionView.collectionViewLayout = createLayout()
        
        // VERİ ÇEKME OPERASYONU BAŞLIYOR 🏁
        fetchAllCategories()
    }
    
    func fetchAllCategories() {
        print("Tüm kategoriler çekiliyor...")
        
        // DispatchGroup: Birden fazla internet işlemini takip etmek için trafik polisi gibidir.
        let group = DispatchGroup()
        
        var popularMovies: [Movie] = []
        var upcomingMovies: [Movie] = []
        var topRatedMovies: [Movie] = []
        
        // 1. İSTEK: Popüler Filmler
        group.enter() // Gruba "iş başladı" diyoruz
        NetworkManager.shared.fetchMovies(from: .popular) { movies in
            popularMovies = movies ?? []
            group.leave() // "Bu iş bitti" diyoruz
        }
        
        // 2. İSTEK: Yakında Gelecekler
        group.enter()
        NetworkManager.shared.fetchMovies(from: .upcoming) { movies in
            upcomingMovies = movies ?? []
            group.leave()
        }
        
        // 3. İSTEK: En Çok Oy Alanlar
        group.enter()
        NetworkManager.shared.fetchMovies(from: .topRated) { movies in
            topRatedMovies = movies ?? []
            group.leave()
        }
        
        // TÜM İŞLER BİTİNCE BURASI ÇALIŞIR 🔔
        group.notify(queue: .main) { [weak self] in
            print("Tüm veriler geldi, ekran yenileniyor.")
            
            // Kategorileri sırasıyla diziyoruz
            let cat1 = MovieCategory(title: "Popüler", movies: popularMovies)
            let cat2 = MovieCategory(title: "Yakında Sinemalarda", movies: upcomingMovies)
            let cat3 = MovieCategory(title: "Efsaneler (Top Rated)", movies: topRatedMovies)
            
            self?.categories = [cat1, cat2, cat3]
            self?.collectionView.reloadData()
        }
    }
    
    // MARK: - Layout
    func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(140),
                                               heightDimension: .absolute(240))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 16
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 30, trailing: 16)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .absolute(40))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                               elementKind: UICollectionView.elementKindSectionHeader,
                                                               alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    // MARK: - DataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories[section].movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        let category = categories[indexPath.section]
        let currentMovie = category.movies[indexPath.row]
        
        cell.movieTitleLabel.text = currentMovie.title
        cell.scoreProgressView.setProgress(voteAverage: currentMovie.voteAverage)
        
        if let posterPath = currentMovie.posterPath {
            let fullImageUrlString = imageBaseURL + posterPath
            if let url = URL(string: fullImageUrlString) {
                cell.moviePosterImageView.kf.setImage(with: url)
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.reuseIdentifier, for: indexPath) as? SectionHeaderView else {
            return UICollectionReusableView()
        }
        header.titleLabel.text = categories[indexPath.section].title
        return header
    }
}
