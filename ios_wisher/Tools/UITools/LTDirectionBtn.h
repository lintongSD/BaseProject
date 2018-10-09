//
//  LTDirectionBtn.h
//  AntFarms
//
//  Created by 全速 on 2018/6/2.
//  Copyright © 2018年 MuXi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DirectionBtnType) {
    DirectionBtnTypeLeft=1,
    DirectionBtnTypeRight,
    DirectionBtnTypeTop,
    DirectionBtnTypeBottom
};
@interface LTDirectionBtn : UIButton

@property (nonatomic, assign) DirectionBtnType directionType;

+ (LTDirectionBtn *) directionBtnWithType:(DirectionBtnType)type margin:(CGFloat)margin;

@end
