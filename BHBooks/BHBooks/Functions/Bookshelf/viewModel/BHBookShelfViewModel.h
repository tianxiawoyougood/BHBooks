//
//  BHBookShelfViewModel.h
//  BHBooks
//
//  Created by sunbinhua on 2019/2/12.
//  Copyright © 2019 paidian. All rights reserved.
//

#import "BHBaseViewModel.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class BHBookShelfController;
@interface BHBookShelfViewModel : BHBaseViewModel<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, weak) BHBookShelfController *bookShelfController;

@end

NS_ASSUME_NONNULL_END
