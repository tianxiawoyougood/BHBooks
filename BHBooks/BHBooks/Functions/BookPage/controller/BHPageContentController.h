//
//  BHPageContentController.h
//  BHBooks
//
//  Created by sunbinhua on 2019/2/14.
//  Copyright © 2019 paidian. All rights reserved.
//

#import "BHBaseController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BHPageContentController : BHBaseController

@property (nonatomic, copy) NSMutableAttributedString *content;//内容
@property (nonatomic, copy) NSString *text;



@end

NS_ASSUME_NONNULL_END
