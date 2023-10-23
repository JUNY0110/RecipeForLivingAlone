//
//  FoodListViewController.swift
//  PleaseRecipe
//
//  Created by 지준용 on 2023/10/08.
//

import UIKit

import SnapKit

final class FoodListViewController: UIViewController, FoodListViewDelegate {

    // MARK: - Properties
    
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
        
        foodListView.viewDelegate = self
        configureNavigationBarItems()
        configureSearchBar()
        fetchFoodDatum()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        configureNavigationBarColor()
        appearTabBar()
    }
    
    // MARK: - Methods
    
    private func fetchFoodDatum() {
        let networkManager = NetworkManager()
        let viewModel = FoodListViewModel(networkManager: networkManager)
        
        foodListView.viewModel = viewModel
        
        viewModel.onCompletedData = { [weak self] datum in
            self?.foodListView.foodDatum = datum
        }
    }
    
    func moveToRecipeViewController(_ data: FoodListView.Item) {
        let recipeViewController = RecipeViewController()
        recipeViewController.foodData = data
        
        self.navigationController?.pushViewController(recipeViewController, animated: true)
    }
    
    private func appearTabBar() {
        tabBarController?.tabBar.isHidden = false
    }
}

// MARK: - NavigationUI

extension FoodListViewController {
    private func configureNavigationBarItems() {
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem = backBarButtonItem
        let rightBarButtonItem = UIBarButtonItem(title: "찜목록", style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationItem.title = "요리 레시피"
    }
    
    private func configureNavigationBarColor() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.tintColor = .systemBlue
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
