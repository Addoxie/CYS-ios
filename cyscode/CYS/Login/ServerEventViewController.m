//
//  ServerEventViewController.m
//  ZDE
//
//  Created by NX on 15/7/16.
//  Copyright (c) 2015年 谢阳晴. All rights reserved.
//

#import "ServerEventViewController.h"

@interface ServerEventViewController (){
    
    UIWebView *webview;
      
}


@end

@implementation ServerEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    webview=[[UIWebView alloc]initWithFrame:CGRectMake(0.0f,44.0f,ScreenWidth,ScreenHeight-44.0f)];
    webview.delegate=self;
    webview.scalesPageToFit=YES;
    //NSURL *myurl=[NSURL URLWithString:self.urlstr];
    NSString *urlstr=[NSString stringWithFormat:@"%@",@"http://wap.hao123.com/"];
    NSURL *myurl=[NSURL URLWithString:urlstr];
    NSURLRequest *request=[NSURLRequest requestWithURL:myurl];
    
    
    [webview loadRequest:request];
    
    [self.view addSubview:webview];
    
    // Do any additional setup after loading the view.
    NavBarView *mybarview=[[NavBarView alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, 64)];
    mybarview.delegate=self;
    mybarview.navbarTitle=@"农心-服务条款";
    mybarview.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:mybarview];
    UIView *bgv=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    bgv.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:bgv];
    
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden=NO;
}
-(void)itemactionWithType:(NSInteger)typeindex{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
