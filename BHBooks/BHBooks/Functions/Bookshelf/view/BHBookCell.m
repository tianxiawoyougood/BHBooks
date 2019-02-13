//
//  BHBookCell.m
//  BHBooks
//
//  Created by sunbinhua on 2019/2/12.
//  Copyright © 2019 paidian. All rights reserved.
//

#import "BHBookCell.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>

NSString * const kBookCellID    = @"kBookCellID";

@implementation BHBookCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    
    [self.contentView addSubview:self.bookImgView];
    [self.bookImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
    }];
}


#pragma mark - setter

- (void)setBook:(BHBook *)book {
    _book = book;
    
    [self.bookImgView sd_setImageWithURL:[NSURL URLWithString:book.imageURL] placeholderImage:[UIImage imageNamed:@"1"]];
    self.nameLab.text = book.name;
}


#pragma mark - getter

- (UIImageView *)bookImgView {
    if (!_bookImgView) {
        _bookImgView = [UIImageView new];
    }
    return _bookImgView;
}

- (UILabel *)nameLab {
    if (!_nameLab) {
        _nameLab = [UILabel new];
        
    }
    return _nameLab;
}

@end
