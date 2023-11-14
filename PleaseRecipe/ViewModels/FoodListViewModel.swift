//
//  ViewModel.swift
//  PleaseRecipe
//
//  Created by 지준용 on 2023/10/08.
//

import UIKit

final class FoodListViewModel {

    // MARK: - Properties
    
    private let networkManager = NetworkManager.shared
    var diffableDataSource: UITableViewDiffableDataSource<Section, Food>!
    var snapshot: NSDiffableDataSourceSnapshot<Section, Food>!
    
    // MARK: Output
    
    private var foodDatum = [Food]() {
        didSet {
            onCompletedData()
        }
    }
    
    var onCompletedData: () -> () = {}
    
    // MARK: - Init
    
    init() {
        fetchFoodDatum()
    }
    
    // MARK: - Methods
    
    private func fetchFoodDatum() {
        networkManager.makeFoodDatum { food in
            DispatchQueue.main.async {
                self.foodDatum.append(food)
            }
        }
    }

    func setupSnapshot(with word: String = "") {
        snapshot = NSDiffableDataSourceSnapshot<Section, Food>()
        snapshot.appendSections([.food])

        let filteredFoodDatum = filteredFoodDatum(with: word)
        snapshot.appendItems(filteredFoodDatum)
    }
    
    private func filteredFoodDatum(with word: String) -> [Food] {
        let filteredDatum = foodDatum.filter { $0.foodName.contains(word) }
        return filteredDatum.isEmpty ? foodDatum : filteredDatum
    }
    
    func setupDataSource(_ tableView: UITableView) {
        diffableDataSource = UITableViewDiffableDataSource<Section, Food>(tableView: tableView, cellProvider: { tableView, indexPath, itemIdentifier in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: FoodListCell.identifier, for: indexPath) as! FoodListCell
            cell.configureCell(itemIdentifier.foodImageURL,
                               itemIdentifier.foodName,
                               itemIdentifier.summary)
            
            return cell
        })
    }
    
    func applySnapshot(_ snapshot: NSDiffableDataSourceSnapshot<Section, Food>) {
        diffableDataSource.apply(snapshot)
    }
}
