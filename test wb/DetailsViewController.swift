//
//  SecondViewController.swift
//  test wb
//
//  Created by Diego Abramoff on 16.05.23.
//

import UIKit

class DetailsViewController: UIViewController {
    
    weak var delegate: LikeStatusProtocol?
    var indexPath: IndexPath?
    var flight: Flight?
    var like: Bool?

    private var flightView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
        $0.isUserInteractionEnabled = true
        return $0
    } (UIView())
    
    private var stackMain: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.distribution = .fillEqually
        $0.axis = .vertical
        $0.spacing = Size.indentInCell
        return $0
    } (UIStackView())
    
    private var stackCities: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.distribution = .fillEqually
        $0.axis = .horizontal
        $0.spacing = Size.indentInCell
        return $0
    } (UIStackView())
    
    private var stackStartDate: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.distribution = .fillEqually
        $0.axis = .horizontal
        $0.spacing = Size.indentInCell
        return $0
    } (UIStackView())
    
    private var stackEndDate: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.distribution = .fillEqually
        $0.axis = .horizontal
        $0.spacing = Size.indentInCell
        return $0
    } (UIStackView())
    
    private var startLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .right
        $0.textColor = .systemGray
        $0.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        $0.text = "Дата вылета"
        return $0
    } (UILabel())
    
    private var endLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .right
        $0.textColor = .systemGray
        $0.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        $0.text = "Дата возвращения"
        return $0
    } (UILabel())
    
    private var startCity: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .right
        $0.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return $0
    } (UILabel())
    
    private var endCity: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return $0
    } (UILabel())
    
    private var startDate: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .systemGray
        $0.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return $0
    } (UILabel())
    
    private var endDate: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .systemGray
        $0.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return $0
    } (UILabel())
    
    private var price: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
        $0.textColor = .systemBlue
        $0.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        return $0
    } (UILabel())
    
    private var likeButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("TAP TO LIKE ", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
        $0.tintColor = .lightGray
        $0.semanticContentAttribute = .forceRightToLeft
        $0.layer.cornerRadius = 8
        $0.layer.borderColor = UIColor.systemBlue.cgColor
        $0.layer.borderWidth = 2
        $0.addTarget(nil, action: #selector(tapLike), for: .touchUpInside)
        return $0
    }(UIButton())

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        title = "Информация о полете"
        let navigationBarButton = UIBarButtonItem(image: UIImage(named: "back"), style: .plain,
                                                  target: self, action: #selector(tapNavBar))
        navigationItem.leftBarButtonItem = navigationBarButton
        showItems()
        setupView()
    }

    @objc private func tapNavBar() {
        _ = navigationController?.popToRootViewController(animated: true)
        if let like = like, let indexPath = indexPath {
            delegate?.updateLikeStatus(with: like, at: indexPath)
        }
    }
    
    @objc private func tapLike() {
        rotateButton()
        if let like = like {
            if like {
                self.like? = false
                likeButton.setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
                likeButton.tintColor = .lightGray
            } else {
                self.like? = true
                likeButton.setImage(UIImage(systemName: "hand.thumbsup.fill"), for: .normal)
                likeButton.tintColor = .systemBlue
            }
        }
    }
    
    func showItems() {
        view.addSubview(flightView)
        [stackMain, price, likeButton].forEach { flightView.addSubview($0) }
        [stackCities, stackStartDate, stackEndDate].forEach { stackMain.addArrangedSubview($0) }
        [startCity, endCity].forEach { stackCities.addArrangedSubview($0) }
        [startLabel, startDate].forEach { stackStartDate.addArrangedSubview($0) }
        [endLabel, endDate].forEach { stackEndDate.addArrangedSubview($0) }
        
        NSLayoutConstraint.activate([
            flightView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Size.indentInCollection),
            flightView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            flightView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            flightView.heightAnchor.constraint(equalToConstant: Size.heightOfDetailTile),
            
            stackMain.topAnchor.constraint(equalTo: flightView.topAnchor, constant: Size.indentInCell),
            stackMain.centerXAnchor.constraint(equalTo: flightView.centerXAnchor),
            stackCities.centerXAnchor.constraint(equalTo: stackMain.centerXAnchor),

            startCity.heightAnchor.constraint(equalToConstant: 20),
            endCity.heightAnchor.constraint(equalToConstant: 20),
            startLabel.heightAnchor.constraint(equalToConstant: 20),
            endLabel.heightAnchor.constraint(equalToConstant: 20),
            startDate.heightAnchor.constraint(equalToConstant: 20),
            endDate.heightAnchor.constraint(equalToConstant: 20),
            
            likeButton.topAnchor.constraint(equalTo: endLabel.bottomAnchor, constant: Size.indentInCell * 3),
            likeButton.leadingAnchor.constraint(equalTo: flightView.centerXAnchor),
            likeButton.trailingAnchor.constraint(equalTo: flightView.trailingAnchor, constant: -Size.indentInCell),
            likeButton.heightAnchor.constraint(equalToConstant: Size.heightOfCell),
            
            price.topAnchor.constraint(equalTo: endLabel.bottomAnchor, constant: Size.indentInCell * 3),
            price.leadingAnchor.constraint(equalTo: flightView.leadingAnchor, constant: Size.indentInCell),
            price.trailingAnchor.constraint(equalTo: flightView.centerXAnchor, constant: -Size.indentInCell),
            price.heightAnchor.constraint(equalToConstant: Size.heightOfCell),
        ])
    }
    
    private func setupView() {
        if let like = like, let flight = flight {
            let shortDateFormatter = DateFormatter()
            let longDateFormatter = DateFormatter()
            shortDateFormatter.dateFormat = "dd MMM yyyy"
            longDateFormatter.dateFormat = "yyy-mm-dd HH:mm:ss Z zzz"
            if let date = longDateFormatter.date(from: flight.startDate) {
                startDate.text = shortDateFormatter.string(from: date)
            }
            if let date = longDateFormatter.date(from: flight.endDate) {
                endDate.text = shortDateFormatter.string(from: date)
            }
            
            startCity.text = flight.startCity
            endCity.text = flight.endCity
            price.text = String(flight.price) + "₽"
            
            if !like {
                likeButton.setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
            } else {
                likeButton.setImage(UIImage(systemName: "hand.thumbsup.fill"), for: .normal)
            }
        }
    }
    
    private func rotateButton() {
        var perspective = CATransform3DIdentity
        perspective.m34 = 1 / -200
        likeButton.imageView!.layer.transform = perspective
        let rotate = CABasicAnimation(keyPath: "transform.rotation.y")
        rotate.fromValue = 0
        rotate.byValue = CGFloat.pi * 2
        rotate.duration = 0.5
        likeButton.imageView!.layer.add(rotate, forKey: nil)
    }
}
