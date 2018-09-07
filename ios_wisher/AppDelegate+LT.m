//
//  AppDelegate+LT.m
//  ios_wisher
//
//  Created by 全速 on 2018/5/8.
//  Copyright © 2018年 lin-tong. All rights reserved.
//

#import "AppDelegate+LT.h"

@interface AppDelegate ()

@end

@implementation AppDelegate (LT)

- (void)setupRootVc{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = self.tabbarVC;
}


@end
