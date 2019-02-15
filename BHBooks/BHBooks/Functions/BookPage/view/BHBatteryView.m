//
//  BHBatteryView.m
//  BHBooks
//
//  Created by sunbinhua on 2019/2/15.
//  Copyright © 2019 paidian. All rights reserved.
//

#import "BHBatteryView.h"

@implementation BHBatteryView
{
    UIView *batteryView;
    UILabel *batteryLab;
    CAShapeLayer *batteryLayer;
    CAShapeLayer *layer2;
    CGFloat w;
    CGFloat lineW;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
        [self setUpUI];
    }
    return self;
}

- (void)initialize {
    
    _lineColor = [UIColor grayColor];
    _contentColor = _lineColor;
    _warningColor = _lineColor;
}

- (void)setUpUI {
    
    /**
     =======
    ||     ||[]
     =======
     */
    
    //电池的宽度
    w = 25;
    //电池的高度
    CGFloat h = 10;
    //电池的x的坐标
    CGFloat x = 0;
    //电池的y坐标
    CGFloat y = 0;
    //电池的线宽
    lineW = 1;
    
    //绘制电池
    UIBezierPath *path1 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(x, y, w, h) cornerRadius:2];
    batteryLayer = [CAShapeLayer layer];
    batteryLayer.lineWidth = lineW;
    batteryLayer.strokeColor = _lineColor.CGColor;
    batteryLayer.fillColor = [UIColor clearColor].CGColor;
    batteryLayer.path = [path1 CGPath];
    [self.layer addSublayer:batteryLayer];
    
    
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(x+w+1, y+h/3)];
    [path2 addLineToPoint:CGPointMake(x+w+1, y+h*2/3)];
    layer2 = [CAShapeLayer layer];
    layer2.lineWidth = 2;
    layer2.strokeColor = _lineColor.CGColor;
    layer2.fillColor = [UIColor clearColor].CGColor;
    layer2.path = [path2 CGPath];
    [self.layer addSublayer:layer2];
    
    batteryView = [[UIView alloc] initWithFrame:CGRectMake(x+1, y+lineW, 0, h - lineW*2)];
    batteryView.layer.cornerRadius = 1;
    batteryView.backgroundColor = self.contentColor;
    [self addSubview:batteryView];
    
    batteryLab = [[UILabel alloc] initWithFrame:CGRectMake(x+w+5, y, 30, h)];
    batteryLab.textColor = _lineColor;
    batteryLab.textAlignment = NSTextAlignmentLeft;
    batteryLab.font = [UIFont systemFontOfSize:10];
    [self addSubview:batteryLab];
    
    
}

- (void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
    
    batteryLayer.strokeColor = _lineColor.CGColor;
    layer2.strokeColor = _lineColor.CGColor;
    batteryLab.textColor = _lineColor;
}

- (void)runProgress:(CGFloat)progressValue {
    
    CGRect frame = batteryView.frame;
    frame.size.width = (progressValue * (w-lineW*2));
    batteryView.frame = frame;
    
    batteryLab.text = [[NSString stringWithFormat:@"%.f",progressValue*100] stringByAppendingString:@"%"];
    
    if (progressValue<0.1) {
        batteryView.backgroundColor = self.warningColor;
    }else{
        batteryView.backgroundColor = self.contentColor;
    }
    
    
}

@end
