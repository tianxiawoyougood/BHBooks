//
//  BHBookShelfDecorationView.m
//  BHBooks
//
//  Created by sunbinhua on 2019/2/12.
//  Copyright © 2019 paidian. All rights reserved.
//

#import "BHBookShelfDecorationView.h"

@interface BHBookShelfDecorationView ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation BHBookShelfDecorationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, frame.size.width - 20, frame.size.height - 20)];
        UIImage *image = [UIImage imageNamed:@"BookShelfCell"];
        _imageView.image = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
        [self addSubview:_imageView];
        
    }
    return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    
    _imageView.frame = CGRectMake(10, 10, layoutAttributes.frame.size.width - 20, layoutAttributes.frame.size.height - 20);
}

@end
