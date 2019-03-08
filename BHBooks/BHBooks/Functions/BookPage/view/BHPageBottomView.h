//
//  BHPageBottomView.h
//  BHBooks
//
//  Created by sunbinhua on 2019/3/7.
//  Copyright © 2019 paidian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, BHSetupFontType) {
    BHSetupFontTypeAdd,
    BHSetupFontTypeSubtract,
};
typedef void(^Block)(UIButton *sender);
typedef void(^FontBlock)(BHSetupFontType type);

@interface BHPageBottomView : UIView

@property (nonatomic, copy) Block listBlock;
@property (nonatomic, copy) Block readModelBlock;
@property (nonatomic, copy) FontBlock setupFontBlock;

@end

NS_ASSUME_NONNULL_END
