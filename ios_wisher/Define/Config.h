//
//  Config.h
//  ios_wisher
//
//  Created by 全速 on 2018/5/8.
//  Copyright © 2018年 lin-tong. All rights reserved.
//

#ifndef Config_h
#define Config_h

#import "LTGetCurrentVC.h"
//*************** iPhoneX *****************
#define iphoneX             [LTGetCurrentVC isIphoneX]
#define navBarHeight        [LTGetCurrentVC lt_navBarHeight]
#define safeAreaHeight      [LTGetCurrentVC lt_safeAreaHeight]
#define statusBarHeight     [LTGetCurrentVC lt_statusBarHeight]


//*************** UIConfig *****************
#define kScreenW ([[UIScreen mainScreen]bounds].size.width)
#define kScreenH ([[UIScreen mainScreen]bounds].size.height)

#define kNumFrom375(a) (kScreenW/375 * a)
#define kNumFrom667(a) (kScreenH/667 * a)

#define font375(num) [UIFont systemFontOfSize:kNumFrom375(num)]

#define ImageNamed(name) [UIImage imageNamed:name]

//*************** 全局 *****************

#define APPDELEGATE (AppDelegate *)[UIApplication sharedApplication].delegate

// window
#define kWindow [UIApplication sharedApplication].keyWindow

// 根视图控制器
#define RootVC kWindow.rootViewController

// 当前导航栏控制器
#define CURRENT_NAV \
({ \
UITabBarController *rootVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;\
UINavigationController *currentNav = (UINavigationController *)rootVc.selectedViewController;\
(currentNav);\
})


#endif /* Config_h */
