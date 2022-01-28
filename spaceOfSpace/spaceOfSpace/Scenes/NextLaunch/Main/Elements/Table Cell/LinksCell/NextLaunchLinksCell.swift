import UIKit
import Kingfisher

class NextLaunchLinksCell: UITableViewCell, CellProtocol {
    
    weak var parentViewController: UIViewController?
    static var identifier: String = "NextLaunchLinksCell"
    
    var cellView = UIView()
    
    var sourceImage = UIImageView()
    
    var sourceDescription = UILabel()
    
    var sourceTitle = UILabel()
    
    var sourceLink = URL(string: "https://www.google.com")
    
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
        guard let vm = vm as? NextLaunchLinksCellVM else { return }
        setImage(with: vm.imageURL)
        sourceDescription.text = vm.sourceDescription
        sourceTitle.text = vm.sourceTitle
        sourceLink = vm.sourceLink
        backgroundColor = .clear
    }
    
    private func setupCell() {
        
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        selectionStyle = .none
        
        cellView.backgroundColor = UIColor(red: 0.282, green: 0.282, blue: 0.29, alpha: 0.8)
        cellView.clipsToBounds = true
        cellView.layer.cornerRadius = 15.0
        
        sourceImage.clipsToBounds = true
        sourceImage.layer.cornerRadius = 14.0
        sourceImage.contentMode = .scaleAspectFill
        
        sourceTitle.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.bold)
        sourceTitle.textColor = .white
        sourceTitle.numberOfLines = 1
        
        sourceDescription.font = UIFont.systemFont(ofSize: 15)
        sourceDescription.textColor = .white
        sourceDescription.numberOfLines = 1
        
        setupView()
    }
    
    private func setupView() {
        
        cellView = cellView.useConstraints(addToView: self)
        sourceImage = sourceImage.useConstraints(addToView: cellView)
        sourceTitle = sourceTitle.useConstraints(addToView: cellView)
        sourceDescription = sourceDescription.useConstraints(addToView: cellView)
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: topAnchor),
            cellView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            cellView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            cellView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -14)
        ])
        
        NSLayoutConstraint.activate([
            sourceImage.widthAnchor.constraint(equalToConstant: 50),
            sourceImage.heightAnchor.constraint(equalToConstant: 50),
            sourceImage.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
            sourceImage.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 12)
        ])
        
        NSLayoutConstraint.activate([
            sourceTitle.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 18),
            sourceTitle.leadingAnchor.constraint(equalTo: sourceImage.trailingAnchor, constant: 24),
            sourceTitle.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -12)
        ])
        
        NSLayoutConstraint.activate([
            sourceDescription.topAnchor.constraint(equalTo: sourceTitle.bottomAnchor),
            sourceDescription.leadingAnchor.constraint(equalTo: sourceImage.trailingAnchor, constant: 24),
            sourceDescription.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -12),
            sourceDescription.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -17)
        ])
    }
    
    private func setImage(with imageURL: URL) {
        
        let resource = ImageResource(downloadURL: imageURL, cacheKey: imageURL.absoluteString)
        sourceImage.kf.indicatorType = .activity
        sourceImage.kf.setImage(
            with: resource,
            placeholder: UIColor.darkGray.image(),
            options: [.transition(.fade(0.75)),
                      .scaleFactor(UIScreen.main.scale)
            ],
            progressBlock: nil
        )
    }
}
