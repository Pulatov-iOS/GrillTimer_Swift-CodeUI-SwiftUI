import UIKit
import SnapKit
import Combine

enum DishType: CaseIterable {
    case skewers
    case steak
    case ribs
    case wings
    case thighs
    case sausages
    case kebab
}

enum MeatType: CaseIterable {
    case pork
    case beef
    case chicken
    case lamb
    case turkey
}

final class DishesViewController: UIViewController {

    // MARK: - Public Properties
    var viewModel: DishesViewModel!
    
    // MARK: Private Properties
    private var cancellables = Set<AnyCancellable>()
    private let sectionHeaderTitles: [AnyHashable: String] = [
        DishType.skewers: NSLocalizedString("App.Dishes.Dish.Skewers", comment: ""),
        DishType.steak: NSLocalizedString("App.Dishes.Dish.Steak", comment: ""),
        DishType.ribs: NSLocalizedString("App.Dishes.Dish.Ribs", comment: ""),
        DishType.wings: NSLocalizedString("App.Dishes.Dish.Wings", comment: ""),
        DishType.thighs: NSLocalizedString("App.Dishes.Dish.Thighs", comment: ""),
        DishType.sausages: NSLocalizedString("App.Dishes.Dish.Sausages", comment: ""),
        DishType.kebab: NSLocalizedString("App.Dishes.Dish.Kebab", comment: ""),
        
        MeatType.pork: NSLocalizedString("App.Dishes.Meat.Pork", comment: ""),
        MeatType.beef: NSLocalizedString("App.Dishes.Meat.Beef", comment: ""),
        MeatType.chicken: NSLocalizedString("App.Dishes.Meat.Chicken", comment: ""),
        MeatType.lamb: NSLocalizedString("App.Dishes.Meat.Lamb", comment: ""),
        MeatType.turkey: NSLocalizedString("App.Dishes.Meat.Turkey", comment: ""),
    ]
    
    // MARK: - UI Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("App.Dishes.NavigationTitle", comment: "")
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
        button.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        button.backgroundColor = UIColor(resource: .Color.Main.backgroundItem)
        button.layer.cornerRadius = 27.5
        return button
    }()
    
    private let segmentedControl: UISegmentedControl = {
        let segment = UISegmentedControl(items: [
            NSLocalizedString("App.Dishes.SegmentedControlItemDishes", comment: ""),
            NSLocalizedString("App.Dishes.SegmentedControlItemTypeOfMeat", comment: "")
        ])
        segment.selectedSegmentIndex = 0
        segment.backgroundColor = UIColor(resource: .Color.Main.backgroundItem)
        segment.selectedSegmentTintColor = UIColor(resource: .Color.Dishes.buttonSegmentedControl)
        segment.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.manrope(ofSize: 16, style: .medium), NSAttributedString.Key.foregroundColor: UIColor(resource: .Color.Main.text)], for: .normal)
        segment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        return segment
    }()
    
    private lazy var collectionView: UICollectionView = { [unowned self] in
        let layout = DishesCompositionalLayout()
        let collection = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.showsVerticalScrollIndicator = false
        collection.register(DishesCollectionCell.self, forCellWithReuseIdentifier: "DishesCollectionCell")
        collection.register(DishHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "DishHeaderView")
        return collection
    }()
    
    private lazy var dataSource: UICollectionViewDiffableDataSource<AnyHashable, DishDTO> = {
        let dataSource = UICollectionViewDiffableDataSource<AnyHashable, DishDTO>(collectionView: self.collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: DishDTO) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishesCollectionCell.reuseIdentifier, for: indexPath) as? DishesCollectionCell else { return nil }
            cell.setInformation(item, sortingType: self.viewModel.currentSortingSubject.value)
            cell.cellTappedPublisher
                .sink { [weak self] id in
                    self?.viewModel.tableCellTapped(id)
                }
                .store(in: &self.cancellables)
            return cell
        }
        
        dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "DishHeaderView", for: indexPath) as? DishHeaderView else { fatalError("") }
            let sectionIdentifier = dataSource.snapshot().sectionIdentifiers[indexPath.section]
            if let dishType = sectionIdentifier as? DishType {
                let sectionType = self.sectionHeaderTitles[dishType] ?? ""
                headerView.setTitle(sectionType)
            } else if let meatType = sectionIdentifier as? MeatType {
                let sectionType = self.sectionHeaderTitles[meatType] ?? ""
                headerView.setTitle(sectionType)
            }
            return headerView
        }
        
        return dataSource
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
        bind()
        initialSnapshot()
    }
    
    // MARK: - Methods
    private func configureUI() {
        view.backgroundColor = UIColor(resource: .Color.Main.background)
    }
    
    private func addSubviews() {
        view.addSubviews([titleLabel, settingsButton, segmentedControl, collectionView, backgroundTabBarView, tabBar])
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
        
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(22)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(38)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
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
    
    private func bind() {
        segmentedControl.addTarget(self, action: #selector(segmentedControlTypeSortingChanged(_:)), for: .valueChanged)
        
        viewModel.dishesSubject.sink { error in
            print(error)
        } receiveValue: { [weak self] _ in
            self?.initialSnapshot()
        }
        .store(in: &cancellables)

        viewModel.currentSortingSubject
            .sink { [weak self] type in
                self?.initialSnapshot()
            }
            .store(in: &cancellables)
    }
    
    private func initialSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<AnyHashable, DishDTO>()
    
        if viewModel.currentSortingSubject.value == .dish {
            snapshot.appendSections(DishType.allCases)
            
            for type in DishType.allCases {
                snapshot.appendItems(viewModel.dishesSubject.value.filter { $0.dishType == "\(type)"}, toSection: type)
            }
        } else {
            snapshot.appendSections(MeatType.allCases)
            
            for type in MeatType.allCases {
                snapshot.appendItems(viewModel.dishesSubject.value.filter { $0.meatType == "\(type)"}, toSection: type)
            }
        }
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    @objc func settingsButtonTapped() {

    }
    
    @objc func segmentedControlTypeSortingChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            viewModel.changedTypeSorting(.dish)
        case 1:
            viewModel.changedTypeSorting(.meat)
        default:
            break
        }
    }
}
