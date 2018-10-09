//
//  LTWebViewController.m
//  ios_wisher
//
//  Created by zhifan on 2018/10/9.
//  Copyright © 2018 lin-tong. All rights reserved.
//

#import "LTWebViewController.h"
#import <WebKit/WebKit.h>
@interface LTWebViewController () <WKNavigationDelegate,WKUIDelegate, WKScriptMessageHandler>

@property (nonatomic, strong) WKWebView *webView;
@property (weak, nonatomic) CALayer *progresslayer;
@property (strong, nonatomic) WKWebViewConfiguration *configuration;

@end

@implementation LTWebViewController

// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"页面开始加载时调用");
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"当内容开始返回时调用");
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"页面加载完成之后调用");
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(nonnull NSError *)error{
    //    ShowErrorStatus(error);
    
    [self.navigationController popViewControllerAnimated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
    });
    NSLog(@"页面加载失败时调用");
}


// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    //如果是跳转一个新页面
    
    decisionHandler(WKNavigationResponsePolicyAllow);
    NSLog(@"%@",navigationResponse.response.URL.absoluteString);
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    if (navigationAction.targetFrame == nil) {
        [webView loadRequest:navigationAction.request];
    }
    if ([navigationAction.request.URL.absoluteString containsString:@"/end.html"]){
        //如果没有需要拼接字符串redirect_url=URLEncode
        for (UIViewController *vc in self.navigationController.childViewControllers) {
            if ([vc isKindOfClass:NSClassFromString(@"SSProductDetailVC")]) {
                [self.navigationController popToViewController:vc animated:YES];
                break;
            }
        }
        decisionHandler(WKNavigationActionPolicyCancel);
    }else{
        decisionHandler(WKNavigationActionPolicyAllow);
        NSLog(@"%@",navigationAction.request.URL.absoluteString);
    }
}
//****************JS与OC交互*****************
//配置
- (WKWebViewConfiguration *)configuration{
    if (!_configuration) {
        _configuration = [[WKWebViewConfiguration alloc] init];
        WKUserContentController *userContentController = [[WKUserContentController alloc] init];
        _configuration.userContentController = userContentController;
    }
    return _configuration;
}

#pragma mark----ScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    //JS调用OC方法
    NSLog(@"body:%@",message.body);
    if ([message.name isEqualToString:@"jumpQRCode"]) {
        [self jumpQRCode];
    }
}

- (void)jumpQRCode{
//    [BeforeScanSingleton shareScan].scanResult = ^(NSString *strScan){
//        @strongify(self)
//        NSString *JSResult = [NSString stringWithFormat:@"callback('%@','%@')", index,strScan];
//        [self.webView evaluateJavaScript:JSResult completionHandler:^(id _Nullable result, NSError * _Nullable error) {
//            NSLog(@"完成....");
//        }];
//    };
}
#pragma mark----UI

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    
    //进度条
    UIView *progress = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 2)];
    progress.backgroundColor = [UIColor clearColor];
    [self.view addSubview:progress];
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, 0, 2);
    layer.backgroundColor = [UIColor lt_colorWithHexString:@"0x6686A7"].CGColor;
    [progress.layer addSublayer:layer];
    self.progresslayer = layer;
    
    [self loadURLRequest];
    
    //    [self setupBarItem];
}

- (void) setupBarItem{
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setImage:[UIImage imageNamed:@"icon_arrow_left"] forState:0];
    leftButton.frame = CGRectMake(0, 0, 25, 25);
    leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftButton addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage:[UIImage imageNamed:@"ic_dynamic_video_close"] forState:0];
    closeBtn.frame = CGRectMake(0, 0, 25, 25);
    closeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    UIBarButtonItem *popItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItems = @[popItem];
}

- (void)closeAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) loadURLRequest{
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]]];
}
#pragma mark - 观察者
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progresslayer.opacity = 1;
        self.progresslayer.frame = CGRectMake(0, 0, self.view.bounds.size.width * [change[NSKeyValueChangeNewKey] floatValue], 2);
        if ([change[NSKeyValueChangeNewKey] floatValue] == 1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progresslayer.opacity = 0;
            });
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progresslayer.frame = CGRectMake(0, 0, 0, 2);
            });
        }
    } else if ([keyPath isEqualToString:@"title"]) {
        self.navigationItem.title = change[NSKeyValueChangeNewKey];
    } else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] init];
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
        _webView.configuration.allowsInlineMediaPlayback = YES;
    }
    return _webView;
}
@end
