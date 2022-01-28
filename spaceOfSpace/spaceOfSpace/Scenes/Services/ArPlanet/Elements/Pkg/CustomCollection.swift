//import UIKit
//
//public protocol CustomLayoutDelegateServices {
//
//    func collectionViewServices(_ collectionView: UICollectionView, heightForItemAt indexPath: IndexPath, with width: CGFloat) -> CGFloat
//}
//
//public class UICustomCollectionViewLayoutServices: UICollectionViewLayout {
//
//    public var delegate: CustomLayoutDelegateServices!
//    private var showHeader = false
//    private var showFooter = false
//
//    public var numberOfColumns = 2
//    public var cellPadding: CGFloat = 8.0
//
//    private var cache = [UICollectionViewLayoutAttributes]()
//
//    private var contentHeight: CGFloat = 0.0
//    private var contentWidth: CGFloat {
//        let insets = collectionView!.contentInset
//        return collectionView!.bounds.width - (insets.left + insets.right)
//    }
//
//    override public var collectionViewContentSize: CGSize {
//        return CGSize(width: contentWidth, height: contentHeight)
//    }
//
//    override public func prepare() {
//        if cache.isEmpty {
//            collectionView?.contentInset = UIEdgeInsets(top: cellPadding, left: cellPadding, bottom: cellPadding, right: cellPadding)
//            let columnWidth = contentWidth / CGFloat(numberOfColumns)
//            var xOffset = [CGFloat]()
//            for column in 0 ..< numberOfColumns {
//                xOffset.append(CGFloat(column) * columnWidth )
//            }
//            let headerHeight: CGFloat
//            if self.showHeader {
//                headerHeight = 88
//                let a = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, with: IndexPath(item: 1, section: 0))
//                a.frame = CGRect(x: cellPadding, y: contentHeight + cellPadding, width: contentWidth - (cellPadding*2), height: 185)
//                contentHeight = max(contentHeight, a.frame.maxY + cellPadding)
//                cache.append(a)
//            } else {
//                headerHeight = 0
//            }
//
//            var yOffset = [CGFloat](repeating: headerHeight, count: numberOfColumns)
//            var col = 0
//            for item in 0 ..< collectionView!.numberOfItems(inSection: 0) {
//                let indexPath = IndexPath(item: item, section: 0)
//
//                let width = columnWidth - cellPadding * 2
//
//                let cardHeight = delegate.collectionViewServices(collectionView!, heightForItemAt: indexPath, with: width)
//                let height = cellPadding +  cardHeight + cellPadding
//                let frame = CGRect(x: xOffset[col], y: yOffset[col], width: columnWidth, height: height)
//                let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
//
//                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
//                attributes.frame = insetFrame
//                cache.append(attributes)
//
//                contentHeight = max(contentHeight, frame.maxY)
//                yOffset[col] = yOffset[col] + height
//
//                col = col >= (numberOfColumns - 1) ? 0 : col+1
//            }
//
//            if (showFooter) {
//
//                let a = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, with: IndexPath(item: 1, section: 0))
//                a.frame = CGRect(x: cellPadding, y: contentHeight + cellPadding, width: contentWidth - (cellPadding*2), height: 185)
//                contentHeight = max(contentHeight, a.frame.maxY + cellPadding)
//                cache.append(a)
//            }
//        }
//    }
//
//    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        var layoutAttributes = [UICollectionViewLayoutAttributes]()
//        for attributes in cache {
//            if attributes.frame.intersects(rect) {
//                layoutAttributes.append(attributes)
//            }
//        }
//        return layoutAttributes
//    }
//}
//
//
//class CategoryItemServices: UICollectionViewCell {
//    static var identifier: String = "CategoryItemServices"
//
//    var categoryTitle = UILabel()
//    var categoryImage = UIImageView()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupItem()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func setupItem() {
//        contentView.layer.cornerRadius = 20
//        contentView.layer.masksToBounds = true
//
//        categoryImage.clipsToBounds = true
//        categoryImage.contentMode = .scaleAspectFill
//
//        categoryTitle.font = UIFont.systemFont(ofSize: 34, weight: .medium)
//        categoryTitle.numberOfLines = 0
//
//        setupAutoLayout()
//    }
//
//    func setupAutoLayout() {
//        categoryTitle.translatesAutoresizingMaskIntoConstraints = false
//        categoryImage.translatesAutoresizingMaskIntoConstraints = false
//
//        contentView.addSubview(categoryImage)
//        contentView.addSubview(categoryTitle)
//
//        NSLayoutConstraint.activate([
//            categoryTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 9),
//            categoryTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
//            categoryTitle.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor),
//            categoryTitle.heightAnchor.constraint(lessThanOrEqualTo: contentView.heightAnchor)
//        ])
//
//        NSLayoutConstraint.activate([
//            categoryImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            categoryImage.topAnchor.constraint(equalTo: contentView.topAnchor),
//            categoryImage.widthAnchor.constraint(equalTo: contentView.widthAnchor),
//            categoryImage.heightAnchor.constraint(equalTo: contentView.heightAnchor)
//        ])
//    }
//
////    override var isSelected: Bool {
////        didSet{
////            if self.isSelected {
////                UIView.animate(withDuration: 0.3) { // for animation effect
////                     self.backgroundColor = UIColor(red: 115/255, green: 190/255, blue: 170/255, alpha: 1.0)
////                    self.categoryImage.backgroundColor=UIColor(red: 115/255, green: 190/255, blue: 170/255, alpha: 1.0)
////                    let overlay: UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.categoryImage.frame.size.width, height: self.categoryImage.frame.size.height))
////                    overlay.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
////                    self.categoryImage.addSubview(overlay)
////                    overlay.isUserInteractionEnabled = false
////                }
////
////
////            }
////            else {
////                UIView.animate(withDuration: 0.3) { // for animation effect
////                     self.backgroundColor = UIColor(red: 60/255, green: 63/255, blue: 73/255, alpha: 1.0)
////                    self.categoryImage.backgroundColor=UIColor(red: 60/255, green: 63/255, blue: 73/255, alpha: 1.0)
////                }
////            }
////        }
////    }
//}
//
