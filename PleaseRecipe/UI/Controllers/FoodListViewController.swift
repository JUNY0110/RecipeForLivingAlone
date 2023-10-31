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
    
    private let networkManager = NetworkManager()
    private var foodDatum = [Food]() {
        didSet {
            foodListView.foodDatum = foodDatum
        }
    }
    
    // MARK: - Views
    
    private let splashViewController = SplashViewController()
    private let searchController = UISearchController()
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
        
        foodListView.reloadData()
        
        configureNavigationBarColor()
        appearTabBar()
    }
    
    // MARK: - Methods
    
    private func fetchFoodDatum() {
        let viewModel = FoodListViewModel(networkManager: networkManager)
        foodListView.viewModel = viewModel
        
        viewModel.onCompletedData = { [weak self] datum in
            self?.foodListView.foodDatum = datum
        }
    }
    
    func moveToRecipeViewController(_ data: Food) {
        let recipeViewController = RecipeViewController()
        recipeViewController.foodData = data
        
        guard let width = view.window?.windowScene?.screen.bounds.width else { return }
        recipeViewController.viewModel = .init(networkManager: networkManager, width: width)
        
        self.navigationController?.pushViewController(recipeViewController, animated: true)
    }
    
    private func appearTabBar() {
//        tabBarController?.tabBar.isHidden = false
    }
    
    private func showSplashView() {
        present(splashViewController, animated: false)
    }
}

// MARK: - NavigationUI

extension FoodListViewController {
    private func configureNavigationBarItems() {
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem = backBarButtonItem
        
//        let rightBarButtonItem = UIBarButtonItem(title: "찜목록", style: .plain, target: self, action: nil)
//        navigationItem.rightBarButtonItem = rightBarButtonItem
        
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
        searchController.searchBar.delegate = self
    }
}

// MARK: - UISearchResultsUpdating

extension FoodListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        foodListView.applySnapshot(with: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.replacingOccurrences(of: " ", with: "").isEmpty else { return }
        view.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        foodListView.applySnapshot()
        view.endEditing(true)
    }
}
