import UIKit

final class NextLaunchMissionCell: UITableViewCell, CellProtocol {
    
    weak var parentViewController: UIViewController?
    static var identifier: String = "NextLaunchMissionCell"

    var missionDescription = UILabel()
    
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
        guard let vm = vm as? NextLaunchMissionCellVM else { return }
        missionDescription.text = vm.missionDescription
        backgroundColor = .clear
    }
    
    private func setupCell() {
        missionDescription.font = UIFont(name: "SanFranciscoText-Regular", size: 15)
        missionDescription.numberOfLines = 0
        missionDescription.textColor = .white
        
        setupView()
    }

    private func setupView() {
        
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        selectionStyle = .none
        
        missionDescription = missionDescription.useConstraints(addToView: self)
        NSLayoutConstraint.activate([
            missionDescription.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            missionDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            missionDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            missionDescription.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}
