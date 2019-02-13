//
//  BHBookCell.h
//  BHBooks
//
//  Created by sunbinhua on 2019/2/12.
//  Copyright © 2019 paidian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BHBook.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString * const kBookCellID;

@interface BHBookCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UIImageView *bookImgView;
@property (nonatomic, strong) BHBook *book;

@end

NS_ASSUME_NONNULL_END
