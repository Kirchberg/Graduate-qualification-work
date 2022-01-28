import UIKit

extension ServicesViewController: UITableViewDelegate,  UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! ServicesCell
            cell.backgroundColor = UIColor.systemGray4
            
        switch indexPath.row {
        case 0:
            cell.cellLabel.text = "Space AR"
            cell.cellImg.image=UIImage(named: "arkit")
            cell.cellDesc.text="Create your own universe in your room"
        case 1:
            cell.cellLabel.text = "SolAR System"
            cell.cellImg.image=UIImage(named: "solAR")
            cell.cellDesc.text="All solar system will spin in your room"
        case 2:
            cell.cellLabel.text = "RIFTS by NASA"
            cell.cellImg.image=UIImage(named: "APOD")
            cell.cellImg.contentMode = .scaleToFill
            cell.cellDesc.text="Random image from the space"
        default:
            cell.cellLabel.text = "UNKNOWN"
            cell.imageView?.backgroundColor=UIColor.systemPink
        }
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let newViewController = ServicesArPlanetViewController()
            //newViewController.hidesBottomBarWhenPushed=true
            newViewController.isSystem=false
            newViewController.modalPresentationStyle = .fullScreen
            present(newViewController, animated: true, completion: nil)
        case 1:
            let newViewController = SolarSystemViewController()
            newViewController.hidesBottomBarWhenPushed=true
            self.navigationController?.pushViewController(newViewController, animated: true)

        case 2:
            let newViewController = ApodViewController()
            newViewController.modalPresentationStyle = .fullScreen
            present(newViewController, animated: true, completion: nil)
        default:
           return
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func setupTableView() {
        tableview.separatorStyle = .none
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(ServicesCell.self, forCellReuseIdentifier: "cellId")
        
        self.view.addSubview(tableview)
        
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        ])
    }
}

class ServicesCell: UITableViewCell {
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(rgb: 0x1C1C1E)
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 10
        
        return view
    }()
    
    let cellLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(rgb: 0xFFFFFF)
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cellImg: UIImageView = {
        let img=UIImageView()
        img.layer.masksToBounds = true
        img.contentMode = .scaleAspectFit
        img.backgroundColor = UIColor(rgb: 0x1C1C1E)
        img.layer.cornerRadius = 8
        img.contentMode = .scaleToFill
        img.translatesAutoresizingMaskIntoConstraints=false
        return img
    }()
    
    let cellDesc:UILabel = {
        let label=UILabel()
        label.textColor = UIColor(rgb: 0xFFFFFF)
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines=0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor=UIColor.systemGray4
        setupView()
    }
    
    func setupView() {
        addSubview(cellView)
        cellView.addSubview(cellLabel)
        cellView.addSubview(cellImg)
        cellView.addSubview(cellDesc)
        self.selectionStyle = .none
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            cellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            cellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
        ])
        cellLabel.heightAnchor.constraint(equalToConstant: 41).isActive = true
        cellLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -10).isActive=true
        cellLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 4).isActive = true
        cellLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 108).isActive = true
        
        NSLayoutConstraint.activate([
            cellImg.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 20),
            cellImg.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 22),
            cellImg.widthAnchor.constraint(equalToConstant: 60),
            cellImg.heightAnchor.constraint(equalToConstant: 60),
            
        ])
        
        NSLayoutConstraint.activate([
            cellDesc.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 44),
            cellDesc.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 108),
            cellDesc.heightAnchor.constraint(equalToConstant: 44),
            cellDesc.widthAnchor.constraint(equalToConstant: 221),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
