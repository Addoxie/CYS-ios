//
//  RegisterViewController.m
//  ZDE
//
//  Created by 谢阳晴 on 15/5/19.
//  Copyright (c) 2015年 谢阳晴. All rights reserved.
//

#import "RegisterViewController.h"
#import "verifyViewController.h"
#import "ServerEventViewController.h"
#import "SetPasswordViewController.h"
#import "SettingWebViewController.h"

@interface RegisterViewController ()
{
    UIButton *oldbutton;
    UILabel *denglulabel;
    UILabel *mimalabel;
    UIButton *getcodebutton;
    UIButton *remembermebutton;
    UIButton *loginbutton;
    UIButton *registerbutton;
    BOOL haveremember;
    NSInteger logintype;
    UILabel *forgetpasswordlb;
    UIButton *itembutton;
    UILabel *registerlb;
    UIButton *getnewcodenbutton;
    NSInteger i;
    BOOL havepress;
    NSTimer *timer;
    UIImageView *captchaimageview;
    UIButton *agreebutton;
   // NavBarView *mybarview;
    UIImageView *phoneimageview;
    UIImageView *newpwimageview;
    UIImageView *successimageview;
    UIImageView *bigsuccessimagev;
    UIView *lineview1;
    UIView *lineview2;
    UITextField *codetf;
    UITextField *passwordtf2;
    UIImageView *pwimgView;
    UIImageView *pwimgView1;
}


@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    havepress=YES;
    //[self addviews];
    pwimgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_phone_1"]];
    pwimgView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_qrcode_1"]];

    self.view.backgroundColor=[UIColor whiteColor];
    
     pwimgView.frame = CGRectMake(15, 0, 20, 25);
     pwimgView1.frame = CGRectMake(15, 0, 20, 25);
   
    
    self.usernametf=[[UITextField alloc]initWithFrame:CGRectMake(15, 160, ScreenWidth-30, 60)];
    self.usernametf.delegate=self;
    self.usernametf.placeholder=@"手机号码";
     self.usernametf.layer.masksToBounds = YES;
     self.usernametf.layer.cornerRadius = 6.0;
    self.usernametf.layer.borderWidth=0.0;
    self.usernametf.tintColor=KlightOrangeColor;
     KtfAddpaddingView(self.usernametf);
    self.usernametf.keyboardType=UIKeyboardTypeNumberPad;
    [self.usernametf.leftView addSubview:pwimgView];
    self.usernametf.leftViewMode = UITextFieldViewModeAlways;
    self.usernametf.leftView.bounds=CGRectMake(0, 0, 40, 25);

    self.usernametf.layer.borderColor=[kimiColor(232, 232, 233, 1) CGColor];
    [self.view addSubview:self.usernametf];
    [self.usernametf addSubview:[[UIManager shareInstance]getlineviewWithFrame:CGRectMake(0, 49, ScreenWidth-30, 1) withimage:nil withbgcolor:KLineColor]];

//    self.passwordtf=[[UITextField alloc]initWithFrame:CGRectMake(15, ScreenHeight/2-60-50, ScreenWidth-30, 50)];
//    self.passwordtf.delegate=self;
//    self.passwordtf.placeholder=@"设置密码";
//    self.passwordtf.secureTextEntry=YES;
//    self.passwordtf.layer.cornerRadius = 6.0;
//    self.passwordtf.tintColor=KlightOrangeColor;
//
//    self.passwordtf.layer.borderWidth=0.0;
//     KtfAddpaddingView(self.passwordtf);
//    self.passwordtf.layer.borderColor=[kimiColor(232, 232, 233, 1) CGColor];
//    [self.passwordtf.leftView addSubview:pwimgView2];
//    self.passwordtf.leftViewMode = UITextFieldViewModeAlways;
//    self.passwordtf.leftView.bounds=CGRectMake(0, 0, 40, 25);
//    [self.view addSubview:self.passwordtf];
//    
//    [self.passwordtf addSubview:[[UIManager shareInstance]getlineviewWithFrame:CGRectMake(0, 49, ScreenWidth-30, 1) withimage:nil withbgcolor:KLineColor]];
//    
    
//    passwordtf2=[[UITextField alloc]initWithFrame:CGRectMake(15, ScreenHeight/2-50, ScreenWidth-30, 50)];
//    passwordtf2.delegate=self;
//   
//    passwordtf2.tintColor=KlightOrangeColor;
//    passwordtf2.placeholder=@"确认密码";
//    passwordtf2.secureTextEntry=YES;
//    passwordtf2.layer.cornerRadius = 6.0;
//    
//    passwordtf2.layer.borderWidth=0.0;
//    KtfAddpaddingView(passwordtf2);
//    passwordtf2.layer.borderColor=[kimiColor(232, 232, 233, 1) CGColor];
//    [passwordtf2.leftView addSubview:pwimgView3];
//    passwordtf2.leftViewMode = UITextFieldViewModeAlways;
//    passwordtf2.leftView.bounds=CGRectMake(0, 0, 40, 25);
//    [self.view addSubview:passwordtf2];
//    
//    [passwordtf2 addSubview:[[UIManager shareInstance]getlineviewWithFrame:CGRectMake(0, 49, ScreenWidth-30, 1) withimage:nil withbgcolor:KLineColor]];
//    
    
    codetf=[[UITextField alloc]initWithFrame:CGRectMake(15, 230, (ScreenWidth-60)/3*2, 60)];
    codetf.delegate=self;
    codetf.placeholder=@"验证码";
  //  codetf.secureTextEntry=YES;
    codetf.layer.cornerRadius = 6.0;
    codetf.tintColor=KlightOrangeColor;
    codetf.layer.borderWidth=0.0;
    KtfAddpaddingView(codetf);
    codetf.keyboardType=UIKeyboardTypeNumberPad;
    
    [codetf.leftView addSubview:pwimgView1];
    codetf.leftViewMode = UITextFieldViewModeAlways;
    codetf.leftView.bounds=CGRectMake(0, 0, 40, 25);
    codetf.layer.borderColor=[kimiColor(232, 232, 233, 1) CGColor];
    [self.view addSubview:codetf];
    
    [codetf addSubview:[[UIManager shareInstance]getlineviewWithFrame:CGRectMake(0, 49, ScreenWidth-30, 1) withimage:nil withbgcolor:KLineColor]];
    
    
    getcodebutton=[UIButton buttonWithType:UIButtonTypeCustom];
    getcodebutton.frame=CGRectMake((ScreenWidth-60)/3*2+30+10, 230, (ScreenWidth-60)/3*1-10, 50);
    getcodebutton.alpha=0.8;
    getcodebutton.backgroundColor=KlightOrangeColor;
    [getcodebutton setTitle:@"获取验证码" forState:UIControlStateNormal];
    getcodebutton.titleLabel.font=[UIFont systemFontOfSize:13.0];
    [getcodebutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    // getcodebutton.backgroundColor=[UIColor grayColor];
    getcodebutton.layer.masksToBounds = YES;
    getcodebutton.layer.cornerRadius = 4.0;
    getcodebutton.layer.borderWidth = 1.0;
    getcodebutton.layer.borderColor = [[UIColor clearColor] CGColor];
    
    [getcodebutton addTarget:self action:@selector(getnewCode:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:getcodebutton];
    
    
    
    
    itembutton=[UIButton buttonWithType:UIButtonTypeCustom];
    itembutton.frame=CGRectMake(ScreenWidth-ScreenWidth/4-40, 220,ScreenWidth/4,20);
    //[itembutton setTitle:[buttonnameArr objectAtIndex:i] forState:UIControlStateNormal];
    itembutton.titleLabel.font=[UIFont systemFontOfSize:13.0];
    
    itembutton.tag=10000000;
    [itembutton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    //  [itembutton setTitleEdgeInsets:UIEdgeInsetsMake(5, 0, 1, 1)];
    [itembutton addTarget:self action:@selector(changeimageaction) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:itembutton];
    
    loginbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    loginbutton.tag=1002;
    loginbutton.frame=CGRectMake(15, ScreenHeight/2+30, ScreenWidth-30, 50);
    loginbutton.layer.masksToBounds = YES;
    loginbutton.layer.cornerRadius = 8.0;
    loginbutton.layer.borderWidth = 1.0;
    loginbutton.layer.borderColor = [KlightOrangeColor CGColor];
    [loginbutton setTitle:@"提交" forState:UIControlStateNormal];
    [loginbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginbutton.titleLabel.font=[UIFont systemFontOfSize:22.0];
    loginbutton.backgroundColor=KlightOrangeColor;
    [loginbutton addTarget:self action:@selector(regnextaction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginbutton];

    
    UILabel *fuwulabel1=[[UILabel alloc]init];
    fuwulabel1.frame=CGRectMake(10, ScreenHeight/2+100, ScreenWidth-20, 30);
    
    fuwulabel1.text=@"手机仅用于注册，患者不可见";
    fuwulabel1.textAlignment=NSTextAlignmentCenter;
    
    fuwulabel1.font=[UIFont systemFontOfSize:16.0];
    fuwulabel1.textColor=KLineColor;
    [self.view addSubview:fuwulabel1];
    
    UILabel *fuwulabel=[[UILabel alloc]init];
    fuwulabel.frame=CGRectMake(10, ScreenHeight/2+125, ScreenWidth/2-3, 30);
    
    fuwulabel.text=@"注册即表示同意";
    fuwulabel.textAlignment=NSTextAlignmentRight;
    
    fuwulabel.font=[UIFont systemFontOfSize:16.0];
    fuwulabel.textColor=KLineColor;
    [self.view addSubview:fuwulabel];
    
    UIButton *serveevenyvc=[UIButton buttonWithType:UIButtonTypeSystem];
    serveevenyvc.frame=CGRectMake(ScreenWidth/2, ScreenHeight/2+125, 0, 30);
    [serveevenyvc setTitle:@"《服务条款》" forState:UIControlStateNormal];
    [serveevenyvc sizeToFit];
    [serveevenyvc addTarget:self action:@selector(serveevenyvcaction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:serveevenyvc];
    
    
    
    
    UILabel *fuwulabel2=[[UILabel alloc]init];
    fuwulabel2.frame=CGRectMake(10, ScreenHeight-70, ScreenWidth-20, 30);
    
    fuwulabel2.text=@"如果您有任何疑问，请拨打客服电话";
    fuwulabel2.textAlignment=NSTextAlignmentCenter;
    
    fuwulabel2.font=[UIFont systemFontOfSize:16.0];
    fuwulabel2.textColor=KLineColor;
    [self.view addSubview:fuwulabel2];
    
    
    UIButton *phonebtn=[UIButton buttonWithType:UIButtonTypeSystem];
    phonebtn.frame=CGRectMake(0, ScreenHeight-35, ScreenWidth, 30);
    [phonebtn setTitle:@"400-061-8989" forState:UIControlStateNormal];
   // [phonebtn sizeToFit];
    [phonebtn addTarget:self action:@selector(phonebtnaction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:phonebtn];

    timer=[NSTimer timerWithTimeInterval:1 target:self selector:@selector(timeraction:) userInfo:nil repeats:YES];
    
    NavBarView *mybarview=[[NavBarView alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, 64)];
    mybarview.delegate=self;
   // mybarview.navbarTitle=@"注册";
    [mybarview setnavcanclecolor:[UIColor orangeColor]];
    [mybarview setnavcancletitle:@" 返回登录"];
    [mybarview setnavcancletimage:@"back"];
    
    mybarview.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:mybarview];
    UIView *bgv=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    bgv.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:bgv];


      // Do any additional setup after loading the view.
}
-(void)phonebtnaction{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"4000618989"];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];

}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.usernametf resignFirstResponder];
    [self.passwordtf resignFirstResponder];
    [passwordtf2 resignFirstResponder];
    [codetf resignFirstResponder];
}
-(void)serveevenyvcaction{
    SettingWebViewController *VC=[[SettingWebViewController alloc]init];
    VC.urslstr=[NSString stringWithFormat:@"%@%@",k_webbaseurl,@"serviceAgreement.html"];
    VC.title=@"服务协议";
    // @"http://rm.chengyisheng.com.cn:8080/app_web/app_doctor_web/view/authentication.html";
    
    [self.navigationController pushViewController:VC animated:YES];

}
-(void)addviews{
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
-(void)agreebuttonaction{
    if (havepress==NO) {
        havepress=YES;
        // [agreebutton setTitle:@"+ 我已阅读并接受服务条款" forState:UIControlStateNormal];
        [agreebutton setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
    } else {
        havepress=NO;
        // [agreebutton setTitle:@"我已阅读并接受服务条款" forState:UIControlStateNormal];
        [agreebutton setImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
    }
   
}
-(void)haveaccountaction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (BOOL)myisPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField==self.usernametf) {
        if (![self myisPureInt:self.usernametf.text]||self.usernametf.text.length!=11) {
             pwimgView.image=[UIImage imageNamed:@"login_phone_1"];
        }else{
            pwimgView.image=[UIImage imageNamed:@"login_phone_2"];
            
        }
        
    }else{
          if (![textField.text isEqualToString:@""]) {
           pwimgView1.image=[UIImage imageNamed:@"login_qrcode_2"];
          }else{
           pwimgView1.image=[UIImage imageNamed:@"login_qrcode_1"];
          }
    }
    
}
-(void)regnextaction{
    
//    verifyViewController *verifyvc=[[verifyViewController alloc]init];
//    verifyvc.title=NSLocalizedString(@"Register", nil);
//    verifyvc.phonenum=self.usernametf.text;
//    [self.navigationController pushViewController:verifyvc animated:YES];
    [self.usernametf resignFirstResponder];
    [self.passwordtf resignFirstResponder];
    [passwordtf2 resignFirstResponder];
    [codetf resignFirstResponder];
    
    if (![self myisPureInt:self.usernametf.text]||self.usernametf.text.length!=11) {
        [[PublicTools shareInstance]setmyPview:self.view];
        [[PublicTools shareInstance]creareNotificationUIView:NSLocalizedString(@"请输入您的手机号", nil)];
    }else{
        NSLog(@"%@",self.passwordtf.text);
        if (havepress!=YES) {
            [[PublicTools shareInstance]setmyPview:self.view];
            [[PublicTools shareInstance]creareNotificationUIView:@"请阅读并同意服务条款"];
            
        }else{
            if ([codetf.text isEqualToString:@""]){
                
                [[PublicTools shareInstance]setmyPview:self.view];
                [[PublicTools shareInstance]creareNotificationUIView:@"请输入验证码"];
            }else{
               
                
                [MsisdnDataService verfyCaptchaCodeWithMsisdn:self.usernametf.text captcha:codetf.text block:^(id dic) {
                    SetPasswordViewController *verifyvc=[[SetPasswordViewController alloc]init];
                    //verifyvc.title=NSLocalizedString(@"Register", nil);
                    
                    verifyvc.phonenum=self.usernametf.text;
                    verifyvc.signature=[dic objectForKey:@"signature"];
                    [self.navigationController pushViewController:verifyvc animated:YES];
                }];
                
                
               
            
            }

        }
    }
    
}
-(void)changeimageaction{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.usernametf resignFirstResponder];
    [self.passwordtf resignFirstResponder];
    [passwordtf2 resignFirstResponder];
    [codetf resignFirstResponder];
    return YES;
}
-(void)getnewCode:(UIButton *)button{
    [self.usernametf resignFirstResponder];
    [self.passwordtf resignFirstResponder];
    [passwordtf2 resignFirstResponder];
    [codetf resignFirstResponder];
    
    if (![self myisPureInt:self.usernametf.text]||self.usernametf.text.length!=11) {
        [[PublicTools shareInstance]setmyPview:self.view];
        [[PublicTools shareInstance]creareNotificationUIView:NSLocalizedString(@"请输入您的手机号", nil)];
    }else{
        getcodebutton.userInteractionEnabled=NO;
        getcodebutton.backgroundColor=KLineColor;
        i=60;
        
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        
        
        [MsisdnDataService getCaptchaCodeWithMsisdn:self.usernametf.text type:0 block:^(id responsearr) {
            
            NSLog(@"%@",responsearr);
             NSLog(@"%@",responsearr);
        }];
        
        
        
        
        
        
    }
    
  

   

    
}
-(void)timeraction:(NSTimer *)timer{
    
    if (i>0) {
        i--;
        
        getcodebutton.userInteractionEnabled=NO;
        [getcodebutton setTitle:[NSString stringWithFormat:@"请等待%zd秒",i] forState:UIControlStateNormal];
        
        }else{
        
        [getcodebutton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [timer invalidate];
        getcodebutton.userInteractionEnabled=YES;
        getcodebutton.backgroundColor=KlightOrangeColor;
        
    }
    
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
