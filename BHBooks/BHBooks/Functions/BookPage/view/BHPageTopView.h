//
//  BHPageTopView.h
//  BHBooks
//
//  Created by sunbinhua on 2019/3/7.
//  Copyright © 2019 paidian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^Block)(UIButton *btn);

@interface BHPageTopView : UIView
@property (nonatomic, copy) Block backBlock;
@end

NS_ASSUME_NONNULL_END
