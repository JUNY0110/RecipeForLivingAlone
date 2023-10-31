//
//  StretchyHeaderView.swift
//  PleaseRecipe
//
//  Created by 지준용 on 10/25/23.
//

import UIKit

import SnapKit

protocol StretchyHeaderViewDelegate: AnyObject {
    func tappedYoutubeLink()
}

final class StretchyHeaderView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: StretchyHeaderViewDelegate?
    var viewModel: FoodListCellViewModel!
    var imageURL: String? {
        didSet {
            viewModel.imageURL = imageURL
            loadImage()
        }
    }
    
    // MARK: - Views
    
    private let containerView = UIView()
    
    private let foodImageView: UIImageView = {
        $0.backgroundColor = .systemGray6
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView())
    
    let foodNameLabel: UILabel = {
        $0.text = ""
        $0.font = .h2
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    let foodDescriptionLabel: UILabel = {
        $0.text = ""
        $0.font = .b2
        $0.textAlignment = .left
        $0.textColor = .secondaryLabel
        $0.numberOfLines = 3
        return $0
    }(UILabel())
    
    private let hStackView: UIStackView = {
        $0.axis = .horizontal
        $0.distribution = .equalCentering
        return $0
    }(UIStackView())
    
    private let numberOfServingLabel: UILabel = {
        $0.text = ""
        $0.font = .b2
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    private let timeLabel: UILabel = {
        $0.text = ""
        $0.font = .b2
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    private lazy var youtubeLinkLabel: UILabel = {
        $0.text = ""
        $0.font = .b2
        $0.textAlignment = .right
        $0.textColor = .red
        $0.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedYoutubeLink))
        $0.addGestureRecognizer(tapGesture)
        return $0
    }(UILabel())
    
    private let divisionLine: UIView = {
        $0.backgroundColor = .lightGray
        return $0
    }(UIView())

    // MARK: - Init
    
    @available(*, unavailable)
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    private func layout() {
        addSubview(containerView)
        containerView.addSubview(foodImageView)

        addSubview(foodNameLabel)
        foodNameLabel.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        addSubview(foodDescriptionLabel)
        foodDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(foodNameLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        addSubview(hStackView)
        hStackView.snp.makeConstraints {
            $0.top.equalTo(foodDescriptionLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        hStackView.addArrangedSubview(numberOfServingLabel)
        hStackView.addArrangedSubview(timeLabel)
        hStackView.addArrangedSubview(youtubeLinkLabel)
        
        addSubview(divisionLine)
        divisionLine.snp.makeConstraints {
            $0.top.equalTo(hStackView.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(8)
            $0.height.equalTo(0.5)
        }
    }
    
    // MARK: - Configure
    
    func configureStretchyHeader(_ foodImageURL: String,
                                 _ foodName: String,
                                 _ foodDescription: String,
                                 _ numberOfServing: String,
                                 _ time: String,
                                 _ youtubeURL: String) {
        self.imageURL = foodImageURL
        self.foodNameLabel.text = foodName
        self.foodDescriptionLabel.text = foodDescription
        
        configureLabelText(numberOfServingLabel, UIImage(systemName: "person")!, "\(numberOfServing)")
        configureLabelText(timeLabel, UIImage(systemName: "clock.arrow.circlepath")!, "\(time)")
        
        let youtubeImage = youtubeURL.isEmpty ? "youtubeNone" : "youtube"
        let textColor = youtubeURL.isEmpty ? UIColor.systemGray2 : UIColor.black
        configureLabelText(youtubeLinkLabel, UIImage(named: youtubeImage)!, "유튜브", textColor)
    }
    
    private func configureLabelText(_ label: UILabel, _ image: UIImage, _ text: String, _ textColor: UIColor? = nil ) {
        let attributedString = NSMutableAttributedString(string: "")
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = image
        attributedString.append(NSAttributedString(attachment: imageAttachment))
        attributedString.append(NSAttributedString(string: " "))
        attributedString.append(NSAttributedString(string: text))
        label.attributedText = attributedString
        label.textColor = textColor
    }
    
    // MARK: - Methods
    
    func scrollViewDidScroll(scrollView: UIScrollView, headerImageHeight: CGFloat) {
        let offsetY = -(scrollView.contentOffset.y)
        containerView.clipsToBounds = offsetY <= 0
        
        containerView.snp.makeConstraints {
            $0.top.horizontalEdges.width.equalToSuperview()
            $0.height.equalTo(headerImageHeight)
        }
        
        foodImageView.snp.remakeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().offset(offsetY >= 0 ? 0 : -offsetY / 2)
            $0.height.equalToSuperview().offset(max(offsetY, 0))
        }
    }
    
    private func loadImage() {
        viewModel.onCompleted = { image in
            self.foodImageView.image = image
        }
    }
    
    @objc func tappedYoutubeLink() {
        delegate?.tappedYoutubeLink()
    }
}
