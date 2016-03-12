//
//  ResetPWSuccessViewController.m
//  ZDE
//
//  Created by NX on 15/6/15.
//  Copyright (c) 2015年 谢阳晴. All rights reserved.
//

#import "ResetPWSuccessViewController.h"

@interface ResetPWSuccessViewController ()
{
    
    NavBarView *mybarview;
    UIImageView *phoneimageview;
    UIImageView *newpwimageview;
    UIImageView *successimageview;
    UIImageView *bigsuccessimagev;
    UITextField *code1tf;
    UITextField *code2tf;
    UIView *lineview1;
    UIView *lineview2;
    UIButton *nextbutton;
    UIButton *sentcodebutton;
    NSInteger i;
    NSTimer *timer;
}

@end

@implementation ResetPWSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    // Do any additional setup after loading the view.
    UIView *bgv1=[[UIView alloc]initWithFrame:CGRectMake(40, 70, ScreenWidth-80, 90)];
    bgv1.backgroundColor=[UIColor whiteColor];
    phoneimageview=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 25, 25)];
    phoneimageview.clipsToBounds=YES;
    phoneimageview.layer.masksToBounds=YES;
    
    phoneimageview.layer.cornerRadius =25/2.0;
    
    phoneimageview.layer.borderColor = [UIColor whiteColor].CGColor;
    phoneimageview.layer.borderWidth=1.0;
    
    phoneimageview.layer.rasterizationScale = [UIScreen mainScreen].scale;
    phoneimageview.image=[UIImage imageNamed:@"check"];
    [bgv1 addSubview:phoneimageview];
    
    
    lineview1=[[UIView alloc]initWithFrame:CGRectMake(35, 10+12, (ScreenWidth-80)/2-25/2.0-35, 1)];
    lineview1.backgroundColor=KGreenColor;
    [bgv1 addSubview:lineview1];
    
    UILabel *phonelabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 10+35, (ScreenWidth-80)/3, 25)];
    phonelabel.text=@"填写验证手机";
    phonelabel.textColor=KGreenColor;
    phonelabel.font=[UIFont systemFontOfSize:12.0];
    phonelabel.textAlignment=NSTextAlignmentLeft;
    [bgv1 addSubview:phonelabel];
    
    newpwimageview=[[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth-80)/2-25/2.0, 10, 25, 25)];
    newpwimageview.clipsToBounds=YES;
    newpwimageview.layer.masksToBounds=YES;
    
    newpwimageview.layer.cornerRadius =25/2.0;
    
    newpwimageview.layer.borderColor = KGreenColor.CGColor;
    newpwimageview.layer.borderWidth=1.0;
    
    newpwimageview.layer.rasterizationScale = [UIScreen mainScreen].scale;
    newpwimageview.image=[UIImage imageNamed:@"check"];
    [bgv1 addSubview:newpwimageview];
    
    lineview2=[[UIView alloc]initWithFrame:CGRectMake((ScreenWidth-80)/2-25/2.0+25, 10+12, (ScreenWidth-80)/2-25/2.0-35, 1)];
    lineview2.backgroundColor=KGreenColor;
    [bgv1 addSubview:lineview2];
    
    UILabel *pwlabel=[[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth-80)/2-(ScreenWidth-80)/3/2, 10+35, (ScreenWidth-80)/3, 25)];
    pwlabel.text=@"设置新密码";
    pwlabel.textColor=KGreenColor;
    pwlabel.font=[UIFont systemFontOfSize:12.0];
    pwlabel.textAlignment=NSTextAlignmentCenter;
    [bgv1 addSubview:pwlabel];
    
    
    successimageview=[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth-80-35, 10, 25, 25)];
    successimageview.clipsToBounds=YES;
    successimageview.layer.masksToBounds=YES;
    
    successimageview.layer.cornerRadius =25/2.0;
    
    successimageview.layer.borderColor = [UIColor whiteColor].CGColor;
    successimageview.layer.borderWidth=1.0;
    
    successimageview.layer.rasterizationScale = [UIScreen mainScreen].scale;
    successimageview.backgroundColor=KGreenColor;
     successimageview.image=[UIImage imageNamed:@"check"];
    [bgv1 addSubview:successimageview];
    
    UILabel *successlabel=[[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth-80)-(ScreenWidth-80)/3-10, 10+35, (ScreenWidth-80)/3, 25)];
    successlabel.text=@"修改成功";
    successlabel.textColor=KGreenColor;
    successlabel.font=[UIFont systemFontOfSize:12.0];
    successlabel.textAlignment=NSTextAlignmentRight;
    [bgv1 addSubview:successlabel];
    
    
//    code1tf=[[UITextField alloc]initWithFrame:CGRectMake(30, 210, ScreenWidth-60, 60)];
//    code1tf.delegate=self;
//    code1tf.placeholder=@"设置新登录密码:6-16位";
//    code1tf.layer.masksToBounds = YES;
//    code1tf.layer.cornerRadius = 6.0;
//    code1tf.layer.borderWidth = 1.0;
//    code1tf.layer.borderColor = [[UIColor grayColor] CGColor];
//    [self.view addSubview:code1tf];
//    
//    code2tf=[[UITextField alloc]initWithFrame:CGRectMake(30, 280, ScreenWidth-60, 60)];
//    code2tf.delegate=self;
//    code2tf.placeholder=@"再输入一次新密码";
//    code2tf.layer.masksToBounds = YES;
//    code2tf.layer.cornerRadius = 6.0;
//    code2tf.layer.borderWidth = 1.0;
//    code2tf.layer.borderColor = [[UIColor grayColor] CGColor];
//    [self.view addSubview:code2tf];
    //    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textViewEditChanged:)
    //                                                name:@"UITextFieldTextDidChangeNotification"
    //                                              object:code2tf];
    //
    //    sentcodebutton=[UIButton buttonWithType:UIButtonTypeCustom];
    //    sentcodebutton.frame=CGRectMake((ScreenWidth-60)/3*2+30+10, 280, (ScreenWidth-60)/3*1-10, 60);
    //
    //    sentcodebutton.layer.masksToBounds = YES;
    //    sentcodebutton.layer.cornerRadius = 6.0;
    //    sentcodebutton.layer.borderWidth = 1.0;
    //    sentcodebutton.layer.borderColor = [[UIColor greenColor] CGColor];
    //    [sentcodebutton setTitle:@"获取验证码" forState:UIControlStateNormal];
    //    [sentcodebutton addTarget:self action:@selector(getnewCode:) forControlEvents:UIControlEventTouchUpInside];
    //    sentcodebutton.backgroundColor=[UIColor greenColor];
    //    [self.view addSubview:sentcodebutton];
    
    nextbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    nextbutton.frame=CGRectMake(30, ScreenHeight-80, ScreenWidth-60, 60);
    
    nextbutton.layer.masksToBounds = YES;
    nextbutton.layer.cornerRadius = 6.0;
    nextbutton.layer.borderWidth = 1.0;
    nextbutton.layer.borderColor = [KGreenColor CGColor];
    [nextbutton setTitle:@"修改成功" forState:UIControlStateNormal];
    //nextbutton.userInteractionEnabled=NO;
    nextbutton.titleLabel.font=[UIFont systemFontOfSize:22.0];
    [nextbutton addTarget:self action:@selector(nextaction) forControlEvents:UIControlEventTouchUpInside];
    nextbutton.backgroundColor=KGreenColor;
    [self.view addSubview:nextbutton];
    
    [self.view addSubview:bgv1];
    
    
    UIImageView *mainsuccessimagev=[[UIImageView alloc]initWithFrame:CGRectMake(40, 190, ScreenWidth-80, ScreenHeight-190-90)];
    mainsuccessimagev.image=[UIImage imageNamed:@"newchangePW.png"];
    [self.view addSubview:mainsuccessimagev];
    
    // Do any additional setup after loading the view.
    mybarview=[[NavBarView alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, 64)];
    mybarview.delegate=self;
    mybarview.navbarTitle=@"忘记密码(3/3)";
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
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)nextaction{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
