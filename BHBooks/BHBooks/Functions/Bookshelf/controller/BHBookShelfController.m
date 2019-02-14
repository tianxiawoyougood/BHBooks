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
#import "BHFileTool.h"
#import "BHPageViewController.h"

@interface BHBookShelfController ()

@property (nonatomic, strong) UICollectionView *collectionView;


@property (nonatomic, strong) BHBookShelfViewModel *bookShelfViewModel;

@end

@implementation BHBookShelfController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpUI];
    [self loadData];
}

- (void)setUpUI {
    
    [self.view addSubview:self.collectionView];
}

- (void)loadData {
    
    NSMutableArray *books = [[NSMutableArray alloc] init];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray *fileArray = [fileManager contentsOfDirectoryAtPath:BHBooksPath error:nil];
    
    for (NSString *file in fileArray) {
        
        NSArray *arr = [file componentsSeparatedByString:@"."];
        
        BHBook *book = [[BHBook alloc] init];
        book.name = arr.firstObject;
        book.fileType = arr.lastObject;
        book.filePath = [BHBooksPath stringByAppendingPathComponent:file];
        
        [books addObject:book];
    }
    
    self.bookShelfViewModel.dataSource = books;
    [self.collectionView reloadData];
}

- (NSArray *)testData {
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    for (int i = 0; i< 16; i++) {
        BHBook *book = [[BHBook alloc] init];
        book.name = [NSString stringWithFormat:@"%d",i];
        [arr addObject:book];
    }
    
    return arr;
}

- (void)loogPressAction:(UILongPressGestureRecognizer *)loogPressGesture {
    
    // 获取此次点击的坐标，根据坐标获取cell对应的indexpPath
    CGPoint point = [loogPressGesture locationInView:_collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
    
    //根据长按手势的状态进行处理
    switch (loogPressGesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            // 没有点击到cell，不进行处理
            if (!indexPath) {
                break;
            }
            // 开始移动
            [_collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
        }
            break;
            
        case UIGestureRecognizerStateChanged:
        {
            //移动过程中更新位置坐标
            [_collectionView updateInteractiveMovementTargetPosition:point];
        }
            break;
            
        case UIGestureRecognizerStateEnded:
        {
            //停止移动
            [_collectionView endInteractiveMovement];
        }
            break;
            
        default:
            //取消移动
            [_collectionView cancelInteractiveMovement];
            break;
    }
}


#pragma mark - getter

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        BHBookShelfLayout *layout = [[BHBookShelfLayout alloc] init];
        layout.itemSize = CGSizeMake(80, 80);
        layout.headerReferenceSize = CGSizeMake(self.view.bounds.size.width, 0);
        layout.footerReferenceSize = CGSizeMake(self.view.bounds.size.width, 0);
        layout.sectionInset = UIEdgeInsetsMake(10, 30, 0, 30);
        layout.minimumLineSpacing = 20;
        layout.minimumInteritemSpacing = ([UIScreen mainScreen].bounds.size.width - 80 * 3 - 60) / 2;
        
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self.bookShelfViewModel;
        _collectionView.dataSource = self.bookShelfViewModel;
        
        [_collectionView registerClass:[BHBookCell class] forCellWithReuseIdentifier:kBookCellID];
        
        UILongPressGestureRecognizer *loogPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(loogPressAction:)];
        [_collectionView addGestureRecognizer:loogPressGesture];
        
    }
    return _collectionView;
}

- (BHBookShelfViewModel *)bookShelfViewModel {
    if (!_bookShelfViewModel) {
        _bookShelfViewModel = [[BHBookShelfViewModel alloc] init];
        _bookShelfViewModel.bookShelfController = self;
    }
    return _bookShelfViewModel;
}

@end
