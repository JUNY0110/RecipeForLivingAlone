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
    }
    
    // MARK: - Layout
    
    private func layout() {
        self.view.addSubview(animationView)
        
        animationView.snp.makeConstraints {
            $0.size.equalTo(100)
            $0.center.equalToSuperview()
        }
    }
}
