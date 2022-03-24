//
//  ElementModel.h
//  DysonSphereProgramCalculator
//
//  Created by Murphy on 2022/3/24.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

typedef NSString * ElementId;

/// 公式成份
@interface IngredientModel : NSObject

// 元素id
@property (nonatomic) ElementId elementId;
// 需要数量
@property (nonatomic) NSUInteger number;

@end
 
/// 生产公式
@interface FormulaModel : NSObject

// 生产工具
@property (nonatomic) ElementId tool;
// 公式
@property (nonatomic) NSArray<IngredientModel *> * formulas;
// 需要时间(秒)
@property (nonatomic) NSUInteger duration;
// 产出数量
@property (nonatomic) NSUInteger number;

@end

// 组件|建筑 模型
@interface ElementModel : NSObject

@property (nonatomic) ElementId eleId;
// 名称
@property (nonatomic) NSString * name;

// 合成公式
@property (nonatomic) NSArray<FormulaModel *> * formulas;

// 建筑属性
// 耗电
@property (nonatomic) float power;

// 待机耗电
@property (nonatomic) float standbyPower;

// 效率 制作台属性
@property (nonatomic) float efficiency;

@end

NS_ASSUME_NONNULL_END
