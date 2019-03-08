//
//  BHPageTopView.m
//  BHBooks
//
//  Created by sunbinhua on 2019/3/7.
//  Copyright © 2019 paidian. All rights reserved.
//

#import "BHPageTopView.h"
#import <Masonry/Masonry.h>
#import "BHUIManager.h"

@interface BHPageTopView ()
@property (nonatomic, strong) UIButton *backBtn;
@end

@implementation BHPageTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor darkGrayColor];
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    [self addSubview:self.backBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.backBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10*kDesignScaleXForIP6);
        make.top.equalTo(self).offset(4 + [BHUIManager statusBarOffset]);
    }];
}

- (void)back:(UIButton *)sender {
    if (self.backBlock) {
        self.backBlock(sender);
    }
}


#pragma mark - getter

- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

@end
