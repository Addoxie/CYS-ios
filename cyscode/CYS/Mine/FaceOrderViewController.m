//
//  FaceOrderViewController.m
//  CYS
//
//  Created by 谢阳晴 on 16/2/20.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import "FaceOrderViewController.h"






@interface FaceOrderViewController (){
    UIWebView *webview;
    UIImagePickerController *imagePicker;
    NavBarView *mybarview;
    JGProgressHUD *hud;
    UIButton *morebutton;
    BOOL havereload;
    
}

@end


@implementation FaceOrderViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor=KBackgroundColor;
    
    webview=[[UIWebView alloc]initWithFrame:CGRectMake(0.0f,44.0f,ScreenWidth,ScreenHeight-44)];
    webview.delegate=self;
    
    webview.scalesPageToFit=YES;
    webview.backgroundColor=KBackgroundColor;
    havereload=NO;
    [self.view addSubview:webview];
    
    NSString *tokenstr=KGetDefaultstr(@"token");
    NSLog(@"%@",tokenstr);
    
    NSString *encodetoken =[self encodeString:tokenstr];
    
    
    
    NSLog(@"%@",encodetoken);
    
    self.urslstr=[NSString stringWithFormat:@"http://rm.chengyisheng.com.cn:8080/app/doctor/toOrderList.htm?token=%@&status=%zd",encodetoken,_statustype];
    

    
    NSString *urlstr=[NSString stringWithFormat:@"%@",self.urslstr];
    //    //http://123.59.47.218:82/app/web/ProjectCity.html
    //    //http://www.zhongdianer.com/app/web/ProjectCity.html
    NSLog(@"%@",urlstr);
    NSURL *myurl=[NSURL URLWithString:urlstr];
    NSURLRequest *request=[NSURLRequest requestWithURL:myurl];
    //
    //  [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"localStorage.setItem('CYSTOKEN', '%@');",KGetDefaultstr(@"token")]];
    [webview loadRequest:request];
    //  [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"localStorage.setItem('CYSTOKEN', '%@');",KGetDefaultstr(@"token")]];
       hud=[[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleDark];
    [hud showInView:self.view];
    [hud dismissAfterDelay:15];
    
    
    
    
    
    morebutton=[UIButton buttonWithType:UIButtonTypeCustom];
    morebutton.frame=CGRectMake(ScreenWidth-65, 29, 65, 30);
    
    [morebutton setTitle:@"保存" forState:UIControlStateNormal];
    //[canclebutton setImage:[UIImage imageNamed:@"backArrow.png"] forState:UIControlStateNormal];
    // [morebutton setImage:[UIImage imageNamed:@"more.png"] forState:UIControlStateNormal];
    [morebutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [morebutton addTarget:self action:@selector(morebuttonaction) forControlEvents:UIControlEventTouchUpInside];
    
    
   // [mybarview addSubview:morebutton];
    
    
    //    UIView *bgv10=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    //    bgv10.backgroundColor=[UIColor whiteColor];
    //    [self.view addSubview:bgv10];
    
    
    // Do any additional setup after loading the view.
}
-(NSString*)encodeString:(NSString*)unencodedString{
    
    // CharactersToBeEscaped = @":/?&=;+!@#$()~',*";
    // CharactersToLeaveUnescaped = @"[].";
    
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)unencodedString,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
}
-(void)morebuttonaction{
    // [self selectPictureAction];
//    hud=[[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleDark];
//    [hud showInView:self.view];
//    [hud dismissAfterDelay:5];
//    [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"savePersonal();"]];
    // [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"saveAuthentication();"]];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    mybarview=[[NavBarView alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, 64)];
    mybarview.delegate=self;
    mybarview.navbarTitle=@"见面咨询预约";
    // mybarview.isRoot=YES;
    [mybarview setnavcanclecolor:[UIColor whiteColor]];
    // mybarview.alpha=0.7;
    mybarview.backgroundColor=KlightOrangeColor;
    [self.view addSubview:mybarview];
    self.navigationController.navigationBar.hidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden=YES;
}
-(void)itemactionWithType:(NSInteger)typeindex{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)webViewDidStartLoad:(UIWebView *)webView{
    
    //JSContext *context = [webview  valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
   // NSLog(@"%@",KGetDefaultstr(@"token"));
    
    // [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"localStorage.clear();"]];
   // [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"savePersonal('CYSTOKEN','%@');",KGetDefaultstr(@"token")]];
    // sleep(2.0);
    //    NSLog(@"%@",resultstr);
    //    NSLog(@"%@",resultstr);
    //  JSContext *context = [webview  valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    //    context[@"selectUpload"] = ^() {
    //        // return [NSString stringWithFormat:@"recieveToken('%@');",[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"token"]]];
    //      //  [self selectPictureAction];
    //
    //    };
    //    context[@"getToken"] = ^() {
    //        //[self selectPictureAction];
    //
    //        //return [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"token"]];
    //        //  NSString *str = [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"recieveToken('%@');",[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"token"]]]];
    //        //        NSString *alertJS=[NSString stringWithFormat:@""]; //准备执行的js代码
    //        //        [context evaluateScript:alertJS];
    //
    //    };
    //    NSString *str = [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"recieveToken(123123);"]];
    //    NSString *alertJS=[NSString stringWithFormat:@"sessionStorage.setItem(%@,%@);",@"demokey",@"iosqweqweqweqweqweqwqweqweqw"]; //准备执行的js代码
    //    [context evaluateScript:alertJS];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    //[webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"localStorage.clear();"]];
    
//    if (havereload==NO) {
//        [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"localStorage.clear();"]];
//        [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"localStorage.setItem('CYSTOKEN','%@');",KGetDefaultstr(@"token")]];
//        [webview reload];
//        havereload=YES;
//    }
//    
    [hud dismiss];
    //    JSContext *context = [webview  valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //    //  JSContext *context = [webview  valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //
    //    context[@"selectUpload"] = ^() {
    //      //  [self selectPictureAction];
    //
    //    };
    //    //    context[@"getToken"] = ^() {
    //    //        //[self selectPictureAction];
    //    //
    //    //         NSString *str = [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"recieveToken('%@');",[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"token"]]]];
    //    //
    //    //    };
    //    //    NSString *alertJS=@"alert('test js OC')"; //准备执行的js代码
    //    //    [context evaluateScript:alertJS];
    //    //    NSLog(@"%@", context[@"selectUpload"]);
    //    //  NSString *str = [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"recieveToken(123123);"]];
    //
    //
    //
    //    NSString *str = [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"localStorage.setItem('CYSTOKEN', '%@');",KGetDefaultstr(@"token")]];
}
-(void)getpic{
    //    [self pimagebuttonaction];
    //    NSString *urlstr=[NSString stringWithFormat:@"%@",@"http://www.baidu.com/"];
    //    //    //http://123.59.47.218:82/app/web/ProjectCity.html
    //    //    //http://www.zhongdianer.com/app/web/ProjectCity.html
    //    NSURL *myurl=[NSURL URLWithString:urlstr];
    //    NSURLRequest *request=[NSURLRequest requestWithURL:myurl];
    //    //
    //    [webview loadRequest:request];
    
}





- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSString * url = request.URL.absoluteString;
    NSLog(@"%@",url);
    
   
        return YES;
    
}

@end
