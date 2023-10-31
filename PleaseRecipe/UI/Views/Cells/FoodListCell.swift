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
    private var imageURL: String? {
        didSet {
            viewModel.imageURL = imageURL
            loadImage()
        }
    }
    
    var viewModel: FoodListCellViewModel!
    
    // MARK: - Views
    
    private let foodImageView: UIImageView = {
        $0.backgroundColor = .systemGray6
        $0.layer.cornerRadius = 8
        $0.layer.masksToBounds = true
        return $0
    }(UIImageView())
    
    private let vStackView: UIStackView = {
        $0.axis = .vertical
        $0.alignment = .top
        $0.spacing = 10
        return $0
    }(UIStackView())
    
    private let foodNameLabel: UILabel = {
        $0.text = ""
        $0.textAlignment = .left
        $0.numberOfLines = 1
        $0.font = .h3
        return $0
    }(UILabel())
    
    private let foodDescriptionLabel: UILabel = {
        $0.text = ""
        $0.textAlignment = .left
        $0.textColor = .systemGray2
        $0.numberOfLines = 2
        $0.font = .b2
        return $0
    }(UILabel())
    
    // MARK: - Init
    
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
        
        self.foodImageView.image = nil
        self.foodNameLabel.text = ""
        self.foodDescriptionLabel.text = ""
    }
    
    // MARK: - Layout
    
    private func layout() {
        contentView.addSubview(foodImageView)
        foodImageView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(20)
            $0.left.equalToSuperview().offset(16)
            $0.size.equalTo(80)
        }
        
        contentView.addSubview(vStackView)
        vStackView.addArrangedSubview(foodNameLabel)
        vStackView.addArrangedSubview(foodDescriptionLabel)
        
        vStackView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(20)
            $0.left.equalTo(foodImageView.snp.right).offset(16)
            $0.right.equalToSuperview().offset(-16)
        }
    }
    
    // MARK: - Configure
    
    func configureCell(cellViewModelInit networkManager: NetworkManager, _ foodImageName: String?, _ foodName: String, _ foodDescription: String) {
        self.viewModel = .init(networkManager: networkManager, width: 80)
        self.imageURL = foodImageName
        self.foodNameLabel.text = foodName
        self.foodDescriptionLabel.text = foodDescription
    }
    
    // MARK: - Methods
    
    private func loadImage() {
        viewModel.onCompleted = { [weak self] image in
            guard let weakSelf = self else { return }
            
            weakSelf.foodImageView.image = image
        }
    }
}
