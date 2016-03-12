//
//  EnterBandCardInfoViewController.m
//  CYS
//
//  Created by 谢阳晴 on 16/3/1.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import "EnterBandCardInfoViewController.h"


@interface EnterBandCardInfoViewController ()
{
    
    JGProgressHUD *hud;
    NavBarView *mybarview;
    UIButton *morebutton;
    UIWebView *webview;
}

@end


@implementation EnterBandCardInfoViewController
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
    mybarview.navbarTitle=self.title;
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
    
        if (self.needhidemorebtn) {
    
        } else {
             [mybarview addSubview:morebutton];
        }

  //  [mybarview addSubview:morebutton];
    
    
}

-(void)morebuttonaction{
    if (self.targettype==0) {
        NSString *resultstr= [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@();",@"getBranch"]];
        NSLog(@"%@",resultstr);
        NSData *jsondata=[resultstr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *mydic = [NSJSONSerialization JSONObjectWithData:jsondata options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@",mydic);
        if ([[mydic objectForKey:@"state"] boolValue]==false) {
          NSLog(@"%@",resultstr);
            
        }else{
            [self.delegate EnterBandCardInfodataMethodname:@"" stringval:[mydic objectForKey:@"input"] type:self.targettype];
            [self.navigationController popViewControllerAnimated:YES];
        }
       

    } else if (self.targettype==1) {
        NSString *resultstr= [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@();",@"getBankNumber"]];
        NSLog(@"%@",resultstr);
        NSData *jsondata=[resultstr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *mydic = [NSJSONSerialization JSONObjectWithData:jsondata options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@",mydic);
        if ([[mydic objectForKey:@"state"] boolValue]==false) {
            NSLog(@"%@",resultstr);
            
        }else{
            [self.delegate EnterBandCardInfodataMethodname:@"" stringval:[mydic objectForKey:@"input"] type:self.targettype];
            [self.navigationController popViewControllerAnimated:YES];
        }


    } else if (self.targettype==2) {
        NSString *resultstr= [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@();",@"getBankUserName"]];
        NSLog(@"%@",resultstr);
        NSData *jsondata=[resultstr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *mydic = [NSJSONSerialization JSONObjectWithData:jsondata options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@",mydic);
        if ([[mydic objectForKey:@"state"] boolValue]==false) {
            NSLog(@"%@",resultstr);
            
        }else{
            [self.delegate EnterBandCardInfodataMethodname:@"" stringval:[mydic objectForKey:@"input"] type:self.targettype];
            [self.navigationController popViewControllerAnimated:YES];
        }


  }
   
//    NSLog(@"%@",resultstr);
//    [self.navigationController popViewControllerAnimated:YES];
   
    
    
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
    [hud dismiss];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
   // NSString * url = request.URL.absoluteString;
    
    NSString *urlString = [[request URL] absoluteString];
    NSArray *urlComps = [urlString componentsSeparatedByString:@"://"];
    if([urlComps count] && [[urlComps objectAtIndex:0] isEqualToString:@"cysnative"])
    {
        NSArray *arrFucnameAndParameter = [(NSString*)[urlComps objectAtIndex:1] componentsSeparatedByString:@":**:"];
        NSLog(@"%@",arrFucnameAndParameter);
        NSString *funcStr = [arrFucnameAndParameter objectAtIndex:0];
        
        
        if (1 == [arrFucnameAndParameter count])
        {
            NSLog(@"%@",arrFucnameAndParameter);
            // 没有参数
            if([funcStr isEqualToString:@"selectPictureAction"])
            {
                /*调用本地函数*/
                //   [self testFunc];
                
               
            }
        }
        else if(2 == [arrFucnameAndParameter count])
        {
            NSLog(@"%@",arrFucnameAndParameter);
            //有参数的
//            if([funcStr isEqualToString:@"localAddBankCardSuccess"] && [arrFucnameAndParameter objectAtIndex:1])
//            {
//                
//            }
        }
        return NO;
    }

    
    
    
    
    
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
