//
//  StationDetailsView.swift
//  JakDojade-Task
//
//  Created by Jakub Sędal on 18/04/2024.
//

import MapKit
import CoreLocation
import SwiftUI

struct Coordinates {
    let lat: Double
    let lon: Double
}

struct StationDetailsView: View {
    @State private var route: MKRoute?
    @ObservedObject var viewModel: StationDetailsViewModel

    var body: some View {
        NavigationStack {
            VStack {
                Map {
                    Annotation(
                        "You",
                        coordinate: viewModel.userLocation
                    ) {
                        Image(uiImage: .location)
                            .imageScale(.large)
                            .foregroundStyle(.tint)
                    }
                    Annotation(
                        "Station",
                        coordinate: CLLocationCoordinate2D(
                            latitude: viewModel.station.lat,
                            longitude: viewModel.station.lon
                        )
                    ) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color.teal)
                            HStack(content: {
                                Text(String(viewModel.station.numBikesAvailable))
                                Image(uiImage: .vector)
                                    .foregroundStyle(.tint)
                            })
                            .padding(4)
                            .background(Color.white)
                        }
                    }
                    if let route {
                        MapPolyline(route.polyline)
                            .stroke(.blue, lineWidth: 2)
                        // .stroke(gradient, style: stroke)
                    }
                }
                Spacer()
                BikeStationCellView(
                    station: viewModel.station,
                    onTapped: nil
                )
            }.onAppear(perform: {
                fetchRouteFrom(
                    from: viewModel.userLocation,
                    to: CLLocationCoordinate2D(
                        latitude: viewModel.station.lat,
                        longitude: viewModel.station.lon
                    )
                )
            })
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        viewModel.popToHomeView()
                    } label: {
                        HStack {
                            Image(systemName: "arrow.backward")
                                .foregroundColor(Color.JakDojadeColors.primaryWhite)
                        }
                    }
                }
            }
            .toolbarBackground(Color.JakDojadeColors.navBarColor, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
    
    private func fetchRouteFrom(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D) {
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: MKPlacemark(coordinate: source))
            request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination))
            request.transportType = .walking
            
            Task {
                let result = try? await MKDirections(request: request).calculate()
                route = result?.routes.first
            }
        }
}
