//
//  LGGetWebViewController.m
//  EducationCollection
//
//  Created by mac on 2021/5/8.
//

#import "LGGetWebViewController.h"
#import <FDFullscreenPopGesture/UINavigationController+FDFullscreenPopGesture.h>
#import <WebKit/WebKit.h>
#import "UIColor+LGExtension.h"
//加载
//#import "LGXLDotLoading.h"
//自定义导航
#import "LGNavigationView.h"

@interface LGGetWebViewController ()<UIScrollViewDelegate,WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler,UIDocumentInteractionControllerDelegate>
/**  关闭按钮 */
@property (nonatomic , strong)UIButton *closeBtn;
/**  */
@property (nonatomic , strong)WKWebView *webView;
/**  */
@property (nonatomic , assign)BOOL canGoBack;
//
@property(nonatomic ,strong)UIView * refreshView;

@end

@implementation LGGetWebViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.canGoBack = YES;
    self.fd_prefersNavigationBarHidden = YES;
    [self.view addSubview:self.navigationView];
    self.navigationView.title = self.title;
    [self.navigationView.rightBtn setTitle:@"···" forState:UIControlStateNormal];
    self.navigationView.rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.navigationView.rightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    self.navigationView.rightBtn.titleLabel.font = LGFontWeight(18, UIFontWeightSemibold);
    [self.navigationView.rightBtn setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
    [self.navigationView.rightBtn addTarget:self action:@selector(shareDocumentAction) forControlEvents:UIControlEventTouchUpInside];
    self.view.backgroundColor = [UIColor whiteColor];
    //设置网页的配置文件
    WKWebViewConfiguration * configuration = [[WKWebViewConfiguration alloc]init];
//    configuration.allowsInlineMediaPlayback = true ;
//    configuration.selectionGranularity = YES;
//    configuration.preferences.javaScriptEnabled = YES;
//    configuration.preferences.javaScriptCanOpenWindowsAutomatically = NO;
    //JS交互
//    [configuration.userContentController addScriptMessageHandler:self name:@"h5redirect"];
    
    [self creatWebViewWithConfig:configuration];

    [self.view addSubview:self.refreshView];
}

-(void)goBackAction{
    if (self.canGoBack == NO) {
        return;
    }
    if (self.webView.canGoBack == YES) {
        [self.webView goBack];
    }else{
        if (self.isPresent == YES) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

//返回
-(void)closeBtnAction{
    if (self.isPresent == YES) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//分享
-(void)shareDocumentAction{
    NSString *urlStr = ([self.urlStr containsString:@"http"] || [self.urlStr containsString:@"https"])?self.urlStr:[NSString stringWithFormat:@"%@%@",BaseUrl,self.urlStr];
    if (self.params && [self.params allKeys]>0) {
        NSArray *tempArray = self.params.allKeys;
        for (NSInteger i=0; i<tempArray.count; i++) {
            NSString *key = tempArray[i];
            NSString *segemtStr = (i==0)?@"?":@"&";
            urlStr = [NSString stringWithFormat:@"%@%@%@=%@",urlStr,segemtStr,key,self.params[key]];
        }
    }
    NSURL *url = [NSURL URLWithString:urlStr];
    if(url){
        UIActivityViewController *controller = [[UIActivityViewController alloc]initWithActivityItems:@[url] applicationActivities:nil];
        [self presentViewController:controller animated:YES completion:nil];
    }else{
        [TooltipView showMessage:@"无法预览" offset:0];
    }
    
}

//登录成功重新加载web
-(void)loginSucessAction{
    [self performSelector:@selector(reloadAction) withObject:nil afterDelay:0.2];
}

//重新加载web操作
-(void)reloadAction{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"jsss" ofType:@"html"];
    NSString *html = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:html baseURL:[[NSBundle mainBundle] bundleURL]];
}

#pragma mark--刷新web操作
-(void)retryBtnAction{
    [self reloadAction];
}


//设置标题
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))] && object == self.webView) {
        
    }else if([keyPath isEqualToString:@"title"] && object == self.webView){
        if (self.webView.title && self.webView.title.length>0) {
            self.navigationView.title = self.webView.title;
        }else{
            self.navigationView.title = (self.title.length>0)?self.title:@"详情";
        }
        
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark -- JS跳转
-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSLog(@"scriptMessage:%@---body:%@",message.name, message.body);
    if ([message.name isEqualToString:@"h5redirect"]){
//        [self H5JumpAction:message.body];
    }
}

#pragma mark --web代理
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    NSLog(@"message：%@",message);
    if ([message isEqualToString:@"needlogin"]) {
//        [self ifLoginWithHiddeBar:NO loginfrom:@"15" success:nil];
        completionHandler();
        return;
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.webView reload];
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    NSLog(@"message：%@",message);
    NSString *jscript1 = [NSString stringWithFormat:@"h5pay();"];
    [self.webView evaluateJavaScript:jscript1 completionHandler:nil];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    [alertController addAction:([UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields[0].text?:@"");
    }])];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    WKNavigationActionPolicy actionPolicy = WKNavigationActionPolicyAllow;
    //这句是必须加上的，不然会异常
    decisionHandler(actionPolicy);
}


// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    NSLog(@"decidePolicyForNavigationResponse：%@",navigationResponse);
    WKNavigationResponsePolicy actionPolicy = WKNavigationResponsePolicyAllow;
    //这句是必须加上的，不然会异常
    decisionHandler(actionPolicy);
}

//页面开始加载时调用
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    self.refreshView.hidden = NO ;
//    [LGXLDotLoading showInView:self.refreshView];
}

//加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    NSDictionary *dic = error.userInfo;
    NSMutableString *errorKey = [[NSMutableString alloc] initWithFormat:@"%@",dic[@"NSErrorFailingURLKey"]];
    
    self.refreshView.hidden = YES ;
//    [LGXLDotLoading hideInView:self.refreshView];
    //打电话
    if ([errorKey containsString:@"tel:"]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:errorKey]];
     
    }else{
//        [self.emptyView showFaildViewWithImageName:@"emptyViewBG" andDes:@"亲，网络不给力啊~" offset:0];
    }
}

//加载完成时调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    if (self.webView.canGoBack == YES) {
        self.closeBtn.hidden = NO;
    }else{
        self.closeBtn.hidden = YES;
    }
    
    self.refreshView.hidden = YES;
//    [LGXLDotLoading hideInView:self.refreshView];
}


#pragma mark -- 创建控件
-(void)creatWebViewWithConfig:(WKWebViewConfiguration *)configuration{
    //创建WKWebView
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, topBarHeight , Screen_W, Screen_H - topBarHeight) configuration:configuration];
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"jsss" ofType:@"html"];
//    NSString *html = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
//    [webView loadHTMLString:html baseURL:[[NSBundle mainBundle] bundleURL]];
    webView.scrollView.bounces = NO;
    webView.navigationDelegate = self;
    webView.UIDelegate = self;
    [webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    [webView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:0 context:nil];
    self.webView = webView;
    [self.view addSubview:webView];
    
    NSString *urlStr = ([self.urlStr containsString:@"http"] || [self.urlStr containsString:@"https"])?self.urlStr:[NSString stringWithFormat:@"%@%@",BaseUrl,self.urlStr];
    if (self.params && [self.params allKeys]>0) {
        NSArray *tempArray = self.params.allKeys;
        for (NSInteger i=0; i<tempArray.count; i++) {
            NSString *key = tempArray[i];
            NSString *segemtStr = (i==0)?@"?":@"&";
            urlStr = [NSString stringWithFormat:@"%@%@%@=%@",urlStr,segemtStr,key,self.params[key]];
        }
    }
    //评估H5连接需要这个
    if(self.withAsset == YES){
        urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [self.webView loadRequest:request];
}

//-(LGNavigationView *)navigationView{
//    if(!_navigationView){
//        _navigationView = [[LGNavigationView alloc]initWithFrame:CGRectMake(0, 0, Screen_W, topBarHeight)];
//        _navigationView.title = (self.title.length>0)?self.title:@"详情";
//        [_navigationView.backBtn addTarget:self action:@selector(goBackAction) forControlEvents:UIControlEventTouchUpInside];
//        [_navigationView addSubview:self.closeBtn];
//    }
//    return _navigationView;
//}

-(UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeBtn.frame = CGRectMake(49, statusBarHeight, 44, 44);
        [_closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
        [_closeBtn setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        [_closeBtn setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateHighlighted];
        _closeBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_closeBtn addTarget:self action:@selector(closeBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _closeBtn.hidden = YES;
    }
    return _closeBtn;
}

-(UIView *)refreshView{
    if (!_refreshView) {
        _refreshView = [[UIView alloc]initWithFrame:CGRectMake(0,(Screen_H-viewPix(50))/2+viewPix(20), Screen_W, viewPix(50))];
        _refreshView.backgroundColor = [UIColor clearColor] ;
    }
    return _refreshView ;
}


- (void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"title"];
    [self.webView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
