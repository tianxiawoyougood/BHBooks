//
//  BHBaseNavigationController.m
//  BHBooks
//
//  Created by sunbinhua on 2019/2/15.
//  Copyright © 2019 paidian. All rights reserved.
//

#import "BHBaseNavigationController.h"

@interface BHBaseNavigationController ()

@end

@implementation BHBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    return self.topViewController;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
