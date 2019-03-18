//
//  YDBaseTableViewCell.m
//  app_ios
//
//  Created by 王远东 on 2019/3/18.
//  Copyright © 2019 王远东. All rights reserved.
//

#import "YDBaseTableViewCell.h"
@interface YDBaseTableViewCell ()

@property (nonatomic, strong) UIView *line;

@end

@implementation YDBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.cellBackgroundView];
        [_cellBackgroundView addSubview:self.line];
        [self buildView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_cellBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cellBackgroundView).offset(16);
        make.bottom.equalTo(self.cellBackgroundView);
        make.right.equalTo(self.cellBackgroundView).offset(-14);
        make.height.mas_equalTo(1);
    }];
}

- (void)bindDataWithViewModel:(id)viewModel {
    
}

- (void)buildView {
    
}

- (void)setCellBackgroundImage:(NSString *)imageName {
    _cellBackgroundView.image = [UIImage imageNamed:imageName];
}

- (UIImageView *)cellBackgroundView {
    if (_cellBackgroundView == nil) {
        _cellBackgroundView = [[UIImageView alloc] init];
        _cellBackgroundView.contentMode = UIViewContentModeScaleAspectFill;
        _cellBackgroundView.userInteractionEnabled = YES;
    }
    return _cellBackgroundView;
}

- (UIView *)line {
    if (_line == nil) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor colorWithHexString:@"E1E1E1"];
    }
    return _line;
}

@end
