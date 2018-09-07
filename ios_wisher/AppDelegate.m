//
//  AppDelegate.m
//  ios_wisher
//
//  Created by 全速 on 2018/5/8.
//  Copyright © 2018年 lin-tong. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+LT.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setupRootVc];
    // 键盘管理
    [IQKeyboardManager sharedManager].enable = YES;
    return YES;
}

- (LTBaseTabBarController *)tabbarVC{
    if (!_tabbarVC) {
        // 子控制器图标
        NSArray *tabBarItemImgSelect =  @[@"tab_home_selected",
                                          @"tab_bai_selected",
                                          @"tab_mine_selected"];
        NSArray *tabBarItemImgs = @[@"tab_home_normal",
                                    @"tab_bai_normal",
                                    @"tab_mine_normal"];
        NSArray *titles = @[@"首页", @"百道圈", @"我的"];
        NSArray *controllers = @[@"LTHomeController", @"LTDynamicController", @"LTMineController"];
        
        _tabbarVC = [LTBaseTabBarController addChildVc:controllers titles:titles images:tabBarItemImgs selectedImages:tabBarItemImgSelect];
    }
    return _tabbarVC;
}

@end
