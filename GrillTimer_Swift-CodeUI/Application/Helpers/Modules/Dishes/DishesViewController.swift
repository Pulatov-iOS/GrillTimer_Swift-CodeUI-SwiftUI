import UIKit
import SnapKit
import Combine

final class DishesViewController: UIViewController {

    // MARK: - Public Properties
    var viewModel: DishesViewModel!
    
    // MARK: Private Properties
    private let grillTableView = UITableView()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - UI Properties
    private let tabBar: TabBarItem
    
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
        setupTableView()
        bindings()
    }
    
    // MARK: - Helpers
    private func addSubviews() {
        view.addSubviews([grillTableView, tabBar])
    }
    
    private func configureConstraints() {
        grillTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tabBar.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(30)
            make.width.equalToSuperview()
        }
    }
    
    private func configureUI() {
        view.backgroundColor = UIColor(resource: .Color.Dish.dishViewBackground)
        
        let titleLabel = UILabel()
        titleLabel.text = "Dishes"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        self.navigationItem.titleView = titleLabel
    }
    
    private func setupTableView() {
        grillTableView.delegate = self
        grillTableView.dataSource = self
        grillTableView.separatorStyle = .none
        grillTableView.allowsSelection = false
        grillTableView.showsVerticalScrollIndicator = false
        grillTableView.backgroundColor = .clear
        grillTableView.register(MainTableViewCell.self, forCellReuseIdentifier: "CustomCell")
    }
    
    private func bindings() {
        viewModel.dishesSubject.sink { error in
            print(error)
        } receiveValue: { [weak self] _ in
            self?.grillTableView.reloadData()
        }
        .store(in: &cancellables)
    }
}

// MARK: - TableViewDelegate/DataSource
extension DishesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dishesSubject.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! MainTableViewCell
        cell.delegate = self
        let dish = viewModel.dishesSubject.value[indexPath.row]
        cell.setInformation(dish)
        return cell
    }
}

// MARK: - MainTableViewCellDelegate
extension DishesViewController: MainTableViewCellDelegate {
    
    func didSelectCell(_ cell: MainTableViewCell) {
        guard let indexPath = grillTableView.indexPath(for: cell) else { return }
        let dish = viewModel.dishesSubject.value[indexPath.row]
        viewModel.tableCellTapped(dish)
    }
}
