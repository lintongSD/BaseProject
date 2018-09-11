//
//  LTBaseModel.h
//  ios_wisher
//
//  Created by ZhiFan on 2018/9/11.
//  Copyright © 2018年 lin-tong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTBaseModel : NSObject

//请求回来的消息
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, copy) id data;

@end
