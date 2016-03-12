//
//  PubilcViewController.m
//  CYS
//
//  Created by 谢阳晴 on 16/1/5.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import "PubilcViewController.h"

#import <JavaScriptCore/JavaScriptCore.h>
#import "PhotoBroswerVC.h"

@interface PubilcViewController (){
    UIWebView *webview;
    UIImagePickerController *imagePicker;
    NavBarView *mybarview;
    JGProgressHUD *hud;
    UIButton *morebutton;
    BOOL havereload;
    
}

@end

@implementation PubilcViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor=KBackgroundColor;
  
    webview=[[UIWebView alloc]initWithFrame:CGRectMake(0.0f,44.0f,ScreenWidth,ScreenHeight-44)];
    webview.delegate=self;
    
    webview.scalesPageToFit=YES;
    webview.backgroundColor=KBackgroundColor;
    havereload=NO;
    [self.view addSubview:webview];
    
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
    JSContext *context = [webview  valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
//    //  JSContext *context = [webview  valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
//    
    context[@"iosSelectPic"] = ^() {
//        NSLog(@"+++++++Begin Log+++++++");
//        NSArray *args = [JSContext currentArguments];
//        for (JSValue *jsVal in args) {
//            NSLog(@"%@", jsVal);
//        }
//        JSValue *this = [JSContext currentThis];
//        NSLog(@"this: %@",this);
//        NSLog(@"-------End Log-------");
        NSLog(@"hahahahaa");

        
    };
//    //    NSString *alertJS=@"alert('test js OC')"; //准备执行的js代码
//    //    [context evaluateScript:alertJS];
//    //   NSString *str = [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"recieveToken(123123);"]];
//    context[@"getToken"] = ^() {
//        
//        
//    };
    // NSString *str = [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"recieveToken(123123);"]];
    
    //    UIButton *getnewcodenbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    //    getnewcodenbutton.frame=CGRectMake(0,65,90,40);
    //    getnewcodenbutton.alpha=0.8;
    //    [getnewcodenbutton setTitle:@"Pic" forState:UIControlStateNormal];
    //    getnewcodenbutton.titleLabel.font=[UIFont systemFontOfSize:13.0];
    //  //  [getnewcodenbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    getnewcodenbutton.backgroundColor=[UIColor redColor];
    //
    //    [getnewcodenbutton addTarget:self action:@selector(getpic) forControlEvents:UIControlEventTouchUpInside];
    //    getnewcodenbutton.userInteractionEnabled=YES;
    //    [self.view addSubview:getnewcodenbutton];
    
    hud=[[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleDark];
    [hud showInView:self.view];
    [hud dismissAfterDelay:15];
    
    mybarview=[[NavBarView alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, 64)];
    mybarview.delegate=self;
    mybarview.navbarTitle=@"个人信息";
    // mybarview.isRoot=YES;
    [mybarview setnavcanclecolor:[UIColor whiteColor]];
    // mybarview.alpha=0.7;
    mybarview.backgroundColor=KlightOrangeColor;
    [self.view addSubview:mybarview];
    
    
    
    morebutton=[UIButton buttonWithType:UIButtonTypeCustom];
    morebutton.frame=CGRectMake(ScreenWidth-65, 29, 65, 30);
    
    [morebutton setTitle:@"保存" forState:UIControlStateNormal];
    //[canclebutton setImage:[UIImage imageNamed:@"backArrow.png"] forState:UIControlStateNormal];
    // [morebutton setImage:[UIImage imageNamed:@"more.png"] forState:UIControlStateNormal];
    [morebutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [morebutton addTarget:self action:@selector(morebuttonaction) forControlEvents:UIControlEventTouchUpInside];
    
    
    if ([KGetDefaultstr(@"userstatus") isEqualToString:@"AUDIT_PASSED"]) {
        
    }else{
        [mybarview addSubview:morebutton];
    }

    
    //    UIView *bgv10=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    //    bgv10.backgroundColor=[UIColor whiteColor];
    //    [self.view addSubview:bgv10];
    
    
    // Do any additional setup after loading the view.
}
-(void)morebuttonaction{
   // [self selectPictureAction];
    hud=[[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleDark];
    [hud showInView:self.view];
    [hud dismissAfterDelay:15];

    [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"saveAuthentication();"]];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [hud dismiss];
    self.navigationController.navigationBar.hidden=YES;
}
-(void)itemactionWithType:(NSInteger)typeindex{
    if (self.isreg) {
          [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"localStorage.clear();"]];
         [self.navigationController popViewControllerAnimated:YES];
//        if (!KGetDefaultstr(@"usertitle")||!KGetDefaultstr(@"nick-name")||!KGetDefaultstr(@"userhospital")) {
//            UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:nil message:@"请填写个人信息!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alertview show];
//        }else{
//           [self.navigationController popViewControllerAnimated:YES];
//        }
        
    }else{
          [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"localStorage.clear();"]];
         [self.navigationController popViewControllerAnimated:YES];
    }
   
}
-(void)webViewDidStartLoad:(UIWebView *)webView{
    
    //JSContext *context = [webview  valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    NSLog(@"%@",KGetDefaultstr(@"token"));
    
   // [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"localStorage.clear();"]];
   [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"localStorage.setItem('CYSTOKEN','%@');",KGetDefaultstr(@"token")]];
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
    
    if (havereload==NO) {
        [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"localStorage.clear();"]];
        [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"localStorage.setItem('CYSTOKEN','%@');",KGetDefaultstr(@"token")]];
        [webview reload];
        havereload=YES;
    }
  
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
    // [self pimagebuttonaction];
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
    
//    [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"localStorage.clear();"]];
//    [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"localStorage.setItem('CYSTOKEN','%@');",KGetDefaultstr(@"token")]];

    
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
                    [self selectPictureAction];
                }
                
                
            }else if([funcStr isEqualToString:@"localiosSaveSuccess"]){
                [hud dismiss];
                [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
                
                [[PublicTools shareInstance]creareNotificationUIView:@"修改成功"];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadindex" object:nil];
                  [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"localStorage.clear();"]];
                [self.navigationController popViewControllerAnimated:YES];
           
            }else if([funcStr isEqualToString:@"localiosSaveFail"]){
                 [hud dismiss];
                [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
                
                [[PublicTools shareInstance]creareNotificationUIView:@"修改失败"];

            }else if([funcStr isEqualToString:@"localiosNoChange"]){
                [hud dismiss];
                [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
                
                [[PublicTools shareInstance]creareNotificationUIView:@"请上传职称图片"];
                
            }else if([funcStr isEqualToString:@"localiosInfoNuLL"]){
                [hud dismiss];
                [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
                
                [[PublicTools shareInstance]creareNotificationUIView:@"请完善信息"];
                
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
                NSMutableArray *imagearr=[[NSMutableArray alloc]initWithArray:@[imageurlstr]];
                NSMutableArray *imageurlarr=[[NSMutableArray alloc]init];
                for (NSString *tmpimageurlstr in imagearr) {
                    NSString *imagerul=tmpimageurlstr;
                    [imageurlarr addObject:imagerul];
                }

                
                
                [PhotoBroswerVC show:self type:PhotoBroswerVCTypePush index:0 photoModelBlock:^NSMutableArray *{
                    
                    
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

                
                
                
                /*调用本地函数*/
                // [self printLog:@"js调用本地带参数的方法成功！"];
            }
        }
        return NO;
    };

    
    
    if([url rangeOfString:@"name="].location !=NSNotFound)//
    {
        WebEnterViewController *VC=[[WebEnterViewController alloc]init];
        VC.delegate=self;
        VC.methodname=@"updataUserMessage";
        VC.urslstr=url;
        [self.navigationController pushViewController:VC animated:YES];
        
        
        return NO;
    }else if([url rangeOfString:@"hospital="].location !=NSNotFound){
        HospitalWebViewController *VC=[[HospitalWebViewController alloc]init];
        VC.delegate=self;
        VC.methodname=@"updataUserMessage";
        VC.urslstr=url;
        [self.navigationController pushViewController:VC animated:YES];

        return NO;
        
    }else{
        return YES;
    }
    
    
}
-(void)webDealtdataMethodname:(NSString *)methodname stringval:(NSString *)stringval{
  //  [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@('%@');",methodname,[NSString stringWithFormat:@"%@",stringval]]];
    // [webview reload];
    NSLog(@"%@",stringval);
    [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@('%@');",@"changeName",stringval]];
}
-(void)hospitalDealtdataMethodname:(NSString *)methodname stringval:(NSString *)stringval{
    //NSArray *array=[stringval componentsSeparatedByString:@","];
    
  //  NSLog(@"%@",array);
    
    [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@('%@');",@"changeHospital",stringval]];

//   [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@('%@','%@','%@','%@','%@');",@"changeHospital",[array objectAtIndex:0],[array objectAtIndex:1],[array objectAtIndex:2],[array objectAtIndex:3],[array objectAtIndex:4]]];
    
}
-(void)selectPictureAction{
    UserUIcontrol *mycontrol=[[UserUIcontrol alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    mycontrol.delegate=self;
    mycontrol.controlType=Getphoto;
    [[UIApplication sharedApplication].keyWindow addSubview:mycontrol];
}
-(void)controlDCtypeIsAlbum:(BOOL)isalbum{
    if (isalbum) {
        imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        
        [self presentViewController:imagePicker animated:YES completion:NULL];
    } else {
        imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        // imagePicker.mediaTypes = @[(NSString*)kUTTypeMovie];
        [self presentViewController:imagePicker animated:YES completion:NULL];
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    //key:UIImagePickerControllerOriginalImage 取原始图片
    //key:UIImagePickerControllerEditedImage 取编辑后的图片
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    // [picker dismissViewControllerAnimated:YES completion:nil];
//    MLImageCrop *imageCrop = [[MLImageCrop alloc]init];
//    imageCrop.delegate = self;
//    imageCrop.ratioOfWidthAndHeight = 1800/1800;
//    imageCrop.image=image;
//    [imageCrop showWithAnimation:NO];
    [imagePicker dismissViewControllerAnimated:YES completion:nil];
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:image,@"imge",nil];
    hud=[[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleDark];
    [hud showInView:self.view];
   // [hud dismissAfterDelay:15];
    
    [[BaseDataService shareInstance]PostNetWorkDataWithURLStr:@"private/generalinfo/file" whitdic:dic theReturnBlock:^(id respdic) {
        NSLog(@"%@",respdic);
        //setUploadPic
        // NSLog(@"%@",[[[respdic objectAtIndex:1] objectForKey:@"result"] objectForKey:@"resource_url"]);
        [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"setPic('%@','%@');",[[[respdic objectAtIndex:1] objectForKey:@"result"] objectForKey:@"image_thumbnail_url"],[[[respdic objectAtIndex:1] objectForKey:@"result"] objectForKey:@"resource_url"]]];
        [hud dismiss];
    }];

    
}
-(void)cropImage:(UIImage *)cropImage forOriginalImage:(UIImage *)originalImage{
    
    
//    
//    [imagePicker dismissViewControllerAnimated:YES completion:nil];
//    
//    NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:cropImage,@"imge",nil];
//    hud=[[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleDark];
//    [hud showInView:self.view];
//    [hud dismissAfterDelay:15];
//
//    [[BaseDataService shareInstance]PostNetWorkDataWithURLStr:@"private/generalinfo/file" whitdic:dic theReturnBlock:^(id respdic) {
//        NSLog(@"%@",respdic);
//        //setUploadPic
//       // NSLog(@"%@",[[[respdic objectAtIndex:1] objectForKey:@"result"] objectForKey:@"resource_url"]);
//        [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"setUploadPic('%@');",[[[respdic objectAtIndex:1] objectForKey:@"result"] objectForKey:@"resource_url"]]];
//        [hud dismiss];
//    }];
    
    
}
-(void)getCurrentUserAuthToken{
    
    // NSString *str = [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"postStr('%@');",[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"token"]]]];
    //   NSLog(@"JS返回值：%@",str);
}
-(void)uploadImage{
    //[self selectPictureAction];
}
-(void)setResultToJS{
    NSString *imageurlstr=@"http://img.taopic.com/uploads/allimg/130724/240450-130H422422687.jpg";
    
    NSString *resultstr=[NSString stringWithFormat:@"image_id:%@,image_url:%@,thumbnail_url1:%@,thumbnail_url2:%@",@"wqeqwe",imageurlstr,imageurlstr,imageurlstr];
    [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"postStr('%@');",[NSString stringWithFormat:@"%@",resultstr]]];
    // NSLog(@"JS返回值：%@",str);
}
-(BOOL)getToken{
    NSLog(@"haha");
    return true;
}


@end
