import UIKit
import SnapKit
import Combine

final class DefaultMainViewController: UIViewController {

    // MARK: - Properties
    // MARK: Public
    var viewModel: MainViewModel!
    
    // MARK: Private
    private let grillTableView = UITableView()
    private var cancellables = Set<AnyCancellable>()
    
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
        view.addSubview(grillTableView)
    }
    
    private func configureConstraints() {
        grillTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configureUI() {
        view.backgroundColor = UIColor(resource: .Color.mainViewBackground)
        
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
extension DefaultMainViewController: UITableViewDelegate, UITableViewDataSource {
    
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
extension DefaultMainViewController: MainTableViewCellDelegate {
    
    func didSelectCell(_ cell: MainTableViewCell) {
        guard let indexPath = grillTableView.indexPath(for: cell) else { return }
        let dish = viewModel.dishesSubject.value[indexPath.row]
        viewModel.tableCellTapped(dish)
    }
}
