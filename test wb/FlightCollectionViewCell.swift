//
//  FlightCollectionViewCell.swift
//  test wb
//
//  Created by Diego Abramoff on 16.05.23.
//

import UIKit

class FlightCollectionViewCell: UICollectionViewCell {

    private var flightView: UIView = { $0 } (UIView(backgroundColor: .white, cornerRadius: 8, isInteractive: true))
    
    private var startCity: UILabel = { $0 } (UILabel(textAligment: .center, textColor: .black, fontSize: 16,
                                                     fontWeight: .regular))
    private var endCity: UILabel = { $0 }   (UILabel(textAligment: .center, textColor: .black, fontSize: 16,
                                                     fontWeight: .regular))
    
    private var startDate: UILabel = { $0 } (UILabel(textAligment: .center, textColor: .systemGray, fontSize: 16,
                                                     fontWeight: .regular))
    private var endDate: UILabel = { $0 }   (UILabel(textAligment: .center, textColor: .systemGray, fontSize: 16,
                                                     fontWeight: .regular))
    
    private var price: UILabel = { $0 }     (UILabel(textAligment: .center, textColor: .systemBlue, fontSize: 18,
                                                     fontWeight: .bold))
    
    private var likeButton: UIImageView = {
                                            $0.translatesAutoresizingMaskIntoConstraints = false
                                            $0.image = UIImage(systemName: "hand.thumbsup")
                                            $0.tintColor = .lightGray
                                            return $0
                                            }(UIImageView())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        showItems()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showItems() {
        contentView.addSubview(flightView)
        [startCity, endCity,
         startDate, endDate,
         price, likeButton].forEach { flightView.addSubview($0) }
        
        NSLayoutConstraint.activate([
            flightView.topAnchor.constraint(equalTo: contentView.topAnchor),
            flightView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            flightView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            flightView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            likeButton.centerYAnchor.constraint(equalTo: flightView.centerYAnchor),
            likeButton.trailingAnchor.constraint(equalTo: flightView.trailingAnchor, constant: -Size.indentInCell),
            likeButton.heightAnchor.constraint(equalToConstant: Size.heightOfCell - Size.indentInCell * 4),
            likeButton.widthAnchor.constraint(equalToConstant: Size.heightOfCell - Size.indentInCell * 4),
            
            price.centerYAnchor.constraint(equalTo: flightView.centerYAnchor),
            price.trailingAnchor.constraint(equalTo: likeButton.leadingAnchor, constant: -Size.indentInCell),

            startDate.topAnchor.constraint(equalTo: flightView.topAnchor, constant: Size.indentInCell),
            startDate.leadingAnchor.constraint(equalTo: flightView.leadingAnchor, constant: Size.indentInCell),
            startDate.heightAnchor.constraint(equalToConstant: 20),

            endDate.topAnchor.constraint(equalTo: startDate.bottomAnchor, constant: Size.indentInCell),
            endDate.leadingAnchor.constraint(equalTo: flightView.leadingAnchor, constant: Size.indentInCell),
            endDate.heightAnchor.constraint(equalToConstant: 20),

            startCity.topAnchor.constraint(equalTo: flightView.topAnchor, constant: Size.indentInCell),
            startCity.leadingAnchor.constraint(equalTo: startDate.trailingAnchor, constant: Size.indentInCell),
            startCity.heightAnchor.constraint(equalToConstant: 20),

            endCity.topAnchor.constraint(equalTo: startDate.bottomAnchor, constant: Size.indentInCell),
            endCity.leadingAnchor.constraint(equalTo: startCity.leadingAnchor),
            endCity.heightAnchor.constraint(equalToConstant: 20),

        ])
    }
    
    func setupCell(with flight: Flight, like: Bool) {
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
        price.text = String(flight.price)
        
        if !like {
            likeButton.image = UIImage(systemName: "hand.thumbsup")
        } else {
            likeButton.image = UIImage(systemName: "hand.thumbsup.fill")
        }
    }
}
