//
//  UploadViewController.m
//  CYS
//
//  Created by 谢阳晴 on 16/1/5.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import "UploadViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "PhotoBroswerVC.h"

@interface UploadViewController (){
    UIWebView *webview;
    UIImagePickerController *imagePicker;
    NavBarView *mybarview;
}

@end

@implementation UploadViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor=KBackgroundColor;
    
    webview=[[UIWebView alloc]initWithFrame:CGRectMake(0.0f,44.0f,ScreenWidth,ScreenHeight-44)];
    webview.delegate=self;
    
    webview.scalesPageToFit=YES;
    webview.backgroundColor=KBackgroundColor;
    
    [self.view addSubview:webview];
    
    NSString *urlstr=[NSString stringWithFormat:@"%@",self.urslstr];
    //    //http://123.59.47.218:82/app/web/ProjectCity.html
    //    //http://www.zhongdianer.com/app/web/ProjectCity.html
    NSURL *myurl=[NSURL URLWithString:urlstr];
    NSURLRequest *request=[NSURLRequest requestWithURL:myurl];
    //
    [webview loadRequest:request];
   
    JSContext *context = [webview  valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //  JSContext *context = [webview  valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    context[@"selectUpload"] = ^() {
        [self selectPictureAction];
        
    };
//    NSString *alertJS=@"alert('test js OC')"; //准备执行的js代码
//    [context evaluateScript:alertJS];
  //   NSString *str = [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"recieveToken(123123);"]];
    context[@"getToken"] = ^() {
        //[self selectPictureAction];
        
       //  NSString *str = [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"recieveToken(123123);"]];
        
       // NSString *str = [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"recieveToken('%@');",[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"token"]]]];
        
    };
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
    
    
    
    UIButton *getnewcodenbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    getnewcodenbutton.frame=CGRectMake(0,25,90,40);
    getnewcodenbutton.alpha=0.8;
    [getnewcodenbutton setTitle:@"Pic" forState:UIControlStateNormal];
    getnewcodenbutton.titleLabel.font=[UIFont systemFontOfSize:13.0];
    //  [getnewcodenbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    getnewcodenbutton.backgroundColor=[UIColor yellowColor];
    
    [getnewcodenbutton addTarget:self action:@selector(getpic) forControlEvents:UIControlEventTouchUpInside];
    getnewcodenbutton.userInteractionEnabled=YES;
    
    mybarview=[[NavBarView alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, 64)];
    mybarview.delegate=self;
    mybarview.navbarTitle=@"上传图片";
   // mybarview.isRoot=YES;
    [mybarview setnavcanclecolor:[UIColor orangeColor]];
    // mybarview.alpha=0.7;
    mybarview.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:mybarview];
    //    UIView *bgv10=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    //    bgv10.backgroundColor=[UIColor whiteColor];
    //    [self.view addSubview:bgv10];
    
    [mybarview addSubview:getnewcodenbutton];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
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
   
    JSContext *context = [webview  valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //  JSContext *context = [webview  valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    context[@"selectUpload"] = ^() {
       // return [NSString stringWithFormat:@"recieveToken('%@');",[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"token"]]];
        [self selectPictureAction];
        
    };
    context[@"getToken"] = ^() {
        //[self selectPictureAction];
        
          //return [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"token"]];
      //  NSString *str = [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"recieveToken('%@');",[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"token"]]]];
//        NSString *alertJS=[NSString stringWithFormat:@""]; //准备执行的js代码
//        [context evaluateScript:alertJS];
        
    };
//    NSString *str = [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"recieveToken(123123);"]];
//    NSString *alertJS=[NSString stringWithFormat:@"sessionStorage.setItem(%@,%@);",@"demokey",@"iosqweqweqweqweqweqwqweqweqw"]; //准备执行的js代码
//    [context evaluateScript:alertJS];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    JSContext *context = [webview  valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //  JSContext *context = [webview  valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    context[@"selectUpload"] = ^() {
        [self selectPictureAction];
        
    };
    context[@"getToken"] = ^() {
        //[self selectPictureAction];
        
        
    };
//    NSString *alertJS=@"alert('test js OC')"; //准备执行的js代码
//    [context evaluateScript:alertJS];
//    NSLog(@"%@", context[@"selectUpload"]);
//    NSString *str = [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"recieveToken(123123);"]];
    
    
    
     NSString *str = [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"localStorage.setItem('key', '123456');"]];
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
    
     [self setResultToJS];
}





- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSString * url = request.URL.absoluteString;
    NSLog(@"%@",url);
    
    
  
    NSString *urlString = [[request URL] absoluteString];
    NSArray *urlComps = [urlString componentsSeparatedByString:@"://"];
    if([urlComps count] && [[urlComps objectAtIndex:0] isEqualToString:@"cysnative"])
    {
        NSArray *arrFucnameAndParameter = [(NSString*)[urlComps objectAtIndex:1] componentsSeparatedByString:@":/"];
        NSString *funcStr = [arrFucnameAndParameter objectAtIndex:0];
        
        
        if (1 == [arrFucnameAndParameter count])
        {
            // 没有参数
            if([funcStr isEqualToString:@"selectUpload"])
            {
                /*调用本地函数*/
             //   [self testFunc];
                
                
                 [self selectPictureAction];
            }
        }
        else if(2 == [arrFucnameAndParameter count])
        {
            NSLog(@"%@",arrFucnameAndParameter);
            //有参数的
            if([funcStr isEqualToString:@"printLog:"] && [arrFucnameAndParameter objectAtIndex:1])
            {
                /*调用本地函数*/
               // [self printLog:@"js调用本地带参数的方法成功！"];
            }
        }
        return NO;
    };

    
    
    if([url rangeOfString:@"haha"].location !=NSNotFound)//
    {
       
        
        
        return NO;
    }else{
        return YES;
        
    }
    
    
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
    MLImageCrop *imageCrop = [[MLImageCrop alloc]init];
    imageCrop.delegate = self;
    imageCrop.ratioOfWidthAndHeight = 1800/1800;
    imageCrop.image=image;
    [imageCrop showWithAnimation:NO];
    
}
-(void)cropImage:(UIImage *)cropImage forOriginalImage:(UIImage *)originalImage{
    
    [imagePicker dismissViewControllerAnimated:YES completion:nil];
}
-(void)getCurrentUserAuthToken{
    
   // NSString *str = [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"postStr('%@');",[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"token"]]]];
 //   NSLog(@"JS返回值：%@",str);
}
-(void)uploadImage{
    //[self selectPictureAction];
}
-(void)setResultToJS{
    NSString *imageurlstr=@"http://img.taopic.com/uploads/allimg/140119/234926-14011ZU35340.jpg";
    
   // NSString *resultstr=[NSString stringWithFormat:@"id:%@,image_url:%@,thumbnail_url1:%@,thumbnail_url2:%@",@"wqeqwe",imageurlstr,imageurlstr,imageurlstr];
    
    
    NSDictionary *dic=[[NSDictionary alloc]initWithObjectsAndKeys:@"123",@"image_id",imageurlstr,@"image_url",imageurlstr,@"thumbnail_url1", nil];
    //NSLog(@"%@",resultstr);
   // NSDictionary *dic=[resultstr ]
    
//    NSData *jsonData = [resultstr dataUsingEncoding:NSUTF8StringEncoding];
//    
//    NSError *err;
//    
//    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
//                         
//                                                        options:NSJSONReadingMutableContainers
//                         
//                                                          error:&err];
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
    NSString * JSONString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];


    NSString *str = [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"getPic(%@);",JSONString]];
    
   // NSLog(@"Json：%@",JSONString);
}

- (NSString *)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}
-(void)showpicurl:(NSString *)string{
    
    
    [PhotoBroswerVC show:self type:PhotoBroswerVCTypePush index:0 photoModelBlock:^NSMutableArray *{
        
        NSMutableArray *imageurlarr=@[string];
        NSMutableArray *networkImages=imageurlarr;
        
        NSMutableArray *modelsM = [NSMutableArray arrayWithCapacity:networkImages.count];
        
        for (NSUInteger i = 0; i< networkImages.count; i++) {
            
            PhotoModel *pbModel=[[PhotoModel alloc] init];
            pbModel.mid = i + 1;
            //            pbModel.title = [NSString stringWithFormat:@"这是标题%@",@(i+1)];
            //            pbModel.desc = [NSString stringWithFormat:@"我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字%@",@(i+1)];
            pbModel.image_HD_U = networkImages[i];
//            pbModel.feebackimageid=[[imagearr objectAtIndex:indexPath.row] objectForKey:@"id"];
//            pbModel.feebackpostid=[dic objectForKey:@"id"];
            pbModel.havefeeback=NO;
            //源frame
            
            UIImageView *imageV =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
            pbModel.sourceImageView = imageV;
            
            [modelsM addObject:pbModel];
        }
        
        return modelsM;
    }];

}
@end
