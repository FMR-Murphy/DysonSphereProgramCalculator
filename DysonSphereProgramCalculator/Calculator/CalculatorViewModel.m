//
//  CalculatorViewModel.m
//  DysonSphereProgramCalculator
//
//  Created by Murphy on 2022/3/30.
//

#import "CalculatorViewModel.h"

#import "ElementModel.h"

#import <YYModel/YYmodel.h>

@interface CalculatorViewModel ()

/// 物品列表
@property (nonatomic) NSArray<ElementModel *> *itemList;

/// 物品字典
@property (nonatomic) NSDictionary<ElementId, ElementModel *> * elementDic;
/// 公式字典
@property (nonatomic) NSDictionary<FormulaId, FormulaModel *> * formulaDic;
@end

@implementation CalculatorViewModel

- (instancetype)init {
    if (self == [super init]) {
        
    }
    return self;
}

- (NSArray<FormulaModel *> *)formulaFromElementId:(NSString *)elementId number:(NSInteger)number {
    ElementModel *model = [self.elementDic valueForKey:elementId];
    
    NSMutableArray<FormulaModel *> *mArray = [NSMutableArray array];
    
    // 获取当前选中的配方
    FormulaModel *formula = [self.formulaDic valueForKey:model.formulas[model.currFormulaIndex]];
    formula.targetProduct = model;
    formula.targetNumber = number;
    
    // 添加到数组中
    [mArray addObject:formula];
    
    // 递归，获取原料的数据
    [formula.ingredients enumerateObjectsUsingBlock:^(IngredientModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // (formula.toolNumber * obj.number) 原料需要的 产量 / min
//        NSArray *array = [self formulaFromElementId:obj.elementId number:(formula.targetNumber /formula.number * obj.number)];
        
        [mArray addObjectsFromArray:[self formulaFromElementId:obj.elementId number:(formula.targetNumber /formula.number * obj.number)]];
        NSLog(@"%@",[mArray yy_modelToJSONObject]);
    }];
//    // 递归，获取原料的数据
//    for (IngredientModel *ingredient in formula.ingredients) {
//        // (formula.toolNumber * obj.number) 原料需要的 产量 / min
//        NSArray *array = [self formulaFromElementId:ingredient.elementId number:(formula.targetNumber /formula.number * ingredient.number)];
//        [mArray addObjectsFromArray:array];
//    }
    return [mArray copy];
}



#pragma mark - lazy
- (NSArray<ElementModel *> *)itemList {
    if (!_itemList) {
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"Resources" withExtension:@"plist"]];
        __block NSMutableArray * array = [NSMutableArray array];
        [[self listArray] enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ElementModel *model = [ElementModel yy_modelWithDictionary:[dic valueForKey:obj]];
            [array addObject:model];
        }];
        _itemList = [array copy];
    }
    return _itemList;
}

- (NSDictionary<ElementId,ElementModel *> *)elementDic {
    if (!_elementDic) {
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"Resources" withExtension:@"plist"]];
        __block NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
        [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [mdic setValue:[ElementModel yy_modelWithDictionary:obj] forKey:key];
        }];
        _elementDic = [mdic copy];
    }
    return _elementDic;
}

- (NSDictionary<FormulaId,FormulaModel *> *)formulaDic {
    if (!_formulaDic) {
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"FormulaList" withExtension:@"plist"]];
        __block NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
        [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [mdic setValue:[FormulaModel yy_modelWithDictionary:obj] forKey:key];
        }];
        _formulaDic = [mdic copy];
    }
    return _formulaDic;
}

- (NSArray<NSString *> *)listArray {
    return @[
        @"ore_0105",
        @"ore_0106",
        @"ore_0107",
        @"ore_0200",
        @"item_0001",
        @"item_0002",
        @"item_0003",
        @"item_0004",
        @"item_0005",
        @"item_0006",
        @"item_0007",
        @"item_0008",
        @"item_0009",
        @"item_0010",
        @"item_0011",
        @"item_0012",
        @"item_0013",
        @"item_0014",
        @"item_0015",
        @"item_0016",
        @"item_0017",
        @"item_0018",
        @"item_0019",
        @"item_0020",
        @"item_0021",
        @"item_0022",
        @"item_0023",
        @"item_0024",
        @"item_0025",
        @"item_0026",
        @"item_0027",
        @"item_0028",
        @"item_0029",
        @"item_0030",
        @"item_0031",
        @"item_0032",
        @"item_0033",
        @"item_0034",
        @"item_0035",
        @"item_0036",
        @"item_0037",
        @"item_0038",
        @"item_0039",
        @"item_0040",
        @"item_0041",
        @"item_0042",
        @"item_0100",
        @"item_0101",
        @"item_0102",
        @"item_0200",
        @"item_0201",
        @"item_0202",
        @"item_0203",
        @"item_0300",
        @"item_0301",
        @"item_0302",
        @"item_0303",
        @"item_0400",
        @"item_0401",
        @"matrix_0001",
        @"matrix_0002",
        @"matrix_0003",
        @"matrix_0004",
        @"matrix_0005",
        @"matrix_0006",
        @"building_0001",
        @"building_0002",
        @"building_0003",
        @"building_0004",
        @"building_0005",
        @"building_0006",
        @"building_0007",
        @"building_0008",
        @"building_0009",
        @"building_0010",
        @"building_0100",
        @"building_0101",
        @"building_0102",
        @"building_0103",
        @"building_0200",
        @"building_0201",
        @"building_0202",
        @"building_0203",
        @"building_0204",
        @"building_0205",
        @"building_0206",
        @"building_0207",
        @"building_0208",
        @"building_0300",
        @"building_0301",
        @"building_0302",
        @"building_0400",
        @"building_0401",
        @"building_0402",
        @"building_0403",
        @"building_0404",
        @"building_0405",
        @"building_0406",
        @"building_0407",
        @"building_0408",
        @"building_0409",
        @"building_0410",
        @"building_0411",
        @"building_0412",
        @"building_0413",
        @"building_0500",
        @"building_0600",
        @"building_0601",
        @"building_0602",
        @"building_0603",
    ];
}

@end
