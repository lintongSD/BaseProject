//
//  UIColor+ColorHex.m
//  lygcwz
//
//  Created by lyscds2017 on 2018/1/22.
//  Copyright © 2018年 miaojinliang. All rights reserved.
//

#import "UIColor+ColorHex.h"

@implementation UIColor (ColorHex)

#pragma mark ---- 常用颜色
+ (UIColor *)lineColor{
    return [UIColor lt_colorWithHexString:@"#ECECEC"];
}

+ (UIColor *)lt_defaultBgColor{
    return [UIColor lt_colorWithHexString:@"#F0F0F0"];
}
+ (UIColor *)lt_themeColor{
    return [UIColor lt_colorWithHexString:@"#006BFF"];
}
#pragma mark ---- 项目颜色宏
+ (UIColor *)lt_secodTextColor{
    return [UIColor lt_colorWithHexString:@"#B6B5B5"];
}

#pragma mark ---- 颜色配置
+ (UIColor *)lt_colorWithHexString: (NSString *)color{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

+ (UIColor *)randomColor{
    return [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
}
@end
