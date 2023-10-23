//
//  RecipeViewController.swift
//  PleaseRecipe
//
//  Created by 지준용 on 10/22/23.
//

import UIKit

import SnapKit

final class RecipeViewController: UIViewController {

    // MARK: - Properties
    
    var foodData: FoodListView.Item!
    
    // MARK: - Enum
    
    private enum Metric {
        static var statusBarHeight: CGFloat!
        static var stickyHeaderHeightMax: CGFloat!
        static var stickyHeaderHeightMaxWithoutStatusBar: CGFloat!
    }
    
    // MARK: - Views
    
    let scrollView: UIScrollView = {
        $0.backgroundColor = .yellow
        return $0
    }(UIScrollView())
    
    let contentView = UIView()
    
    let headerView: UIImageView = {
        $0.image = UIImage(named: "image")
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        $0.backgroundColor = .gray
        return $0
    }(UIImageView())
    
    let label: UILabel = {
        $0.text = "1long text\n\n\n2long text\n\n\n\n\n3long textlong text\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n4textlongtextlong"
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 36)
        return $0
    }(UILabel())
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        
        setupMetric()
        layout()
    }
    
    // MARK: - Layout
    
    private func layout() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints{
            $0.top.equalTo(view)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Metric.stickyHeaderHeightMax)
            $0.horizontalEdges.equalTo(view.snp.horizontalEdges).inset(20)
            $0.bottom.equalToSuperview()
        }
        
        scrollView.addSubview(headerView)
        headerView.snp.makeConstraints {
            $0.top.equalTo(view.snp.top)
            $0.horizontalEdges.equalTo(view.snp.horizontalEdges)
            $0.bottom.equalTo(contentView.snp.top).offset(-20)
        }
        
        contentView.addSubview(label)
        label.snp.makeConstraints {
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
}
