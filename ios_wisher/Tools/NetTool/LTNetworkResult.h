//
//  LTNetworkResult.h
//  ios_wisher
//
//  Created by ZhiFan on 2018/9/11.
//  Copyright © 2018年 lin-tong. All rights reserved.
//

#import "LTBaseModel.h"

@interface LTNetworkResult : LTBaseModel


- (void) clarifyResultWithStatus1:(void(^)(void))success status0:(void(^)(void))failed otherCallBack:(void(^)(NSInteger code))otherCallBack;

@end
