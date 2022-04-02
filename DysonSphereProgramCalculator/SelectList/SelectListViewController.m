//
//  SelectListViewController.m
//  DysonSphereProgramCalculator
//
//  Created by Murphy on 2022/3/31.
//

#import "SelectListViewController.h"
#import "ElementModel.h"
#import <Masonry/Masonry.h>
#import <ReactiveObjC/ReactiveObjC.h>

static NSString *const TableViewCellIdentifier = @"TableViewCellIdentifier";

@interface SelectListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) UITableView *tableView;

@end

@implementation SelectListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
    [self bindSignal];
}

- (void)bindSignal {
    @weakify(self);
    [[[[RACObserve(self, itemList) distinctUntilChanged] takeUntil:self.rac_willDeallocSignal] filter:^BOOL(id  _Nullable value) {
        return value;
    }] subscribeNext:^(NSArray<ElementModel *> * _Nullable x) {
        @strongify(self);
        [self.tableView reloadData];
    }];
}

#pragma mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableViewCellIdentifier];
    ElementModel *model = self.itemList[indexPath.row];
    
    UIListContentConfiguration *configuration = [UIListContentConfiguration cellConfiguration];
    configuration.image = [UIImage imageNamed:model.iconName];
    configuration.text = model.name;
    
    cell.contentConfiguration = configuration;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.targetElementBlock(self.itemList[indexPath.row]);
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UI
- (void)createUI {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.rowHeight = 50;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:TableViewCellIdentifier];
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
