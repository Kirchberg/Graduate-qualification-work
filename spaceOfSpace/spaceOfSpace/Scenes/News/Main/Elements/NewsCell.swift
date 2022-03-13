//
//  NewsCell.swift
//  spaceOfSpace
//
//  Created by Kirill Kostarev on 30.03.2021.
//

import UIKit

class NewsCell: UITableViewCell {

    static var identifier: String = "NewsCell"
    
    var newsImage = UIImageView()
    var newsTitle = UILabel()
    var newsContent = UILabel()
    var newsSource = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            contentView.backgroundColor = UIColor(red: 0.114, green: 0.114, blue: 0.114, alpha: 0.94)
        } else {
            contentView.backgroundColor = .black
        }
    }
    
    private func setupCell() {
        contentView.backgroundColor = .black

        newsImage.clipsToBounds = true
        newsImage.layer.cornerRadius = 20.0
        newsImage.contentMode = .scaleAspectFill

        newsTitle.font = UIFont.systemFont(ofSize: 17)
        newsTitle.textColor = .white
        newsTitle.numberOfLines = 3

        newsContent.font = UIFont.systemFont(ofSize: 13)
        newsContent.textColor = UIColor(red: 0.557, green: 0.557, blue: 0.576, alpha: 1)
        newsContent.numberOfLines = 5

        newsSource.font = UIFont.systemFont(ofSize: 12)
        newsSource.textColor = UIColor(red: 0.388, green: 0.388, blue: 0.4, alpha: 1)
        newsSource.numberOfLines = 1
        
        setupAutoLayout()
    }
    
    private func setupAutoLayout() {
        
        newsImage = self.newsImage.useConstraints(addToView: contentView)
        newsTitle = self.newsTitle.useConstraints(addToView: contentView)
        newsContent = self.newsContent.useConstraints(addToView: contentView)
        newsSource = self.newsSource.useConstraints(addToView: contentView)
        
        NSLayoutConstraint.activate([
            newsImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            newsImage.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 15),
            newsImage.widthAnchor.constraint(equalToConstant: 85),
            newsImage.heightAnchor.constraint(equalToConstant: 105),
            newsImage.leadingAnchor.constraint(greaterThanOrEqualTo: newsContent.trailingAnchor, constant: 12),
            newsImage.leadingAnchor.constraint(greaterThanOrEqualTo: newsSource.trailingAnchor, constant: 12),
            newsImage.leadingAnchor.constraint(greaterThanOrEqualTo: newsTitle.trailingAnchor, constant: 12),
            newsImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            newsTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            newsTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12)
        ])

        NSLayoutConstraint.activate([
            newsContent.topAnchor.constraint(equalTo: newsTitle.bottomAnchor, constant: 6),
            newsContent.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12)
        ])

        NSLayoutConstraint.activate([
            newsSource.topAnchor.constraint(greaterThanOrEqualTo: newsContent.bottomAnchor, constant: 6),
            newsSource.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            newsSource.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5.5)
        ])
    }
}
