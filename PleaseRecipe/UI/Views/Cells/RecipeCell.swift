//
//  RecipeCell.swift
//  PleaseRecipe
//
//  Created by 지준용 on 10/24/23.
//

import UIKit

import SnapKit

final class RecipeCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "recipeCell"
    
    // MARK: - Views
    
    private let hContainerView: UIView = {
        $0.backgroundColor = .systemGray6
        $0.layer.cornerRadius = 4
        return $0
    }(UIView())
    
    private let ingredientNameLabel: UILabel = {
        $0.text = ""
        $0.textAlignment = .left
        $0.numberOfLines = 0
        $0.font = .b3
        
        let attrString = NSMutableAttributedString(string: $0.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        $0.attributedText = attrString
        return $0
    }(UILabel())
    
    private let measuringLabel: UILabel = {
        $0.text = ""
        $0.textAlignment = .right
        $0.font = .b2
        return $0
    }(UILabel())
    
    // MARK: Init
    
    @available(*, unavailable)
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        ingredientNameLabel.text = ""
        measuringLabel.text = ""
    }
    
    // MARK: - Layout
    
    private func layout() {
        contentView.addSubview(hContainerView)
        hContainerView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.verticalEdges.equalToSuperview().inset(2)
            $0.height.greaterThanOrEqualTo(30)
        }
        
        hContainerView.addSubview(ingredientNameLabel)
        ingredientNameLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(8)
            $0.verticalEdges.equalToSuperview()
        }
        
        hContainerView.addSubview(measuringLabel)
        measuringLabel.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-8)
            $0.verticalEdges.equalToSuperview()
        }
    }
    
    // MARK: - Configure
    
    func configureCell(_ ingredientName: String, _ measuringValue: String = "") {
        self.ingredientNameLabel.text = ingredientName
        self.measuringLabel.text = measuringValue
    }
}
