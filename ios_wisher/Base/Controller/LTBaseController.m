//
//  LTBaseController.m
//  ios_wisher
//
//  Created by 全速 on 2018/5/8.
//  Copyright © 2018年 lin-tong. All rights reserved.
//

#import "LTBaseController.h"
#import "LTBaseTabBarController.h"
@interface LTBaseController ()

@end

@implementation LTBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor randomColor];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSLog(@"\n----当前Class----\n----%@---- \n", NSStringFromClass([self class]));
    
    if ([NSStringFromClass([self class]) isEqualToString:@"LTHomeController"]
        || [NSStringFromClass([self class]) isEqualToString:@"LTDynamicController"]
        || [NSStringFromClass([self class]) isEqualToString:@"LTMineController"]) {
        [[LTBaseTabBarController sharedController] hidesTabBar:NO animated:YES];
    }else {
        
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    if ([NSStringFromClass([self class]) isEqualToString:@"LTHomeController"]||
        [NSStringFromClass([self class]) isEqualToString:@"LTDynamicController"]||
        [NSStringFromClass([self class]) isEqualToString:@"LTMineController"]) {
        [LTBaseTabBarController sharedController].tabBar.hidden = YES;
    }else {
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        [[LTBaseTabBarController sharedController] hidesTabBar:YES animated:YES];
    }
}

- (void)dealloc {
    NSLog(@"\n----销毁----\n----%@----dealloc \n", NSStringFromClass([self class]));
}

@end
