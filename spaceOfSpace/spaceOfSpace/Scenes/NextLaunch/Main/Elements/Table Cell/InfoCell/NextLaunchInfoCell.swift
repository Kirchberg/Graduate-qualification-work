//
//  NextLaunchInfoCell.swift
//  spaceOfSpace
//
//  Created by Kirill Kostarev on 13.05.2021.
//

import UIKit

class NextLaunchInfoCell: UITableViewCell, CellProtocol {
    
    weak var parentViewController: UIViewController?
    static var identifier: String = "NextLaunchInfoCell"
    
    var rocketTitle = UILabel()
    
    var launchServiceProviderTitle = UILabel()
    
    var launchDate = UILabel()
    
    var launchDateWithTime = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateWith(vm: NextLaunchCellVMProtocol) {
        guard let vm = vm as? NextLaunchInfoCellVM else { return }
        rocketTitle.text = vm.rocketTitle
        launchServiceProviderTitle.text = vm.launchServiceProviderTitle
        launchDateWithTime.text = vm.launchDateWithTime
        backgroundColor = .clear
    }
    
    private func setupCell() {
        
        rocketTitle.font = UIFont.systemFont(ofSize: 34, weight: UIFont.Weight.bold)
        rocketTitle.textColor = .white
        rocketTitle.numberOfLines = 2
        
        launchServiceProviderTitle.font = UIFont.systemFont(ofSize: 15)
        launchServiceProviderTitle.textColor = .white
        launchServiceProviderTitle.numberOfLines = 2
        
        launchDate.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
        launchDate.text = "Launch Date"
        launchDate.textColor = .white
        launchDate.numberOfLines = 1
        
        launchDateWithTime.font = UIFont.systemFont(ofSize: 15)
        launchDateWithTime.textColor = .white
        launchDateWithTime.numberOfLines = 2
        
        setupView()
    }
    
    private func setupView() {
        
        selectionStyle = .none
        
        rocketTitle = rocketTitle.useConstraints(addToView: self)
        launchServiceProviderTitle = launchServiceProviderTitle.useConstraints(addToView: self)
        launchDate = launchDate.useConstraints(addToView: self)
        launchDateWithTime = launchDateWithTime.useConstraints(addToView: self)
        
        NSLayoutConstraint.activate([
            rocketTitle.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 11),
            rocketTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            rocketTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            launchServiceProviderTitle.topAnchor.constraint(equalTo: rocketTitle.bottomAnchor),
            launchServiceProviderTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            launchServiceProviderTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
        ])
        
        NSLayoutConstraint.activate([
            launchDate.topAnchor.constraint(equalTo: launchServiceProviderTitle.bottomAnchor, constant: 15),
            launchDate.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            launchDateWithTime.topAnchor.constraint(equalTo: launchDate.bottomAnchor),
            launchDateWithTime.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            launchDateWithTime.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            launchDateWithTime.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}
