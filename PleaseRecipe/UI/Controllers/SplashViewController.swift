//
//  SplashViewController.swift
//  PleaseRecipe
//
//  Created by 지준용 on 10/31/23.
//

import UIKit

import Lottie
import SnapKit

final class SplashViewController: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel = FoodListViewModel()
    
    // MARK: - Views
    
    private let animationView: LottieAnimationView = {
        $0.contentMode = .scaleToFill
        $0.loopMode = .loop
        $0.play()
        return $0
    }(LottieAnimationView(name: "foodLottie"))
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        layout()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.dismiss(animated: false)
            
            self.showFoodListViewController()
        }
    }
    
    // MARK: - Layout
    
    private func layout() {
        self.view.addSubview(animationView)
        
        animationView.snp.makeConstraints {
            $0.size.equalTo(100)
            $0.center.equalToSuperview()
        }
    }
    
    private func showFoodListViewController() {
        let foodListViewController = FoodListViewController()
        foodListViewController.viewModel = viewModel
        
        let navigationController = UINavigationController(rootViewController: foodListViewController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: false)
    }
}
