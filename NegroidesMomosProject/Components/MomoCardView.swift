//
//  MomoCardView.swift
//  NegroidesMomosProject
//
//  Created by Pedro Lopez Zamora on 17/06/25.
//

import SwiftUI

struct MomoCardView: View {
    let momo: MomoModel

    var body: some View {
        VStack(spacing: 8) {
            AsyncImage(url: URL(string: momo.image)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } placeholder: {
                ProgressView()
                    .frame(width: 120, height: 120)
            }

            Text(momo.name)
                .font(.headline)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)

            Text(momo.description)
                .font(.caption)
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .truncationMode(.tail)
            
        }
        .padding()
        .background(Color.black.opacity(0.7))
        .cornerRadius(12)
    }
}
