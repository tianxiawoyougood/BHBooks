//
//  BHUIManager.m
//  BHBooks
//
//  Created by sunbinhua on 2019/2/15.
//  Copyright © 2019 paidian. All rights reserved.
//

#import "BHUIManager.h"

@implementation BHUIManager

+ (BOOL)isIphoneX{
    if (kScreenHeight == 812 || kScreenHeight == 896) {
        return YES;
    }else{
        return NO;
    }
}

+ (CGFloat)navigationBarHeight{
    if ([BHUIManager isIphoneX]) {
        return 88;
    }else{
        return 64;
    }
}

+ (CGFloat)tabbarHieght{
    if ([BHUIManager isIphoneX]) {
        return 83;
    }else{
        return 49;
    }
}

+ (CGFloat)iphoneXTabrOffset{
    if ([BHUIManager isIphoneX]) {
        return 34;
    }else{
        return 0;
    }
}

+ (CGFloat)iphoneXNavgationBarOffset{
    if ([BHUIManager isIphoneX]) {
        return 24;
    }else{
        return 0;
    }
}

+ (CGFloat)statusBarOffset {
    if ([BHUIManager isIphoneX]) {
        return 44;
    }else {
        return 20;
    }
}

@end
