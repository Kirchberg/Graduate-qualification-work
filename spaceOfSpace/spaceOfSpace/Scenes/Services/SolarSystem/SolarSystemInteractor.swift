import UIKit

protocol SolarSystemBusinessLogic {}

protocol SolarSystemDataStore {}

class SolarSystemInteractor: SolarSystemBusinessLogic, SolarSystemDataStore {
    var presenter: SolarSystemPresentationLogic?
    var worker: SolarSystemWorker?
}
