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

- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)elementKind atIndexPath:(nonnull NSIndexPath *)indexPath top:(CGFloat)top{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:elementKind withIndexPath:indexPath];
    
    NSUInteger numberOfItems = [self.collectionView numberOfItemsInSection:indexPath.section];
    int itemsPerRow = 3;
    NSUInteger rows = (numberOfItems + itemsPerRow -1) / itemsPerRow;
    CGFloat cellHeight = 80;
    CGFloat cellSpace = 20;
    CGFloat headerHeight = 90;
    CGFloat footerHeight = 70;
    
    CGFloat height = headerHeight + cellHeight * rows + cellSpace * (rows - 1) + footerHeight;
    
    attributes.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, height);
    attributes.zIndex = -1;
    
    return attributes;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *superAttrs = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray *attrs = [NSMutableArray arrayWithArray:superAttrs];
    
    for (UICollectionViewLayoutAttributes *attr in superAttrs) {
        if (attr.representedElementKind == UICollectionElementKindSectionHeader) {
            [attrs addObject:[self layoutAttributesForDecorationViewOfKind:@"BHBookShelfDecorationView" atIndexPath:attr.indexPath top:attr.frame.origin.y]];
        }
    }
    
    return attrs;
}

@end
