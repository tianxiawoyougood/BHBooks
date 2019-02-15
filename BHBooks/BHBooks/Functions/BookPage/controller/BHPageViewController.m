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


@end

@implementation BHPageViewController

//控制状态栏是否显示
- (BOOL)prefersStatusBarHidden {
    return YES;
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

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}

- (void)initialization {
    
    _attributeDict = @{NSFontAttributeName:[UIFont fontWithName:@"PingFang SC" size:13]};
    
    _currentIndex = 0;
    _currentChapter = 0;
    
    _contentSize = CGSizeMake(CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - [BHUIManager statusBarOffset] - [BHUIManager tabbarHieght]);
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
    
#warning 这里需要好好学习一下
    
    NSMutableArray *pageArray = [NSMutableArray array];
    NSMutableAttributedString *orginAttributeString = [[NSMutableAttributedString alloc] initWithString:contentString attributes:textAttribute];
    NSTextStorage *textStorage = [[NSTextStorage alloc] initWithAttributedString:orginAttributeString];
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    [textStorage addLayoutManager:layoutManager];
    int i = 0;
    while (YES) {
        i++;
        NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:contentSize];
        [layoutManager addTextContainer:textContainer];
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

@end
