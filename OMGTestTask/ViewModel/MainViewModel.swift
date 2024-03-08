//
//  MainViewModel.swift
//  OMGTestTask
//
//  Created by Vitaliy Shmikov on 02.03.2024.
//

import Foundation

class MainViewModel {
    var verticalItems: [VerticalItemModel] = []
    var timer: DispatchSourceTimer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
    
    var updateTableView: (() -> Void)?
    var updateRandomHorizontalCell: (([Int]) -> Void)?
    
    let backgroundQueue = DispatchQueue.global(qos: .background)
    let backgroundLock = NSLock()
    
    func loadData() {
        verticalItems = loadTestData()
        updateTableView?()
        startTimer()
    }
    
    private func loadTestData() -> [VerticalItemModel]  {
        let itemsCount = Int.random(in: 101...150)
        for _ in 0..<itemsCount {
            var horizontalItems: [HorizontalItemModel] = []
            let horizontalCount = Int.random(in: 11...15)
            for _ in 0..<horizontalCount {
                horizontalItems.append(HorizontalItemModel(number: Int.random(in: 1...100)))
            }
            verticalItems.append(VerticalItemModel(horizontalItems: horizontalItems))
        }
        return verticalItems
    }
    
    private func startTimer() {
        timer.schedule(deadline: .now(), repeating: .seconds(1))
        timer.setEventHandler { [weak self] in
            self?.updateRandomHorizontalItem();
        }
        timer.resume()
    }
    
    func updateRandomHorizontalItem() {
        backgroundQueue.async { [self] in
            backgroundLock.lock()
            var updateIndicies = [Int]()
            for index in verticalItems.indices {
                let randomIndex = Int.random(in: 0..<verticalItems[index].horizontalItems.count)
                let updatedRandomNumber = Int.random(in: 1...100)
                verticalItems[index].horizontalItems[randomIndex].number = updatedRandomNumber
                updateIndicies.append(randomIndex)
            }
            updateRandomHorizontalCell?(updateIndicies)
            backgroundLock.unlock()
        }
    }
}
