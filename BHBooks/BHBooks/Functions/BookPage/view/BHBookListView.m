//
//  BHBookListView.m
//  BHBooks
//
//  Created by sunbinhua on 2019/3/8.
//  Copyright © 2019 paidian. All rights reserved.
//

#import "BHBookListView.h"
#import "BHUIManager.h"


#define kBHChapterCellId    @"kBHChapterCellId"

@interface BHBookListView ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *headerView;

@end

@implementation BHBookListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self.backView addGestureRecognizer:tap];
    }
    return self;
}

- (void)setUpUI {
    
    [self addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.width.mas_equalTo(0.8*kScreenWidth);
        make.height.mas_equalTo([BHUIManager navigationBarHeight]);
    }];
    
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self.headerView.mas_bottom);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    [self addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.tableView.mas_right);
        make.right.equalTo(self.mas_right);
    }];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kBHChapterCellId];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = [UIColor grayColor];
    cell.textLabel.text = self.list[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeTranslation(-kScreenWidth*0.9, 0);
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
    
    if (self.selectChapterBlock) {
        self.selectChapterBlock(indexPath.row);
    }
}

#pragma mark - event

- (void)tap:(UITapGestureRecognizer*)tap {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeTranslation(-kScreenWidth*0.9, 0);
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
    
}


#pragma mark - setter

- (void)setList:(NSArray *)list {
    _list = list;
    [self.tableView reloadData];
}


#pragma mark - getter

- (UIView *)backView {
    if (!_backView) {
        _backView = [UIView new];
        _backView.backgroundColor = [UIColor clearColor];
    }
    return _backView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kBHChapterCellId];
    }
    return _tableView;
}

- (UILabel *)headerView {
    if (!_headerView) {
        _headerView = [UILabel new];
        _headerView.font = [UIFont systemFontOfSize:17];
        _headerView.text = @"目录";
    }
    return _headerView;
}



@end
