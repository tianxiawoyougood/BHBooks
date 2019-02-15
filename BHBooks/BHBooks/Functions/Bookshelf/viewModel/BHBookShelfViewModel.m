//
//  BHBookShelfViewModel.m
//  BHBooks
//
//  Created by sunbinhua on 2019/2/12.
//  Copyright © 2019 paidian. All rights reserved.
//

#import "BHBookShelfViewModel.h"
#import "BHBookCell.h"
#import "BHPlaceholderBookCell.h"
#import "BHPageViewController.h"
#import "BHBookShelfController.h"
#import "BHBookshelfHeaderView.h"

@implementation BHBookShelfViewModel


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    id book = [self.dataSource objectAtIndex:indexPath.row];
    if ([book isKindOfClass:[BHBook class]]) {
        
        BHBookCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kBookCellID forIndexPath:indexPath];
        cell.book = book;
        return cell;
        
    }else{
        BHPlaceholderBookCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kBHPlaceholderBookCellId forIndexPath:indexPath];
        return cell;
    }
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        BHBookshelfHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kBHBookshelfHeaderViewId forIndexPath:indexPath];
        return headerView;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(collectionView.bounds.size.width, 18);
}

// 是否可以移动
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// 移动完成 更新数据
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(nonnull NSIndexPath *)sourceIndexPath toIndexPath:(nonnull NSIndexPath *)destinationIndexPath {
    
    id book = [self.dataSource objectAtIndex:destinationIndexPath.row];
    if ([book isKindOfClass:[BHBook class]]) {
        
        NSMutableArray *tempArr = [NSMutableArray arrayWithArray:self.dataSource];
        [tempArr exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
        
        self.dataSource = tempArr;
        [collectionView reloadData];
    }
}


#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    id model = [self.dataSource objectAtIndex:indexPath.row];
    
    if ([model isKindOfClass:[BHBook class]]) {
        
        BHBook *book = (BHBook *)model;
        BHPageViewController *pageVC = [[BHPageViewController alloc] init];
        pageVC.filePath = book.filePath;
        
        [self.bookShelfController.navigationController pushViewController:pageVC animated:YES];
    }
    
}


@end
