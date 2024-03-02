//
//  VerticalItemCell.swift
//  OMGTestTask
//
//  Created by Vitaliy Shmikov on 02.03.2024.
//

import Foundation
import UIKit

class VerticalItemCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var collectionView: UICollectionView!
    var horizontalItems: [HorizontalItemModel] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HorizontalItemCell.self, forCellWithReuseIdentifier: "HorizontalItemCell")
        contentView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        // MARK: reset horizontal scroll state
        if collectionView.contentOffset != .zero {
            collectionView.contentOffset = .zero
        }
    }

    
    func setupCell(verticalItemModel: VerticalItemModel) {
        horizontalItems = verticalItemModel.horizontalItems
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return horizontalItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HorizontalItemCell", for: indexPath) as! HorizontalItemCell
        cell.setupCell(horizontalItemModel: horizontalItems[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = 60
        return CGSize(width: size, height: size)
    }
    
    func updateRandomItem() {
        let randomIndex = Int.random(in: 0..<horizontalItems.count)
        let indexPath = IndexPath(item: randomIndex, section: 0)
        if let cell = collectionView.cellForItem(at: indexPath) as? HorizontalItemCell {
            let updatedRandomNumber = Int.random(in: 1...100)
            horizontalItems[randomIndex].number = updatedRandomNumber
            cell.numberLabel.text = "\(updatedRandomNumber)"
        }
    }
}
