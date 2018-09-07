//
//  LTTipsButton.m
//  ios_wisher
//
//  Created by 全速 on 2018/5/9.
//  Copyright © 2018年 lin-tong. All rights reserved.
//

#import "LTTipsButton.h"

@interface LTTipsButton ()
@property (nonatomic, strong) UILabel *tipLabel; /**< 提示文字数量 */
@end

@implementation LTTipsButton

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.hidden = YES;
        _tipLabel.backgroundColor = [UIColor lt_colorWithHexString:@"0xFF6836"];
        _tipLabel.textColor = [UIColor whiteColor];
        _tipLabel.font = [UIFont systemFontOfSize:10];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        [_tipLabel lt_cornerRadius:8.0];
        [self addSubview:_tipLabel];
    }
    return self;
}

- (void)setTag:(NSInteger)tag {
    [super setTag:tag];
/*
    @weakify(self)
    if (tag == 1) {
        [[[NSNotificationCenter defaultCenter] rac_addObserverForName:LoadDynamicMsgSuccessNoti object:nil] subscribeNext:^(NSNotification * _Nullable x) {
            @strongify(self)
            NSDictionary *dataDic = x.object;
            if (dataDic) {
                self.tipLabel.text = [NSString stringWithFormat:@"%@",dataDic[@"num"]];
                self.tipLabel.hidden = [dataDic[@"num"] integerValue] == 0;
            } else {
                self.tipLabel.hidden = YES;
            }
        }];
        [RACObserve(self.tipLabel, text) subscribeNext:^(id  _Nullable x) {
        }];
    } else if (tag == 5) {
        [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kLoadActivityMessageSuccessNoti object:nil] subscribeNext:^(NSNotification * _Nullable x) {
            @strongify(self)
            NSDictionary *dataDic = x.object;
            if (dataDic) {
                self.tipLabel.text = [NSString stringWithFormat:@"%@",dataDic[@"num"]];
                self.tipLabel.hidden = [dataDic[@"num"] integerValue] == 0;
            } else {
                self.tipLabel.hidden = YES;
            }
        }];
    }
*/
    
}


- (void)layoutSubviews {
    [super layoutSubviews];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_centerX).with.offset(4);
        make.top.equalTo(self.mas_top).with.offset(2);
        make.width.height.mas_equalTo(16);
    }];
}


#pragma mark 设置button内部的image的范围
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * 0.6;
    return CGRectMake(0, 5, imageW, imageH);
}

#pragma mark 设置button内部的title的范围
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleY = contentRect.size.height * 0.6;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(0, titleY, titleW, titleH);
}


@end
