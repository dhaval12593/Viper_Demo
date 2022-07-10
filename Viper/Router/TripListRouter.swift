import Foundation
import SwiftUI

class TripListRouter {

    func makeDetailView(for trip: Trip, dataModel: DataModel) -> some View {
        let interactor = TripDetailInteractor(trip: trip, model: dataModel, mapInfoProvider: RealMapDataProvider())
        let presenter = TripDetailPresenter(interactor: interactor)
        return TripDetailView(presenter: presenter)
    }
}
