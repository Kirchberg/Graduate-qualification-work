//
//  TitleItem.swift
//  spaceOfSpace
//
//  Created by Aleksandr Dergachev on 19.05.2021.
//

import UIKit

class TitleItem: UITableViewCell {
    static var identifier: String = "TitleItem"
    
    var leadingConstraint:NSLayoutConstraint?
    
    var articleTitle = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupItem()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupItem() {
        articleTitle.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        articleTitle.numberOfLines = 0
        setupAutoLayout()
    }
    
    func setupAutoLayout() {
        articleTitle.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(articleTitle)
        
        leadingConstraint=articleTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        
        NSLayoutConstraint.activate([
            leadingConstraint!,
            articleTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            articleTitle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            articleTitle.heightAnchor.constraint(lessThanOrEqualTo: contentView.heightAnchor)
        ])
    }
    
    func setupLevel(level:Int){
        leadingConstraint?.constant=CGFloat(level*12)
    }
}
