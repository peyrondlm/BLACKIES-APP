//
//  MomoGridView.swift
//  NegroidesMomosProject
//
//  Created by Pedro Lopez Zamora on 17/06/25.
//

import SwiftUI

struct MomoGridView: View {
    let momos: [MomoModel]
    let onSelect: (MomoModel) -> Void

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 20) {
                let rows = stride(from: 0, to: momos.count, by: 2).map {
                    Array(momos[$0..<min($0 + 2, momos.count)])
                }

                ForEach(rows.indices, id: \.self) { rowIndex in
                    HStack(spacing: 16) {
                        ForEach(rows[rowIndex], id: \.id) { momo in
                            MomoCardView(momo: momo)
                                .onTapGesture {
                                    onSelect(momo)
                                }
                        }
                    }
                }
            }
            .padding()
        }
    }
}
