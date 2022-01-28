//
//  NextLaunchInteractor.swift
//  spaceOfSpace
//
//  Created by Kirill Kostarev on 27.03.2021.
//

import UIKit

protocol NextLaunchInteractorInput {
}

final class NextLaunchInteractor {
    var presenter: NextLaunchPresenterInput?
    var router: NextLaunchRouterInput?
    var worker: NextLaunchWorker?
    var dataSource: NextLaunchDataSource?
}

extension NextLaunchInteractor: NextLaunchInteractorProtocol {
    func viewIsReady() {
        worker = NextLaunchWorker()
        worker?.requestNextLaunch(success: { data in
            guard let data = data else { return }
            self.dataSource = data
            guard let dataSource = self.dataSource else { return }
            self.presenter?.update(dataSource: dataSource)
        })
    }
    
    func selected(with name: CellNameProtocol, didSelectRowAt indexPath: Int) {
        guard let name = (name as? NextLaunchPresenter.CommonCellName)?.name else { return }
        switch name {
        case .links:
            guard let stringURL = dataSource?.linksSection[indexPath].browserURL, !stringURL.isEmpty else { return }
            router?.openSecondScreen(withURL: stringURL)
        default:
            break
        }
    }
}

extension NextLaunchInteractor: NextLaunchInteractorInput {
}
