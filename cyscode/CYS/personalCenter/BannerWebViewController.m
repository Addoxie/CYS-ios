//
//  BannerWebViewController.m
//  CYS
//
//  Created by 谢阳晴 on 16/2/17.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import "BannerWebViewController.h"


@interface BannerWebViewController (){
    UIWebView *webview;
}

@end

@implementation BannerWebViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        self.view.backgroundColor=KBackgroundColor;
    //    _codetf1=[self getTextFieldWithFrame:CGRectMake(0, 70, ScreenWidth, 45) theneedSecure:NO];
    //    _codetf1.delegate=self;
    //    _codetf1.textColor=KBlackColor;
    //    _codetf1.backgroundColor=[UIColor whiteColor];
    //   // _codetf1.text=self.oldname;
    //    _codetf1.tintColor=KOrangeColor;
    //    _codetf1.clearButtonMode=UITextFieldViewModeAlways;
    //    _codetf1.returnKeyType=UIReturnKeyDone;
    //
    //    KtfAddpaddingView(_codetf1);
    //    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:)
    //                                                name:UITextFieldTextDidChangeNotification
    //                                              object:_codetf1];
    //
    //    [self.view addSubview:_codetf1];
    //    self.view.backgroundColor=KBackgroundColor;
    
    webview=[[UIWebView alloc]initWithFrame:CGRectMake(0.0f,0.0f,ScreenWidth,ScreenHeight)];
    webview.delegate=self;
    
    webview.scalesPageToFit=YES;
    webview.backgroundColor=KBackgroundColor;
    
    [self.view addSubview:webview];
    
    NSString *urlstr=[NSString stringWithFormat:@"%@",self.urslstr];
    //    //http://123.59.47.218:82/app/web/ProjectCity.html
    //    //http://www.zhongdianer.com/app/web/ProjectCity.html
    NSLog(@"%@",urlstr);
    NSURL *myurl=[NSURL URLWithString:urlstr];
    NSURLRequest *request=[NSURLRequest requestWithURL:myurl];
    //
    [webview loadRequest:request];
    
    
    
    
    
    
    self.navigationController.navigationBar.hidden=NO;
    
    // [_codetf1 becomeFirstResponder];
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=NO;
}
@end
