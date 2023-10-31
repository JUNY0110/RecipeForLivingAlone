//
//  RecipeViewController.swift
//  PleaseRecipe
//
//  Created by 지준용 on 10/25/23.
//

import UIKit

import SnapKit

final class RecipeViewController: UIViewController {

    // MARK: - Properties
    
    var foodData: Food!
    var viewModel: FoodListCellViewModel!
    
    // MARK: - Enum
    
    private enum Metric {
        static var statusBarHeight: CGFloat!
        static var stickyHeaderHeightMax: CGFloat!
        static var stickyHeaderHeightMaxWithoutStatusBar: CGFloat!
    }
    
    // MARK: - Views
    
    private lazy var tableView: UITableView = {
        $0.backgroundColor = .white
        $0.separatorStyle = .none
        $0.allowsSelection = false
        $0.delegate = self
        $0.dataSource = self
        $0.register(RecipeHeader.self, forHeaderFooterViewReuseIdentifier: RecipeHeader.identifier)
        $0.register(RecipeCell.self, forCellReuseIdentifier: RecipeCell.identifier)
        return $0
    }(UITableView(frame: .zero, style: .grouped))
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        
        setupMetric()
        layout()
    }
    
    // MARK: - Layout
    
    private func layout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupMetric() {
        guard let statusBarHeight = view.window?.windowScene?.statusBarManager?.statusBarFrame.height,
              let stickyHeaderHeightMax = view.window?.windowScene?.screen.bounds.height else {
            return
        }
        
        Metric.statusBarHeight = statusBarHeight + 6
        Metric.stickyHeaderHeightMax = stickyHeaderHeightMax / 3
        Metric.stickyHeaderHeightMaxWithoutStatusBar = Metric.stickyHeaderHeightMax - Metric.statusBarHeight - 60
    }
}

// MARK: - UIScrollViewDelegate

extension RecipeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let remainingTopSpacing = scrollView.contentOffset.y
        configureNavigationAppearance(with: remainingTopSpacing)
    }
    
    private func configureNavigationAppearance(with remainingTopSpacing: CGFloat) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        if remainingTopSpacing >= Metric.stickyHeaderHeightMaxWithoutStatusBar {
            appearance.backgroundColor = .systemBackground
            navigationController?.navigationBar.tintColor = .black
        } else {
            appearance.backgroundColor = .clear
            navigationController?.navigationBar.tintColor = .systemBackground
        }
        
        navigationController?.navigationBar.standardAppearance = appearance
    }
}

// MARK: - UITableViewDataSource

extension RecipeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let section = RecipeSection(rawValue: section) {
            switch section {
            case .ingredient: return foodData.ingredients.count
            case .seasoning: return foodData.seasonings.count
            case .recipe: return foodData.cookingOrders.count
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: RecipeHeader.identifier) as! RecipeHeader
        
        if let section = RecipeSection(rawValue: section) {
            header.ingredientHeaderLabel.text = String(reflecting: section)
            
            if section == .recipe {
                header.measuringHeaderLabel.text = ""
            }
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecipeCell.identifier, for: indexPath) as! RecipeCell
        
        if let section = RecipeSection(rawValue: indexPath.section) {
            switch section {
            case .ingredient:
                let ingredients = foodData.ingredients.sorted(by: {$0.key < $1.key})
                let ingredient = ingredients[indexPath.row].key
                let measuring = ingredients[indexPath.row].value
                
                cell.configureCell(ingredient, measuring)
            case .seasoning:
                let sesonings = foodData.seasonings.sorted(by: {$0.key < $1.key})
                let sesoning = sesonings[indexPath.row].key
                let measuring = sesonings[indexPath.row].value
                
                cell.configureCell(sesoning, measuring)
            case .recipe:
                cell.configureCell("\(indexPath.row + 1). \(foodData.cookingOrders[indexPath.row])", "")
            }
        }
        
        return cell
    }
}

// MARK: - Nested Types

extension RecipeViewController {
    enum RecipeSection: Int, CustomStringConvertible {
        case ingredient
        case seasoning
        case recipe
        
        var description: String {
            switch self {
            case .ingredient: "식재료"
            case .seasoning: "조미료"
            case .recipe: "레시피"
            }
        }
    }
}
