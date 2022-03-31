//
//  CalculatorViewModel.h
//  DysonSphereProgramCalculator
//
//  Created by Murphy on 2022/3/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class ElementModel;
@class FormulaModel;

@interface CalculatorViewModel : NSObject

/// 物品列表
@property (nonatomic, readonly) NSArray<ElementModel *> *itemList;

/// 量化
- (NSArray<FormulaModel *> *)formulaFromElementId:(NSString *)elementId number:(NSInteger)number;

@end

NS_ASSUME_NONNULL_END
