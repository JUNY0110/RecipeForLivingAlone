//
//  RecipeHeader.swift
//  PleaseRecipe
//
//  Created by 지준용 on 10/24/23.
//

import UIKit

import SnapKit

final class RecipeHeader: UITableViewHeaderFooterView {
    
    // MARK: - Properties
    
    static let identifier = "recipeHeader"
    
    // MARK: - Views
    
    private let hContainerView = UIView()
    
    private let sectionLeftLabel: UILabel = {
        $0.text = ""
        $0.textColor = .secondaryLabel
        $0.font = .b2
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    private let sectionRightLabel: UILabel = {
        $0.text = ""
        $0.textColor = .secondaryLabel
        $0.font = .b2
        $0.textAlignment = .right
        return $0
    }(UILabel())
    
    // MARK: - Init
    
    @available(*, unavailable)
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        layout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    private func layout() {
        contentView.addSubview(hContainerView)
        hContainerView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.verticalEdges.equalToSuperview().inset(2)
        }
        
        hContainerView.addSubview(sectionLeftLabel)
        sectionLeftLabel.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.verticalEdges.equalToSuperview()
        }
        
        hContainerView.addSubview(sectionRightLabel)
        sectionRightLabel.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.verticalEdges.equalToSuperview()
        }
    }
    
    // MARK: - Configure
    
    func configureHeader(left sectionLeftText: String, right sectionRightText: String = "계량") {
        self.sectionLeftLabel.text = sectionLeftText
        self.sectionRightLabel.text = sectionRightText
    }
}
