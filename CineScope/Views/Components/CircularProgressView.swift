//
//  CircularProgressView.swift
//  CineScope
//
//  Created by Semih TAKILAN on 27.12.2025.
//

import UIKit

class CircularProgressView: UIView {
    
    private var progressLayer = CAShapeLayer()
    private var trackLayer = CAShapeLayer()
    let percentageLabel = UILabel()
    
    var progressColor: UIColor = .systemGreen {
        didSet { progressLayer.strokeColor = progressColor.cgColor }
    }
    
    var trackColor: UIColor = UIColor.lightGray.withAlphaComponent(0.5) {
        didSet { trackLayer.strokeColor = trackColor.cgColor }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = trackColor.cgColor
        trackLayer.lineWidth = 4
        trackLayer.strokeEnd = 1.0
        layer.addSublayer(trackLayer)
        
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = progressColor.cgColor
        progressLayer.lineWidth = 4
        progressLayer.strokeEnd = 0.0
        progressLayer.lineCap = .round
        layer.addSublayer(progressLayer)
        
        percentageLabel.translatesAutoresizingMaskIntoConstraints = false
        percentageLabel.textAlignment = .center
        percentageLabel.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        percentageLabel.textColor = .white
        addSubview(percentageLabel)
        
        NSLayoutConstraint.activate([
            percentageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            percentageLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: bounds.midY),
                                      radius: (bounds.width - 4) / 2,
                                      startAngle: -CGFloat.pi / 2,
                                      endAngle: 1.5 * CGFloat.pi,
                                      clockwise: true)
        trackLayer.path = circlePath.cgPath
        progressLayer.path = circlePath.cgPath
    }
    
    func setProgress(voteAverage: Double) {
        let percentage = CGFloat(voteAverage / 10.0)
        
        DispatchQueue.main.async {
            self.progressLayer.strokeEnd = percentage
            
            if voteAverage >= 7.5 {
                self.progressColor = .systemGreen
            } else if voteAverage >= 5.0 {
                self.progressColor = .systemYellow
            } else {
                self.progressColor = .systemRed
            }
            
            let scoreInt = Int(voteAverage * 10)
            self.percentageLabel.text = "%\(scoreInt)"
        }
    }
}
