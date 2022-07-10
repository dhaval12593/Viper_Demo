import Foundation

import SwiftUI
import Combine

class TripDetailPresenter: ObservableObject {
    @Published var tripName: String = "No name"
    let setTripName: Binding<String>
    private let interactor: TripDetailInteractor

    private var cancellables = Set<AnyCancellable>()

    init(interactor: TripDetailInteractor) {
        self.interactor = interactor
        setTripName = Binding<String>(
          get: { interactor.tripName },
          set: { interactor.setTripName($0) }
        )

        // 2
        interactor.tripNamePublisher
          .assign(to: \.tripName, on: self)
          .store(in: &cancellables)
    }

    func save() {
      interactor.save()
    }
}
