//
//  ViewController.swift
//  Baby-TikTok
//
//  Created by Alvin Tu on 3/4/21.
//

import UIKit
struct VideoModel {
    let caption: String
    let username: String
    let audioTrackName: String
    let videoFileName: String
    let videoFileFormat: String
}
class ViewController: UIViewController {
    
    private var collectionView: UICollectionView?
    private var data = [VideoModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 0...5 {
        for n in 1...5 {
            let model = VideoModel(caption: "Hunter's Growth", username: "@alvin", audioTrackName: "not sure", videoFileName: "hunter\(n)", videoFileFormat: "mp4")
            data.append(model)
        }
        }
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0 )
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: VideoCollectionViewCell.identifier)
    
        collectionView?.isPagingEnabled = true
        collectionView?.dataSource = self
        view.addSubview(collectionView!)
        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
    
}

//override func view(){
//    super.viewDidLayoutSubViews()
//}
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let viewModel = data[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCollectionViewCell.identifier, for: indexPath) as! VideoCollectionViewCell
        print(viewModel.videoFileName)
        print(viewModel.videoFileFormat)
        cell.configure(with: viewModel)
        return cell
    }
}

