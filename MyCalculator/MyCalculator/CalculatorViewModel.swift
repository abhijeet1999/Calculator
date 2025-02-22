//
//  CalculatorViewModel.swift
//  MyCalculator
//
//  Created by Abhijeet Cherungottil on 2/22/25.
//

import SwiftUI
import CoreCalculator

// MARK: - CalculatorViewModel
class CalculatorViewModel: ObservableObject {
    @Published var value: String = "0"
    @Published var runningNumber: Double = 0
    @Published var currentOperation: Operation = .none
    @Published var newNumber: Bool = true

    private let calculator = Calculator()

    let buttons: [[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.tan, .cos, .sin, .backspace],
        [.zero, .decimal, .equal]
    ]

    // MARK: - didTap(button: CalcButton)
    func didTap(button: CalcButton) {
        switch button {
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine:
            let number = button.rawValue
            if value == "0" || newNumber {
                value = number
                newNumber = false
            } else {
                value += number
            }

        case .add, .subtract, .multiply, .divide:
            if currentOperation != .none && !newNumber {
                performCalculation()
            }
            runningNumber = Double(value) ?? 0
            currentOperation = Operation(rawValue: button.rawValue) ?? .none
            newNumber = true

        case .equal:
            performCalculation()
            newNumber = true
            
        case .backspace:
            if !newNumber && value.count > 1 {
                value.removeLast()
            } else {
                value = "0"
                newNumber = true
            }

        case .clear:
            value = "0"
            runningNumber = 0
            currentOperation = .none
            newNumber = true

        case .decimal:
            if newNumber {
                value = "0"
                newNumber = false
            }
            if !value.contains(".") {
                value += "."
            }

        case .percent:
            if let num = Double(value) {
                value = String(num / 100)
                newNumber = true
            }

        case .negative:
            if let num = Double(value) {
                value = String(-num)
            }

        case .tan, .cos, .sin:
            if let num = Double(value) {
                let radians = num * .pi / 180
                switch button {
                case .tan: value = String(calculator.tangent(radians))
                case .cos: value = String(calculator.cosine(radians))
                case .sin: value = String(calculator.sine(radians))
                default: break
                }
                newNumber = true
            }
        }
    }
    
    // MARK: - performCalculation
    private func performCalculation() {
        let currentNumber = Double(value) ?? 0
        var result: Double = 0

        switch currentOperation {
        case .add:
            result = calculator.add(runningNumber, with: currentNumber)
        case .subtract:
            result = calculator.subtract(runningNumber, with: currentNumber)
        case .multiply:
            result = calculator.multiply(runningNumber, with: currentNumber)
        case .divide:
            var error: NSError?
            result = calculator.divide(runningNumber, with: currentNumber, error: &error)
            if let error = error {
                value = error.localizedDescription
                return
            }
        default:
            return
        }

        value = String(result)
        runningNumber = result
        currentOperation = .none
    }
    
       // Function to calculate button width
        func buttonWidth(item: CalcButton, availableWidth: CGFloat, spacing: CGFloat) -> CGFloat {
            let baseWidth = availableWidth / 4
            if item == .zero {
                return (baseWidth * 2) + spacing
            }
            return baseWidth
        }
       // Function to calculate button height
        func buttonHeight(availableHeight: CGFloat, spacing: CGFloat) -> CGFloat {
            return availableHeight / 6
        }
}

// MARK: - Operation
enum Operation: String {
    case add = "+"
    case subtract = "-"
    case multiply = "X"
    case divide = "÷"
    case none
}

// MARK: - CalcButton
enum CalcButton: String {
    case one = "1", two = "2", three = "3", four = "4", five = "5"
    case six = "6", seven = "7", eight = "8", nine = "9", zero = "0"
    case add = "+", subtract = "-", divide = "÷", multiply = "X"
    case equal = "=", clear = "AC", decimal = ".", percent = "%", backspace = "C"
    case negative = "-/+", tan = "tan", cos = "cos", sin = "sin"
    
    var buttonColor: Color {
        switch self {
        case .add, .subtract, .multiply, .divide, .equal,.backspace:
            return .orange
        case .clear, .negative, .percent:
            return Color(.lightGray)
        default:
            return Color(UIColor(red: 55/255, green: 55/255, blue: 55/255, alpha: 1))
        }
    }
}
