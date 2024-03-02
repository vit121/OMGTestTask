//
//  HorizontalItemCell.swift
//  OMGTestTask
//
//  Created by Vitaliy Shmikov on 02.03.2024.
//

import Foundation
import UIKit

class HorizontalItemCell: UICollectionViewCell {
    let containerView = UIView()
    let numberLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        containerView.layer.borderWidth = 1.0
        containerView.layer.borderColor = UIColor.gray.cgColor
        containerView.layer.cornerRadius = 12.0
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false

        numberLabel.textAlignment = .center
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(numberLabel)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            numberLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            numberLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(horizontalItemModel: HorizontalItemModel) {
        numberLabel.text = "\(horizontalItemModel.number)"
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        startAnimation()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        stopAnimation()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        stopAnimation()
    }
    
    private func startAnimation() {
        UIView.animate(withDuration: 0.3) {
            self.containerView.transform = self.contentView.transform.scaledBy(x: 0.8, y: 0.8)
        }
    }
    
    private func stopAnimation() {
        UIView.animate(withDuration: 0.3) {
            self.containerView.transform = .identity
        }
    }
}
