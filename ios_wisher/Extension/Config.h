//
//  Config.h
//  ios_wisher
//
//  Created by 全速 on 2018/5/8.
//  Copyright © 2018年 lin-tong. All rights reserved.
//

#ifndef Config_h
#define Config_h

//*************** iPhoneX *****************
#define iphoneX             [LTGetCurrentVC isIphoneX]
#define navBarHeight        [LTGetCurrentVC lt_navBarHeight]
#define statusBarHeight     [LTGetCurrentVC lt_statusBarHeight]
#define safeAreaHeight        [LTGetCurrentVC lt_safeAreaHeight]

//*************** UIConfig *****************
#define kScreenW ([[UIScreen mainScreen]bounds].size.width)
#define kScreenH ([[UIScreen mainScreen]bounds].size.height)

#define kNumFrom375(a) (kScreenW/375 * a)
#define kNumFrom667(a) (kScreenH/667 * a)

#define font(num) [UIFont systemFontOfSize:kNumFrom375(num)]



#import "LTGetCurrentVC.h"

#endif /* Config_h */
