import SwiftUI

struct TripListView: View {

    @ObservedObject var presenter: TripListPresenter

    var body: some View {
        List {
          ForEach (presenter.trips, id: \.id) { item in
              self.presenter.linkBuilder(for: item) {
                  TripListCell(trip: item)
                    .frame(height: 240)
              }
          }
          .onDelete(perform: presenter.deleteTrip)
        }
        .navigationBarTitle("RoadTrips", displayMode: .inline)
        .navigationBarItems(trailing: presenter.makeAddNewButton())
    }
}

struct TripListView_Previews: PreviewProvider {
    static var previews: some View {
        let dataModel = DataModel.sample
        let interactor = TripListInteractor(model: dataModel)
        let presenter = TripListPresenter(interactor: interactor)
        return NavigationView {
            TripListView(presenter: presenter)
        }
    }
}
