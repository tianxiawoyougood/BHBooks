//
//  BHUIManager.h
//  BHBooks
//
//  Created by sunbinhua on 2019/2/15.
//  Copyright © 2019 paidian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>


#define kScreenWidth                       (CGRectGetWidth([[UIScreen mainScreen] bounds]))
#define kScreenHeight                      (CGRectGetHeight([[UIScreen mainScreen] bounds]))
#define kScreenScale  [[UIScreen mainScreen] scale]

#define kDesignScaleXForIP6 ([UIScreen mainScreen].bounds.size.width / 375.0)
#define kDesignScaleYForIP6 ([UIScreen mainScreen].bounds.size.height / 667.0)

#define kDesignScaleXForIP6Plus ([UIScreen mainScreen].bounds.size.width / 414.0)
#define kDesignScaleYForIP6Plus ([UIScreen mainScreen].bounds.size.height / 736.0)

NS_ASSUME_NONNULL_BEGIN

@interface BHUIManager : NSObject

+ (BOOL)isIphoneX;

//导航栏的高度
+(CGFloat)navigationBarHeight;
//tabbar的高度
+(CGFloat)tabbarHieght;
//tabbar的差
+(CGFloat)iphoneXTabrOffset;
//导航栏的差
+(CGFloat)iphoneXNavgationBarOffset;
//状态条的差
+ (CGFloat)statusBarOffset;

@end

NS_ASSUME_NONNULL_END
