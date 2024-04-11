//
//  FavoritesViewController.swift
//  GrillTimer_Swift-CodeUI
//
//  Created by Alexander on 11.04.24.
//

import UIKit
import SnapKit
import Combine

final class FavoritesViewController: UIViewController {
    
    // MARK: - Public Properties
    var viewModel: FavoritesViewModel!
    
    // MARK: - UI Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("App.Favorites.NavigationTitle", comment: "")
        label.font = UIFont.manrope(ofSize: 24, style: .bold)
        label.textColor = UIColor(resource: .Color.Main.text)
        return label
    }()
    
    private lazy var settingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor(resource: .Color.Main.text)
        button.setImage(UIImage(systemName: "gearshape"), for: .normal)
        let symbolConfigurationSetup = UIImage.SymbolConfiguration(pointSize: 28)
        button.setPreferredSymbolConfiguration(symbolConfigurationSetup, forImageIn: .normal)
//        button.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        button.backgroundColor = UIColor(resource: .Color.Main.backgroundItem)
        button.layer.cornerRadius = 27.5
        return button
    }()
    
    private let searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = NSLocalizedString("App.Favorites.SearchTextFieldPlaceholder", comment: "")
        textField.layer.cornerRadius = 22.5
        textField.layer.masksToBounds = true
        textField.backgroundColor = UIColor(resource: .Color.Main.backgroundItem)
//        textField.addTarget(self, action: #selector(searchTextFieldDidChange(_:)), for: .editingChanged)
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        return textField
    }()
    
    private let deleteSearchTextButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor(resource: .Color.Favorites.deleteSearchButton)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        let symbolConfigurationDelete = UIImage.SymbolConfiguration(pointSize: 18)
        button.setPreferredSymbolConfiguration(symbolConfigurationDelete, forImageIn: .normal)
//        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        button.backgroundColor = UIColor(resource: .Color.Main.backgroundItem)
        button.layer.cornerRadius = 17.5
        return button
    }()
    
    private let tabBar: TabBarItem
    private let backgroundTabBarView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(resource: .Color.Main.background)
        return view
    }()
    
    // MARK: - Init
    init(tabBar: TabBarItem) {
        self.tabBar = tabBar
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LyfeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
 
        configureUI()
        addSubviews()
        configureConstraints()
//        bind()
//        initialSnapshot()
    }
    
    // MARK: - Methods
    private func configureUI() {
        view.backgroundColor = UIColor(resource: .Color.Main.background)
    }
    
    private func addSubviews() {
        view.addSubviews([titleLabel, settingsButton, searchTextField, deleteSearchTextButton, backgroundTabBarView, tabBar])
    }
    
    private func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.centerX.equalToSuperview()
        }
        
        settingsButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(24)
            make.centerY.equalTo(titleLabel)
            make.width.equalTo(55)
            make.height.equalTo(55)
        }
        
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(33)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(45)
        }
        
        deleteSearchTextButton.snp.makeConstraints { make in
            make.centerY.equalTo(searchTextField)
            make.trailing.equalTo(searchTextField.snp.trailing).inset(6)
            make.width.equalTo(35)
            make.height.equalTo(35)
        }
        
        tabBar.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(30)
            make.width.equalToSuperview()
        }
        
        backgroundTabBarView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
    }
}
