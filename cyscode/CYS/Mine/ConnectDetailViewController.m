//
//  ConnectDetailViewController.m
//  CYS
//
//  Created by 谢阳晴 on 16/1/12.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import "ConnectDetailViewController.h"
#import "CallingViewController.h"
#import "PatientChatViewController.h"
#import "PhotoBroswerVC.h"



//@interface ConnectDetailViewController (){
//    UIButton *_actionButton;
//}
//
//@end

@interface ConnectDetailViewController ()
{
    
    JGProgressHUD *hud;
    NavBarView *mybarview;
    UIButton *morebutton;
    UIWebView *webview;
    BOOL havereload;
     UIButton *_actionButton;
}

@end


@implementation ConnectDetailViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    
    if (self.isphone) {
         webview=[[UIWebView alloc]initWithFrame:CGRectMake(0.0f,44.0f,ScreenWidth,ScreenHeight-44)];
    } else {
         webview=[[UIWebView alloc]initWithFrame:CGRectMake(0.0f,44.0f,ScreenWidth,ScreenHeight-44-80)];
    }
   
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
    mybarview.navbarTitle=@"咨询详情";
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
    
    if (self.isphone) {
        
    } else {
        UIView *bgv1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 80)];
        
        bgv1.backgroundColor=KBackgroundColor;
        _actionButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _actionButton.tag=1002;
        _actionButton.frame=CGRectMake(15, ScreenHeight-80, ScreenWidth-30, 60);
        _actionButton.layer.masksToBounds = YES;
        _actionButton.layer.cornerRadius = 5.0;
        _actionButton.layer.borderWidth = 1.0;
        _actionButton.layer.borderColor = [KlightOrangeColor CGColor];
        
        if (self.isphone) {
            [_actionButton setTitle:@"拨打电话" forState:UIControlStateNormal];
        }else{
            [_actionButton setTitle:@"回复" forState:UIControlStateNormal];
        }
        // [_actionButton setTitle:@"拨打电话" forState:UIControlStateNormal];
        //  [_actionButton setTitle:@"挂电话" forState:UIControlStateSelected];
        [_actionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _actionButton.titleLabel.font=[UIFont systemFontOfSize:22.0];
        _actionButton.backgroundColor=KlightOrangeColor;
        [_actionButton addTarget:self action:@selector(buttonaction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_actionButton];

    }
    
    
    
    
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



//-(void)viewDidLoad{
//    [super viewDidLoad];
//   // self.isphone=YES;
//    
//    
//    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, ScreenHeight-20-90) style:UITableViewStyleGrouped];
//    self.tableView.delegate=self;
//    
//    self.tableView.dataSource=self;
//    self.title=@"咨询";
//    [self.view addSubview:self.tableView];
//    
//    UIView *bgv=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 80)];
//    
//    bgv.backgroundColor=KBackgroundColor;
//    _actionButton=[UIButton buttonWithType:UIButtonTypeCustom];
//    _actionButton.tag=1002;
//    _actionButton.frame=CGRectMake(15, ScreenHeight-80, ScreenWidth-30, 60);
//    _actionButton.layer.masksToBounds = YES;
//    _actionButton.layer.cornerRadius = 5.0;
//    _actionButton.layer.borderWidth = 1.0;
//    _actionButton.layer.borderColor = [KlightOrangeColor CGColor];
//    
//    if (self.isphone) {
//        [_actionButton setTitle:@"拨打电话" forState:UIControlStateNormal];
//    }else{
//        [_actionButton setTitle:@"回复" forState:UIControlStateNormal];
//    }
//    // [_actionButton setTitle:@"拨打电话" forState:UIControlStateNormal];
//    //  [_actionButton setTitle:@"挂电话" forState:UIControlStateSelected];
//    [_actionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    _actionButton.titleLabel.font=[UIFont systemFontOfSize:22.0];
//    _actionButton.backgroundColor=KlightOrangeColor;
//    [_actionButton addTarget:self action:@selector(buttonaction) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_actionButton];
//
//    
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 0.01;
//}
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//   
//    if (indexPath.row==0) {
//        return 64.0;
//    } else if (indexPath.row==1) {
//        return 74.0;
//    }else{
//        
//        UIFont *font=[UIFont systemFontOfSize:15.0];
//        
//        CGRect strsize=KStringSize(@"爱词霸权威在线词典,为您提供描述的中文意思,描述的用法讲解,描述的读音,描述的同义词,描述的反义词,描述的例句等英语服务。爱词霸权威在线词典,为您提供描述的中文意思,描述的用法讲解,描述的读音,描述的同义词,描述的反义词,描述的例句等英语服务。爱词霸权威在线词典,为您提供描述的中文意思,描述的用法讲解,描述的读音,描述的同义词,描述的反义词,描述的例句等英语服务。爱词霸权威在线词典,为您提供描述的中文意思,描述的用法讲解,描述的读音,描述的同义词,描述的反义词,描述的例句等英语服务。爱词霸权威在线词典,为您提供描述的中文意思,描述的用法讲解,描述的读音,描述的同义词,描述的反义词,描述的例句等英语服务。爱词霸权威在线词典,为您提供描述的中文意思,描述的用法讲解,描述的读音,描述的同义词,描述的反义词,描述的例句等英语服务。爱词霸权威在线词典,为您提供描述的中文意思,描述的用法讲解,描述的读音,描述的同义词,描述的反义词,描述的例句等英语服务。爱词霸权威在线词典,为您提供描述的中文意思,描述的用法讲解,描述的读音,描述的同义词,描述的反义词,描述的例句等英语服务。爱词霸权威在线词典,为您提供描述的中文意思,描述的用法讲解,描述的读音,描述的同义词,描述的反义词,描述的例句等英语服务。爱词霸权威在线词典,为您提供描述的中文意思,描述的用法讲解,描述的读音,描述的同义词,描述的反义词,描述的例句等英语服务。爱词霸权威在线词典,为您提供描述的中文意思,描述的用法讲解,描述的读音,描述的同义词,描述的反义词,描述的例句等英语服务。爱词霸权威在线词典,为您提供描述的中文意思,描述的用法讲解,描述的读音,描述的同义词,描述的反义词,描述的例句等英语服务。爱词霸权威在线词典,为您提供描述的中文意思,描述的用法讲解,描述的读音,描述的同义词,描述的反义词,描述的例句等英语服务。爱词霸权威在线词典,为您提供描述的中文意思,描述的用法讲解,描述的读音,描述的同义词,描述的反义词,描述的例句等英语服务。爱词霸权威在线词典,为您提供描述的中文意思,描述的用法讲解,描述的读音,描述的同义词,描述的反义词,描述的例句等英语服务。爱词霸权威在线词典,为您提供描述的中文意思,描述的用法讲解,描述的读音,描述的同义词,描述的反义词,描述的例句等英语服务。爱词霸权威在线词典,为您提供描述的中文意思,描述的用法讲解,描述的读音,描述的同义词,描述的反义词,描述的例句等英语服务。爱词霸权威在线词典,为您提供描述的中文意思,描述的用法讲解,描述的读音,描述的同义词,描述的反义词,描述的例句等英语服务。爱词霸权威在线词典,为您提供描述的中文意思,描述的用法讲解,描述的读音,描述的同义词,描述的反义词,描述的例句等英语服务。爱词霸权威在线词典,为您提供描述的中文意思,描述的用法讲解,描述的读音,描述的同义词,描述的反义词,描述的例句等英语服务。爱词霸权威在线词典,为您提供描述的中文意思,描述的用法讲解,描述的读音,描述的同义词,描述的反义词,描述的例句等英语服务。爱词霸权威在线词典,为您提供描述的中文意思,描述的用法讲解,描述的读音,描述的同义词,描述的反义词,描述的例句等英语服务。爱词霸权威在线词典,为您提供描述的中文意思,描述的用法讲解,描述的读音,描述的同义词,描述的反义词,描述的例句等英语服务。爱词霸权威在线词典,为您提供描述的中文意思,描述的用法讲解,描述的读音,描述的同义词,描述的反义词,描述的例句等英语服务。", ScreenWidth-20, font);
//        
//        if (strsize.size.height+25>64.0*3.5) {
//             return strsize.size.height+25+30;
//        } else {
//             return 64.0*3.5;
//        }
//       
//    }
//}
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 3;
//}
//
//
////-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
////   
////   
////    return bgv;
////}
////-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
////    return 80;
////}
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    UITableViewCell *cell=nil;
//    if (cell==nil) {
//        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"usercell"];
//    }
//    
//    
//    if (indexPath.row==0) {
//        UIImageView *imagev;
//        //=[[UIImageView alloc]init];
//        
//        
//        imagev =[[UIImageView alloc]initWithFrame:CGRectMake(10, 8, 44, 44)];
//        //   imagev.frame=CGRectMake(10, 8, 44, 44);
//        
//        
//        
//        
//        imagev.clipsToBounds=YES;
//        
//        imagev.layer.masksToBounds=YES;
//        imagev.layer.cornerRadius =22.0;
//        imagev.layer.borderColor = [UIColor clearColor].CGColor;
//        imagev.layer.rasterizationScale = [UIScreen mainScreen].scale;
//        
//        // imagev.image=[UIImage imageNamed:@"KAKA"];
//        //  NSLog(@"%@",[NSString stringWithFormat:@"%@",[datadic objectForKey:@"icon"]]);
//       [imagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[self.patientdatadic objectForKey:@"icon"]]] placeholderImage:[UIImage imageNamed:kPlaceholderimage]];
//        [cell addSubview:imagev];
//        
//        UILabel *label=[[UILabel alloc]init];
//        label.frame=CGRectMake(60, 8, 90, 30);
//        label.textColor=KBlackColor;
//        label.font=[UIFont systemFontOfSize:16.0];
//        label.backgroundColor=[UIColor clearColor];
//        [cell addSubview:label];
//        
//        //label.text=
//        NSString *contentstring=[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@",[[self.patientdatadic objectForKey:@"patient"] objectForKey:@"name"]]];
//        
//        NSMutableAttributedString *astring=[[NSMutableAttributedString alloc]initWithString:contentstring];
//        
//        
//        label.attributedText=astring;
//        
//        UILabel *desclabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-190, 7, 180, 30)];
//        desclabel.frame=CGRectMake(60, 30, 180, 30);
//        desclabel.textColor=KLineColor;
//        desclabel.font=[UIFont systemFontOfSize:13.0];
//        desclabel.backgroundColor=[UIColor clearColor];
//        [cell addSubview:desclabel];
//        desclabel.text=[NSString stringWithFormat:@"%@",[[[self.patientdatadic objectForKey:@"auditable"] objectForKey:@"date_created"] substringToIndex:10]];
//        
//        
//        UILabel *sexAgelabel=[[UILabel alloc]init];
//        sexAgelabel.frame=CGRectMake(150, 8, 60, 30);
//        sexAgelabel.textColor=KLineColor;
//        sexAgelabel.font=[UIFont systemFontOfSize:13.0];
//        sexAgelabel.backgroundColor=[UIColor clearColor];
//        NSString *sexstr=[[NSString alloc]init];
//        if ([[[self.patientdatadic objectForKey:@"patient"] objectForKey:@"gender"] integerValue]==0) {
//            sexstr=@"男";
//        }else{
//            sexstr=@"女";
//        }
//        NSString *agestr=[[NSString alloc]init];
//        agestr=[[self.patientdatadic objectForKey:@"patient"] objectForKey:@"age"]?[[self.patientdatadic objectForKey:@"patient"] objectForKey:@"age"]:@"0";
//        
//        
//        sexAgelabel.text=[NSString stringWithFormat:@"%@  %@岁",sexstr,agestr];
//
//        [cell addSubview:sexAgelabel];
//        
//        UILabel *paylabel=[[UILabel alloc]init];
//        paylabel.frame=CGRectMake(ScreenWidth-116, 32.0-12.5, 100, 25);
//        paylabel.textColor=KLineColor;
//        paylabel.layer.cornerRadius=5.0;
////        paylabel.layer.borderWidth=1.5;
////        paylabel.layer.borderColor=KGreenColor.CGColor;
//        paylabel.font=[UIFont systemFontOfSize:22.0];
//        paylabel.backgroundColor=[UIColor clearColor];
//        paylabel.textAlignment=NSTextAlignmentCenter;
//        paylabel.textColor=KlightOrangeColor;
//        paylabel.text=[NSString stringWithFormat:@"%@",@"TA的病例"];
//        [cell addSubview:paylabel];
//    } else if (indexPath.row==1) {
//        
//        UIImageView *imagev;
//        //=[[UIImageView alloc]init];
//        
//        
//        imagev =[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 54, 54)];
//        //   imagev.frame=CGRectMake(10, 8, 44, 44);
//        
//        
//        
//        
//        imagev.clipsToBounds=YES;
//        
//        imagev.layer.masksToBounds=YES;
//        imagev.layer.cornerRadius =5.0;
//        imagev.layer.borderColor = [UIColor clearColor].CGColor;
//        imagev.layer.rasterizationScale = [UIScreen mainScreen].scale;
//        
//        // imagev.image=[UIImage imageNamed:@"KAKA"];
//        //  NSLog(@"%@",[NSString stringWithFormat:@"%@",[datadic objectForKey:@"icon"]]);
//        [imagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@""]] placeholderImage:[UIImage imageNamed:kPlaceholderimage]];
//        [cell addSubview:imagev];
//        
//       
//    }else{
//        UILabel *desclabel=[[UILabel alloc]init];
//        desclabel.frame=CGRectMake(10, 8, ScreenWidth-20, 25);
//        desclabel.textColor=KLineColor;
//        desclabel.font=[UIFont systemFontOfSize:17.0];
//        desclabel.backgroundColor=[UIColor clearColor];
//        desclabel.text=[NSString stringWithFormat:@"%@",@"病情描述："];
//        [cell addSubview:desclabel];
//        
//        
//        
//        UIFont *font=[UIFont systemFontOfSize:15.0];
//        CGRect strsize=KStringSize(@"爱词霸权威在线词典,为您提供描述的中文意思,描述的用法讲解,描述的读音,描述的同义词,描述的反义词,描述的例句等英语服务。", ScreenWidth-20, font);
//        UILabel *detaillabel=[[UILabel alloc]init];
//        detaillabel.frame=CGRectMake(10, 33, ScreenWidth-20, 0);
//        detaillabel.font=[UIFont systemFontOfSize:15.0];
//        detaillabel.backgroundColor=[UIColor clearColor];
//        detaillabel.textAlignment=NSTextAlignmentLeft;
//        detaillabel.textColor=KBlackColor;
//        detaillabel.text=[NSString stringWithFormat:@"%@",@"爱词霸权威在线词典,为您提供描述的中文意思,描述的用法讲解,描述的读音,描述的同义词,描述的反义词,描述的例句等英语服务。爱词霸权威在线词典,为您提供描述的中文意思,描述的用法讲解,描述的读音,描述的同义词,描述的反义词,描述的例句等英语服务。爱词霸权威在线词典,为您提供描述的中文意思,描述的用法讲解,描述的读音,描述的同义词,描述的反义词,描述的例句等英语服务。爱词霸权威在线词典,为您提供描述的中文意思,描述的用法讲解,描述的读音,描述的同义词,描述的反义词,描述的例句等英语服务。爱词霸权威在线词典,为您提供描述的中文意思,描述的用法讲解,描述的读音,描述的同义词,描述的反义词,描述的例句等英语服务。爱词霸权威在线词典,为您提供描述的中文意思,描述的用法讲解,描述的读音,描述的同义词,描述的反义词,描述的例句等英语服务。爱词霸权威在线词典,为您提供描述的中文意思,描述的用法讲解,描述的读音,描述的同义词,描述的反义词,描述的例句等英语服务。爱词霸权威在线词典,为您提供描述的中文意思,描述的用法讲解,描述的读音,描述的同义词,描述的反义词,描述的例句等英语服务。爱词霸权威在线词典,为您提供描述的中文意思,描述的用法讲解,描述的读音,描述的同义词,描述的反义词,描述的例句等英语服务。爱词霸权威在线词典,为您提供描述的中文意思,描述的用法讲解,描述的读音,描述的同义词,描述的反义词,描述的例句等英语服务。爱词霸权威在线词典,为您提供描述的中文意思,描述的用法讲解,描述的读音,描述的同义词,描述的反义词,描述的例句等英语服务。爱词霸权威在线词典,为您提供描述的中文意思,描述的用法讲解,描述的读音,描述的同义词,描述的反义词,描述的例句等英语服务。爱词霸权威在线词典,为您提供描述的中文意思,描述的用法讲解,描述的读音,描述的同义词,描述的反义词,描述的例句等英语服务。爱词霸权威在线词典,为您提供描述的中文意思,描述的用法讲解,描述的读音,描述的同义词,描述的反义词,描述的例句等英语服务。爱词霸权威在线词典,为您提供描述的中文意思,描述的用法讲解,描述的读音,描述的同义词,描述的反义词,描述的例句等英语服务。爱词霸权威在线词典,为您提供描述的中文意思,描述的用法讲解,描述的读音,描述的同义词,描述的反义词,描述的例句等英语服务。爱词霸权威在线词典,为您提供描述的中文意思,描述的用法讲解,描述的读音,描述的同义词,描述的反义词,描述的例句等英语服务。爱词霸权威在线词典,为您提供描述的中文意思,描述的用法讲解,描述的读音,描述的同义词,描述的反义词,描述的例句等英语服务。爱词霸权威在线词典,为您提供描述的中文意思,描述的用法讲解,描述的读音,描述的同义词,描述的反义词,描述的例句等英语服务。爱词霸权威在线词典,为您提供描述的中文意思,描述的用法讲解,描述的读音,描述的同义词,描述的反义词,描述的例句等英语服务。爱词霸权威在线词典,为您提供描述的中文意思,描述的用法讲解,描述的读音,描述的同义词,描述的反义词,描述的例句等英语服务。爱词霸权威在线词典,为您提供描述的中文意思,描述的用法讲解,描述的读音,描述的同义词,描述的反义词,描述的例句等英语服务。爱词霸权威在线词典,为您提供描述的中文意思,描述的用法讲解,描述的读音,描述的同义词,描述的反义词,描述的例句等英语服务。爱词霸权威在线词典,为您提供描述的中文意思,描述的用法讲解,描述的读音,描述的同义词,描述的反义词,描述的例句等英语服务。"];
//        detaillabel.numberOfLines=0;
//        [detaillabel sizeToFit];
//        [cell addSubview:detaillabel];
//        
//        
//    }
//    
//    
//    
//    
//    
//    
//    return cell;
//    
//}
//
//
//

-(void)buttonaction{
    if (self.isphone) {
        CallingViewController *callingvc=[[CallingViewController alloc]init];
        [self.navigationController pushViewController:callingvc animated:YES];
    }else{
        NSLog(@"%@",self.patientdatadic);
        RCConversationModel *model=[[RCConversationModel alloc]init];
        model.conversationType=ConversationType_PRIVATE;
        model.targetId=[[self.patientdatadic objectForKey:@"patient"] objectForKey:@"user_id"];
        model.conversationTitle=[[self.patientdatadic objectForKey:@"patient"] objectForKey:@"name"];
//        PatientChatViewController *conversationPageVC=[[PatientChatViewController alloc]initWithChatModel:model];
//        
//        conversationPageVC.model=model;
//        conversationPageVC.title=[[self.patientdatadic objectForKey:@"patient"] objectForKey:@"name"];
        
       
        
        PatientChatViewController *conversationPageVC=[[PatientChatViewController alloc]initWithChatModel:model];
        
        conversationPageVC.title=[[self.patientdatadic objectForKey:@"patient"] objectForKey:@"name"];;
        conversationPageVC.model=model;
        conversationPageVC.isgroup=NO;
       
        conversationPageVC.teamid=[[self.patientdatadic objectForKey:@"team"] objectForKey:@"id"];
        conversationPageVC.teamdic=self.patientdatadic;
        conversationPageVC.patientd=[[self.patientdatadic objectForKey:@"patient"] objectForKey:@"id"];
        //[conversationPageVC setupmorebutton];
        [[UINavigationBar appearance] setTintColor:KlightOrangeColor];
        
        
        self.navigationController.navigationBar.hidden=NO;
        [self.navigationController pushViewController:conversationPageVC animated:YES];
        
        
        
        
        
   
    }
}
@end
