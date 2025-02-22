//
//  CoreCalculator.h
//  CoreCalculator
//
//  Created by Abhijeet Cherungottil on 2/21/25.
//

#import <Foundation/Foundation.h>

//! Project version number for CoreCalculator.
FOUNDATION_EXPORT double CoreCalculatorVersionNumber;

//! Project version string for CoreCalculator.
FOUNDATION_EXPORT const unsigned char CoreCalculatorVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <CoreCalculator/PublicHeader.h>
#import <UIKit/UIKit.h>



NS_ASSUME_NONNULL_BEGIN

@interface Calculator : NSObject

- (double)add:(double)a with:(double)b;
- (double)subtract:(double)a with:(double)b;
- (double)multiply:(double)a with:(double)b;
- (double)divide:(double)a with:(double)b error:(NSError **)error;
- (double)sine:(double)value;
- (double)cosine:(double)value;
- (double)tangent:(double)value;

@end

NS_ASSUME_NONNULL_END
