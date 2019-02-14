//
//  BHPageContentController.m
//  BHBooks
//
//  Created by sunbinhua on 2019/2/14.
//  Copyright © 2019 paidian. All rights reserved.
//

#import "BHPageContentController.h"

@interface BHPageContentController ()

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel *bottomRightLab;
@property (nonatomic, strong) UILabel *bottomLeftLab;

@property (nonatomic, assign) NSInteger index;//页数
@property (nonatomic, assign) NSInteger totalPages;//总页数


@end

@implementation BHPageContentController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.textView.frame = self.view.bounds;
    [self.view addSubview:self.textView];
    
}


#pragma mark - public




#pragma mark - setter

- (void)setContent:(NSMutableAttributedString *)content {
    _content = content;
    self.textView.attributedText = content;
}

- (void)setText:(NSString *)text {
    _text = text;
    self.textView.text = text;
}


#pragma mark - getter

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.backgroundColor = [UIColor clearColor];
        _textView.editable = NO;
        _textView.scrollEnabled = NO;
        _textView.selectable = NO;
        _textView.textContainerInset = UIEdgeInsetsZero;
    }
    return _textView;
}

- (UILabel *)bottomLeftLab {
    if (!_bottomLeftLab) {
        _bottomLeftLab = [UILabel new];
    }
    return _bottomLeftLab;
}

- (UILabel *)bottomRightLab {
    if (!_bottomRightLab) {
        _bottomRightLab = [UILabel new];
    }
    return _bottomRightLab;
}

@end
