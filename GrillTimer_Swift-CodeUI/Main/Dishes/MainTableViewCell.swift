import UIKit
import SnapKit

protocol MainTableViewCellDelegate: AnyObject {
    func didSelectCell(_ cell: MainTableViewCell)
}

final class MainTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    // MARK: Public
    weak var delegate: MainTableViewCellDelegate?
    
    // MARK: Private
    private let containerView = UIView()
    private let mainImageView = UIImageView()
    private let nameLabel = UILabel()
    private let meatTypeLabel = UILabel()
    private let averageCookingTimesLabel = UILabel()
    private let favoriteButton = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        configureConstraints()
        configureUI()
        cellTappedHandler()
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
        containerView.backgroundColor = UIColor(resource: .mainCellBackground)
        containerView.layer.cornerRadius = 8
        containerView.layer.shadowColor = UIColor(resource: .mainCellShadow).cgColor // Вопрос
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
        nameLabel.text = dish.name
        meatTypeLabel.text = "Meat: \(dish.meatTypes.joined(separator: ", "))"
        averageCookingTimesLabel.text = "Avg. times: \(dish.averageCookingTimes) min"
    }
    
    private func cellTappedHandler() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        containerView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func cellTapped() {
        delegate?.didSelectCell(self)
    }
}
