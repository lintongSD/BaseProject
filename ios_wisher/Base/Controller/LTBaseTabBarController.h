//
//  LTBaseTabBarController.h
//  ios_wisher
//
//  Created by 全速 on 2018/5/8.
//  Copyright © 2018年 lin-tong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTBaseTabBarController : UITabBarController

/*
 * 是否隐藏tabBar
 */
@property (nonatomic, assign) BOOL tabBarHidden;

/** 自定义的覆盖原先的tarbar的控件 */
@property (nonatomic, strong) UIView *tabBarView;

+ (LTBaseTabBarController *)sharedController;

#pragma mark 是否隐藏tabBar
- (void)hidesTabBar:(BOOL)yesOrNO animated:(BOOL)animated;

- (void)changeViewController:(LTTipsButton *)sender;

+ (instancetype)addChildVc:(NSArray *)childVcs
                    titles:(NSArray *)titles
                    images:(NSArray *)images
            selectedImages:(NSArray *)selectedImages;

@end
