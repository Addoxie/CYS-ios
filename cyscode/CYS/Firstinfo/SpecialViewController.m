//
//  SpecialViewController.m
//  CYS
//
//  Created by 谢阳晴 on 16/2/19.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import "SpecialViewController.h"



@interface SpecialViewController ()
{
    
    JGProgressHUD *hud;
    NavBarView *mybarview;
    UIButton *morebutton;
    UIWebView *webview;
}


@end



@implementation SpecialViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    
    
    
    webview=[[UIWebView alloc]initWithFrame:CGRectMake(0.0f,44.0f,ScreenWidth,ScreenHeight-44)];
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
    hud=[[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleDark];
    [hud showInView:self.view];
    [hud dismissAfterDelay:15];
    
    [webview loadRequest:request];
    
    
    
    
    
    mybarview=[[NavBarView alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, 64)];
    mybarview.delegate=self;
    mybarview.navbarTitle=@"专长";
    [mybarview setnavcanclecolor:[UIColor whiteColor]];
    [mybarview setnavcancletitle:@" 返回"];
    [mybarview setnavcancletimage:@"back"];
    
    mybarview.backgroundColor=KlightOrangeColor;
    [self.view addSubview:mybarview];
    UIView *bgv=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    bgv.backgroundColor=KlightOrangeColor;
    [self.view addSubview:bgv];
    
    
    morebutton=[UIButton buttonWithType:UIButtonTypeCustom];
    morebutton.frame=CGRectMake(ScreenWidth-65, 29, 65, 30);
    
    [morebutton setTitle:@"保存" forState:UIControlStateNormal];
    //[canclebutton setImage:[UIImage imageNamed:@"backArrow.png"] forState:UIControlStateNormal];
    // [morebutton setImage:[UIImage imageNamed:@"more.png"] forState:UIControlStateNormal];
    [morebutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [morebutton addTarget:self action:@selector(morebuttonaction) forControlEvents:UIControlEventTouchUpInside];
    
    
    [mybarview addSubview:morebutton];
    
    
}

-(void)morebuttonaction{
    NSString *resultstr=[webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@();",@"saveExpertiseSickArray"]];
    NSLog(@"%@",resultstr);
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate SpecialDealtdataMethodname:self.methodname stringval:resultstr];
    
  
}
-(NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString {
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
    return responseJSON;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    //[webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"localStorage.clear();"]];
    //  mybarview.navbarTitle= [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [mybarview setnavtitle:[webView stringByEvaluatingJavaScriptFromString:@"document.title"]];
    NSLog(@"%@",[webView stringByEvaluatingJavaScriptFromString:@"document.title"]);
    [hud dismiss];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSString * url = request.URL.absoluteString;
    
    
    
    
    
    
    
    
    return YES;
}

-(void)itemactionWithType:(NSInteger)typeindex{
    
    if (webview.canGoBack) {
        [webview goBack];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[pimagev sd_setImageWithURL:[NSURL URLWithString:[self.alldic objectForKey:@"icon-url"]] placeholderImage:nil];
    self.navigationController.navigationBar.hidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden=NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
