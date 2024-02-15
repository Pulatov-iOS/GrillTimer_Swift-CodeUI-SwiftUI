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
        addSubview(containerView)
        containerView.addSubview(mainImageView)
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
    }
    
    private func configureUI() {
        containerView.backgroundColor = .red
        containerView.layer.cornerRadius = 8
        mainImageView.backgroundColor = .black
    }
    
    func setInformation() {
       
    }
    
    private func cellTappedHandler() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        containerView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func cellTapped() {
         delegate?.didSelectCell(self)
    }
}
