//
//  BHPageBottomView.m
//  BHBooks
//
//  Created by sunbinhua on 2019/3/7.
//  Copyright © 2019 paidian. All rights reserved.
//

#import "BHPageBottomView.h"
#import "BHUIManager.h"

@interface BHPageBottomView ()
@property (nonatomic, strong) UIButton *listBtn;
@property (nonatomic, strong) UIButton *nightModelBtn;
@property (nonatomic, strong) UIButton *fontAddBtn;
@property (nonatomic, strong) UIButton *fontSubtractBtn;
@end

@implementation BHPageBottomView

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
    
    [self addSubview:self.listBtn];
    [self addSubview:self.nightModelBtn];
    [self addSubview:self.fontAddBtn];
    [self addSubview:self.fontSubtractBtn];
    
    CGFloat w = 25;
    CGFloat h = w;
    CGFloat y = 20;
    CGFloat distance = (kScreenWidth - 15*kDesignScaleXForIP6 * 2 - 25 * 4) / 3;
    
    self.listBtn.frame = CGRectMake(15*kDesignScaleXForIP6, y, w, h);
    self.nightModelBtn.frame = CGRectMake(CGRectGetMaxX(self.listBtn.frame) + distance, y, w, h);
    self.fontAddBtn.frame = CGRectMake(CGRectGetMaxX(self.nightModelBtn.frame) + distance, y, w, h);
    self.fontSubtractBtn.frame = CGRectMake(CGRectGetMaxX(self.fontAddBtn.frame) + distance, y, w, h);
}

// 目录
- (void)list:(UIButton *)sender {
    if (self.listBlock) {
        self.listBlock(sender);
    }
}

//夜间模式
- (void)night:(UIButton*)sender {
    if (self.readModelBlock) {
        self.readModelBlock(sender);
    }
}

//增大字号
- (void)fontAdd:(UIButton*)sender {
    if (self.setupFontBlock) {
        self.setupFontBlock(BHSetupFontTypeAdd);
    }
}

//减小字号
- (void)fontSubtract:(UIButton *)sender {
    if (self.setupFontBlock) {
        self.setupFontBlock(BHSetupFontTypeSubtract);
    }
}

#pragma mark - getter

- (UIButton *)listBtn {
    if (!_listBtn) {
        _listBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_listBtn setImage:[UIImage imageNamed:@"list"] forState:UIControlStateNormal];
        [_listBtn addTarget:self action:@selector(list:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _listBtn;
}

- (UIButton *)nightModelBtn {
    if (!_nightModelBtn) {
        _nightModelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nightModelBtn setImage:[UIImage imageNamed:@"default"] forState:UIControlStateNormal];
        [_listBtn addTarget:self action:@selector(night:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nightModelBtn;
}

- (UIButton *)fontAddBtn {
    if (!_fontAddBtn) {
        _fontAddBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fontAddBtn setTitle:@"A+" forState:UIControlStateNormal];
        [_listBtn addTarget:self action:@selector(fontAdd:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fontAddBtn;
}

- (UIButton *)fontSubtractBtn {
    if (!_fontSubtractBtn) {
        _fontSubtractBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fontSubtractBtn setTitle:@"A-" forState:UIControlStateNormal];
        [_listBtn addTarget:self action:@selector(fontSubtract:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fontSubtractBtn;
}


@end
