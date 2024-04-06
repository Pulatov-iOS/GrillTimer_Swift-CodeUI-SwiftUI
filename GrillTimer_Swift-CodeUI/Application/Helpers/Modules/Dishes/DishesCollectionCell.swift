//
//  DishesCollectionCell.swift
//  GrillTimer_Swift-CodeUI
//
//  Created by Alexander on 6.04.24.
//

import UIKit
import SnapKit
import Combine

final class DishesCollectionCell: UICollectionViewCell {
    
    // MARK: - Public Properties
    var cellTappedPublisher = PassthroughSubject<Void, Never>()
    static let reuseIdentifier = "DishesCollectionCell"
    
    // MARK: Private Properties
    private let containerView = UIView()
    private let mainImageView = UIImageView()
    private let nameLabel = UILabel()
    private let meatTypeLabel = UILabel()
    private let averageCookingTimesLabel = UILabel()
    private let favoriteButton = UIImageView()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        configureConstraints()
        configureUI()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubviews([mainImageView, nameLabel, meatTypeLabel, averageCookingTimesLabel, favoriteButton])
    }
    
    private func configureConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 15, left: 15, bottom: 0, right: 15))
        }
        
        mainImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
            make.leading.equalToSuperview().offset(15)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalTo(mainImageView.snp.trailing).offset(15)
        }
        
        meatTypeLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(30)
            make.leading.equalTo(mainImageView.snp.trailing).offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        averageCookingTimesLabel.snp.makeConstraints { make in
            make.leading.equalTo(mainImageView.snp.trailing).offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        favoriteButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.trailing.equalTo(containerView.snp.trailing).offset(-15)
            make.width.equalTo(30)
            make.height.equalTo(33)
        }
    }
    
    private func configureUI() {
        containerView.backgroundColor = UIColor(resource: .Color.Dish.Cell.mainCellBackground)
        containerView.layer.cornerRadius = 8
        containerView.layer.shadowColor = UIColor(resource: .Color.Dish.Cell.mainCellShadow).cgColor // Вопрос
        containerView.layer.shadowOpacity = 0.5
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 4
        
        mainImageView.backgroundColor = .black
        
        nameLabel.font = .systemFont(ofSize: 20, weight: .bold)
        
        if let image = UIImage(systemName: "bookmark")?.withRenderingMode(.alwaysTemplate) {
            favoriteButton.image = image
        }
        favoriteButton.tintColor = .black
    }
    
    func setInformation(_ dish: Dish) {
        nameLabel.text = dish.dishType
        meatTypeLabel.text = "Meat:"
        averageCookingTimesLabel.text = "Avg. times: \(dish.averageCookingTimes) min"
    }
    
    private func bind() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        containerView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func cellTapped() {
        cellTappedPublisher.send()
    }
}
