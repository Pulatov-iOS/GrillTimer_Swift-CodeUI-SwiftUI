import UIKit
import SnapKit
import Combine

final class SettingsViewController: UIViewController {
    
    // MARK: - Public Properties
    var viewModel: SettingsViewModel!
    
    // MARK: - UI Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("App.Settings.NavigationItemTitle", comment: "")
        label.font = UIFont.manrope(ofSize: 24, style: .bold)
        label.textColor = UIColor(resource: .Color.Main.text)
        return label
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(resource: .Color.Main.backgroundItem)
        button.tintColor = UIColor(resource: .Color.Main.text)
        let symbolConfigurationAdd = UIImage.SymbolConfiguration(pointSize: 28)
        button.setPreferredSymbolConfiguration(symbolConfigurationAdd, forImageIn: .normal)
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let termsOfUseView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor(resource: .Color.Main.text).cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 25
        view.clipsToBounds = true
        return view
    }()
    
    private let privacyPolicyView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor(resource: .Color.Main.text).cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private let iconTermsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(resource: .Image.Settings.roundedTerms)
        return imageView
    }()
    
    private let iconPrivacyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(resource: .Image.Settings.roundedPrivacy)
        return imageView
    }()
    
    private let termsNextArrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = UIColor(resource: .Color.Main.text)
        imageView.image = UIImage(systemName: "chevron.forward")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let privacyNextArrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = UIColor(resource: .Color.Main.text)
        imageView.image = UIImage(systemName: "chevron.forward")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let termsLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("App.Settings.ItemTermsOfUse", comment: "")
        label.font = UIFont.manrope(ofSize: 15, style: .light)
        label.textColor = UIColor(resource: .Color.Main.text)
        label.textAlignment = .left
        return label
    }()
    
    private let privacyLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("App.Settings.ItemPrivacyPolicy", comment: "")
        label.font = UIFont.manrope(ofSize: 15, style: .light)
        label.textColor = UIColor(resource: .Color.Main.text)
        label.clipsToBounds = true
        return label
    }()
    
    private lazy var termsOfUseButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(resource: .Color.Main.background)
        button.addTarget(self, action: #selector(termsOfUseButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var privacyPolicyButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(resource: .Color.Main.background)
        button.addTarget(self, action: #selector(privacyPolicyButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - LyfeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        addSubviews()
        configureConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setCornerRadius()
    }
    
    // MARK: - Methods
    private func configureUI() {
        view.backgroundColor = UIColor(resource: .Color.Main.background)
    }
    
    private func addSubviews() {
        view.addSubviews([titleLabel, backButton, termsOfUseView, privacyPolicyView])
        termsOfUseView.addSubviews([termsOfUseButton])
        privacyPolicyView.addSubviews([privacyPolicyButton])
        termsOfUseButton.addSubviews([termsLabel, termsNextArrowImageView, iconTermsImageView])
        privacyPolicyButton.addSubviews([privacyLabel, privacyNextArrowImageView, iconPrivacyImageView])
    }
    
    private func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.centerX.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.leading.equalTo(view.snp.leadingMargin).offset(15)
            make.width.equalTo(55)
            make.height.equalTo(55)
        }
        
        termsOfUseView.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
        
        iconTermsImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(5)
            make.centerY.equalToSuperview()
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        termsNextArrowImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-11)
            make.centerY.equalToSuperview()
            make.width.equalTo(28)
            make.height.equalTo(28)
        }
        
        termsLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconTermsImageView.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
        }
        
        termsOfUseButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        privacyPolicyView.snp.makeConstraints { make in
            make.top.equalTo(termsOfUseView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
        
        iconPrivacyImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(5)
            make.centerY.equalToSuperview()
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        privacyNextArrowImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-11)
            make.centerY.equalToSuperview()
            make.width.equalTo(28)
            make.height.equalTo(28)
        }
        
        privacyLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconPrivacyImageView.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
        }
        
        privacyPolicyButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setCornerRadius() {
        termsOfUseView.layer.cornerRadius = termsOfUseView.bounds.height / 2
        privacyPolicyView.layer.cornerRadius = privacyPolicyView.bounds.height / 2
        backButton.layer.cornerRadius = backButton.bounds.height / 2
    }
    
    // MARK: - Actions
    @objc private func termsOfUseButtonTapped() {
        print("Terms of Use")
    }
    
    @objc private func privacyPolicyButtonTapped() {
        print("Privacy policy")
    }
    
    @objc private func backButtonTapped() {
        viewModel.backButtonTapped()
    }
}
