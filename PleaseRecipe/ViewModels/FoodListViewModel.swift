//
//  ViewModel.swift
//  PleaseRecipe
//
//  Created by 지준용 on 2023/10/08.
//

import UIKit

final class FoodListViewModel {

    // MARK: - Properties
    
    let networkManager = NetworkManager.shared

    // MARK: Output
    
    private var foodDatum = [Food]() {
        didSet {
            onCompletedData()
        }
    }
    var diffableDataSource: UITableViewDiffableDataSource<Section, Food>!
    var snapshot: NSDiffableDataSourceSnapshot<Section, Food>!
    
    var onCompletedData: () -> () = {}
    
    // MARK: - Init
    
    init() {
        makeFoodDatum()
    }
    
    // MARK: - Methods
    
    private func makeFoodDatum() {
        for mainURL in APIEnvironment.mainURLs {
            networkManager.makeFoodData(urlString: APIEnvironment.baseURL + mainURL) { result in
                switch result {
                case .success(let food):
                    DispatchQueue.main.async {
                        if !self.foodDatum.contains(food) {
                            self.foodDatum.append(food)
                        }
                    }
                case .failure(let error):
                    debugPrint(String(reflecting: error))
                }
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
