import UIKit
import SnapKit
import Combine

final class DishesCollectionCell: UICollectionViewCell {
    
    // MARK: - Public Properties
    var cellTappedPublisher = PassthroughSubject<Void, Never>()
    static let reuseIdentifier = "DishesCollectionCell"
    
    // MARK:  - UI Properties
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(resource: .Color.Main.backgroundItem)
        view.layer.cornerRadius = 40
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.20
        return view
    }()
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 40
        image.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        image.layer.masksToBounds = true
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.manrope(ofSize: 18, style: .bold)
        return label
    }()
    
    private let avgTimesValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.manrope(ofSize: 18, style: .regular)
        return label
    }()
    
    private let avgTimesUnitLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("App.Dishes.Cell.UnitTimesLabel", comment: "")
        label.font = UIFont.manrope(ofSize: 14, style: .medium)
        label.textColor = .Color.Dishes.Cell.unitText
        return label
    }()
    
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
    
    // MARK: - Methods
    private func addSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubviews([imageView, nameLabel, avgTimesValueLabel, avgTimesUnitLabel])
    }
    
    private func configureConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 5))
        }
        
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().multipliedBy(0.75)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(25)
            make.bottom.equalToSuperview().inset(10)
        }
        
        avgTimesValueLabel.snp.makeConstraints { make in
            make.trailing.equalTo(avgTimesUnitLabel.snp.leading).inset(-3)
            make.bottom.equalToSuperview().inset(10)
        }
        
        avgTimesUnitLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(25)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    private func configureUI() {
  
    }
    
    func setInformation(_ dish: DishDTO, sortingType: SortingType) {
        let sortingTypeName: String
        if sortingType == .meat {
            sortingTypeName = SortingType.dish.rawValue + "." + dish.dishType.prefix(1).uppercased() + dish.dishType.dropFirst()
        } else {
            sortingTypeName = SortingType.meat.rawValue + "." + dish.meatType.prefix(1).uppercased() + dish.meatType.dropFirst()
        }
 
        let labelName = NSLocalizedString("App.Dishes.\(sortingTypeName)", comment: "")
        nameLabel.text = labelName
        avgTimesValueLabel.text = dish.averageCookingTimes
        
        let imageName = "Image/Menu/" + dish.dishType.prefix(1).uppercased() + dish.dishType.dropFirst() + "/\(dish.meatType)"
        imageView.image = UIImage(named: imageName)
    }
    
    private func bind() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        containerView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func cellTapped() {
        cellTappedPublisher.send()
    }
}
