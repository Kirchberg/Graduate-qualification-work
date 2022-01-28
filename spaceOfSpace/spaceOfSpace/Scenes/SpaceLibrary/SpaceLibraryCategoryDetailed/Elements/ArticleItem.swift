import UIKit

class ArticleItem: UITableViewCell {
    static var identifier: String = "ArticleItem"
    
    var articleTitle = UILabel()
    var articleImage = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupItem()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupItem() {
        contentView.layer.cornerRadius = 20

        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowOffset = .zero
        contentView.layer.shadowRadius = 10
        
        articleImage.clipsToBounds = true
        articleImage.contentMode = .scaleAspectFill
        articleImage.layer.cornerRadius = 20
        
        articleTitle.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        articleTitle.numberOfLines = 1
        
        setupAutoLayout()
    }
    
    func setupAutoLayout() {
        articleTitle.translatesAutoresizingMaskIntoConstraints = false
        articleImage.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(articleImage)
        contentView.addSubview(articleTitle)
        
        NSLayoutConstraint.activate([
            articleImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            articleImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            articleImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            articleImage.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            articleTitle.leadingAnchor.constraint(equalTo: articleImage.leadingAnchor, constant: 12),
            articleTitle.trailingAnchor.constraint(equalTo: articleImage.trailingAnchor, constant: -12),
            articleTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            articleTitle.heightAnchor.constraint(lessThanOrEqualTo: contentView.heightAnchor)
        ])
    }
}
