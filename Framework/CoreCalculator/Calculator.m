//
//  Calculator.m
//  CoreCalculator
//
//  Created by Abhijeet Cherungottil on 2/21/25.
//

#import "CoreCalculator.h"

@implementation Calculator

- (double)add:(double)a with:(double)b {
    return a + b;
}

- (double)subtract:(double)a with:(double)b {
    return a - b;
}

- (double)multiply:(double)a with:(double)b {
    return a * b;
}

- (double)divide:(double)a with:(double)b error:(NSError **)error {
    if (b == 0) {
        if (error) {
            *error = [NSError errorWithDomain:@"com.corecalculator"
                                         code:1001
                                     userInfo:@{NSLocalizedDescriptionKey: @"Cannot divide by zero"}];
        }
        return 0.0;
    }
    return a / b;
}

- (double)sine:(double)value {
    return sin(value);
}

- (double)cosine:(double)value {
    return cos(value);
}

- (double)tangent:(double)value {
    return tan(value);
}

@end
