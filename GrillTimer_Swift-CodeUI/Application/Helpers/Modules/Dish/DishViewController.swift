import UIKit
import SnapKit
import Combine

final class DishViewController: UIViewController {
    
    // MARK: - Public Properties
    var viewModel: DishViewModel!
    
    // MARK: - Private Properties
    private let nameLabel = UILabel()
    private let mainImageView = UIImageView()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - LyfeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        configureConstraints()
        configureUI()
        bindings()
    }
    
    // MARK: - Helpers
    private func addSubviews() {
        view.addSubviews([nameLabel, mainImageView])
    }
    
    private func configureConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
        }
        
        mainImageView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(15)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
    }
    
    private func configureUI() {
        view.backgroundColor = UIColor(resource: .Color.Dish.dishViewBackground)
        
        mainImageView.backgroundColor = .black
    }
    
    private func bindings() {
        viewModel.dishSubject.sink { dish in
            self.setInformation(dish)
        }
        .store(in: &cancellables)
    }

    func setInformation(_ dish: Dish) {
        nameLabel.text = dish.dishType
    }
}
