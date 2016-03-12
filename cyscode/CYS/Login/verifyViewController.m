//
//  verifyViewController.m
//  ZDE
//
//  Created by 谢阳晴 on 15/5/19.
//  Copyright (c) 2015年 谢阳晴. All rights reserved.
//

#import "verifyViewController.h"
#import "verifySuccessViewController.h"
#import "SuccessViewController.h"

@interface verifyViewController ()
{
    UILabel *masklb;
    UILabel *phonenumlb;
    UILabel *masklb1;
    UIButton *getcodebutton;
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

@implementation verifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addviews];
    self.view.backgroundColor=[UIColor whiteColor];
    masklb=[[UILabel alloc]initWithFrame:CGRectMake(10, 160, (ScreenWidth-20)/2, 35)];
    masklb.text=NSLocalizedString(@"havesentmessage:", nil);
    masklb.textAlignment=NSTextAlignmentRight;
    masklb.font=[UIFont systemFontOfSize:15.0];
    [self.view addSubview:masklb];
    phonenumlb=[[UILabel alloc]initWithFrame:CGRectMake(10+(ScreenWidth-20)/2, 160, (ScreenWidth-20)/2, 35)];
    phonenumlb.text=self.phonenum;
    phonenumlb.textColor=[UIColor redColor];
    phonenumlb.textAlignment=NSTextAlignmentLeft;
    [self.view addSubview:phonenumlb];
    
    masklb1=[[UILabel alloc]initWithFrame:CGRectMake(30, 190, ScreenWidth-60, 35)];
    masklb1.text=NSLocalizedString(@"entercaptcha", nil);
    masklb1.textAlignment=NSTextAlignmentCenter;
    masklb1.font=[UIFont systemFontOfSize:15.0];
    [self.view addSubview:masklb1];
    
    self.usernametf=[[UITextField alloc]initWithFrame:CGRectMake(15, 250, ScreenWidth-30, 60)];
    self.usernametf.delegate=self;
    self.usernametf.placeholder=NSLocalizedString(@"captcha", nil);
    self.usernametf.layer.masksToBounds = YES;
    self.usernametf.layer.cornerRadius = 6.0;
    self.usernametf.layer.borderWidth=1.0;
     KtfAddpaddingView(self.usernametf);
    self.usernametf.layer.borderColor=[kimiColor(232, 232, 233, 1) CGColor];
    [self.view addSubview:self.usernametf];
    
    getcodebutton=[UIButton buttonWithType:UIButtonTypeCustom];
    getcodebutton.frame=CGRectMake(10, ScreenHeight-130, ScreenWidth-30, 35);
    getcodebutton.alpha=0.8;
    //[getcodebutton setTitle:NSLocalizedString(@"sendcptcha", nil) forState:UIControlStateNormal];
    getcodebutton.titleLabel.font=[UIFont systemFontOfSize:16.0];
    [getcodebutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
   // getcodebutton.backgroundColor=[UIColor grayColor];
    getcodebutton.layer.masksToBounds = YES;
    getcodebutton.layer.cornerRadius = 6.0;
    getcodebutton.layer.borderWidth = 1.0;
    getcodebutton.layer.borderColor = [[UIColor clearColor] CGColor];
    
    [getcodebutton addTarget:self action:@selector(getnewCode:) forControlEvents:UIControlEventTouchUpInside];
  
    [self.view addSubview:getcodebutton];
    
    
    verifybutton=[UIButton buttonWithType:UIButtonTypeCustom];
    verifybutton.frame=CGRectMake(15, ScreenHeight-80,ScreenWidth-30,60);
    verifybutton.alpha=0.8;
    [verifybutton setTitle:NSLocalizedString(@"verifyphone", nil) forState:UIControlStateNormal];
    verifybutton.titleLabel.font=[UIFont systemFontOfSize:22.0];
    [verifybutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    verifybutton.backgroundColor=KGreenColor;
    verifybutton.layer.masksToBounds = YES;
    verifybutton.layer.cornerRadius = 8.0;
    verifybutton.layer.borderWidth = 1.0;
    verifybutton.layer.borderColor = [[UIColor clearColor] CGColor];
    
    [verifybutton addTarget:self action:@selector(verifythecode) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:verifybutton];


    
    timelabel=[[UILabel alloc]initWithFrame:CGRectMake(10, ScreenHeight-130, ScreenWidth-30, 35)];
    timelabel.text=@"60秒 后可重新获取验证码";
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:@"60秒 后可重新获取验证码"];
    NSRange contentRange = {0, [content length]};
    [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
    timelabel.attributedText=content;
    timelabel.textAlignment=NSTextAlignmentCenter;
    timelabel.font=[UIFont systemFontOfSize:13.0];
    [self.view addSubview:timelabel];
    i=60;
    timer=[NSTimer timerWithTimeInterval:1 target:self selector:@selector(timeraction:) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];


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
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.usernametf resignFirstResponder];
   // [self.passwordtf resignFirstResponder];
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
    
    newpwimageview.layer.borderColor = [UIColor whiteColor].CGColor;
    newpwimageview.layer.borderWidth=1.0;
    
    newpwimageview.layer.rasterizationScale = [UIScreen mainScreen].scale;
    newpwimageview.image=[UIImage imageNamed:@"check"];
    [bgv1 addSubview:newpwimageview];
    
    lineview2=[[UIView alloc]initWithFrame:CGRectMake((ScreenWidth-80)/2-25/2.0+25, 10+12, (ScreenWidth-80)/2-25/2.0-35, 1)];
    lineview2.backgroundColor=[UIColor grayColor];
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
    
    successimageview.layer.borderColor = [UIColor grayColor].CGColor;
    successimageview.layer.borderWidth=1.0;
    
    successimageview.layer.rasterizationScale = [UIScreen mainScreen].scale;
    successimageview.backgroundColor=[UIColor whiteColor];
    UILabel *successlabel=[[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth-80)-(ScreenWidth-80)/3-10, 10+35, (ScreenWidth-80)/3, 25)];
    successlabel.text=@"注册成功";
    successlabel.textColor=[UIColor whiteColor];
    successlabel.font=[UIFont systemFontOfSize:12.0];
    successlabel.textAlignment=NSTextAlignmentRight;
    [bgv1 addSubview:successlabel];
    [bgv1 addSubview:successimageview];
    [self.view addSubview:bgv1];

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

-(void)verifythecode{
    if (self.usernametf.text.length==0){
        [[PublicTools shareInstance]setmyPview:self.view];
        [[PublicTools shareInstance]creareNotificationUIView:NSLocalizedString(@"entercaptcha", nil)];
    }else{
        
        NSString *urlstring=[NSString stringWithFormat:@"protected/msisdn/verify-code?msisdn=%@&code=%@",self.phonenum,self.usernametf.text];
        
    }
//    SuccessViewController *successvc=[[SuccessViewController alloc]init];
//    successvc.title=@"注册完成";
//    [self.navigationController pushViewController:successvc animated:YES];
}
-(void)getnewCode:(UIButton *)button{
  
 
    getcodebutton.userInteractionEnabled=NO;
    i=60;
   timelabel.textColor=[UIColor blackColor];
//    timer=[NSTimer timerWithTimeInterval:1 target:self selector:@selector(timeraction:) userInfo:nil repeats:YES];
//    
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];// Do any additional setup after loading the view.
    
    
}
-(void)timeraction:(NSTimer *)timer{
    
    if (i>0) {
        i--;
       
        getcodebutton.userInteractionEnabled=NO;
        timelabel.text=[NSString stringWithFormat:@"%zd秒 后可重新获取验证码",i];
        NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:timelabel.text];
        NSRange contentRange = {0, [content length]};
        [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
        timelabel.attributedText=content;
//        [getcodebutton setTitle:[NSString stringWithFormat:@"请等待%zd秒",i] forState:UIControlStateNormal];
    }else{
        //getcodebutton.backgroundColor=[UIColor greenColor];
      //  [getcodebutton setTitle:[NSString stringWithFormat:@"发送验证码"] forState:UIControlStateNormal];
        timelabel.text=@"请点击重新获取验证码";
        NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:timelabel.text];
        NSRange contentRange = {0, [content length]};
        [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
        timelabel.attributedText=content;
        
        getcodebutton.userInteractionEnabled=YES;
        timelabel.textColor=KGreenColor;
        
    }
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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
