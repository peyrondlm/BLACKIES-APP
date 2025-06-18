//
//  MomoDetailView.swift
//  NegroidesMomosProject
//
//  Created by Pedro Lopez Zamora on 17/06/25.
//

import SwiftUI

struct MomoDetailView: View {
    let momo: MomoModel

    var body: some View {
        VStack(spacing: 20) {
            AsyncImage(url: URL(string: momo.image)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            } placeholder: {
                ProgressView()
                    .frame(height: 200)
            }

            Text("Nombre: \(momo.name)")
                .font(.title)
                .bold()
            
            Text("Autor: \(momo.autor.name)")
                .font(.title2)
                .multilineTextAlignment(.center)

            Text("Descripción: \(momo.description)")
                .font(.body)
                .multilineTextAlignment(.center)
                

            Spacer()
        }
        .padding()
    }
}
