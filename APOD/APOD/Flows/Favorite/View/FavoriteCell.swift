//
//  FavoriteCell.swift
//  APOD
//
//  Created by Nata Kuznetsova on 29.11.2023.
//

import UIKit

final class FavoriteCell: UITableViewCell {
    private var picture: UIImageView = {
        let picture = UIImageView()
        return picture
    }()
    
    private var text1: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    private var text2: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    func setupTextLabel(apod: DataImage, picture: UIImage) {
        let title = apod.title
        let date = apod.date
        text1.text = "\(title ?? "Without Title")"
        text2.text = "\(date ?? "Without Date")"
        self.picture.image = picture
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(picture)
        contentView.addSubview(text1)
        contentView.addSubview(text2)
        setupConstraints()
    }
    
    private func setupConstraints() {
        picture.translatesAutoresizingMaskIntoConstraints = false
        text1.translatesAutoresizingMaskIntoConstraints = false
        text2.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            picture.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            picture.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            picture.heightAnchor.constraint(equalToConstant: 50),
            picture.widthAnchor.constraint(equalTo: picture.heightAnchor),
            picture.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            text1.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            text1.leadingAnchor.constraint(equalTo: picture.trailingAnchor, constant: 30),
            text1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10),
            
            text2.topAnchor.constraint(equalTo: text1.bottomAnchor, constant: 10),
            text2.leadingAnchor.constraint(equalTo: picture.trailingAnchor, constant: 30),
            text2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        text1.text = nil
    }
}
