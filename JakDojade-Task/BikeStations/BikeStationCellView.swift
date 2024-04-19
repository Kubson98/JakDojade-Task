//
//  BikeStationCellView.swift
//  Services
//
//  Created by Jakub Sędal on 19/04/2024.
//

import SwiftUI

struct BikeStationCellView: View {
    var station: BikeStation
    let onTapped: (() -> Void)?
    var body: some View {
        Button {
            (onTapped ?? { print("error") })()
        } label: {
            VStack(spacing: 4) {
                VStack(alignment: .leading, spacing: 4, content: {
                    Text(station.name)
                        .foregroundColor(
                            Color.JakDojadeColors.primaryBlack
                        )
                        .font(.custom("Manrope", size: 24))
                        .bold()
                        .multilineTextAlignment(.leading)
                    HStack {
                        Text("\(station.distance)")
                            .foregroundColor(Color.JakDojadeColors.primaryBlack)
                            .font(.custom("Manrope", size: 12))
                            .bold()
                            .multilineTextAlignment(.leading)
                        Text("·")
                            .foregroundColor(Color(Color.JakDojadeColors.primaryBlack))
                            .font(.custom("Manrope", size: 12))
                            .multilineTextAlignment(.leading)
                        Text("\(station.address)")
                            .foregroundColor(Color.JakDojadeColors.primaryBlack)
                            .font(.custom("Manrope", size: 12))
                            .multilineTextAlignment(.leading)
                    }
                })
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .leading)
                HStack(alignment: .center) {
                    VStack(spacing: 8) {
                        Image(uiImage: .vector)
                            .imageScale(.large)
                            .foregroundStyle(.tint)
                        Text("\(station.numBikesAvailable)")
                            .foregroundColor(Color.JakDojadeColors.positive)
                            .font(.custom("Manrope", size: 44))
                            .bold()
                            .multilineTextAlignment(.center)
                        Text("Bikes available")
                            .foregroundColor(Color.JakDojadeColors.primaryBlack)
                            .font(.custom("Manrope", size: 12))
                            .multilineTextAlignment(.center)
                    }.frame(maxWidth: .infinity)
                    VStack(spacing: 8) {
                        Image(uiImage: .lock)
                            .imageScale(.large)
                            .foregroundStyle(.tint)
                        Text("\(station.numDocksAvailable)")
                            .foregroundColor(Color.JakDojadeColors.primaryBlack)
                            .font(.custom("Manrope", size: 44))
                            .bold()
                            .multilineTextAlignment(.center)
                        Text("Places available")
                            .foregroundColor(Color.JakDojadeColors.primaryBlack)
                            .font(.custom("Manrope", size: 12))
                            .multilineTextAlignment(.center)
                    }.frame(maxWidth: .infinity)
                }.padding(.bottom, 16)
            }
            .background(Color(.white))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(
                color: Color.JakDojadeColors.shadowColor,
                radius: 16,
                x: 0,
                y: 8
            )
        }
    }
}
