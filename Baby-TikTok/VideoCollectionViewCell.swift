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
    
    var player: AVQueuePlayer?
    var playerLayer: AVPlayerLayer?
    var playerLooper: AVPlayerLooper?
    var playerItem: AVPlayerItem?
    private var model: VideoModel?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .black

        
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
        player = AVQueuePlayer()
        playerLayer = AVPlayerLayer(player: player)
        playerItem = AVPlayerItem(url: URL(fileURLWithPath: path))
        playerLooper = AVPlayerLooper(player:player!, templateItem: playerItem!)


        playerLayer!.player = player
        playerLayer!.frame = contentView.bounds
        contentView.layer.addSublayer(playerLayer!)
//        player?.volume = 30.0
//        player?.play()

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //public methods
    func playVideo() {
//        shouldLoopVideo = true
        playerLayer?.player?.play()
        playerLayer?.player!.volume = 30.0
    }
    
    func stopVideo() {
//        shouldLoopVideo = false
        playerLayer?.player?.pause()
        playerLayer!.player?.volume = 0
    }
}
