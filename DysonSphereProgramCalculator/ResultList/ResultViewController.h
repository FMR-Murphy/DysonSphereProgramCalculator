//
//  ResultViewController.h
//  DysonSphereProgramCalculator
//
//  Created by Murphy on 2022/3/31.
//

#import <UIKit/UIKit.h>

@class FormulaModel;

NS_ASSUME_NONNULL_BEGIN

@interface ResultViewController : UIViewController

@property (nonatomic) NSArray<FormulaModel *> * formulaList;

@end

NS_ASSUME_NONNULL_END
