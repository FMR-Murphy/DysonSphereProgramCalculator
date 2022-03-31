//
//  SelectListViewController.h
//  DysonSphereProgramCalculator
//
//  Created by Murphy on 2022/3/31.
//

#import <UIKit/UIKit.h>
@class  ElementModel;

NS_ASSUME_NONNULL_BEGIN

@interface SelectListViewController : UIViewController

/// 物品列表
@property (nonatomic) NSArray<ElementModel *> *itemList;

@property (nonatomic) void(^targetElementBlock)(ElementModel *targetElement);

@end

NS_ASSUME_NONNULL_END
