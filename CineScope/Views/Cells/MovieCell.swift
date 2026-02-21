//
//  MovieCell.swift
//  CineScope
//
//  Created by Semih TAKILAN on 26.12.2025.
//

import UIKit
import Kingfisher

class MovieCell: UICollectionViewCell { // UICollectionViewCell olduğuna dikkat!

    // MARK: - UI Elements
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var scoreProgressView: CircularProgressView! // Özel görünümümüz
    
    // MARK: - Properties
    static let identifier = "MovieCell"
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Poster Köşeleri
        moviePosterImageView.layer.cornerRadius = 12
        moviePosterImageView.clipsToBounds = true
        
        // Progress View Arka Planı (Daha iyi okunsun diye)
        scoreProgressView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        scoreProgressView.layer.cornerRadius = 20
        scoreProgressView.clipsToBounds = true
    }
}
