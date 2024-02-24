import UIKit
import RxSwift
import SnapKit

protocol MainView: AnyObject {
    
}

final class DefaultMainView: UIViewController {

    // MARK: - Properties
    // MARK: Public
    var viewModel: MainViewModel!
    
    // MARK: Private
    private let disposeBag = DisposeBag()
    private var dishes: [Dish]?
    
    private let grillTableView = UITableView()
    
    // MARK: - LyfeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        configureConstraints()
        configureUI()
        setupTableView()
        configureBindings()
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
    
    private func configureBindings() {
        viewModel.fetchDishes()
        viewModel.dishes
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] dishes in
                self?.dishes = dishes
                self?.grillTableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - MainView
extension DefaultMainView: MainView {
    
}

// MARK: - TableViewDelegate/DataSource
extension DefaultMainView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dishes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! MainTableViewCell
        cell.delegate = self
        if let dish = dishes?[indexPath.row] {
            cell.setInformation(dish)
        }
        return cell
    }
}

// MARK: - MainTableViewCellDelegate
extension DefaultMainView: MainTableViewCellDelegate {
    
    func didSelectCell(_ cell: MainTableViewCell) {
         
    }
}
