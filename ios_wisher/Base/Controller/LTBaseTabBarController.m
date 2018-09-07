//
//  LTBaseTabBarController.m
//  ios_wisher
//
//  Created by 全速 on 2018/5/8.
//  Copyright © 2018年 lin-tong. All rights reserved.
//

#import "LTBaseTabBarController.h"
#import "LTBaseNavigationController.h"

@interface LTBaseTabBarController ()
/** 记录前一次选中的按钮 */
@property (nonatomic, strong) LTTipsButton *selectLastBtn;

@property (nonatomic, strong) UITapGestureRecognizer *tapTouch;/**<  动态双击返回顶部的手势 */

@property (nonatomic, assign) NSInteger kTabBarHeight;/**<  tabbar的高度 */
@end

@implementation LTBaseTabBarController

+(LTBaseTabBarController *)sharedController{
    static dispatch_once_t onceToken;
    static LTBaseTabBarController *x;
    dispatch_once(&onceToken, ^{
        x = [[LTBaseTabBarController alloc] init];
    });
    
    
    return x;
}


//创建控制器
+ (instancetype)addChildVc:(NSArray *)childVcs titles:(NSArray *)titles images:(NSArray *)images selectedImages:(NSArray *)selectedImages{
    LTBaseTabBarController *tabVC = [LTBaseTabBarController sharedController];
    for (int i = 0; i < childVcs.count; i++) {
        UIViewController *vc = [NSClassFromString(childVcs[i]) new];
        LTBaseNavigationController *nav = [[LTBaseNavigationController alloc] initWithRootViewController:vc];
        [tabVC addChildViewController:nav];
        [tabVC creatButtonWithNormalName:images[i]
                           andSelectName:selectedImages[i]
                                andTitle:titles[i]
                                  andTag:i
                                andIndex:childVcs.count] ;
    }
    return tabVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildTabBar];
    self.kTabBarHeight = 49 + safeAreaHeight;
    self.tabBar.hidden = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(layoutControllerSubViews) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
    
}

- (void)layoutControllerSubViews {
    UINavigationController *currentNav = (UINavigationController *)self.selectedViewController;
    UIViewController *currentVc = currentNav.topViewController;
    if (_tabBarView &&
        ([currentVc isKindOfClass:NSClassFromString(@"LTHomeController")]||
         [currentVc isKindOfClass:NSClassFromString(@"LTDynamicController")]||
         [currentVc isKindOfClass:NSClassFromString(@"LTMineController")])) {
            _tabBarView.frame = CGRectMake(0,self.view.frame.size.height-49 , kScreenW, 49);
        }
}

//创建按钮
- (void)creatButtonWithNormalName:(NSString *)normal andSelectName:(NSString *)selected andTitle:(NSString *)title andTag:(int)tag andIndex:(NSInteger)index{
    
    LTTipsButton * customButton = [LTTipsButton buttonWithType:UIButtonTypeCustom];
    customButton.tag = tag;
    NSInteger count = index;
    CGFloat buttonW = _tabBarView.frame.size.width /  count;
    
    CGFloat buttonH;
    buttonH = _tabBarView.frame.size.height-0.6 - safeAreaHeight;
    customButton.frame = CGRectMake(buttonW * tag, 0.6, buttonW, buttonH);
    [customButton setImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
    [customButton setImage:[UIImage imageNamed:selected] forState:UIControlStateDisabled];
    [customButton setTitle:title forState:UIControlStateNormal];
    [customButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [customButton setTitleColor:[UIColor lt_colorWithHexString:@"#FF6836"] forState:UIControlStateDisabled];
    [customButton addTarget:self action:@selector(changeViewController:) forControlEvents:UIControlEventTouchDown];
    customButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    customButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    customButton.titleLabel.font = [UIFont systemFontOfSize:11];
    [_tabBarView addSubview:customButton];
    
    if (tag == 0) {
        customButton.enabled = NO;
        _selectLastBtn = customButton;
    }
}

#pragma mark 是否隐藏tabBar
- (void)hidesTabBar:(BOOL)yesOrNO animated:(BOOL)animated{
    self.tabBarHidden = yesOrNO;
    self.tabBar.hidden = YES;
    if (yesOrNO == YES){
        if (self.tabBarView.frame.origin.y == kScreenH){
            return;
        }
    }
    else{
        if (_tabBarView.frame.origin.y == (kScreenH - self.kTabBarHeight)){
            return;
        }
    }
    if (animated == YES){
        [UIView animateWithDuration:0.25f animations:^{
            if (yesOrNO == YES){
                if ((_tabBarView.frame.origin.y + self.kTabBarHeight)== kScreenH) {
                    _tabBarView.frame = CGRectMake(_tabBarView.frame.origin.x, _tabBarView.frame.origin.y + self.kTabBarHeight, _tabBarView.frame.size.width, _tabBarView.frame.size.height);
                }
            }
            else{
                _tabBarView.hidden = NO;
                if (_tabBarView.frame.origin.y > (kScreenH-self.kTabBarHeight)) {
                    _tabBarView.frame = CGRectMake(_tabBarView.frame.origin.x, _tabBarView.frame.origin.y - self.kTabBarHeight, _tabBarView.frame.size.width, _tabBarView.frame.size.height);
                }
            }
        } completion:^(BOOL finished) {
            if (yesOrNO == YES){
                _tabBarView.hidden = YES;
            }else {
                
            }
        }];
    }
    else{
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25f];
        if (yesOrNO == YES){
            if ((_tabBarView.frame.origin.y + self.kTabBarHeight)== kScreenH) {
                _tabBarView.frame = CGRectMake(_tabBarView.frame.origin.x, _tabBarView.frame.origin.y + self.kTabBarHeight, _tabBarView.frame.size.width, _tabBarView.frame.size.height);
            }
            _tabBarView.hidden = YES;
        }
        else{
            _tabBarView.hidden = NO;
            if (_tabBarView.frame.origin.y > (kScreenH-self.kTabBarHeight)) {
                _tabBarView.frame = CGRectMake(_tabBarView.frame.origin.x, _tabBarView.frame.origin.y - self.kTabBarHeight, _tabBarView.frame.size.width, _tabBarView.frame.size.height);
            }
            self.tabBar.hidden = YES;
        }
        [UIView commitAnimations];
    }
}

#pragma mark 按钮被点击时调用
- (void)changeViewController:(LTTipsButton *)sender{
    sender.enabled = NO;
    if (_selectLastBtn != sender) {
        _selectLastBtn.enabled = YES;
    }
    _selectLastBtn = sender;
    self.selectedViewController = self.viewControllers[sender.tag];
}


- (void)buildTabBar{
    self.tabBar.hidden = YES;
    CGFloat tabBarViewY;
    CGFloat tabBarViewHeight;
    if (iphoneX) {
        tabBarViewY = self.view.frame.size.height - 49 - 34;
        tabBarViewHeight = 49+34;
    }else {
        tabBarViewY = self.view.frame.size.height - 49;
        tabBarViewHeight = 49;
    }
    _tabBarView = [[UIView alloc]initWithFrame:CGRectMake(0, tabBarViewY, kScreenW, tabBarViewHeight)];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 0.6)];
    line.backgroundColor = [UIColor blackColor];
    line.alpha = 0.1;
    [_tabBarView addSubview:line];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(kScreenW/2, 0, kScreenW/4, tabBarViewHeight)];
    [_tabBarView addSubview:view];
//    [view addGestureRecognizer:self.tapTouch];
    _tabBarView.userInteractionEnabled = YES;
    _tabBarView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tabBarView];
}


#pragma mark----单例
//单例
- (UITapGestureRecognizer *)tapTouch {
    if (!_tapTouch) {
//        _tapTouch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap)];
//        _tapTouch.numberOfTapsRequired = 2;
    }
    return _tapTouch;
}

@end
