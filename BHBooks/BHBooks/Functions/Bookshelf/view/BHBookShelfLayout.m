//
//  BHBookShelfLayout.m
//  BHBooks
//
//  Created by sunbinhua on 2019/2/12.
//  Copyright © 2019 paidian. All rights reserved.
//

#import "BHBookShelfLayout.h"
#import "BHBookShelfDecorationView.h"

@implementation BHBookShelfLayout

- (void)prepareLayout {
    
    [super prepareLayout];
    
    [self registerClass:[BHBookShelfDecorationView class] forDecorationViewOfKind:@"BHBookShelfDecorationView"];
}

//返回给定矩形中所有视图的数组布局属性
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *superAttrs = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray *attrs = [NSMutableArray arrayWithArray:superAttrs];

    for (UICollectionViewLayoutAttributes *attr in superAttrs) {
        if (attr.representedElementKind == nil) {
            if (attr.indexPath.row % 3 == 0) {
                [attrs addObject:[self layoutAttributesForDecorationViewOfKind:@"BHBookShelfDecorationView" atIndexPath:attr.indexPath top:attr.frame.origin.y]];
            }
        }
    }

    return attrs;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)elementKind atIndexPath:(nonnull NSIndexPath *)indexPath top:(CGFloat)top {
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:elementKind withIndexPath:indexPath];
    
    CGFloat cellHeight = self.itemSize.height;
    CGFloat cellSpace = self.minimumLineSpacing;

          
    CGFloat height = cellHeight + cellSpace;
    
    attributes.frame = CGRectMake(0, top, [UIScreen mainScreen].bounds.size.width, height);
    attributes.zIndex = -1;//层级。cell默认是0
    
    return attributes;
}

@end
