//
//  LTGetCurrentVC.h
//  ios_wisher
//
//  Created by 全速 on 2018/5/9.
//  Copyright © 2018年 lin-tong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LTGetCurrentVC : NSObject
/**
 获取当前VC
 */
+ (UIViewController *)getCurrentVC;

+ (BOOL)isIphoneX;

+ (NSInteger)lt_navBarHeight;

+ (NSInteger)lt_statusBarHeight;

+ (NSInteger)lt_safeAreaHeight;
/**
 判断手机机型
 */
+ (NSString *)lt_iphoneModel;
@end
