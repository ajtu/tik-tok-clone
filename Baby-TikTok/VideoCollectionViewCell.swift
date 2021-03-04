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
    var player: AVPlayer?
    private var model: VideoModel?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .blue

        
    }

    public func configure(with model: VideoModel) {
        self.model = model
        configureVideo()
    }
    
    private func configureVideo() {
        guard let model = model else { return }
        guard let path = Bundle.main.path(forResource: model.videoFileName, ofType: model.videoFileFormat) else {
            print("failed to find video")
            return }
        player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerView = AVPlayerLayer()
        playerView.player = player
        playerView.frame = contentView.bounds
        contentView.layer.addSublayer(playerView)
        player?.volume = 0
        player?.play()

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
