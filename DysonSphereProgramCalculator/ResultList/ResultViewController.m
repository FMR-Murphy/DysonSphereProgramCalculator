//
//  ResultViewController.m
//  DysonSphereProgramCalculator
//
//  Created by Murphy on 2022/3/31.
//

#import "ResultViewController.h"
#import "ElementModel.h"
#import "FormulaTableViewCell.h"
#import <Masonry/Masonry.h>
#import <ReactiveObjC/ReactiveObjC.h>
@interface ResultViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UITableView *tableView;

@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
    [self bindSignal];
}

- (void)bindSignal {
    @weakify(self);
    [[[[[RACObserve(self, formulaList) distinctUntilChanged] filter:^BOOL(id  _Nullable value) {
        return value;
    }] takeUntil:self.rac_willDeallocSignal] deliverOnMainThread] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        NSLog(@"%@",[x yy_modelToJSONObject]);
        [self.tableView reloadData];
    }];
}

#pragma mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.formulaList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FormulaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FormulaTableViewCell class])];
    
    cell.formulaModel = self.formulaList[indexPath.row];
    return cell;
}

#pragma mark - UI
- (void)createUI {
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuideBottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    [self.scrollView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.height.equalTo(self.scrollView);
        make.width.equalTo(@(800));
    }];
}

#pragma mark - lazy
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
    }
    return _scrollView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[FormulaTableViewCell class] forCellReuseIdentifier:NSStringFromClass([FormulaTableViewCell class])];
        _tableView.rowHeight = 50;
    }
    return _tableView;
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
