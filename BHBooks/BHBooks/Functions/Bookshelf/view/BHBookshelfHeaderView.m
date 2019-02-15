//
//  BHBookshelfHeaderView.m
//  BHBooks
//
//  Created by sunbinhua on 2019/2/15.
//  Copyright © 2019 paidian. All rights reserved.
//

#import "BHBookshelfHeaderView.h"
#import <Masonry/Masonry.h>

NSString *const kBHBookshelfHeaderViewId = @"kBHBookshelfHeaderViewId";

@interface BHBookshelfHeaderView ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation BHBookshelfHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    [self addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}


#pragma mark - getter

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.image = [UIImage imageNamed:@"icon_bookshelf_wood1"];
    }
    return _imageView;
}

@end
