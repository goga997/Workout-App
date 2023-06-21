//
//  ImagesCollectionView.swift
//  TrainingApp
//
//  Created by Grigore on 17.06.2023.
//

import UIKit

class ImagesCollectionView: UICollectionView {
    
    let images: [ImageForNewWorkout] = [
        ImageForNewWorkout(imageName: "colection1"),
        ImageForNewWorkout(imageName: "colection2"),
        ImageForNewWorkout(imageName: "collection3"),
        ImageForNewWorkout(imageName: "collection4"),
        ImageForNewWorkout(imageName: "testWorkout"),
    ]
    
    private let collectionLayout = UICollectionViewFlowLayout()
    
    private let idImagesCell = "idImagesCell"
    
    static var extractedImage: ImageForNewWorkout?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: collectionLayout)
        
        configure()
        setUpLayouts()
        setDelegates()
        register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: idImagesCell)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .none
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setUpLayouts() {
        collectionLayout.minimumInteritemSpacing = 3
        collectionLayout.scrollDirection = .horizontal
    }
    
    private func setDelegates() {
        self.delegate = self
        self.dataSource = self
    }
}

//MARK: - UICollectionViewDataSource

extension ImagesCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idImagesCell, for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
        
        let item = images[indexPath.item]
        cell.workoutImageView.image = UIImage(named: item.imageName)?.withRenderingMode(.alwaysTemplate)
        
        return cell
    }
}

//MARK: - UICollectionViewDelegate

extension ImagesCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            ImagesCollectionView.extractedImage = images[0]
        case 1:
            ImagesCollectionView.extractedImage = images[1]
        case 2:
            ImagesCollectionView.extractedImage = images[2]
        case 3:
            ImagesCollectionView.extractedImage = images[3]
        case 4:
            ImagesCollectionView.extractedImage = images[4]
        default:
            ImagesCollectionView.extractedImage = nil
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension ImagesCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3,
                      height: collectionView.frame.height)
    }
}
