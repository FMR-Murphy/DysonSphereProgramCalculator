//
//  FormulaTableViewCell.h
//  DysonSphereProgramCalculator
//
//  Created by Murphy on 2022/4/1.
//

#import <UIKit/UIKit.h>

@class FormulaModel;

NS_ASSUME_NONNULL_BEGIN

@interface FormulaTableViewCell : UITableViewCell

@property (nonatomic) FormulaModel *formulaModel;

@end

NS_ASSUME_NONNULL_END
