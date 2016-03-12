//
//  AddBankCardViewController.m
//  CYS
//
//  Created by 谢阳晴 on 16/3/1.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import "AddBankCardViewController.h"


@interface AddBankCardViewController ()
{
    
    JGProgressHUD *hud;
    NavBarView *mybarview;
    UIButton *morebutton;
    UIWebView *webview;
    BOOL havereload;
}

@end


@implementation AddBankCardViewController
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
    mybarview.navbarTitle=@"添加银行卡";
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
    
//    
//    if (self.needhidemorebtn) {
//        
//    } else {
//         [mybarview addSubview:morebutton];
//    }
   [mybarview addSubview:morebutton];
    
    
}

-(void)morebuttonaction{
    hud=[[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleDark];
    [hud showInView:self.view];
    [hud dismissAfterDelay:15];

   [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@();",@"addBankCard"]];
//    NSLog(@"%@",resultstr);
//    [self.navigationController popViewControllerAnimated:YES];
//    [self.delegate AddBankCardDealtdataMethodname:@"" stringval:resultstr type:0];
    
    
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
    
    
    
    NSString *urlString = [[request URL] absoluteString];
    NSArray *urlComps = [urlString componentsSeparatedByString:@"://"];
    if([urlComps count] && [[urlComps objectAtIndex:0] isEqualToString:@"cysnative"])
    {
        NSArray *arrFucnameAndParameter = [(NSString*)[urlComps objectAtIndex:1] componentsSeparatedByString:@":**:"];
        NSString *funcStr = [arrFucnameAndParameter objectAtIndex:0];
        
        
        if (1 == [arrFucnameAndParameter count])
        {
            NSLog(@"%@",arrFucnameAndParameter);
            // 没有参数
            if([funcStr isEqualToString:@"localAddBankCardSuccess"])
            {
                /*调用本地函数*/
                //   [self testFunc];
                [hud dismiss];
                [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
                [[PublicTools shareInstance]creareNotificationUIView:@"添加银行卡成功"];
                
                [self.navigationController popViewControllerAnimated:YES];
                
                
            }
        }
        else if(2 == [arrFucnameAndParameter count])
        {
            NSLog(@"%@",arrFucnameAndParameter);
            //有参数的
//            if([funcStr isEqualToString:@"localAddBankCardSuccess:"] && [arrFucnameAndParameter objectAtIndex:1])
//            {
//                [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//                [[PublicTools shareInstance]creareNotificationUIView:@"添加银行卡成功"];
//
//                [self.navigationController popViewControllerAnimated:YES];
//            }
        }
        return NO;
    }

    
    
    
    if([url rangeOfString:@"input.html"].location !=NSNotFound){
        EnterBandCardInfoViewController *VC=[[EnterBandCardInfoViewController alloc]init];
        
        VC.delegate=self;
        VC.urslstr=url;
        
        NSLog(@"%@",[[[[url componentsSeparatedByString:@"?"] objectAtIndex:1] componentsSeparatedByString:@"="] objectAtIndex:0]);
        VC.targetstr=[[[[url componentsSeparatedByString:@"?"] objectAtIndex:1] componentsSeparatedByString:@"="] objectAtIndex:0];
        if ([VC.targetstr isEqualToString:@"Branch"]) {
            VC.targettype=0;
            VC.title=@"支行名字";
            
        }else if ([VC.targetstr isEqualToString:@"Bank_number"]) {
              VC.targettype=1;
              VC.title=@"银行卡号";
            
        }else if ([VC.targetstr isEqualToString:@"Bank_user_name"]) {
            
              VC.targettype=2;
              VC.title=@"持卡人姓名";
        }
        
        // VC.urslstr=[NSString stringWithFormat:@"%@%@",k_webbaseurl,@"wallet.html"];
        // @"http://rm.chengyisheng.com.cn:8080/app_web/app_doctor_web/view/authentication.html";
        
        [self.navigationController pushViewController:VC animated:YES];
        return NO;
    }

    
    
    return YES;
}
-(void)EnterBandCardInfodataMethodname:(NSString *)methodname stringval:(NSString *)stringval type:(NSInteger)type{
    if (type==0) {
        [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"changeBranch('%@');",stringval]];
        
    }else if (type==1) {
        [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"changeBankNumber('%@');",stringval]];
    }else if (type==2) {
        [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"changeBankUserName('%@');",stringval]];
    }
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
    [hud dismiss];
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
