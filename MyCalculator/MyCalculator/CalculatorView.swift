//
//  CalculatorView.swift
//  MyCalculator
//
//  Created by Abhijeet Cherungottil on 2/22/25.
//


import SwiftUI

// MARK: - CalculatorView
struct CalculatorView: View {
    @StateObject private var viewModel = CalculatorViewModel()
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
   
    
    var body: some View {
        GeometryReader { geometry in
            let isLandscape = geometry.size.width > geometry.size.height
            
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                // MARK: - Landscape Mode
                if isLandscape {
                    HStack(spacing: 0) {
                        calculatorDisplay
                            .frame(width: geometry.size.width * 0.3)
                            .padding(.horizontal)
                        
                        buttonGrid(
                            screenWidth: geometry.size.width * 0.7,
                            screenHeight: geometry.size.height,
                            spacing: 8,
                            isLandscape: true
                        )
                        .padding(.trailing)
                    }
                } else {
                    // MARK: - PotraitMode
                    VStack {
                        calculatorDisplay
                        buttonGrid(
                            screenWidth: geometry.size.width,
                            screenHeight: geometry.size.height * 0.7,
                            spacing: 12,
                            isLandscape: false
                        )
                    }
                    .padding()
                }
            }
        }
    }
    
    // Function to display calculated text
    private var calculatorDisplay: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Text(viewModel.value)
                    .bold()
                    .font(.system(size: 50))
                    .foregroundColor(.white)
                    .padding()
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
            }
        }
    }
    
    // Function to display button grid text
    private func buttonGrid(screenWidth: CGFloat, screenHeight: CGFloat, spacing: CGFloat, isLandscape: Bool) -> some View {
        let availableWidth = screenWidth - (isLandscape ? spacing * 5 : spacing * 6)
        let availableHeight = screenHeight - (spacing * 7)
        
        return VStack(spacing: spacing) {
            ForEach(viewModel.buttons, id: \.self) { row in
                HStack(spacing: spacing) {
                    ForEach(row, id: \.self) { item in
                        Button {
                            viewModel.didTap(button: item)
                        } label: {
                            Text(item.rawValue)
                                .font(.system(size: isLandscape ? 28 : 32))
                                .frame(
                                    width: viewModel.buttonWidth(item: item, availableWidth: availableWidth, spacing: spacing),
                                    height: viewModel.buttonHeight(availableHeight: availableHeight, spacing: spacing)
                                )
                                .background(item.buttonColor)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
            }
        }
    }
    
   
}


#Preview {
    CalculatorView()
}
