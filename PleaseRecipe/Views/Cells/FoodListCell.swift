//
//  FoodListCell.swift
//  PleaseRecipe
//
//  Created by 지준용 on 2023/10/11.
//

import UIKit

import SnapKit

final class FoodListCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "foodListCell"

    
    @available(*, unavailable)
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
