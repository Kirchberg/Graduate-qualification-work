import Foundation

protocol NextLaunchInteractorProtocol {
    func viewIsReady()
    func selected(with: CellNameProtocol, didSelectRowAt indexPath: Int)
}
