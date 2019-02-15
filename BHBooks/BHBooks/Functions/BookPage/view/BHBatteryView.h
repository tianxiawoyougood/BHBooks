//
//  BHBatteryView.h
//  BHBooks
//
//  Created by sunbinhua on 2019/2/15.
//  Copyright © 2019 paidian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BHBatteryView : UIView
@property (nonatomic, strong) UIColor *contentColor;//电池的填充颜色
@property (nonatomic, strong) UIColor *warningColor;// 低电量时的填充颜色
@property (nonatomic, strong) UIColor *lineColor;//电池边框的颜色

- (void)runProgress:(CGFloat)progressValue;

@end

NS_ASSUME_NONNULL_END
