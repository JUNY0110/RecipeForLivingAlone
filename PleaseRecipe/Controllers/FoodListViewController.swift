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
            foodListView.foodDatum = foodDatum
        }
    }
    
    // MARK: - Views
    
    private let searchController = UISearchController(searchResultsController: SearchResultViewController())
    private let foodListView = FoodListView()
    
    // MARK: - LifeCycle
    
    override func loadView() {
        view = foodListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureNavigationBar()
        configureSearchBar()
        fetchFoodDatum()
    }
    
    // MARK: - Methods
    
    private func fetchFoodDatum() {
        networkManager.onCompleted = { _ in
            self.foodDatum = self.networkManager.foodDatum
        }
    }
}

// MARK: - NavigationUI

extension FoodListViewController {
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "찜목록", style: .plain, target: self, action: nil)
        navigationItem.title = "요리 레시피"
    }
    
    private func configureSearchBar() {
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController?.automaticallyShowsCancelButton = false
        navigationItem.searchController?.obscuresBackgroundDuringPresentation = true
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
    }
}

// MARK: - UISearchResultsUpdating

extension FoodListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        print(text)
    }
}
