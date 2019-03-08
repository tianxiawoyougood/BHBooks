//
//  BHPageViewController.m
//  BHBooks
//
//  Created by sunbinhua on 2019/2/14.
//  Copyright © 2019 paidian. All rights reserved.
//

#import "BHPageViewController.h"
#import "BHPageContentController.h"
#import "BHFileTool.h"
#import "BHUIManager.h"
#import "BHPageTopView.h"
#import "BHPageBottomView.h"
#import <Masonry/Masonry.h>
#import "BHBookListView.h"

@interface BHPageViewController ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource>
{
    CGSize _contentSize;
}

@property (nonatomic, strong) UIPageViewController *pageViewController;

@property (nonatomic, strong) NSArray *chapterList;//章节目录
@property (nonatomic, strong) NSArray *chapterTextArr;//所有章节文字内容
@property (nonatomic, strong) NSArray<NSMutableAttributedString *> *pageContentArray;//page内容的数组（一个章节可能多页，所以不能根据章节划分）

@property (nonatomic, strong) NSDictionary *attributeDict;

@property (nonatomic, assign) NSInteger currentIndex;//当前页
@property (nonatomic, assign) NSInteger currentChapter;//当前章节

@property (nonatomic, strong) BHPageContentController *currentVC;//当前内容控制器

@property (nonatomic, strong) BHPageTopView *topView;//头部视图
@property (nonatomic, strong) BHPageBottomView *bottomView;//底部视图
@property (nonatomic, strong) BHBookListView *listView;//目录视图

@property (nonatomic, assign) BOOL showToolView;


@end

@implementation BHPageViewController

//控制状态栏是否显示
- (BOOL)prefersStatusBarHidden {
    if (self.showToolView) {
        return NO;
    }else{
        return YES;;
    }
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - the cycle life

- (void)dealloc
{
    NSLog(@"%s", __func__);
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _showToolView = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initialization];
    
    [self loadData];
    
    BHPageContentController *contentVC = [self viewControllerAtIndex:_currentIndex];
    [self.pageViewController setViewControllers:@[contentVC] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    
    
    self.pageViewController.view.frame = self.view.bounds;
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    
    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(-[BHUIManager navigationBarHeight]);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo([BHUIManager navigationBarHeight]);
    }];
    
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat height = 60*kDesignScaleXForIP6 + [BHUIManager iphoneXTabrOffset];
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(height);
        make.height.mas_equalTo(height);
    }];
    
    [self.view addSubview:self.listView];
    [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_left);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        make.width.mas_equalTo(kScreenWidth);
    }];

    [self initializBlock];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:tap];
}


#pragma mark - event

- (void)tap:(UITapGestureRecognizer *)tap {
    
    CGPoint point = [tap locationInView:self.view];
    if (point.x < 0.3*kScreenWidth || point.x > 0.7*kScreenWidth || point.y < 0.3*kScreenHeight || point.y > 0.7*kScreenHeight) {
        return;
    }
    NSTimeInterval duration = 0.3;
    if (self.showToolView) {
        self.showToolView = NO;
        
        [self.view setNeedsUpdateConstraints];
        [UIView animateWithDuration:duration animations:^{
            [self.topView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.view).offset(-[BHUIManager navigationBarHeight]);
            }];
            [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.view.mas_bottom).offset(60*kDesignScaleXForIP6 + [BHUIManager iphoneXTabrOffset]);
            }];
            [self.view layoutIfNeeded];
        }];
        
    }else{
        self.showToolView = YES;
        
        [self.view setNeedsUpdateConstraints];
        [UIView animateWithDuration:duration animations:^{
            [self.topView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.view.mas_top);
            }];
            [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.view.mas_bottom);
            }];
            [self.view layoutIfNeeded];
        }];
        
    }
    //更新状态栏是不是显示
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark --

- (void)initialization {
    
    _attributeDict = @{NSFontAttributeName:[UIFont fontWithName:@"PingFang SC" size:13]};
    
    _currentIndex = 0;
    _currentChapter = 0;
    
    _contentSize = CGSizeMake(CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - [BHUIManager statusBarOffset] - [BHUIManager tabbarHieght]);
}

- (void)initializBlock {
    
    __weak typeof(self) weakSelf = self;
    self.topView.backBlock = ^(UIButton * _Nonnull btn) {
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    self.bottomView.listBlock = ^(UIButton * _Nonnull sender) {
        weakSelf.listView.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.listView.transform = CGAffineTransformMakeTranslation(kScreenWidth*0.8, 0);
            
        } completion:^(BOOL finished) {
            
        }];
    };
    self.bottomView.readModelBlock = ^(UIButton * _Nonnull sender) {
        
    };
    self.bottomView.setupFontBlock = ^(BHSetupFontType type) {
        
    };
}

- (void)loadData {
    
    NSString *string;
    if (self.filePath) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:self.filePath]) {
            string = [BHFileTool transcodingWithPath:self.filePath];
        }
        self.chapterList = [BHFileTool getChapterListWithText:string];
        self.chapterTextArr = [BHFileTool getChapterTextArrWithString:string];
        
        //加载第一章的内容
        [self loadChapterContentWithIndex:_currentIndex];
    }
}

- (void)loadChapterContentWithIndex:(NSInteger)index {
    NSArray *arr = [self pagingWithContentString:self.chapterTextArr[index] contentSize:_contentSize textAttribute:self.attributeDict];
    self.pageContentArray = arr;
}

- (NSArray *)pagingWithContentString:(NSString *)contentString contentSize:(CGSize)contentSize textAttribute:(NSDictionary *)textAttribute {
    
    // 将字符串分页
    NSMutableArray *pageArray = [NSMutableArray array];
    NSMutableAttributedString *orginAttributeString = [[NSMutableAttributedString alloc] initWithString:contentString attributes:textAttribute];
    NSTextStorage *textStorage = [[NSTextStorage alloc] initWithAttributedString:orginAttributeString];
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    [textStorage addLayoutManager:layoutManager];
    int i = 0;
    while (YES) {
        i++;
        
        // 文本容器
        NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:contentSize];
        [layoutManager addTextContainer:textContainer];
        
        // 当前容器显示的内荣在字符串中的位置
        NSRange range = [layoutManager glyphRangeForTextContainer:textContainer];
        
        if (range.length <= 0) {
            break;
        }
        
        NSString *str = [contentString substringWithRange:range];
        NSMutableAttributedString *attstr = [[NSMutableAttributedString alloc] initWithString:str attributes:textAttribute];
        [pageArray addObject:attstr];
    }
    
    return pageArray;
}


- (BHPageContentController *)viewControllerAtIndex:(NSUInteger)index {
    if (([self.pageContentArray count] == 0) || (index >= [self.pageContentArray count])) {
        return nil;
    }
    
    BHPageContentController *contentVC = [[BHPageContentController alloc] init];
    contentVC.content = [self.pageContentArray objectAtIndex:index];
    [contentVC setIndex:index totalPages:self.pageContentArray.count];
    self.currentVC = contentVC;
    
    return contentVC;
}


#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    if (_currentIndex == 0 && _currentChapter == 0) {
        //第一章第一页
        return nil;
    }else if (_currentIndex == 0 && _currentChapter > 0) {
        //不是第一章的第一页，展示上一章的
        _currentChapter--;
        [self loadChapterContentWithIndex:_currentChapter];
        _currentIndex = self.pageContentArray.count - 1;
    }else{
        //不是第一页，展示前一页
        _currentIndex--;
    }
    return [self viewControllerAtIndex:_currentIndex];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    if (_currentIndex >= self.pageContentArray.count && _currentChapter >= self.chapterTextArr.count) {
        //最后一章最后一页
        return nil;
    }else if (_currentIndex >= self.pageContentArray.count - 1 && _currentChapter < self.chapterTextArr.count) {
        //不是最后一章的最后一页
        _currentChapter++;
        [self loadChapterContentWithIndex:_currentChapter];
        _currentIndex = 0;
    }else{
        //不是最后一页
        _currentIndex++;
    }
    
    return [self viewControllerAtIndex:_currentIndex];
}


#pragma mark - getter

- (UIPageViewController *)pageViewController {
    if (!_pageViewController) {
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
    }
    return _pageViewController;
}

- (BHPageTopView *)topView {
    if (!_topView) {
        _topView = [[BHPageTopView alloc] init];
    }
    return _topView;
}

- (BHPageBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[BHPageBottomView alloc] init];
    }
    return _bottomView;
}

- (BHBookListView *)listView {
    if (!_listView) {
        _listView = [[BHBookListView alloc] init];
    }
    return _listView;
}


@end
