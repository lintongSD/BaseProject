//
//  LTDirectionBtn.m
//  AntFarms
//
//  Created by 全速 on 2018/6/2.
//  Copyright © 2018年 MuXi. All rights reserved.
//

#import "LTDirectionBtn.h"

@interface LTDirectionBtn ()
@property (nonatomic, assign) CGFloat margin;
@end

@implementation LTDirectionBtn

+ (LTDirectionBtn *)directionBtnWithType:(DirectionBtnType)type margin:(CGFloat)margin{
    LTDirectionBtn *btn = [LTDirectionBtn new];
    btn.directionType = type;
    btn.margin = margin;
    return btn;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGSize imageSize = self.imageView.lt_size;
    CGSize labelSize = self.titleLabel.lt_size;
    
    CGFloat left_orginX = (self.lt_w - imageSize.width - labelSize.width)/2.f;
    CGFloat left_imageY = (self.lt_h - imageSize.height)/2;
    CGFloat left_labelY = (self.lt_h - labelSize.height)/2;
    
    CGFloat top_orginnY = (self.lt_h - imageSize.height - labelSize.height)/2.f;
    CGFloat top_imageX = (self.lt_w - imageSize.width)/2.f;
    CGFloat top_labelX = (self.lt_w - labelSize.width)/2.f;
    
    switch (self.directionType) {
        case DirectionBtnTypeLeft:{
            self.imageView.frame = CGRectMake(left_orginX, left_imageY, imageSize.width, imageSize.height);
            self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame)+self.margin, left_labelY, labelSize.width, labelSize.height);
        }
            break;
        case DirectionBtnTypeRight:{
            self.titleLabel.frame = CGRectMake(left_orginX, left_labelY,  labelSize.width, labelSize.height);
            self.imageView.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame)+self.margin, left_imageY, imageSize.width, imageSize.height);
        }
            break;
        case DirectionBtnTypeTop:{
            self.imageView.frame = CGRectMake(top_imageX, top_orginnY, imageSize.width, imageSize.height);
            self.titleLabel.frame = CGRectMake(top_labelX, CGRectGetMaxY(self.imageView.frame)+self.margin, labelSize.width, labelSize.height);
        }
            break;
        case DirectionBtnTypeBottom:{
            self.titleLabel.frame = CGRectMake(top_labelX, top_orginnY, labelSize.width, labelSize.height);
            self.imageView.frame = CGRectMake(top_imageX, CGRectGetMaxY(self.titleLabel.frame)+self.margin, imageSize.width, imageSize.height);
        }
            break;
    }
    
}

- (void)setDirectionType:(DirectionBtnType)directionType{
    _directionType = directionType;
    [self layoutIfNeeded];
}

@end
