//
//  SuccessViewController.m
//  ZDE
//
//  Created by 谢阳晴 on 15/5/19.
//  Copyright (c) 2015年 谢阳晴. All rights reserved.
//

#import "SuccessViewController.h"


@interface SuccessViewController (){
    UILabel *masklb;
    UILabel *phonenumlb;
    UILabel *masklb1;
    UIButton *moreinfobutton;
    UIButton *verifybutton;
    UILabel *timelabel;
    NSInteger i;
    NSTimer *timer;
    UIImageView *phoneimageview;
    UIImageView *newpwimageview;
    UIImageView *successimageview;
    UIImageView *bigsuccessimagev;
    UIView *lineview1;
    UIView *lineview2;
    
}


@end

@implementation SuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addviews];
    self.view.backgroundColor=[UIColor whiteColor];
//    masklb1=[[UILabel alloc]initWithFrame:CGRectMake(10, 100, ScreenWidth-20, 35)];
//    masklb1.text=NSLocalizedString(@"welcome", nil);
//    masklb.font=[UIFont systemFontOfSize:18.0];
//    masklb1.textAlignment=NSTextAlignmentCenter;
//    [self.view addSubview:masklb1];
    UIImageView *mainsuccessimagev=[[UIImageView alloc]initWithFrame:CGRectMake(50, 160, ScreenWidth-100, ScreenWidth-100)];
    
    
    
    mainsuccessimagev.image=[UIImage imageNamed:@"zdelogo"];
    
    
    [mainsuccessimagev setContentScaleFactor:[[UIScreen mainScreen] scale]];
    
    mainsuccessimagev.contentMode=UIViewContentModeScaleAspectFit;
    
    mainsuccessimagev.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    mainsuccessimagev.clipsToBounds  = YES;
    [self.view addSubview:mainsuccessimagev];

    
    verifybutton=[UIButton buttonWithType:UIButtonTypeCustom];
    verifybutton.frame=CGRectMake(15, ScreenHeight-160,ScreenWidth-30,60);
    verifybutton.alpha=0.8;
    [verifybutton setTitle:NSLocalizedString(@"Finish", nil) forState:UIControlStateNormal];
    verifybutton.titleLabel.font=[UIFont systemFontOfSize:22.0];
    [verifybutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    verifybutton.backgroundColor=KGreenColor;
    verifybutton.layer.masksToBounds = YES;
    verifybutton.layer.cornerRadius = 6.0;
    verifybutton.layer.borderWidth = 1.0;
    verifybutton.layer.borderColor = [[UIColor clearColor] CGColor];
    
    [verifybutton addTarget:self action:@selector(verifysuccess) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:verifybutton];
    moreinfobutton=[UIButton buttonWithType:UIButtonTypeCustom];
    moreinfobutton.frame=CGRectMake(15, ScreenHeight-80,ScreenWidth-30,60);
    moreinfobutton.alpha=0.8;
    [moreinfobutton setTitle:NSLocalizedString(@"moreinfo", nil) forState:UIControlStateNormal];
    moreinfobutton.titleLabel.font=[UIFont systemFontOfSize:22.0];
    [moreinfobutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    moreinfobutton.backgroundColor=KYellowColor;
    moreinfobutton.layer.masksToBounds = YES;
    moreinfobutton.layer.cornerRadius = 8.0;
    moreinfobutton.layer.borderWidth = 1.0;
    moreinfobutton.layer.borderColor = [[UIColor clearColor] CGColor];
    
    [moreinfobutton addTarget:self action:@selector(moreinfoaction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:moreinfobutton];
    

    // Do any additional setup after loading the view.
    NavBarView *mybarview=[[NavBarView alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, 64)];
    mybarview.delegate=self;
    mybarview.navbarTitle=@"注册";
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

-(void)moreinfoaction{
    
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:self.phonenum,@"msisdn",self.signature,@"msisdn-signature",self.password,@"password", nil];
   
   
    
}
-(void)verifysuccess{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:self.phonenum,@"msisdn",self.signature,@"msisdn-signature",self.password,@"password", nil];
    NSLog(@"%@",dic);
       
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)addviews{
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
    phonelabel.text=@"填写手机号码";
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
    pwlabel.text=@"获取验证码";
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
    successimageview.image=[UIImage imageNamed:@"check"];
    UILabel *successlabel=[[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth-80)-(ScreenWidth-80)/3-10, 10+35, (ScreenWidth-80)/3, 25)];
    successlabel.text=@"注册成功";
    successlabel.textColor=KGreenColor;
    successlabel.font=[UIFont systemFontOfSize:12.0];
    successlabel.textAlignment=NSTextAlignmentRight;
    [bgv1 addSubview:successlabel];
    [bgv1 addSubview:successimageview];
    [self.view addSubview:bgv1];

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
