//
//  PatientHistoryViewController.m
//  CYS
//
//  Created by 谢阳晴 on 16/3/4.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import "PatientHistoryViewController.h"
#import "PhotoBroswerVC.h"

@interface PatientHistoryViewController ()
{
    
    JGProgressHUD *hud;
    NavBarView *mybarview;
    UIButton *morebutton;
    UIWebView *webview;
    BOOL havereload;
}

@end

@implementation PatientHistoryViewController

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
    mybarview.navbarTitle=@"病人病例";
    [mybarview setnavcanclecolor:[UIColor whiteColor]];
    [mybarview setnavcancletitle:@" 返回"];
    [mybarview setnavcancletimage:@"back"];
    
    mybarview.backgroundColor=KlightOrangeColor;
    [self.view addSubview:mybarview];
    UIView *bgv=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    bgv.backgroundColor=KlightOrangeColor;
    [self.view addSubview:bgv];
    
    
    //    morebutton=[UIButton buttonWithType:UIButtonTypeCustom];
    //    morebutton.frame=CGRectMake(ScreenWidth-65, 25, 65, 30);
    //
    //    [morebutton setTitle:@"保存" forState:UIControlStateNormal];
    //    //[canclebutton setImage:[UIImage imageNamed:@"backArrow.png"] forState:UIControlStateNormal];
    //    // [morebutton setImage:[UIImage imageNamed:@"more.png"] forState:UIControlStateNormal];
    //    [morebutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [morebutton addTarget:self action:@selector(morebuttonaction) forControlEvents:UIControlEventTouchUpInside];
    
    //
    //    if (self.needhidemorebtn) {
    //
    //    } else {
    //         [mybarview addSubview:morebutton];
    //    }
    //   [mybarview addSubview:morebutton];
    
    
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
            if([funcStr isEqualToString:@"selectPictureAction"])
            {
                /*调用本地函数*/
                //   [self testFunc];
                //                if ([KGetDefaultstr(@"userstatus") isEqualToString:@"AUDIT_PASSED"]) {
                //
                //                }else{
                //
                //                }
                
                if ([KGetDefaultstr(@"userstatus") isEqualToString:@"AUDIT_PASSED"]) {
                    [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
                    
                    [[PublicTools shareInstance]creareNotificationUIView:@"已经通过认证，修改请联系客服"];
                }else{
                    
                }
                
                
            }
        }
        else if(2 == [arrFucnameAndParameter count])
        {
            NSLog(@"%@",arrFucnameAndParameter);
            //有参数的
            if([funcStr isEqualToString:@"showpicaction:"] && [arrFucnameAndParameter objectAtIndex:1])
            {
                NSArray *urlarr=[urlString componentsSeparatedByString:@":**:"];
                NSString *imageurlstr=[urlarr objectAtIndex:1];
                
                NSString *newimageurlstr=[self URLDecodedString:imageurlstr];
                // NSLog(@"%@",newimageurlstr);
                NSData *jsondata=[imageurlstr dataUsingEncoding:NSUTF8StringEncoding];
                
                
                
                
                
                if (jsondata!=nil) {
                    NSDictionary *jsondic=[self dictionaryWithJsonString:newimageurlstr];
                    NSLog(@"%@",jsondic);
                    
                    NSMutableArray *imagearr=[[NSMutableArray alloc]initWithArray:[jsondic objectForKey:@"imgList"]];
                    NSMutableArray *imageurlarr=[[NSMutableArray alloc]init];
                    for (NSString *tmpimageurlstr in imagearr) {
                        NSString *imagerul=tmpimageurlstr;
                        [imageurlarr addObject:imagerul];
                    }
                    
                    
                    
                    [PhotoBroswerVC show:self type:PhotoBroswerVCTypePush index:[[jsondic objectForKey:@"index"] integerValue] photoModelBlock:^NSMutableArray *{
                        
                        
                        NSMutableArray *networkImages=imageurlarr;
                        NSMutableArray *modelsM = [NSMutableArray arrayWithCapacity:networkImages.count];
                        
                        for (NSUInteger i = 0; i< networkImages.count; i++) {
                            
                            PhotoModel *pbModel=[[PhotoModel alloc] init];
                            pbModel.mid = i + 1;
                            //            pbModel.title = [NSString stringWithFormat:@"这是标题%@",@(i+1)];
                            //            pbModel.desc = [NSString stringWithFormat:@"我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字%@",@(i+1)];
                            pbModel.image_HD_U = networkImages[i];
                            //                        pbModel.feebackimageid=[[imagearr objectAtIndex:indexPath.row] objectForKey:@"id"];
                            //                        pbModel.feebackpostid=[dic objectForKey:@"id"];
                            pbModel.havefeeback=NO;
                            //源frame
                            
                            UIImageView *imageV =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
                            pbModel.sourceImageView = imageV;
                            
                            [modelsM addObject:pbModel];
                        }
                        
                        return modelsM;
                    }];
                    
                    
                    
                    
                }
                
                
                
                /*调用本地函数*/
                // [self printLog:@"js调用本地带参数的方法成功！"];
            }
        }
        return NO;
    };
    
    
    
    
    return YES;
}
-(NSString *)URLDecodedString:(NSString *)str
{
    NSString *decodedString=(__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)str, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    return decodedString;
}
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
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
