//
//  FormulaTableViewCell.m
//  DysonSphereProgramCalculator
//
//  Created by Murphy on 2022/4/1.
//

#import "FormulaTableViewCell.h"
#import "ElementModel.h"
#import <Masonry/Masonry.h>

@interface FormulaTableViewCell ()

@property (nonatomic) UIImageView *productImageView;
@property (nonatomic) UILabel *numberLabel;
@property (nonatomic) UIImageView *toolImageView;
@property (nonatomic) UILabel *toolNumberLabel;


@end

@implementation FormulaTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self createUI];
}

- (void)createUI {
    [self.contentView addSubview:self.productImageView];
    [self.productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.width.height.equalTo(@40);
        make.centerY.equalTo(self.contentView);
    }];
    [self.contentView addSubview:self.numberLabel];
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.productImageView.mas_right).offset(20);
        make.centerY.equalTo(self.contentView);
        make.width.equalTo(@80);
    }];
    [self.contentView addSubview:self.toolImageView];
    [self.toolImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.numberLabel.mas_right).offset(20);
        make.centerY.equalTo(self.contentView);
        make.width.height.equalTo(@40);
    }];
    [self.contentView addSubview:self.toolNumberLabel];
    [self.toolNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.toolImageView.mas_right).offset(20);
        make.centerY.equalTo(self.contentView);
        make.width.equalTo(@80);
    }];
}

- (void)setFormulaModel:(FormulaModel *)formulaModel {
    _formulaModel = formulaModel;
    self.productImageView.image = [UIImage imageNamed:formulaModel.targetProduct.iconName];
    self.numberLabel.text = [NSString stringWithFormat:@"%.2f", self.formulaModel.targetNumber];
    self.toolImageView.image = [UIImage imageNamed:formulaModel.tool[formulaModel.currToolIndex].iconName];
    self.toolNumberLabel.text = [NSString stringWithFormat:@"%.2f", self.formulaModel.toolNumber];
}

#pragma mark - lazy
- (UIImageView *)productImageView {
    if (!_productImageView) {
        _productImageView = [[UIImageView alloc] init];
        _productImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _productImageView;
}

- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc] init];
        _numberLabel.minimumScaleFactor = 0.8;
        _numberLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _numberLabel;
}

- (UIImageView *)toolImageView {
    if (!_toolImageView) {
        _toolImageView = [[UIImageView alloc] init];
        _toolImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _toolImageView;
}

- (UILabel *)toolNumberLabel {
    if (!_toolNumberLabel) {
        _toolNumberLabel = [[UILabel alloc] init];
        _toolNumberLabel.minimumScaleFactor = 0.8;
        _toolNumberLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _toolNumberLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
