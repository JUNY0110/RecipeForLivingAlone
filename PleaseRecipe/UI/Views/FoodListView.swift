//
//  FoodListView.swift
//  PleaseRecipe
//
//  Created by 지준용 on 2023/10/11.
//

import UIKit

protocol FoodListViewDelegate: AnyObject {
    func moveToRecipeViewController(_ data: Food)
}

final class FoodListView: UITableView {

    // MARK: - Properties
    weak var viewDelegate: FoodListViewDelegate?
    private var diffableDataSource: UITableViewDiffableDataSource<Section, Food>!
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
        self.diffableDataSource = UITableViewDiffableDataSource<Section, Food>(tableView: self, cellProvider: { tableView, indexPath, itemIdentifier in
            
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
    
    func applySnapshot(with word: String = "") {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Food>()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let snapshot = diffableDataSource.snapshot()
        let itemIdentifier = snapshot.itemIdentifiers[indexPath.row]
        
        viewDelegate?.moveToRecipeViewController(itemIdentifier)
    }
}
