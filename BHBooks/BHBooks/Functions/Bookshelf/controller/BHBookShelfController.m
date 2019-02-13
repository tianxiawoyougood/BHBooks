//
//  BHBookShelfController.m
//  BHBooks
//
//  Created by sunbinhua on 2019/2/12.
//  Copyright © 2019 paidian. All rights reserved.
//

#import "BHBookShelfController.h"
#import "BHBookShelfViewModel.h"
#import "BHBookCell.h"
#import "BHBookShelfLayout.h"

@interface BHBookShelfController ()

@property (nonatomic, strong) UICollectionView *collectionView;


@property (nonatomic, strong) BHBookShelfViewModel *bookShelfViewModel;

@end

@implementation BHBookShelfController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    
    self.bookShelfViewModel.dataSource = [self testData];
}

- (void)setUpUI {
    
    [self.view addSubview:self.collectionView];
}

- (NSArray *)testData {
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    for (int i = 0; i< 3; i++) {
        NSMutableArray *section = [[NSMutableArray alloc] init];
        for (int j = 0; j<3; j++) {
            BHBook *book = [[BHBook alloc] init];
            [section addObject:book];
        }
        [arr addObject:section];
    }
    
    return arr;
}


#pragma mark - getter

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        BHBookShelfLayout *layout = [[BHBookShelfLayout alloc] init];
        layout.itemSize = CGSizeMake(80, 80);
        layout.headerReferenceSize = CGSizeMake(self.view.bounds.size.width, 90);
        layout.footerReferenceSize = CGSizeMake(self.view.bounds.size.width, 70);
        layout.sectionInset = UIEdgeInsetsMake(0, 30, 0, 30);
        layout.minimumLineSpacing = 20;
        layout.minimumInteritemSpacing = ([UIScreen mainScreen].bounds.size.width - 80 * 3 - 60) / 2;
        
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.delegate = self.bookShelfViewModel;
        _collectionView.dataSource = self.bookShelfViewModel;
        
        [_collectionView registerClass:[BHBookCell class] forCellWithReuseIdentifier:kBookCellID];
        
    }
    return _collectionView;
}

- (BHBookShelfViewModel *)bookShelfViewModel {
    if (!_bookShelfViewModel) {
        _bookShelfViewModel = [[BHBookShelfViewModel alloc] init];
    }
    return _bookShelfViewModel;
}

@end
