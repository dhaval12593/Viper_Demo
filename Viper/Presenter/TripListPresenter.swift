import Foundation
import Combine
import SwiftUI

class TripListPresenter: ObservableObject {
    private let router = TripListRouter()
    var interactor: TripListInteractor
    private var cancellables = Set<AnyCancellable>()
    @Published var trips: [Trip] = []

    init(interactor: TripListInteractor) {
        self.interactor = interactor
        interactor.model.$trips
            .assign(to: \.trips, on: self)
            .store(in: &cancellables)
    }

    func makeAddNewButton() -> some View {
        Button(action: addNewTrip, label: {
            Image(systemName: "plus")
        })
    }

    private func addNewTrip() {
        interactor.addNewTrip()
    }

    func deleteTrip(_ index: IndexSet) {
        interactor.deleteTrip(index)
    }

    func linkBuilder<Content: View>(for trip: Trip,
                                    @ViewBuilder content: () -> Content) -> some View {
        NavigationLink(destination: router.makeDetailView(for: trip, dataModel: interactor.model)) { content() }
    }

}
