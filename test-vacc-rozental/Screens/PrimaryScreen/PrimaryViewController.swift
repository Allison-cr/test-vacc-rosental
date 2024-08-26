//
//  PrimaryScreen.swift
//  test-vacc-rozental
//
//  Created by Alexander Suprun on 22.08.2024.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher


final class PrimaryViewController: UIViewController {
    
    let viewModel: PrimaryViewModel
    private let disposeBag = DisposeBag()

    private lazy var imageView: UIImageView = setupImageView()
    private lazy var nameLabel: UILabel = setupNameLabel()
    private lazy var adressLabel: UILabel = setupAdressLabel()
    private lazy var todayLabel: UILabel = setupTodayLabel()
    private lazy var messageFromYK: UIButton = setupMessageFromYK()
    private lazy var primaryView: UIView = setupPrimaryView()
    private lazy var bellButton: UIButton = setupBellButton()
    private lazy var pokazaniya: UILabel = setupPokazaniya()
    private lazy var servicesButton: UIButton = setupServicesButton()
    private lazy var stackView: UIStackView = setupStackView()
    private lazy var bannerCollectionView: UICollectionView = setupBannerCollectionView()
    private lazy var serviceStackView: UIStackView = setupServiceStackView()
    private lazy var cameraButton: UIButton = setupCameraButton()
    private lazy var carrierButton: UIButton = setupCarrierButton()
    private lazy var suggetionButton: UIButton = setupSuggestionButton()
    private lazy var badgeLabel: UILabel = setupBadgeLabel()
    private lazy var adressButton: UIButton = setupAdressButton()
    
    private var banners: [Banner] = []
    
    init(viewModel: PrimaryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainView()
        view.backgroundColor = .primaryBackground
        bindViewModel()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.layer.cornerRadius = imageView.frame.width / 2
    }

    private func bindViewModel() {
        viewModel.addressText
            .observe(on: MainScheduler.instance)
            .bind(to: adressLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.nameText
            .observe(on: MainScheduler.instance)
            .bind(to: nameLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.dataArray
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] menuItems in
                   guard let self = self else { return }
                   self.uptadeStackView(with: menuItems)
               })
               .disposed(by: disposeBag)
        
        viewModel.dataBannerArray
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] data in
                   guard let self = self else { return }
                   self.updateBannerCollection(with: data)
               })
               .disposed(by: disposeBag)
        
        viewModel.imageURL
            .observe(on: MainScheduler.instance)
            .compactMap { $0 }
            .compactMap { URL(string: $0) }
            .subscribe(onNext: { [weak self] url in
                self?.imageView.kf.setImage(with: url)
            })
            .disposed(by: disposeBag)

        viewModel.dataText
               .map { [weak self] date in
                   return self?.getAttributedText(for: date)
               }
               .bind(to: todayLabel.rx.attributedText)
               .disposed(by: disposeBag)
        
        viewModel.countNotification
            .observe(on: MainScheduler.instance)
            .map{ String($0) }
            .bind(to: badgeLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.error
            .subscribe(onNext: { [weak self] error in
                self?.showError(error)
            })
            .disposed(by: disposeBag)
    }
       
    
    private func showError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

private extension PrimaryViewController {
    func setupMainView() {
        setupLayout()
    }
}

private extension PrimaryViewController {
    func setupAdressButton() -> UIButton {
        let button = UIButton()
        let configuration = UIImage.SymbolConfiguration(pointSize: 12, weight: .regular)
        let image = UIImage(systemName: "chevron.down", withConfiguration: configuration)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        return button
    }
    
    func setupImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        return imageView
    }
    
    func setupNameLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        return label
    }
    
    func setupAdressLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        return label
    }
    
    func setupTodayLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        primaryView.addSubview(label)
        return label
    }
    
    func setupBadgeLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        label.backgroundColor = .red
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        return label
    }
    
    func setupMessageFromYK() -> UIButton {
    let button = UIButton()
    let titleLabel = UILabel()
    titleLabel.text = "2 сообщения от УК"
    titleLabel.textColor = .black
    titleLabel.font = UIFont.systemFont(ofSize: 18)
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    let redDotLabel = UILabel()
    redDotLabel.text = "•"
    redDotLabel.textColor = .red
    redDotLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    redDotLabel.translatesAutoresizingMaskIntoConstraints = false
    let stackView = UIStackView(arrangedSubviews: [titleLabel, UIView(), redDotLabel])
    stackView.axis = .horizontal
    stackView.alignment = .center
    stackView.spacing = 8
    stackView.translatesAutoresizingMaskIntoConstraints = false
    button.addSubview(stackView)
    NSLayoutConstraint.activate([
        stackView.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 16),
        stackView.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -16),
        stackView.topAnchor.constraint(equalTo: button.topAnchor, constant: 8),
        stackView.bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: -8)
    ])
    button.backgroundColor = .white
    button.layer.cornerRadius = 8
    button.layer.shadowColor = UIColor.gray.cgColor
    button.layer.shadowOpacity = 0.5
    button.layer.shadowOffset = CGSize(width: 0, height: 1)
    button.layer.shadowRadius = 1
    button.translatesAutoresizingMaskIntoConstraints = false
    primaryView.addSubview(button)
    return button
}

    func setupStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        primaryView.addSubview(stackView)
        return stackView
    }
    
    func setupPrimaryView() -> UIView {
        let primaryView = UIView()
        primaryView.backgroundColor = .white
        primaryView.layer.cornerRadius = 24
        primaryView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(primaryView)
        return primaryView
    }
    
    func setupBellButton() -> UIButton {
        let button = UIButton()
        let configuration = UIImage.SymbolConfiguration(pointSize: 48, weight: .regular)
        let image = UIImage(systemName: "bell", withConfiguration: configuration)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        return button
    }
    
    func setupPokazaniya() -> UILabel {
        let label = UILabel()
        label.text = "Показания счетчиков"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        primaryView.addSubview(label)
        return label
    }
    
    func setupServicesButton() -> UIButton {
        let button = UIButton()
        button.setTitle("Все сервисы", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 8
        button.backgroundColor = .welcomeButton
        button.translatesAutoresizingMaskIntoConstraints = false
        primaryView.addSubview(button)
        return button
    }
    
    func setupBannerCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.itemSize = CGSize(
            width: UIScreen.main.bounds.width - 64,
            height: 76
        )
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(BannerCell.self, forCellWithReuseIdentifier: BannerCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        primaryView.addSubview(collectionView)
        return collectionView
    }
    
    func setupServiceStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8

        stackView.addArrangedSubview(cameraButton)
        stackView.addArrangedSubview(carrierButton)
        stackView.addArrangedSubview(suggetionButton)

        primaryView.addSubview(stackView)
        return stackView
    }

    func setupCameraButton() -> UIButton {
        let button = UIButton()

        var configuration = UIButton.Configuration.plain()
        configuration.image = ServiceEnum.serviceImge(.camera)()
        configuration.imagePlacement = .top
        configuration.imagePadding = 8
        configuration.title = ServiceEnum.serviceTitle(.camera)()
        configuration.baseForegroundColor = .black
        configuration.cornerStyle = .medium
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: 12)
            return outgoing
        }
        button.layer.cornerRadius = 8
        button.configuration = configuration
        button.backgroundColor = .grayback
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }
    
    func setupCarrierButton() -> UIButton {
        let button = UIButton()

        var configuration = UIButton.Configuration.plain()
        configuration.image = ServiceEnum.serviceImge(.carrier)()
        configuration.imagePlacement = .top
        configuration.imagePadding = 8
        configuration.title = ServiceEnum.serviceTitle(.carrier)()
        configuration.baseForegroundColor = .black
        configuration.cornerStyle = .medium
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: 12)
            return outgoing
        }
        button.layer.cornerRadius = 8
        button.configuration = configuration
        button.backgroundColor = .grayback
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }
    
    func setupSuggestionButton() -> UIButton {
        let button = UIButton()

        var configuration = UIButton.Configuration.plain()
        configuration.image = ServiceEnum.serviceImge(.suggestions)()
        configuration.imagePlacement = .top
        configuration.imagePadding = 8
        configuration.title = ServiceEnum.serviceTitle(.suggestions)()
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: 12)
            return outgoing
        }
        configuration.baseForegroundColor = .black
        configuration.cornerStyle = .medium

        button.layer.cornerRadius = 8
        button.configuration = configuration
        button.backgroundColor = .grayback
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }
}

private extension PrimaryViewController {
    func updateBannerCollection(with banners: [Banner]) {
            self.banners = banners
            bannerCollectionView.reloadData()
        }
    
    func getAttributedText(for dateText: String) -> NSAttributedString {
        let todayText = "Сегодня"
        let attributedText = NSMutableAttributedString(string: todayText, attributes: [
            .font: UIFont.systemFont(ofSize: 24, weight: .bold),
            .foregroundColor: UIColor.black
        ])
        
        let dateAttributedText = NSAttributedString(string: " \(dateText)", attributes: [
            .font: UIFont.systemFont(ofSize: 24, weight: .bold),
            .foregroundColor: UIColor.gray
        ])
        
        attributedText.append(dateAttributedText)
        return attributedText
    }
    
    func uptadeStackView(with menuItems: [MenuItem]) {
        guard !menuItems.isEmpty else {
            print("No menu items to display.")
            return
        }
        
        guard let firstItem = menuItems.first else {
            print("First menu item is nil.")
            return
        }
        
        let customView = CustomView(
            leftImage: UIImage(resource: .fristImageView),
            title: firstItem.name ,
            subtitle: firstItem.description ,
            textRightLabel: firstItem.arrear ?? "0.00"
        )
        
        customView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(customView)
        
        guard let lastItem = menuItems.last else {
            print("last menu item is nil.")
            return
        }
        let secondCustomView = CustomView(
            leftImage: UIImage(resource: .secondImageView),
            title: lastItem.name ,
            subtitle: lastItem.description ,
            textRightLabel: lastItem.arrear ?? ""
        )
        secondCustomView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(secondCustomView)

    }

}

extension PrimaryViewController {
    func setupLayout() {
        NSLayoutConstraint.activate([
            
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 48),
            imageView.widthAnchor.constraint(equalToConstant: 48),
            
            nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 24),
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            bellButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            bellButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bellButton.heightAnchor.constraint(equalToConstant: 36),
            bellButton.widthAnchor.constraint(equalToConstant: 36),
            
            badgeLabel.topAnchor.constraint(equalTo: bellButton.topAnchor, constant: -5),
            badgeLabel.trailingAnchor.constraint(equalTo: bellButton.trailingAnchor, constant: 5),
            badgeLabel.widthAnchor.constraint(equalToConstant: 20),
            badgeLabel.heightAnchor.constraint(equalToConstant: 20),
            
            
            
            adressLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 24),
            adressLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            
            adressButton.leadingAnchor.constraint(equalTo: adressLabel.trailingAnchor, constant: 8),
            adressButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),

            primaryView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            primaryView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            primaryView.topAnchor.constraint(equalTo: adressLabel.bottomAnchor, constant: 32),
            primaryView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            todayLabel.leadingAnchor.constraint(equalTo: primaryView.leadingAnchor, constant: 16),
            todayLabel.topAnchor.constraint(equalTo: primaryView.topAnchor, constant: 32),
            
            messageFromYK.leadingAnchor.constraint(equalTo: primaryView.leadingAnchor, constant: 16),
            messageFromYK.trailingAnchor.constraint(equalTo: primaryView.trailingAnchor, constant: -16),
            messageFromYK.topAnchor.constraint(equalTo: todayLabel.bottomAnchor, constant: 16),
            messageFromYK.heightAnchor.constraint(equalToConstant: 50),
            
            stackView.topAnchor.constraint(equalTo: messageFromYK.bottomAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: primaryView.leadingAnchor, constant: 16),
            
            bannerCollectionView.leadingAnchor.constraint(equalTo: primaryView.leadingAnchor, constant: 16),
            bannerCollectionView.trailingAnchor.constraint(equalTo: primaryView.trailingAnchor, constant: -16),
            bannerCollectionView.topAnchor.constraint(equalTo: stackView.bottomAnchor),
            bannerCollectionView.heightAnchor.constraint(equalToConstant: 120),
            
            serviceStackView.leadingAnchor.constraint(equalTo: primaryView.leadingAnchor, constant: 16),
            serviceStackView.trailingAnchor.constraint(equalTo: primaryView.trailingAnchor, constant: -16),
            serviceStackView.topAnchor.constraint(equalTo: bannerCollectionView.bottomAnchor),
            
            servicesButton.leadingAnchor.constraint(equalTo: primaryView.leadingAnchor, constant: 16),
            servicesButton.trailingAnchor.constraint(equalTo: primaryView.trailingAnchor, constant: -16),
            servicesButton.topAnchor.constraint(equalTo: serviceStackView.bottomAnchor, constant: 16),
            servicesButton.heightAnchor.constraint(equalToConstant: 64),
        ])
    }
}


// MARK: - setup UICollection banners
extension PrimaryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return banners.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCell.reuseIdentifier, for: indexPath) as! BannerCell
        let banner = banners[indexPath.item]
        cell.configure(with: banner)
        return cell
    }
}

