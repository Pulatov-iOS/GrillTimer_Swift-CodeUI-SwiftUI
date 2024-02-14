import UIKit
import SnapKit

protocol MainView: AnyObject {
    
}

final class DefaultMainView: UIViewController {

    // MARK: - Properties
    // MARK: Public
    var viewModel: MainViewModel!
    
    // MARK: Private
    private let grillTableView = UITableView()
    
    // MARK: - LyfeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        configureConstraints()
        configureUI()
        setupTableView()
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
//        grillTableView.register(.self, forCellReuseIdentifier: "CustomCell")
    }
}

// MARK: - MainView
extension DefaultMainView: MainView {
    
}

// MARK: - TableViewDelegate/DataSource
extension DefaultMainView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cellId")
        cell.textLabel?.text = "1"
        return cell
    }
    
}
