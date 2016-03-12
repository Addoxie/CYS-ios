//
//  MyspaceViewController.m
//  CYS
//
//  Created by 谢阳晴 on 15/12/17.
//  Copyright © 2015年 谢阳晴. All rights reserved.
//

#import "MyspaceViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "FirstinfoViewController.h"



@interface MyspaceViewController (){
    UIWebView *webview;
    UIImagePickerController *imagePicker;
     NavBarView *mybarview;
}


@end

@implementation MyspaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    webview=[[UIWebView alloc]initWithFrame:CGRectMake(0.0f,44.0f,ScreenWidth,ScreenHeight-44)];
    webview.delegate=self;
    
    webview.scalesPageToFit=YES;
    [self.view addSubview:webview];
    
    NSString *urlstr=[NSString stringWithFormat:@"%@",@"http://192.168.1.100:8010/personal.html"];
    //    //http://123.59.47.218:82/app/web/ProjectCity.html
    //    //http://www.zhongdianer.com/app/web/ProjectCity.html
    NSURL *myurl=[NSURL URLWithString:urlstr];
    NSURLRequest *request=[NSURLRequest requestWithURL:myurl];
    //
    [webview loadRequest:request];

    
    UIButton *getnewcodenbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    getnewcodenbutton.frame=CGRectMake(0, 25,90,40);
    getnewcodenbutton.alpha=0.8;
    [getnewcodenbutton setTitle:@"Pic" forState:UIControlStateNormal];
    getnewcodenbutton.titleLabel.font=[UIFont systemFontOfSize:13.0];
    //  [getnewcodenbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    getnewcodenbutton.backgroundColor=[UIColor redColor];
    
    [getnewcodenbutton addTarget:self action:@selector(getpic) forControlEvents:UIControlEventTouchUpInside];
    getnewcodenbutton.userInteractionEnabled=YES;
    
    
    
    JSContext *context = [webview  valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //  JSContext *context = [webview  valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    context[@"selectUpload"] = ^() {
        [self selectPictureAction];
        
    };
    mybarview=[[NavBarView alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, 64)];
    mybarview.delegate=self;
    mybarview.navbarTitle=@"个人中心";
    mybarview.isRoot=YES;
    [mybarview setnavcanclecolor:[UIColor orangeColor]];
    // mybarview.alpha=0.7;
    mybarview.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:mybarview];
    [mybarview addSubview:getnewcodenbutton];
    //    UIView *bgv10=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    //    bgv10.backgroundColor=[UIColor whiteColor];
    //    [self.view addSubview:bgv10];
    
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //self.navigationController.navigationBar.hidden=NO;
}

-(void)itemactionWithType:(NSInteger)typeindex{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)getpic{
    
    
//    [[CCPCallService sharedInstance]setSelfPhoneNumber:@"14800148000"];
//    
//    [[CCPCallService sharedInstance]setSelfName:@"hahaha"];
//    NSString *callid=[[CCPCallService sharedInstance]makeCallWithType:EVoipCallType_Voice andCalled:@"+8615837736077"];
//    FirstinfoViewController *myspacevc=[[FirstinfoViewController alloc]init];
//    
//    myspacevc.title=@"医生认证";
//    [self.navigationController pushViewController:myspacevc animated:YES];
   // UINavigationController*myspacenav=[[UINavigationController alloc]initWithRootViewController:myspacevc];

//     [self selectPictureAction];
//        NSString *urlstr=[NSString stringWithFormat:@"%@",@"http://192.168.1.100:8010/personal.html"];
//        //    //http://123.59.47.218:82/app/web/ProjectCity.html
//        //    //http://www.zhongdianer.com/app/web/ProjectCity.html
//        NSURL *myurl=[NSURL URLWithString:urlstr];
//        NSURLRequest *request=[NSURLRequest requestWithURL:myurl];
//        //
//        [webview loadRequest:request];
   
}




- (void) performDynamicMethodsViaSelectors {
    //    MethodForSelectors * mfs = [MethodForSelectors alloc];
//    NSArray *classNames = [NSArray arrayWithObjects:@"AAA", @"BBB", nil];
//    //    for ( NSString *array in Arrays ){
//    //
//    //    }
//    //    SEL customSelector = NSSelectorFromString(@"AAA");
//    //    [self performSelector:customSelector withObject:0];
//    NSArray *params = [NSArray arrayWithObjects:@"aaa", @"bbb", nil];
//    
//    
//    for (int c=0; c<[classNames count]; c++) {
//        NSString *className=[classNames objectAtIndex:c];
//        id class=[[NSClassFromString(className) alloc] init];
//        for (int i=0; i<[params count]; i++) {
//            [class performSelector:NSSelectorFromString([NSString stringWithFormat:@"setA%i",i])];
//        }
//    }
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
-(void)IOStoJS{
    //NSString *str = [self.webview stringByEvaluatingJavaScriptFromString:@"postStr();"];
    //要传递的参数一
    NSString *str1 = @"我来自于oc";
    //要传递的参数二
    NSString *str2 = @"我来自于地球";
    NSString *str = [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"postStr('%@','%@');",str1,str2]];
    NSLog(@"JS返回值：%@",str);
}
//JStoOC
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
   // [self selectPictureAction];
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
            if([funcStr isEqualToString:@"testFunc"])
            {
                /*调用本地函数*/
              //  [self testFunc];
            }
        }
        else if(2 == [arrFucnameAndParameter count])
        {
            NSLog(@"%@",arrFucnameAndParameter);
            //有参数的
            if([funcStr isEqualToString:@"printLog:"] && [arrFucnameAndParameter objectAtIndex:1])
            {
                /*调用本地函数*/
              //  [self printLog:@"js调用本地带参数的方法成功！"];
            }
        }

    
    
    }
    
    
    if([url rangeOfString:@"ProjectDetails.html"].location !=NSNotFound)//
    {
        
        
        return NO;
    }else{
        return YES;
        
    }
    
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    
    
   // NSString *str = [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"localStorage.setItem('key', '123456');"]];
}
-(void)getCurrentUserAuthToken{
   
//     NSString *str = [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"postStr('%@');",[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"token"]]]];
//     NSLog(@"JS返回值：%@",str);
}
-(void)uploadImage{
    [self selectPictureAction];
}
-(void)setResultToJS{
    NSString *resultstr=[NSString stringWithFormat:@"image_url:http://img.taopic.com/uploads/allimg/130724/240450-130H422422687.jpg"];
    NSString *str = [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"postStr('%@');",[NSString stringWithFormat:@"%@",resultstr]]];
}
@end
