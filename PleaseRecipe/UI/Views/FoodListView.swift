//
//  FoodListView.swift
//  PleaseRecipe
//
//  Created by 지준용 on 2023/10/11.
//

import UIKit

final class FoodListView: UITableView {

    // MARK: - Properties
    
    private var diffableDataSource: UITableViewDiffableDataSource<Section, Item>!
    var viewModel: FoodListViewModel!
    var foodDatum = [Food]() {
        didSet {
            applySnapshot()
        }
    }

    // MARK: - Init
    
    @available(*, unavailable)
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        delegate = self
        setupDataSource()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetupDataSource
    
    private func setupDataSource() {
        self.diffableDataSource = UITableViewDiffableDataSource<Section, Item>(tableView: self, cellProvider: { tableView, indexPath, itemIdentifier in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: FoodListCell.identifier, for: indexPath) as! FoodListCell
            
            cell.configureCell(cellViewModelInit: self.viewModel.networkManager,
                               itemIdentifier.foodImageURL,
                               itemIdentifier.foodName,
                               itemIdentifier.foodDescription)
            
            return cell
        })
        
        dataSource = diffableDataSource
        register(FoodListCell.self, forCellReuseIdentifier: FoodListCell.identifier)
    }
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.food])
        
        for foodData in foodDatum {
            snapshot.appendItems([Item(foodImageURL: foodData.foodImageURL,
                                       foodName: foodData.title,
                                       foodDescription: foodData.summary)])
        }
        
        diffableDataSource.apply(snapshot)
    }
}

// MARK: - UITableViewDelegate

extension FoodListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
