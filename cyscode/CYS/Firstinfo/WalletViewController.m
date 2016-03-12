//
//  WalletViewController.m
//  CYS
//
//  Created by 谢阳晴 on 16/2/23.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import "WalletViewController.h"
#import "AddBankCardViewController.h"

#import "EnterBandCardInfoViewController.h"

@interface WalletViewController ()
{
    
    JGProgressHUD *hud;
    NavBarView *mybarview;
    UIButton *morebutton;
    UIWebView *webview;
    BOOL havereload;
}

@end

@implementation WalletViewController

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
    mybarview.navbarTitle=@"钱包";
    [mybarview setnavcanclecolor:[UIColor whiteColor]];
    [mybarview setnavcancletitle:@" 返回"];
    [mybarview setnavcancletimage:@"back"];
    
    mybarview.backgroundColor=KlightOrangeColor;
    [self.view addSubview:mybarview];
    UIView *bgv=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    bgv.backgroundColor=KlightOrangeColor;
    [self.view addSubview:bgv];
    
    
    morebutton=[UIButton buttonWithType:UIButtonTypeCustom];
    morebutton.frame=CGRectMake(ScreenWidth-85, 29, 85, 30);
    
    [morebutton setTitle:@"账户明细" forState:UIControlStateNormal];
    //[canclebutton setImage:[UIImage imageNamed:@"backArrow.png"] forState:UIControlStateNormal];
    // [morebutton setImage:[UIImage imageNamed:@"more.png"] forState:UIControlStateNormal];
    [morebutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [morebutton addTarget:self action:@selector(morebuttonaction) forControlEvents:UIControlEventTouchUpInside];
    
    
    [mybarview addSubview:morebutton];
    
    
}

-(void)morebuttonaction{
    
    
    AcountDetailViewController *VC=[[AcountDetailViewController alloc]init];
    
    VC.title=@"账户明细";

     VC.urslstr=[NSString stringWithFormat:@"%@%@",k_webbaseurl,@"accountDetail.html"];
  //  VC.urslstr=@"http://rm.chengyisheng.com.cn:8080/app_web/app_doctor_web/view/accountDetail.html";
    
    [self.navigationController pushViewController:VC animated:YES];

//    NSString *resultstr=[webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@();",@"saveExpertiseSickArray"]];
//    NSLog(@"%@",resultstr);
//      [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"localStorage.clear();"]];
//    [self.navigationController popViewControllerAnimated:YES];
//    [self.delegate WalletDealtdataMethodname:self.methodname stringval:resultstr];
    
    
}
-(NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString {
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
    return responseJSON;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    //[webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"localStorage.clear();"]];
    //  mybarview.navbarTitle= [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
//    [mybarview setnavtitle:[webView stringByEvaluatingJavaScriptFromString:@"document.title"]];
//    NSLog(@"%@",[webView stringByEvaluatingJavaScriptFromString:@"document.title"]);
    if (havereload==NO) {
        [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"localStorage.clear();"]];
        [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"localStorage.setItem('CYSTOKEN','%@');",KGetDefaultstr(@"token")]];
        [webview reload];
        havereload=YES;
    }

    [hud dismiss];
    
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSString * url = request.URL.absoluteString;
      NSLog(@"%@",url);
    if([url rangeOfString:@"addBankCard"].location !=NSNotFound){
        AddBankCardViewController *VC=[[AddBankCardViewController alloc]init];
        VC.urslstr=url;
        // VC.urslstr=[NSString stringWithFormat:@"%@%@",k_webbaseurl,@"wallet.html"];
        // @"http://rm.chengyisheng.com.cn:8080/app_web/app_doctor_web/view/authentication.html";
        
        [self.navigationController pushViewController:VC animated:YES];
        return NO;
    }else if([url rangeOfString:@"bankMessage"].location !=NSNotFound){
        EnterBandCardInfoViewController *VC=[[EnterBandCardInfoViewController alloc]init];
        VC.urslstr=url;
        VC.title=@"银行卡信息";
        VC.needhidemorebtn=YES;
        // VC.urslstr=[NSString stringWithFormat:@"%@%@",k_webbaseurl,@"wallet.html"];
        // @"http://rm.chengyisheng.com.cn:8080/app_web/app_doctor_web/view/authentication.html";
        
        [self.navigationController pushViewController:VC animated:YES];
        return NO;
    }
    
    
    return YES;
}

-(void)itemactionWithType:(NSInteger)typeindex{
    
    if (webview.canGoBack) {
        [webview goBack];
    } else {
          [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"localStorage.clear();"]];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [webview reload];
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
