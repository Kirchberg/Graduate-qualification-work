import UIKit
import Kingfisher

class NextLaunchPhotoCell: UICollectionViewCell {
    
    static var identifier: String = "NextLaunchPhotoCell"
    
    var photoImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        photoImage.layer.masksToBounds = true
        photoImage.layer.cornerRadius = 14.0
        
        setupView()
    }
    
    private func setupView() {
        photoImage = photoImage.useConstraints(addToView: self)
        NSLayoutConstraint.activate([
            photoImage.widthAnchor.constraint(equalToConstant: 142),
            photoImage.heightAnchor.constraint(equalToConstant: 114),
            photoImage.topAnchor.constraint(equalTo: topAnchor),
            photoImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            photoImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            photoImage.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func updateWith(imageURL: URL?) {
        guard let imageURL = imageURL else { return }
        let resource = ImageResource(downloadURL: imageURL, cacheKey: imageURL.absoluteString)
        photoImage.kf.indicatorType = .activity
        photoImage.kf.setImage(
            with: resource,
            placeholder: UIColor.darkGray.image(),
            options: [.transition(.fade(0.75)),
                      .scaleFactor(UIScreen.main.scale)
            ],
            progressBlock: nil
        )
    }
}
