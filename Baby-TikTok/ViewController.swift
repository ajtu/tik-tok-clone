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
        let videos = setupModel()
        for _ in 0...5 {
            data.append(contentsOf: videos)
        }
        
        let layout = VerticalFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0 )
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: VideoCollectionViewCell.identifier)
    
        collectionView?.isPagingEnabled = false
        collectionView?.dataSource = self
        collectionView?.delegate = self
        view.addSubview(collectionView!)
        
        

        let timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(self.playVideoCellInFocus), userInfo: nil, repeats: false)




    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
    
    
    
    
    
     func setupModel() -> [VideoModel]{
        let model1 = VideoModel(caption: "hunter in bath", username: "@alvin", audioTrackName: "not sure", videoFileName: "hunter1", videoFileFormat: "mp4")
        let model2 = VideoModel(caption: "hunter running in grass", username: "@alvin", audioTrackName: "not sure", videoFileName: "hunter2", videoFileFormat: "mp4")
        let model3 = VideoModel(caption: "hunter on sofa", username: "@alvin", audioTrackName: "not sure", videoFileName: "hunter3", videoFileFormat: "mp4")
        let model4 = VideoModel(caption: "hunter with aidan", username: "@alvin", audioTrackName: "not sure", videoFileName: "hunter4", videoFileFormat: "mp4")
        let model5 = VideoModel(caption: "hunter with mom", username: "@alvin", audioTrackName: "not sure", videoFileName: "hunter5", videoFileFormat: "mp4")
        let array = [model1,model2,model3,model4,model5]
        return array
    }
    
    
    @objc fileprivate func playVideoCellInFocus() {
        var cellToPlay: VideoCollectionViewCell?
        
        let visibleVideoCells: [VideoCollectionViewCell] = collectionView!.visibleCells.compactMap { (cell) -> VideoCollectionViewCell? in
            if let videoCell = cell as? VideoCollectionViewCell {
                return videoCell
            }
            return nil
        }
        
        var currentLargestVisibleRect: CGFloat = 0.0
        let adjustedViewBounds = view.bounds
        
        print(visibleVideoCells)
        
        for cell in visibleVideoCells {
            guard let indexPath = collectionView!.indexPath(for: cell) else {
                continue
            }
            let attributes = collectionView!.layoutAttributesForItem(at: indexPath)
            var cellRect = attributes!.frame
            cellRect = collectionView!.convert(cellRect, to: view)
            
            let videoViewRect = CGRect(x: 0.0, y: cellRect.origin.y, width: cellRect.size.width, height: cell.playerLayer!.frame.size.height)

            var visibleVideoFrameHeight = cell.playerLayer!.frame.intersection(adjustedViewBounds).height
            
            if videoViewRect.origin.y < 0 {
                visibleVideoFrameHeight += videoViewRect.origin.y
            }

            if ((collectionView?.frame.contains(CGPoint(x: collectionView!.frame.origin.x, y: (collectionView?.frame.origin.y)! + collectionView!.frame.origin.y))) != nil) {
                if visibleVideoFrameHeight > currentLargestVisibleRect {
                    currentLargestVisibleRect = visibleVideoFrameHeight
                    cellToPlay = cell
                }
            }
        }
        
        for cell in visibleVideoCells {
            if cell == cellToPlay {
                cell.playVideo()
            } else {
                cell.stopVideo()
            }
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let viewModel = data[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCollectionViewCell.identifier, for: indexPath) as! VideoCollectionViewCell
        cell.configure(with: viewModel)
        
        return cell
    }
}



extension ViewController: UICollectionViewDelegate, UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //check for which video is in focus
        self.playVideoCellInFocus()
    }
    
}



class VerticalFlowLayout: UICollectionViewFlowLayout {
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {

        guard let collectionView = self.collectionView else {
            let latestOffset = super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
            return latestOffset
        }

        // Page height used for estimating and calculating paging.
        let pageHeight = self.itemSize.height + self.minimumLineSpacing

        // Make an estimation of the current page position.
        let approximatePage = collectionView.contentOffset.y/pageHeight

        // Determine the current page based on velocity.
        let currentPage = velocity.y == 0 ? round(approximatePage) : (velocity.y < 0.0 ? floor(approximatePage) : ceil(approximatePage))

        // Create custom flickVelocity.
        let flickVelocity = velocity.y * 0.33

        // Check how many pages the user flicked, if <= 1 then flickedPages should return 0.
        let flickedPages = (abs(round(flickVelocity)) <= 1) ? 0 : round(flickVelocity)

        let newVerticalOffset = ((currentPage + flickedPages) * pageHeight) - collectionView.contentInset.top

        return CGPoint(x: proposedContentOffset.x, y: newVerticalOffset)
    }

}
