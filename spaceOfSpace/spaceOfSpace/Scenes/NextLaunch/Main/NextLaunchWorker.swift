import UIKit

final class NextLaunchWorker {
    
    let nextLaunchManager = NextLaunchAPIService()
    
    func requestNextLaunch(success: @escaping (NextLaunchDataSource?)->()) {
        nextLaunchManager.requestNextLaunch { data in
            success(data)
        }
    }
}
