//
//  MainViewController.swift
//  OMGTestTask
//
//  Created by Vitaliy Shmikov on 02.03.2024.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource {
    let tableView = UITableView()
    var viewModel = MainViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        tableView.dataSource = self
        tableView.register(VerticalItemCell.self, forCellReuseIdentifier: "VerticalItemCell")
        tableView.rowHeight = 100
        tableView.separatorStyle = .none
        view.addSubview(tableView)

        viewModel.updateTableView = { [weak self] in
            self?.tableView.reloadData()
        }
        viewModel.updateRandomHorizontalCell = { [weak self] in
            self?.updateRandomItemInEachCell()
        }
//        viewModel.updateRandomHorizontalCell = { updateIndices in
//            self.updateRandomItemInEachCell(updateIndices: updateIndices)
//        }
        viewModel.loadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.verticalItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VerticalItemCell", for: indexPath) as! VerticalItemCell
        cell.setupCell(verticalItemModel: viewModel.verticalItems[indexPath.row])
        return cell
    }
    
    func updateRandomItemInEachCell() {
        DispatchQueue.main.async {
            guard let visibleCells = self.tableView.visibleCells as? [VerticalItemCell] else { return }
            for cell in visibleCells {
                cell.updateRandomItem()
            }
        }
    }
    
//    func updateRandomItemInEachCell(updateIndices: [Int]) {
//        DispatchQueue.main.async {
//            guard let visibleCells = self.tableView.visibleCells as? [VerticalItemCell] else { return }
//            for index in visibleCells.indices {
//                let updatedNumber = self.viewModel.verticalItems[index].horizontalItems[updateIndices[index]].number
//                visibleCells[index].updateItem(updateIndex: updateIndices[index], updatedNumber: updatedNumber)
//            }
//        }
//    }
}
