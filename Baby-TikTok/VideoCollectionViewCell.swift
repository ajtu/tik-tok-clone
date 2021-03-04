//
//  VideoCollectionViewCell.swift
//  Baby-TikTok
//
//  Created by Alvin Tu on 3/4/21.
//

import UIKit
import AVFoundation

class VideoCollectionViewCell: UICollectionViewCell {
    static let identifier = "VideoCollectionViewCell"
    let player: AVPlayer = AVPlayer()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }

    public func configure(with model: VideoModel) {
        contentView.backgroundColor = .blue

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
