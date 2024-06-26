import UIKit

final class DishesHeaderView: UICollectionReusableView {
    
    // MARK: - UI Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Color.Main.text
        label.font = UIFont.manrope(ofSize: 22, style: .bold)
        return label
    }()
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        arrangeSubviews()
        setupViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func arrangeSubviews() {
        addSubview(titleLabel)
    }
    
    private func setupViewConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(0)
            make.leading.trailing.equalToSuperview().inset(10)
        }
    }
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
}

