//
//  ElementModel.h
//  DysonSphereProgramCalculator
//
//  Created by Murphy on 2022/3/24.
//

/**
 制作             产量 * 工具效率
 产量 / min = number / duration * 60
 工具效率 = tool.efficiency
 
 关于使用增产剂
 是否使用增产剂及使用模式，属于生产工具的属性。
 使用增产后，耗电功率 * 1.5
 
 增产模式
 公式原料需要数量不变
 产出 = 公式效率 * 工具效率 * 1.25
 
 加速模式
 公式原料需要数量 * 2
 产出 = 公式效率 * 工具效率 * 2
 
 采集             产量 * 工具效率 * 簇数 * 科技效率（矿物利用）
 采矿             产量为30 / min，采矿机效率为1，大型采矿机效率为2，
 水、硫酸       产量为50 / min，抽水机效率为1
 
 气巨、冰巨、原油  产量，按实际游戏中填写。
 产量 = 1 / 1 * 60 * 矿脉（行星参数）
 初始值为1秒1个，乘上参数之后为正确数值
 */

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

// 物品id
typedef NSString * ElementId;
// 公式id
typedef NSString * FormulaId;
// 原矿，矿物采集公式中，采集产物的通用id
static NSString *const RawOreId = @"RawOre";

/// 原料 | 产物
@interface IngredientModel : NSObject

// 物品 id
@property (nonatomic) ElementId elementId;
// 数量
@property (nonatomic) NSUInteger number;

@end


/// 生产公式
@interface FormulaModel : NSObject

@property (nonatomic) FormulaId formulaId;
/// 生产工具
@property (nonatomic) NSArray<ElementId> * tool;
/// 当前使用的工具index，默认0
@property (nonatomic) NSUInteger currToolIndex;
/// 配方名
@property (nonatomic) NSString * name;
/// 原料
@property (nonatomic) NSArray<IngredientModel *> * ingredients;
/// 产出
@property (nonatomic) NSArray<IngredientModel *> * products;

/// 需要时间(秒)
@property (nonatomic) NSUInteger duration;
/// 产出数量
@property (nonatomic) NSUInteger number;

@end

// 组件|建筑 模型
@interface ElementModel : NSObject

@property (nonatomic) ElementId eleId;
/// 名称
@property (nonatomic) NSString * name;
/// 图标名
@property (nonatomic) NSString * iconName;
/// 合成公式
@property (nonatomic) NSArray<FormulaId> * formulas;
/// 当前使用的公式index
@property (nonatomic) NSUInteger currFormulaIndex;

// 建筑属性
/// 耗电
@property (nonatomic) float power;
/// 待机耗电
@property (nonatomic) float standbyPower;
/// 效率 制作台属性
@property (nonatomic) float efficiency;


@end

NS_ASSUME_NONNULL_END
