//
//  FirstinfoViewController.m
//  CYS
//
//  Created by 谢阳晴 on 15/12/11.
//  Copyright © 2015年 谢阳晴. All rights reserved.
//

#import "FirstinfoViewController.h"
#import "UploadViewController.h"

@interface FirstinfoViewController (){
    UIWebView *webview;
    UIImagePickerController *imagePicker;
    NavBarView *mybarview;
}

@end

@implementation FirstinfoViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor=KBackgroundColor;
   
    webview=[[UIWebView alloc]initWithFrame:CGRectMake(0.0f,44.0f,ScreenWidth,ScreenHeight-44)];
    webview.delegate=self;
   
    webview.scalesPageToFit=YES;
    webview.backgroundColor=KBackgroundColor;
    
      [self.view addSubview:webview];
    
    NSString *urlstr=[NSString stringWithFormat:@"%@",@"http://192.168.1.100:8010/"];
    //    //http://123.59.47.218:82/app/web/ProjectCity.html
    //    //http://www.zhongdianer.com/app/web/ProjectCity.html
    NSURL *myurl=[NSURL URLWithString:urlstr];
    NSURLRequest *request=[NSURLRequest requestWithURL:myurl];
    //
    [webview loadRequest:request];

    
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
    mybarview.navbarTitle=@"个人中心";
    mybarview.isRoot=YES;
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
    if([url rangeOfString:@"upload.html"].location !=NSNotFound)//
    {
       // [self selectPictureAction];
        UploadViewController *uploadvc=[[UploadViewController alloc]init];
        uploadvc.title=@"上传图片";
        uploadvc.urslstr=url;
     //   UINavigationController *myspacenav=[[UINavigationController alloc]initWithRootViewController:uploadvc];

        [self.tabBarController.navigationController pushViewController:uploadvc animated:YES];
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
    
    NSString *str = [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"postStr('%@');",[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"token"]]]];
    NSLog(@"JS返回值：%@",str);
}
-(void)uploadImage{
    [self selectPictureAction];
}
-(void)setResultToJS{
    NSString *imageurlstr=@"http://img.taopic.com/uploads/allimg/130724/240450-130H422422687.jpg";
    
    NSString *resultstr=[NSString stringWithFormat:@"image_id:%@,image_url:%@,thumbnail_url1:%@,thumbnail_url2:%@",@"wqeqwe",imageurlstr,imageurlstr,imageurlstr];
//    NSDictionary *dic=[[NSDictionary alloc]initWithObjectsAndKeys:@"image_id:%@,image_url:%@,thumbnail_url1:%@,thumbnail_url2:%@",@"wqeqwe",imageurlstr,imageurlstr,imageurlstr, nil];
    NSString *str = [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"getPic('%@');",[NSString stringWithFormat:@"%@",resultstr]]];
    NSLog(@"JS返回值：%@",str);
}
@end
