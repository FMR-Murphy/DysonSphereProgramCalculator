//
//  ElementModel.m
//  DysonSphereProgramCalculator
//
//  Created by Murphy on 2022/3/24.
//

#import "ElementModel.h"

@implementation IngredientModel


@end

@interface FormulaModel ()
/// 产量 / min
@property (nonatomic) float yieldForMin;

@end

@implementation FormulaModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{
        @"ingredients": [IngredientModel class],
        @"products": [IngredientModel class],
        @"tool": [ElementModel class],
    };
}

- (float)number {
    if (_number == 0) {
        [self.products enumerateObjectsUsingBlock:^(IngredientModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.elementId isEqualToString:self.targetProduct.eleId] || [obj.elementId isEqualToString:RawOreId]) {
                _number = obj.number;
                *stop = YES;
            }
        }];
    }
    return _number;
}

/// 产量 / min
- (float)yieldForMin {
    if (_yieldForMin <= 0) {
        _yieldForMin = (self.number / self.duration * 60) * self.tool[self.currToolIndex].efficiency;
    }
    return _yieldForMin;
}

/// 达到 targetNumber 所需要的工具数量
- (float)toolNumber {
    if (_toolNumber == 0) {
        _toolNumber = self.targetNumber / [self yieldForMin];
    }
    return _toolNumber;
}

@end

@implementation ElementModel


@end
   
