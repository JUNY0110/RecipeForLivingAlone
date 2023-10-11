//
//  FoodListViewController.swift
//  PleaseRecipe
//
//  Created by 지준용 on 2023/10/08.
//

import UIKit

import SnapKit

final class FoodListViewController: UIViewController {

    // MARK: - Properties
    
    private let networkManager = NetworkManager()
    private var foodDatum = [Food]() {
        didSet {
            applySnapshot()
        }
    }
    private var dataSource: UITableViewDiffableDataSource<Section, Item>!
    
    // MARK: - Views
    
    private let searchController = UISearchController(searchResultsController: SearchResultViewController())
    private lazy var tableView: UITableView = {
        $0.dataSource = dataSource
        $0.register(FoodListCell.self, forCellReuseIdentifier: FoodListCell.identifier)
        return $0
    }(UITableView())
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        fetchFoodDatum()
        configureNavigationBar()
        configureTableView()
        
        layout()
    }
    
    // MARK: - Layout
    
    private func layout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - Configure
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "찜목록", style: .plain, target: self, action: nil)
        navigationItem.title = "요리 레시피"
        
        configureSearchBar()
    }
    
    private func configureSearchBar() {
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController?.automaticallyShowsCancelButton = false
        navigationItem.searchController?.obscuresBackgroundDuringPresentation = true
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
    }
    
    // MARK: - Methods
    
    private func fetchFoodDatum() {
        networkManager.onCompleted = {_ in
            self.foodDatum = self.networkManager.foodDatum
        }
    }
}

// MARK: - DiffableTableViewDataSource

extension FoodListViewController {
    private func configureTableView() {
        self.dataSource = UITableViewDiffableDataSource<Section, Item>(tableView: tableView, cellProvider: { tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(withIdentifier: FoodListCell.identifier, for: indexPath) as! FoodListCell
            
            cell.configureCell(itemIdentifier.foodImage,
                               itemIdentifier.foodName,
                               itemIdentifier.foodDescription)
            return cell
        })
    }
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.food])
        
        for foodData in foodDatum {
            snapshot.appendItems([Item(foodImage: foodData.titleImageURL,
                                       foodName: foodData.title,
                                       foodDescription: foodData.summary)])
        }
        
        dataSource.apply(snapshot)
    }
}

// MARK: - UISearchResultsUpdating

extension FoodListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        print(text)
    }
}

// MARK: - Nested Types

extension FoodListViewController {
    private enum Section: CaseIterable {
        case food
    }
    
    private struct Item: Hashable {
        let foodImage: String
        let foodName: String
        let foodDescription: String
    }
}
