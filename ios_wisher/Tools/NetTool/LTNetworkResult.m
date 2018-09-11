//
//  LTNetworkResult.m
//  ios_wisher
//
//  Created by ZhiFan on 2018/9/11.
//  Copyright © 2018年 lin-tong. All rights reserved.
//

#import "LTNetworkResult.h"
#import "AppDelegate.h"
#import "LTBaseNavigationController.h"
#import "LTLoginController.h"

@implementation LTNetworkResult
- (void)clarifyResultWithStatus1:(void (^)(void))success status0:(void (^)(void))failed otherCallBack:(void (^)(NSInteger))otherCallBack {
    //成功
    if (self.code.integerValue == 200) {
        if (success) {
            success();
        }
    }else if (self.code.integerValue == 0){
        if (failed) {
            failed();
        }else{
            [self pushToLoginVc];
        }
    }else {
        if (otherCallBack) {
            otherCallBack(self.code.integerValue);
        }
    }
}

- (void)pushToLoginVc {
    LTLoginController *loginVc = [[LTLoginController alloc] init];
    LTBaseNavigationController *nav = [[LTBaseNavigationController alloc] initWithRootViewController:loginVc];
    AppDelegate *app = APPDELEGATE;
    typedef void (^Animation)(void);
    Animation animation = ^{
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        app.window.rootViewController = nav;
        [UIView setAnimationsEnabled:oldState];
    };
    
    [UIView transitionWithView:app.window
                      duration:0.3f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:animation
                    completion:nil];
}
@end
