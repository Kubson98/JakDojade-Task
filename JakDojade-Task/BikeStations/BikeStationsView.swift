//
//  BikeStationsView.swift
//  JakDojade-Task
//
//  Created by Jakub Sędal on 18/04/2024.
//

import SwiftUI

struct BikeStationsView: View {
    @ObservedObject var viewModel: BikeStationsViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 8) {
                ZStack {
                    ScrollView(showsIndicators: false, content: {
                        ForEach(viewModel.allStations, id: \.stationId) { station in
                            BikeStationCellView(
                                station: station,
                                onTapped: { viewModel.goToDetails(for: station) }
                            )
                        }
                    })
                }
                .background(Color.JakDojadeColors.background)
            }
            .refreshable(action: {
                viewModel.fetchData()
            })
            .padding(.horizontal, 16)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("")
                }
            }
            .toolbarBackground(Color.JakDojadeColors.navBarColor)
            .toolbarBackground(.visible, for: .navigationBar)
            .background(Color.JakDojadeColors.background)
        }
    }
}


