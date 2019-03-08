//
//  BHBookListView.h
//  BHBooks
//
//  Created by sunbinhua on 2019/3/8.
//  Copyright © 2019 paidian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^BookListBlock)(NSInteger index);

@interface BHBookListView : UIView
@property (nonatomic, strong) NSArray *list;

@property (nonatomic, copy) BookListBlock selectChapterBlock;
@end

NS_ASSUME_NONNULL_END
