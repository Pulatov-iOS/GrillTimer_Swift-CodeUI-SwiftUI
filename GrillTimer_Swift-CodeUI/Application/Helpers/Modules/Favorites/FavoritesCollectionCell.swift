import UIKit
import Combine

final class FavoritesCollectionCell: UICollectionViewCell {
    
    // MARK: - Public Properties
    var deleteButtonSubject = PassthroughSubject<String, Never>()
    var cellTappedSubject = PassthroughSubject<String, Never>()
    static let reuseIdentifier = "FavoritesCollectionCell"
    
    // MARK: - Private Properties
    private var dishId: String?
    
    // MARK: - UI Properties
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(resource: .Color.Main.backgroundItem)
        view.layer.cornerRadius = 40
        view.layer.shadowColor = UIColor(resource: .Color.Main.shadow).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.20
        return view
    }()
    
    private let timerImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(resource: .Image.Timer.timer)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let nameFavoriteDishLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.manrope(ofSize: 15, style: .medium)
        return label
    }()
    
    private let dishTypeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.manrope(ofSize: 13, style: .medium)
        return label
    }()
    
    private let meatTypeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor(resource: .Color.Favorites.meatTypeText)
        label.font = UIFont.manrope(ofSize: 13, style: .medium)
        return label
    }()
    
    private let cookingTimeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.manrope(ofSize: 20, style: .medium)
        return label
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "trash")?.resized(to: CGSize(width: 40, height: 40)), for: .normal)
        button.tintColor = UIColor(resource: .Color.Main.button)
        return button
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        configureConstraints()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func addSubviews() {
        contentView.addSubviews([containerView, deleteButton])
        containerView.addSubviews([nameFavoriteDishLabel, timerImage, dishTypeLabel, meatTypeLabel, cookingTimeLabel])
    }
    
    private func configureConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(24)
            make.width.equalTo(345)
        }
        
        timerImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.width.equalTo(31)
            make.height.equalTo(31)
        }
        
        nameFavoriteDishLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.leading.equalToSuperview().offset(60)
            make.width.equalTo(180)
        }
        
        dishTypeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(60)
            make.bottom.equalToSuperview().inset(18)
        }
        
        meatTypeLabel.snp.makeConstraints { make in
            make.leading.equalTo(dishTypeLabel.snp.trailing).offset(8)
            make.centerY.equalTo(dishTypeLabel)
        }
        
        cookingTimeLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(24)
            make.centerY.equalToSuperview()
        }
        
        deleteButton.snp.makeConstraints { make in
            make.trailing.equalTo(containerView.snp.trailing).offset(66)
            make.centerY.equalToSuperview().offset(10)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
    }
    
    private func bind() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(leftSwipe(_:)))
        addGestureRecognizer(panGestureRecognizer)
        
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        containerView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func leftSwipe(_ gesture: UIPanGestureRecognizer) {
        guard let superview = superview else { return }
                
        switch gesture.state {
        case .changed:
            let translation = gesture.translation(in: superview)
            let newX = frame.origin.x + translation.x
            let limitedX = min(max(newX, -80), 0)
            frame.origin.x = limitedX
            gesture.setTranslation(.zero, in: superview)
            
        case .ended:
            if frame.origin.x > -40 {
                UIView.animate(withDuration: 0.3) {
                    self.frame.origin.x = 0
                }
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.frame.origin.x = -80
                }
            }
            
        default:
            break
        }
    }
    
    @objc private func deleteButtonTapped() {
        deleteButtonSubject.send(dishId ?? "")
    }
    
    @objc private func cellTapped() {
        cellTappedSubject.send(dishId ?? "")
    }
       
    func setInformation(_ dish: Dish) {
        if let name = dish.favoriteName {
            nameFavoriteDishLabel.text = name
            cookingTimeLabel.text = "\(dish.averageFavoriteCookingTime)" + " " + NSLocalizedString("App.Favorites.CollectionCell.UnitCookingTime", comment: "")
        }
        
        dishTypeLabel.text = dish.dishType
        meatTypeLabel.text = dish.meatType
        
        dishId = dish.id
    }
}
