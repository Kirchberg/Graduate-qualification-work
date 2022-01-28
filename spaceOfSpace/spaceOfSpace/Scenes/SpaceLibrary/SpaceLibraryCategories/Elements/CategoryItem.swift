import UIKit

class CategoryItem: UICollectionViewCell {
    static var identifier: String = "CategoryItem"
    
    var categoryTitle = UILabel()
    var categoryImage = UIImageView()
    var mainView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupItem()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupItem() {
        contentView.backgroundColor = .systemGray
        contentView.layer.cornerRadius = 20
        
        contentView.layer.shadowPath = UIBezierPath(rect: contentView.bounds).cgPath
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowOffset = .zero
        contentView.layer.shadowRadius = 10
        
        mainView.layer.cornerRadius = 20
        mainView.layer.masksToBounds = true
        
        categoryImage.clipsToBounds = true
        categoryImage.contentMode = .scaleAspectFill
        
        categoryTitle.font = UIFont.systemFont(ofSize: 34, weight: .medium)
        categoryTitle.numberOfLines = 0
        
        setupAutoLayout()
    }
    
    func setupAutoLayout() {
        mainView.translatesAutoresizingMaskIntoConstraints = false
        categoryTitle.translatesAutoresizingMaskIntoConstraints = false
        categoryImage.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(mainView)
        mainView.addSubview(categoryImage)
        mainView.addSubview(categoryTitle)
        
        NSLayoutConstraint.activate([
            mainView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            mainView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            categoryTitle.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 9),
            categoryTitle.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 8),
            categoryTitle.widthAnchor.constraint(lessThanOrEqualTo: mainView.widthAnchor),
            categoryTitle.heightAnchor.constraint(lessThanOrEqualTo: mainView.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            categoryImage.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            categoryImage.topAnchor.constraint(equalTo: mainView.topAnchor),
            categoryImage.widthAnchor.constraint(equalTo: mainView.widthAnchor),
            categoryImage.heightAnchor.constraint(equalTo: mainView.heightAnchor)
        ])
    }
}
