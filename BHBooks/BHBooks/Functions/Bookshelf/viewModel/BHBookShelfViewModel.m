//
//  BHBookShelfViewModel.m
//  BHBooks
//
//  Created by sunbinhua on 2019/2/12.
//  Copyright © 2019 paidian. All rights reserved.
//

#import "BHBookShelfViewModel.h"
#import "BHBookCell.h"

@implementation BHBookShelfViewModel


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BHBookCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kBookCellID forIndexPath:indexPath];
    cell.book = [self.dataSource objectAtIndex:indexPath.row];
    return cell;
}

@end
