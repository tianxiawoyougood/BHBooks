//
//  BHBookManager.m
//  BHBooks
//
//  Created by sunbinhua on 2019/2/12.
//  Copyright © 2019 paidian. All rights reserved.
//

#import "BHBookManager.h"

@implementation BHBookManager

+ (instancetype)shareInstance {
    
    static BHBookManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[BHBookManager alloc] init];
    });
    
    return manager;
}


@end
