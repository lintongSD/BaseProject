//
//  UIColor+ColorHex.h
//  lygcwz
//
//  Created by lyscds2017 on 2018/1/22.
//  Copyright © 2018年 miaojinliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#define themeColor [UIColor lt_colorWithHexString:@"#006BFF"]
@interface UIColor (ColorHex)
+ (UIColor *)lt_colorWithHexString: (NSString *)color;
+ (UIColor *)randomColor;

+ (UIColor *)lineColor;
+ (UIColor *)lt_defaultBgColor;
+ (UIColor *)lt_themeColor;

+ (UIColor *)lt_secodTextColor;@end
