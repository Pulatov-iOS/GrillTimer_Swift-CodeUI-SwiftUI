import UIKit
import SnapKit
import Combine

enum DishType {
    case steak
    case dd
}

final class DishesViewController: UIViewController {

    // MARK: - Public Properties
    var viewModel: DishesViewModel!
    
    // MARK: Private Properties
    private var cancellables = Set<AnyCancellable>()
    private let sectionHeaderTitles: [DishType: String] = [
        .steak: "1",
        .dd: "2"
    ]
    
    // MARK: - UI Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("App.Dishes.NavigationTitle", comment: "")
        label.font = UIFont.manrope(ofSize: 24, style: .bold)
        label.textColor = UIColor(resource: .Color.Main.text)
        return label
    }()
    
    private let segmentedControl: UISegmentedControl = {
        let segment = UISegmentedControl(items: [
            NSLocalizedString("App.Dishes.SegmentedControlItemDishes", comment: ""),
            NSLocalizedString("App.Dishes.SegmentedControlItemTypeOfMeat", comment: "")
        ])
        segment.selectedSegmentIndex = 0
        segment.backgroundColor = UIColor(resource: .Color.Main.backgroundItem)
        segment.selectedSegmentTintColor = UIColor(resource: .Color.Dish.buttonSegmentedControl)
        segment.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.manrope(ofSize: 14, style: .regular), NSAttributedString.Key.foregroundColor: UIColor(resource: .Color.Main.text)], for: .normal)
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
    
    private lazy var dataSource: UICollectionViewDiffableDataSource<DishType, Dish> = {
        let dataSource = UICollectionViewDiffableDataSource<DishType, Dish>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: Dish) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishesCollectionCell.reuseIdentifier, for: indexPath) as? DishesCollectionCell else { return nil }
            cell.setInformation(item)
            return cell
        }
        
        dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "DishHeaderView", for: indexPath) as? DishHeaderView else { fatalError("") }
            let sectionIdentifier = dataSource.snapshot().sectionIdentifiers[indexPath.section]
            let sectionType = self.sectionHeaderTitles[sectionIdentifier] ?? ""
            headerView.setTitle(sectionType)
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
 
        addSubviews()
        configureConstraints()
        configureUI()
        bind()
        initialSnapshot()
    }
    
    // MARK: - Helpers
    private func addSubviews() {
        view.addSubviews([titleLabel ,segmentedControl, collectionView, backgroundTabBarView, tabBar])
        
    }
    
    private func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.centerX.equalToSuperview()
        }
        
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(22)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(35)
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
    
    private func configureUI() {
        view.backgroundColor = UIColor(resource: .Color.Main.background)
    }
    
    private func bind() {
        viewModel.dishesSubject.sink { error in
            print(error)
        } receiveValue: { [weak self] _ in
            self?.initialSnapshot()
        }
        .store(in: &cancellables)

    }
    
    func initialSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<DishType, Dish>()
        snapshot.appendSections([.steak, .dd])
        snapshot.appendItems(viewModel.dishesSubject.value, toSection: .steak)
        snapshot.appendItems(viewModel.dishesSubject.value, toSection: .dd)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

//let dish = viewModel.dishesSubject.value[indexPath.row]
//viewModel.tableCellTapped(dish)
