import UIKit

final class NextLaunchViewController: VerticalViewController {
    var interactor: NextLaunchInteractorProtocol?
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        interactor?.viewIsReady()
    }

    // MARK: UI
    
    lazy var spinnerView = ProgressHUD(text: "Loading")
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.backgroundColor = .black
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.register(NextLaunchInfoCell.self, forCellReuseIdentifier: NextLaunchInfoCell.identifier)
        tableView.register(NextLaunchMissionCell.self, forCellReuseIdentifier: NextLaunchMissionCell.identifier)
        tableView.register(NextLaunchGalleryCell.self, forCellReuseIdentifier: NextLaunchGalleryCell.identifier)
        tableView.register(NextLaunchLinksCell.self, forCellReuseIdentifier: NextLaunchLinksCell.identifier)
        return tableView
    }()
    
    private func setupUI() {
        setupTableView()
        spinnerView = spinnerView.useConstraints(addToView: view)
        spinnerView.show()
    }
    
    private func setupTableView() {
        tableView = tableView.useConstraints(addToView: view)
        
        if let tabBarController = self.tabBarController {
            let adjustForTabbarInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: tabBarController.tabBar.frame.height, right: 0)
            tableView.contentInset = adjustForTabbarInsets
            tableView.scrollIndicatorInsets = adjustForTabbarInsets
        }
        
        extendedLayoutIncludesOpaqueBars = true
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        registerCells()
    }
    
    private func registerCells() {
        [NextLaunchInfoCell.self,
         NextLaunchMissionCell.self,
         NextLaunchGalleryCell.self,
         NextLaunchLinksCell.self
        ].forEach {
            tableView.register($0, forCellReuseIdentifier: NSStringFromClass($0))
        }
    }
    
    var cellVMs = [[NextLaunchCellVMProtocol]]()
    
    func updateSection(withIndex index: Int, cellVMs: [NextLaunchCellVMProtocol]) {
        self.cellVMs[index] = cellVMs
        tableView.reloadSections(IndexSet(integer: index), with: .fade)
    }

    func updateAllSections(cellVMs: [[NextLaunchCellVMProtocol]]) {
        self.cellVMs = cellVMs
        spinnerView.hide()
        tableView.reloadData()
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate

extension NextLaunchViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return cellVMs.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellVMs[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellVM = cellVMs[indexPath.section][indexPath.row]
        let cell = tableView.dequeueCellWithClass(cellClass: cellVM.cellType, forIndexPath: indexPath)
        if var cell = cell as? CellProtocol {
            cell.updateWith(vm: cellVM)
            cell.parentViewController = self
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellVMs[indexPath.section][indexPath.row].height
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (section == 3) ? 41 : 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return (section == 3) ? "Links" : nil
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 3 {
            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 41))
            let label = UILabel()
            label.frame = CGRect.init(x: 15, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
            label.text = "Links"
            label.font = .systemFont(ofSize: 20, weight: UIFont.Weight.bold)
            label.textColor = .white

            headerView.addSubview(label)
            return headerView
        }
        
        return UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 0))
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellVM = cellVMs[indexPath.section][indexPath.row]
        interactor?.selected(with: cellVM.cellName, didSelectRowAt: indexPath.row)
    }
}
