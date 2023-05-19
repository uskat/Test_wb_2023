//
//  ViewController.swift
//  test wb
//
//  Created by Diego Abramoff on 16.05.23.
//

import UIKit

protocol LikeStatusProtocol: AnyObject {
    func updateLikeStatus(with likeStatus: Bool, at indexPath: IndexPath)
}

protocol ReloadDataProtocol: AnyObject {
    func reload()
}

class FlightsViewController: UIViewController {
    
    let networkManager: NetworkManager
    var flights: [Flight] = [] 
    var likes: [Bool] = []
    
    private lazy var collectionView: UICollectionView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
        $0.dataSource = self
        $0.delegate = self
        $0.register(FlightCollectionViewCell.self, forCellWithReuseIdentifier: FlightCollectionViewCell.identifier)
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()))

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Пора в путешествие"
        view.backgroundColor = .systemGray6
        firstLoad()
        showItems()
    }
    
    func firstLoad() {
        let address = networkManager.urlComponents()
        
        self.networkManager.fetchData(fromAddress: address) { data in
            switch data {
            case .success(let flights): self.flights = flights
            case .failure(let error): print(error.localizedDescription)
            }
            self.likes = Array(repeating: false, count: self.flights.count)
            self.collectionView.reloadData()
        }
    }
    
    private func showItems() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
    }
}

extension FlightsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        flights.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FlightCollectionViewCell.identifier, for: indexPath) as! FlightCollectionViewCell
        cell.setupCell(with: flights[indexPath.row], like: likes[indexPath.row])
        return cell
    }
}

extension FlightsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            //задаем ширину ячейки: ширина экрана минус 2 отступа с каждой стороны
        return CGSize(width: Size.widthOfScreen - 2 * Size.indentInCollection, height: Size.heightOfCell)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        Size.indentInCollection   ///расстояние между ячейками в коллекции
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detail = DetailsViewController()
        detail.indexPath = indexPath
        detail.flight = flights[indexPath.row]
        detail.like = likes[indexPath.row]
        detail.delegate = self
        navigationController?.pushViewController(detail, animated: true)
    }
}

extension FlightsViewController: LikeStatusProtocol {
    func updateLikeStatus(with likeStatus: Bool, at indexPath: IndexPath) {
        self.collectionView.performBatchUpdates {
            likes[indexPath.row] = likeStatus
            let cell = self.collectionView.cellForItem(at: indexPath) as? FlightCollectionViewCell
            cell?.setupCell(with: flights[indexPath.row], like: likes[indexPath.row])
        }
    }
}
