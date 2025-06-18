//
//  ContentView.swift
//  NegroidesMomosProject
//
//  Created by Pedro Lopez Zamora on 13/06/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()

    var body: some View {
        GeometryReader { geo in
            let zoom: CGFloat = 0.95

            ZStack(alignment: .topLeading) {
                if !viewModel.levels.isEmpty, let currentLevel = viewModel.currentLevel {
                    // Fondo del iceberg
                    Image("icebergfondocropped")
                        .resizable()
                        .scaledToFill()
                        .frame(
                            width: geo.size.width / zoom,
                            height: (geo.size.height * CGFloat(viewModel.levels.count)) / zoom
                        )
                        .offset(y: -CGFloat(viewModel.currentLevelIndex) * geo.size.height / zoom)
                        .clipped()
                        .zIndex(0)
                        .animation(.easeInOut(duration: 0.8), value: viewModel.currentLevelIndex)

                    // Contenido principal
                    VStack {
                        Spacer()

                        HStack(alignment: .center) {
                            // Botones de navegación
                            VStack(spacing: 20) {
                                Button {
                                    viewModel.goToPreviousLevel()
                                } label: {
                                    Image(systemName: "arrow.up.circle.fill")
                                        .font(.largeTitle)
                                        .foregroundColor(.white)
                                }
                                .background(.black)
                                .clipShape(Circle())
                                .padding()
                                .keyboardShortcut(.upArrow, modifiers: [])

                                Button {
                                    viewModel.goToNextLevel()
                                } label: {
                                    Image(systemName: "arrow.down.circle.fill")
                                        .font(.largeTitle)
                                        .foregroundColor(.white)
                                }
                                .background(.black)
                                .clipShape(Circle())
                                .padding()
                                .keyboardShortcut(.downArrow, modifiers: [])
                            }
                            .padding(.horizontal)

                            Spacer()

                            // Grid de momos
                            VStack {
                                Text("Nivel \(currentLevel.number)")
                                    .font(.title).bold()
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.black.opacity(0.7))
                                    .clipShape(RoundedRectangle(cornerRadius: 15))

                                MomoGridView(
                                    momos: viewModel.momosForCurrentLevel(),
                                    onSelect: { selected in
                                        viewModel.selectedMomo = selected
                                    }
                                )
                            }
                            .frame(maxWidth: 500)
                            .padding(.top, 75)

                            Spacer()

                            // Imagen del nivel
                            AsyncImage(url: URL(string: currentLevel.image)) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 150)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                            } placeholder: {
                                ProgressView()
                                    .frame(width: 150, height: 150)
                            }
                            .padding()
                        }

                        Spacer()
                    }
                    .frame(width: geo.size.width, height: geo.size.height)
                    .zIndex(1)
                    .animation(.easeInOut(duration: 0.8), value: viewModel.currentLevelIndex)
                } else {
                    ProgressView("Cargando niveles...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.black.opacity(0.8))
                }
            }
            .ignoresSafeArea()
            .sheet(item: $viewModel.selectedMomo) { momo in
                MomoDetailView(momo: momo)
            }
            .task {
                await viewModel.loadData()
            }
        }
    }
}

#Preview {
    ContentView()
}
