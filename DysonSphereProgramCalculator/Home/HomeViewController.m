//
//  HomeViewController.m
//  example-OC
//
//  Created by Murphy on 2022/3/23.
//

#import "HomeViewController.h"

#import "CalculatorViewModel.h"
#import "SelectListViewController.h"
#import "ResultViewController.h"
#import "ElementModel.h"

#import <ReactiveObjC/ReactiveObjC.h>
#import <Masonry/Masonry.h>

@interface HomeViewController ()

@property (nonatomic) CalculatorViewModel *viewModel;
/// 选择目标产物
@property (nonatomic) UIButton *selectButton;
/// 目标数量
@property (nonatomic) UITextField *numberTextField;
/// 计算
@property (nonatomic) UIButton *resultButton;
/// 目标产物
@property (nonatomic) ElementModel *targetElement;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
    [self bindSingal];
}

- (void)bindSingal {
    @weakify(self);
    [[[self.selectButton rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        SelectListViewController *listVC = [[SelectListViewController alloc] init];
        listVC.itemList = self.viewModel.itemList;
        listVC.targetElementBlock = ^(ElementModel * _Nonnull targetElement) {
            @strongify(self);
            self.targetElement = targetElement;
        };
        [self.navigationController pushViewController:listVC animated:YES];
    }];
    
    [[[[RACObserve(self, targetElement) distinctUntilChanged] takeUntil:self.rac_willDeallocSignal] filter:^BOOL(id  _Nullable value) {
        return value;
    }] subscribeNext:^(ElementModel * _Nullable x) {
        @strongify(self);
        [self.selectButton setTitle:x.name forState:UIControlStateNormal];
        [self.selectButton setImage:[UIImage imageNamed:x.iconName] forState:UIControlStateNormal];
    }];
    
    [[[self.resultButton rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        NSInteger number = self.numberTextField.text.integerValue;
        NSString *alertMessage;
        if (number <= 0) {
            alertMessage = @"需要输入生产数量/min";
        }
        if (!self.targetElement) {
            alertMessage = @"先选择生产目标";
        }
        if (alertMessage.length > 0) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:alertMessage preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
        ResultViewController *resultVC = [[ResultViewController alloc] init];
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            resultVC.formulaList = [self.viewModel formulaFromElementId:self.targetElement.eleId number:number];
        });
        [self.navigationController pushViewController:resultVC animated:YES];
    }];
}

- (void)createUI {
    [self.view addSubview:self.selectButton];
    [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.right.equalTo(@-20);
        make.top.equalTo(self.mas_topLayoutGuideBottom).offset(50);
        make.height.equalTo(@30);
    }];
    
    [self.view addSubview:self.numberTextField];
    [self.numberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.selectButton);
        make.top.equalTo(self.selectButton.mas_bottom).offset(30);
        make.height.equalTo(@30);
    }];
    
    [self.view addSubview:self.resultButton];
    [self.resultButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.selectButton);
        make.top.equalTo(self.numberTextField.mas_bottom).offset(30);
        make.height.equalTo(@50);
    }];
}

- (CalculatorViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[CalculatorViewModel alloc] init];
    }
    return _viewModel;
}

- (UIButton *)selectButton {
    if (!_selectButton) {
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectButton.titleLabel.font = [UIFont systemFontOfSize:18];
        [_selectButton setTitle:@"选择生产目标" forState:UIControlStateNormal];
        [_selectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _selectButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _selectButton.backgroundColor = [UIColor redColor];
    }
    return _selectButton;
}

- (UITextField *)numberTextField {
    if (!_numberTextField) {
        _numberTextField = [[UITextField alloc] init];
        _numberTextField.keyboardType = UIKeyboardTypeNumberPad;
        _numberTextField.placeholder = @"输入生产数量/min";
    }
    return _numberTextField;
}

- (UIButton *)resultButton {
    if (!_resultButton) {
        _resultButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _resultButton.titleLabel.font = [UIFont systemFontOfSize:18];
        [_resultButton setTitle:@"计算" forState:UIControlStateNormal];
        [_resultButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _resultButton;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
