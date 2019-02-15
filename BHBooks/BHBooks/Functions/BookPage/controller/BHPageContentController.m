//
//  BHPageContentController.m
//  BHBooks
//
//  Created by sunbinhua on 2019/2/14.
//  Copyright © 2019 paidian. All rights reserved.
//

#import "BHPageContentController.h"
#import <Masonry/Masonry.h>
#import "BHUIManager.h"
#import "BHBatteryView.h"

@interface BHPageContentController ()

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel *bottomRightLab;
@property (nonatomic, strong) UILabel *bottomLeftLab;
@property (nonatomic, strong) BHBatteryView *batteryView;

@property (nonatomic, assign) NSInteger index;//页数
@property (nonatomic, assign) NSInteger totalPages;//总页数


@end

@implementation BHPageContentController

//控制状态栏是否显示
- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpUI];
    [self setBattery];
}


- (void)setUpUI {
    
    [self.view addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset([BHUIManager statusBarOffset]);
        make.bottom.equalTo(self.view.mas_bottom).offset(-[BHUIManager tabbarHieght]);
    }];
    
    [self.view addSubview:self.bottomLeftLab];
    [self.bottomLeftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.bottom.equalTo(self.view.mas_bottom).offset(-[BHUIManager iphoneXTabrOffset] - 10);
    }];
    
    [self.view addSubview:self.bottomRightLab];
    [self.bottomRightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.bottom.equalTo(self.view.mas_bottom).offset(-[BHUIManager iphoneXTabrOffset] - 10);
    }];
    
    [self.view addSubview:self.batteryView];
    [self.batteryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.top.equalTo(self.view).offset([BHUIManager isIphoneX]?15:10);
        make.width.mas_offset(60);
        make.height.mas_offset(20);
    }];
}

- (void)setBattery {
    
    
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    [[NSNotificationCenter defaultCenter] addObserverForName:UIDeviceBatteryLevelDidChangeNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        CGFloat battery = [UIDevice currentDevice].batteryLevel;
        [self.batteryView runProgress:battery];
    }];
    
    CGFloat battery = [UIDevice currentDevice].batteryLevel;
    [self.batteryView runProgress:battery];
}


#pragma mark - public

- (void)setIndex:(NSInteger)index totalPages:(NSInteger)totalPages {
    index += 1;
    _index = index;
    _totalPages = totalPages;
    
    CGFloat progress = index / (totalPages * 1.0f);
    self.bottomLeftLab.text = [NSString stringWithFormat:@"本章进度%.1lf%%",progress*100];
    self.bottomRightLab.text = [NSString stringWithFormat:@"%ld/%ld",(long)index,(long)totalPages];
    
}


#pragma mark - setter

- (void)setContent:(NSMutableAttributedString *)content {
    _content = content;
    self.textView.attributedText = content;
}

- (void)setText:(NSString *)text {
    _text = text;
    self.textView.text = text;
}


#pragma mark - getter

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.backgroundColor = [UIColor clearColor];
        _textView.editable = NO;
        _textView.scrollEnabled = NO;
        _textView.selectable = NO;
        _textView.textContainerInset = UIEdgeInsetsZero;
    }
    return _textView;
}

- (UILabel *)bottomLeftLab {
    if (!_bottomLeftLab) {
        _bottomLeftLab = [UILabel new];
    }
    return _bottomLeftLab;
}

- (UILabel *)bottomRightLab {
    if (!_bottomRightLab) {
        _bottomRightLab = [UILabel new];
    }
    return _bottomRightLab;
}

- (BHBatteryView *)batteryView {
    if (!_batteryView) {
        _batteryView = [[BHBatteryView alloc] init];
        _batteryView.lineColor = [UIColor grayColor];
        _batteryView.contentColor = [UIColor grayColor];
        _batteryView.warningColor = [UIColor yellowColor];
    }
    return _batteryView;
}

@end
