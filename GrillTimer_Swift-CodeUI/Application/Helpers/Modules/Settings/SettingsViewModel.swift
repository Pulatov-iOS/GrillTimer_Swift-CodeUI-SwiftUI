final class SettingsViewModel {
    
    // MARK: - Public properties
    var dismissScreen: (() -> Void)?
    
    // MARK: - Methods
    func backButtonTapped() {
        dismissScreen?()
    }
}
