//
//  LoginViewController.m
//  ZDE
//
//  Created by 谢阳晴 on 15/5/18.
//  Copyright (c) 2015年 谢阳晴. All rights reserved.
//

#import "LogintocysViewController.h"
#import "RegisterViewController.h"
#import "ForPWViewController.h"
#import "AFHttpTool.h"
#import "RCDCommonDefine.h"
#import "RCDRCIMDataSource.h"
#import "RCDHttpTool.h"
#import "PubilcViewController.h"


#define RCDDataSource [RCDRCIMDataSource shareInstance]

@interface LogintocysViewController (){
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
    UIImageView *pimagev;
    JGProgressHUD *HUD;
    UIImageView *userimgView;
    UIImageView *pwimgView;
}

@end

@implementation LogintocysViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    haveremember=NO;
    UIImageView *bgimageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight )];
    bgimageview.image=[UIImage imageNamed:@""];
    [bgimageview setContentScaleFactor:[[UIScreen mainScreen] scale]];
    bgimageview.contentMode=UIViewContentModeScaleAspectFill;
    bgimageview.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    bgimageview.clipsToBounds  = YES;
   // [self.view addSubview:bgimageview];
    self.view.backgroundColor=[UIColor whiteColor];

        mimalabel=[[UILabel alloc]initWithFrame:CGRectMake(10, ScreenHeight-170, ScreenWidth-20, 40)];
        mimalabel.text=@"使用第三方登录方式";
        mimalabel.textAlignment=NSTextAlignmentCenter;
       // [self.view addSubview:mimalabel];

    UIButton *normallogin=[UIButton buttonWithType:UIButtonTypeCustom];
    normallogin.tag=1001;
    normallogin.frame=CGRectMake(ScreenWidth/2-60/2, ScreenHeight-120, 60, 60);
   
    [normallogin setImage:[UIImage imageNamed:@"weixin1"] forState:UIControlStateNormal];
    normallogin.titleLabel.font=[UIFont systemFontOfSize:18.0];
    normallogin.backgroundColor=[UIColor whiteColor];
    oldbutton=normallogin;
    [normallogin addTarget:self action:@selector(weixinloginaction) forControlEvents:UIControlEventTouchUpInside];
   // [self.view addSubview:normallogin];
    
    pimagev=[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/2-155/2,40, 155, 220)];
    pimagev.image= [UIImage imageNamed:@"login_logo"];
    
    
    [self.view addSubview:pimagev];
    
    
    userimgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_phone_1"]];
    pwimgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_code_1"]];

    self.usernametf=[[UITextField alloc]initWithFrame:CGRectMake(15, ScreenHeight/2-20, ScreenWidth-30, 40)];
    self.usernametf.delegate=self;
    self.usernametf.placeholder=@"手机号";
    KtfAddpaddingView(self.usernametf);
    userimgView.frame = CGRectMake(15, 0, 20, 25);
    [self.usernametf.leftView addSubview:userimgView];
    self.usernametf.font=[UIFont systemFontOfSize:18];
    self.usernametf.leftViewMode = UITextFieldViewModeAlways;
    self.usernametf.leftView.bounds=CGRectMake(0, 0, 40, 25);
     self.usernametf.layer.masksToBounds = YES;
     self.usernametf.layer.cornerRadius = 6.0;
    self.usernametf.tintColor=KlightOrangeColor;
    self.usernametf.layer.borderWidth=0.0;
    self.usernametf.layer.borderColor=[kimiColor(232, 232, 233, 1) CGColor];
    self.usernametf.returnKeyType=UIReturnKeyDone;
    self.usernametf.keyboardType=UIKeyboardTypeNumberPad;
    [self.view addSubview:self.usernametf];
    [self.usernametf addSubview:[[UIManager shareInstance]getlineviewWithFrame:CGRectMake(0, 39, ScreenWidth-30, 1) withimage:nil withbgcolor:KLineColor]];
    
//    mimalabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 215, ScreenWidth/4*1-5, 40)];
//    mimalabel.text=NSLocalizedString(@"pw", nil);
//    mimalabel.textAlignment=NSTextAlignmentCenter;
//    [self.view addSubview:mimalabel];
    self.passwordtf=[[UITextField alloc]initWithFrame:CGRectMake(15, ScreenHeight/2+30, ScreenWidth-30, 40)];
    self.passwordtf.delegate=self;
    self.passwordtf.secureTextEntry=YES;
     self.passwordtf.font=[UIFont systemFontOfSize:18];
     KtfAddpaddingView(self.passwordtf);
    self.passwordtf.tintColor=KlightOrangeColor;
     pwimgView.frame = CGRectMake(15, 0, 20, 25);
    
   
    [self.passwordtf.leftView addSubview:pwimgView];
    
    self.passwordtf.leftViewMode = UITextFieldViewModeAlways;
    self.passwordtf.leftView.bounds=CGRectMake(0, 0, 40, 25);
    
    self.passwordtf.placeholder=@"密码";
    self.passwordtf.layer.masksToBounds = YES;
    self.passwordtf.layer.cornerRadius = 6.0;
    self.passwordtf.returnKeyType=UIReturnKeyDone;
    self.passwordtf.layer.borderWidth=0.0;
    self.passwordtf.layer.borderColor=[kimiColor(232, 232, 233, 1) CGColor];
    [self.view addSubview:self.passwordtf];
    [self.passwordtf addSubview:[[UIManager shareInstance]getlineviewWithFrame:CGRectMake(0, 39, ScreenWidth-30, 1) withimage:nil withbgcolor:KLineColor]];
    
    
    
    getnewcodenbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    getnewcodenbutton.frame=CGRectMake(ScreenWidth-ScreenWidth/4-20, 225,ScreenWidth/4,40);
    getnewcodenbutton.alpha=0.8;
    [getnewcodenbutton setTitle:NSLocalizedString(@"sendcptcha", nil) forState:UIControlStateNormal];
    getnewcodenbutton.titleLabel.font=[UIFont systemFontOfSize:13.0];
    [getnewcodenbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    getnewcodenbutton.backgroundColor=[UIColor redColor];
    getnewcodenbutton.layer.masksToBounds = YES;
    getnewcodenbutton.layer.cornerRadius = 3.0;
    getnewcodenbutton.layer.borderWidth = 1.0;
    getnewcodenbutton.layer.borderColor = [[UIColor clearColor] CGColor];
    
    [getnewcodenbutton addTarget:self action:@selector(getnewCode:) forControlEvents:UIControlEventTouchUpInside];
    getnewcodenbutton.userInteractionEnabled=YES;
    getnewcodenbutton.hidden=YES;
    [self.view addSubview:getnewcodenbutton];

    
    
    
    
    
    remembermebutton =[UIButton buttonWithType:UIButtonTypeCustom];
    remembermebutton.frame=CGRectMake(15, 375-131, ScreenWidth/4*1, 30);
    [remembermebutton setTitle:NSLocalizedString(@"rememberme", nil) forState:UIControlStateNormal];
    [remembermebutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [remembermebutton setImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
    [remembermebutton setImage:[UIImage imageNamed:@"check"] forState:UIControlStateSelected];
    remembermebutton.titleLabel.font=[UIFont systemFontOfSize:14.0];
    //remembermebutton.backgroundColor=[UIColor grayColor];
    [remembermebutton addTarget:self action:@selector(remembermebuttonaction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:remembermebutton];
    
    
  
//        forgetpasswordlb=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2-60, ScreenHeight-40, 120, 30)];
//        forgetpasswordlb.text=@"忘记密码？";
//        forgetpasswordlb.font=[UIFont systemFontOfSize:22.0];
//        forgetpasswordlb.textColor=KLineColor;
//        forgetpasswordlb.textAlignment=NSTextAlignmentLeft;
//        [self.view addSubview:forgetpasswordlb];
    
        itembutton=[UIButton buttonWithType:UIButtonTypeSystem];
        itembutton.frame=CGRectMake(ScreenWidth/2-60, ScreenHeight-30, 120, 30);
        [itembutton setTitle:@"忘记密码？" forState:UIControlStateNormal];
    
        itembutton.titleLabel.font=[UIFont systemFontOfSize:18.0];
    
        itembutton.tag=10000000;
        //[itembutton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        //  [itembutton setTitleEdgeInsets:UIEdgeInsetsMake(5, 0, 1, 1)];
        [itembutton addTarget:self action:@selector(forgetpasswordaction) forControlEvents:UIControlEventTouchUpInside];
        
        
        [self.view addSubview:itembutton];

    

    
    
    
    loginbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    loginbutton.tag=1002;
    loginbutton.frame=CGRectMake(15, ScreenHeight/2+70+50, (ScreenWidth-45)/2, 40);
    loginbutton.layer.masksToBounds = YES;
    loginbutton.layer.cornerRadius = 6.0;
    loginbutton.layer.borderWidth = 1.0;
    loginbutton.layer.borderColor = [[UIColor clearColor] CGColor];
    [loginbutton setTitle:@"登录" forState:UIControlStateNormal];
    [loginbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginbutton.titleLabel.font=[UIFont boldSystemFontOfSize:22.0];
    loginbutton.backgroundColor=KlightOrangeColor;
    [loginbutton addTarget:self action:@selector(trueloginaction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginbutton];
    

    
    registerbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    registerbutton.frame=CGRectMake(15*2+(ScreenWidth-45)/2, ScreenHeight/2+70+50, (ScreenWidth-45)/2,40);
    [registerbutton setTitle:@"注册" forState:UIControlStateNormal];
    registerbutton.titleLabel.font=[UIFont boldSystemFontOfSize:22.0];
    registerbutton.layer.cornerRadius=6.0;
    registerbutton.layer.borderWidth=1.0;
    registerbutton.layer.borderColor=KlightOrangeColor.CGColor;
    registerbutton.tag=10000000;
    [registerbutton setTitleColor:KlightOrangeColor forState:UIControlStateNormal];
    //  [itembutton setTitleEdgeInsets:UIEdgeInsetsMake(5, 0, 1, 1)];
    [registerbutton addTarget:self action:@selector(registerbuttonaction) forControlEvents:UIControlEventTouchUpInside];
   // registerbutton.backgroundColor=KlightOrangeColor;
    
    [self.view addSubview:registerbutton];

    
    UIButton *dismissbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    dismissbutton.tag=1002;
    dismissbutton.frame=CGRectMake(5, 25, 30, 30);
   // [dismissbutton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [dismissbutton addTarget:self action:@selector(dismissbuttonaction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dismissbutton];

    //[self.view addSubview:containview];
    
    // Do any additional setup after loading the view.
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.usernametf resignFirstResponder];
     [self.passwordtf resignFirstResponder];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField==self.usernametf) {
        if (![self myisPureInt:self.usernametf.text]||self.usernametf.text.length!=11) {
            userimgView.image=[UIImage imageNamed:@"login_phone_1"];
        }else{
            userimgView.image=[UIImage imageNamed:@"login_phone_2"];
            
        }
    }else{
          if (![textField.text isEqualToString:@""]) {
              pwimgView.image=[UIImage imageNamed:@"login_code_2"];
          }else{
               pwimgView.image=[UIImage imageNamed:@"login_code_1"];
         
          }
    }
   

    
}
-(void)dismissbuttonaction{
    if (self.needfirst) {
//         [[NSNotificationCenter defaultCenter]postNotificationName:@"changecentervc" object:@"yes"];
    } else {
        // [[NSNotificationCenter defaultCenter]postNotificationName:@"changecentervc" object:@"no"];
    }
   
    [self dismissViewControllerAnimated:YES completion:nil];
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
-(void)weixinloginaction{
    
}
-(void)getnewCode:(UIButton *)button{
    getnewcodenbutton.userInteractionEnabled=NO;
    i=60;
    getnewcodenbutton.backgroundColor=[UIColor grayColor];
    timer=[NSTimer timerWithTimeInterval:1 target:self selector:@selector(timeraction:) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    // Do any additional setup after loading the view.
    
    
}
-(void)timeraction:(NSTimer *)timer{
   
    if (i>0) {
        i--;
        
        getnewcodenbutton.userInteractionEnabled=NO;
        [getnewcodenbutton setTitle:[NSString stringWithFormat:@"请等待%zd秒",i] forState:UIControlStateNormal];
    }else{
        getnewcodenbutton.backgroundColor=[UIColor redColor];
        [getnewcodenbutton setTitle:[NSString stringWithFormat:@"发送验证码"] forState:UIControlStateNormal];
         getnewcodenbutton.userInteractionEnabled=YES;
    }
    
}

-(void)registerbuttonaction{
    RegisterViewController *registervc=[[RegisterViewController alloc]init];
    registervc.title=NSLocalizedString(@"Register", nil);
    [self.navigationController pushViewController:registervc animated:YES];
}
-(void)forgetpasswordaction{
    
    
    ForPWViewController *forgetpwvc=[[ForPWViewController alloc]init];
    [self.navigationController pushViewController:forgetpwvc animated:YES];
    
    
}
-(void)trueloginaction{
    [self.usernametf resignFirstResponder];
    [self.passwordtf resignFirstResponder];
    
    
 
    if (![self myisPureInt:self.usernametf.text]||self.usernametf.text.length!=11) {
        [[PublicTools shareInstance]setmyPview:self.view];
        [[PublicTools shareInstance]creareNotificationUIView:@"请输入正确的登录信息"];
    }else{
        HUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
        [HUD showInView:self.view];
        [HUD dismissAfterDelay:2.0];

        
      [LoginDataService loginWithUsername:self.usernametf.text password:self.passwordtf.text block:^(id dic) {
          NSLog(@"%@",dic);
          
          NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
          [defaults setObject:[dic objectForKey:@"token"] forKey:@"token"];
          [defaults setObject:[dic objectForKey:@"msisdn"] forKey:@"phonenum"];
          [defaults setObject:[dic objectForKey:@"doctor-id"] forKey:@"doctor-id"];
          [defaults setObject:[[dic objectForKey:@"doctor-info"] objectForKey:@"icon"] forKey:@"icon-url"];
          [defaults setObject:[[dic objectForKey:@"doctor-info"] objectForKey:@"name"] forKey:@"nick-name"];
          [defaults setObject:[[dic objectForKey:@"doctor-info"] objectForKey:@"id"] forKey:@"userid"];
          [defaults setObject:[[dic objectForKey:@"doctor-info"] objectForKey:@"title"] forKey:@"usertitle"];
          [defaults setObject:[[dic objectForKey:@"doctor-info"] objectForKey:@"hospital"] forKey:@"userhospital"];
          [defaults setObject:[[dic objectForKey:@"doctor-info"] objectForKey:@"department"] forKey:@"department"];
          
          if ([[[dic objectForKey:@"doctor-info"] objectForKey:@"hospital"]isEqualToString:@"AUDIT_PASSED"]) {
            //HAVEPASS;
          }
          [defaults setObject:[[dic objectForKey:@"doctor-info"] objectForKey:@"status"] forKey:@"userstatus"];
               
          [defaults setObject:[[dic objectForKey:@"doctor-info"] objectForKey:@"cheng_num"] forKey:@"usercheng_num"];
          
//          [defaults setObject:[[dic objectForKey:@"im-reg-id"] objectForKey:@"im_id"] forKey:@"im-id"];
//          [defaults setObject:[[dic objectForKey:@"im-reg-id"] objectForKey:@"im_reg_id"] forKey:@"im-token"];
          [defaults synchronize];
          
          [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadindex" object:nil];
          [[NSNotificationCenter defaultCenter]postNotificationName:@"reloginupdateinfo" object:nil];
          
          [self dismissViewControllerAnimated:YES completion:nil];
          
        
          
          
          [LoginDataService getSelfIMInfoblock:^(id respdic) {
              NSLog(@"%@",respdic);
              NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
              [defaults setObject:[respdic objectForKey:@"im_id"] forKey:@"im-id"];
              [defaults setObject:[respdic objectForKey:@"im_reg_id"] forKey:@"im-token"];
              [defaults synchronize];
              [self login:[[NSUserDefaults standardUserDefaults]objectForKey:@"im-id"] password:@"123456"];
             // [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadindex" object:nil];

          }];
          
                  
          
         
          

      }];
    }
    
    
}

- (void)login:(NSString *)userName password:(NSString *)password
{
    RCNetworkStatus stauts=[[RCIMClient sharedRCIMClient]getCurrentNetworkStatus];
    
    if (RC_NotReachable == stauts) {
       // _errorMsgLb.text=@"当前网络不可用，请检查！";
        return;
    } else {
       // _errorMsgLb.text=@"";
    }
    
     [[NSUserDefaults standardUserDefaults] removeObjectForKey :@"UserCookies"];
     [self loginRongCloud:@"haha@chengyisheng.com" token:[[NSUserDefaults standardUserDefaults]objectForKey:@"im-token"] password:password];
    
//    [AFHttpTool loginWithEmail:userName password:password env:0
//                       success:^(id response) {
//                           if ([response[@"code"] intValue] == 200) {
//                                 //                                NSString *token = response[@"result"][@"token"];
//                               //                                   RCDLoginInfo *loginInfo = [RCDLoginInfo shareLoginInfo];
//                               //                                   loginInfo = [loginInfo initWithDictionary:response[@"result"] error:NULL];
//                              
//                           }else{
//                               //关闭HUD
//                               //                                   [hud hide:YES];
//                               //                                   int _errCode = [response[@"code"] intValue];
//                               //                                   NSLog(@"NSError is %d",_errCode);
//                               //                                   if(_errCode==500)
//                               //                                   {
//                               //                                       _errorMsgLb.text=@"APP服务器错误！";
//                               //
//                               //                                   }else
//                               //                                   {
//                               //                                       _errorMsgLb.text=@"用户名或密码错误！";
//                               //                                   }
//                               //                                   [_pwdTextField shake];
//                           }
//                       }
//                       failure:^(NSError* err) {
//                           //关闭HUD
//                           //                               [hud hide:YES];
//                           //                               NSLog(@"NSError is %ld",(long)err.code);
//                           //                               if (err.code == 3840) {
//                           //                                   _errorMsgLb.text=@"用户名或密码错误！";
//                           //                                   [_pwdTextField shake];
//                           //                               }else{
//                           //                                   _errorMsgLb.text=@"DemoServer错误！";
//                           //                                   [_pwdTextField shake];
//                           //                               }
//                           
//                       }];
//
}



////验证用户信息格式
//- (BOOL)validateUserName:(NSString*)userName
//                 userPwd:(NSString*)userPwd
//{
//    NSString* alertMessage = nil;
//    if (userName.length == 0) {
//        alertMessage = @"用户名不能为空!";
//    }
//    else if (userPwd.length == 0) {
//        alertMessage = @"密码不能为空!";
//    }
//    if (self.rcDebug) {
//        if (self.currentModel == nil) {
//            alertMessage = @"请选择AppKey";
//        }
//    }
//    
//    if (alertMessage) {
//        _errorMsgLb.text = alertMessage;
//        [_pwdTextField shake];
//        return NO;
//    }
//    
//    return [RCDTextFieldValidate validateEmail:userName]
//    && [RCDTextFieldValidate validatePassword:userPwd];
//}














- (BOOL)myisPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}
-(void)loadIMdata{
    if (![[NSUserDefaults standardUserDefaults]objectForKey:@"imusername"]) {
        
           }
}

-(void)regpushtoken{
     if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"isneedpush"]isEqualToString:@"YES"]){
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"pushtoken"],@"token",@"ios",@"os-type", nil];
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"token"]) {
        
    }
 }
   // [HUD dismiss];
    if (self.isrootvc) {
        [self.delegate havelogin];
    }
   
}
-(void)newgetprojid{
//    JGProgressHUD *hud=[[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleLight];
//    [hud dismissAfterDelay:10];
//    [hud showInView:[UIApplication sharedApplication].keyWindow];
 //   NSString *urlstring1=[NSString stringWithFormat:@"private/order/ordered-project/"];
    
}

-(void)remembermebuttonaction:(UIButton *)button{
   
   
    if (haveremember==NO) {
        haveremember=YES;
         [remembermebutton setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
    }else{
        haveremember=NO;
         [remembermebutton setImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
    }
}
-(void)loginaction:(UIButton *)button{
    [self.usernametf resignFirstResponder];
    [self.passwordtf resignFirstResponder];
    button.backgroundColor=[UIColor whiteColor];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if (button.tag==oldbutton.tag) {
        
    }else{
        oldbutton.backgroundColor=[UIColor grayColor];
        [oldbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        oldbutton=button;
    }
    if (button.tag==1001) {
        [timer invalidate];
        i=60;
         getnewcodenbutton.backgroundColor=[UIColor redColor];
        [getnewcodenbutton setTitle:[NSString stringWithFormat:NSLocalizedString(@"sendcptcha", nil)] forState:UIControlStateNormal];
        getnewcodenbutton.userInteractionEnabled=YES;

        denglulabel.text=NSLocalizedString(@"Login", nil);
        mimalabel.text=NSLocalizedString(@"pw", nil);
        self.usernametf.placeholder=NSLocalizedString(@" Phonenum", nil);
        self.passwordtf.placeholder=NSLocalizedString(@" enterpw", nil);
        self.passwordtf.frame=CGRectMake(10+ScreenWidth/4*1, 215, ScreenWidth/3*2, 40);

        remembermebutton.hidden=NO;
        forgetpasswordlb.hidden=NO;
        getnewcodenbutton.hidden=YES;
        
    }else{
        denglulabel.text=NSLocalizedString(@" Phonenum", nil);
        mimalabel.text=NSLocalizedString(@"captcha", nil);
        self.passwordtf.frame=CGRectMake(10+ScreenWidth/4*1, 215, ScreenWidth/4*1, 40);
        self.usernametf.placeholder=NSLocalizedString(@" Phonenum", nil);
        self.passwordtf.placeholder=NSLocalizedString(@" enterpw", nil);
        getnewcodenbutton.hidden=NO;

        remembermebutton.hidden=YES;
        forgetpasswordlb.hidden=YES;
        

        
        
   
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (void)loginRongCloud:(NSString *)userName token:(NSString *)token password:(NSString *)password
{
    token=[[NSUserDefaults standardUserDefaults]objectForKey:@"im-token"];
    NSLog(@"%@",token);
    //登陆融云服务器
    [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
        [self dismissViewControllerAnimated:YES completion:nil];
        //[HUD dismiss];
       // NSLog([NSString stringWithFormat:@"token is %@  userId is %@",token,userId],nil);
//        [self loginSuccess:userName password:password token:token userId:[[NSUserDefaults standardUserDefaults]objectForKey:@"im-id"]];
//        
        
        
    } error:^(RCConnectErrorCode status) {
      //  [HUD dismiss];
        //关闭HUD
//        [hud hide:YES];
//        NSLog(@"RCConnectErrorCode is %ld",(long)status);
//        _errorMsgLb.text=@"Token无效！";
//        [_pwdTextField shake];
        
    } tokenIncorrect:^{
        NSLog(@"IncorrectToken");
        
//        //        if (_loginFailureTimes<3) {
//        //            _loginFailureTimes++;
//        //            [AFHttpTool getTokenSuccess:^(id response) {
//        //                [self loginRongCloud:userName token:token password:password];
//        //            } failure:^(NSError *err) {
//        //                dispatch_async(dispatch_get_main_queue(), ^{
//        //                [hud hide:YES];
//        //                _errorMsgLb.text=@"Token无效";
//        //                });
//        //            }];
//        //        }else
//        //        {
//        _loginFailureTimes=0;
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [hud hide:YES];
//            _errorMsgLb.text=@"Token无效";
//        });
//        //        }
        
        
    }];
}
- (void)loginSuccess:(NSString *)userName password:(NSString *)password token:(NSString *)token userId:(NSString *)userId
{
    
    
    
    NSInteger groupcount=(NSInteger)[[RCIMClient sharedRCIMClient]getTotalUnreadCount];
    //    int groupmessagecount=[[RCIMClient sharedRCIMClient]getUnreadCount:ConversationType_GROUP targetId:nil];
    //    int privatemessagecount=[[RCIMClient sharedRCIMClient]getUnreadCount:ConversationType_PRIVATE targetId:nil];
    
//    NSLog(@"%zd",groupcount);
//    NSLog(@"%zd",groupcount);
    
    //保存默认用户
    [DEFAULTS setObject:userName forKey:@"userName"];
    [DEFAULTS setObject:password forKey:@"userPwd"];
    [DEFAULTS setObject:token forKey:@"userToken"];
    [DEFAULTS setObject:userId forKey:@"userId"];
    [DEFAULTS synchronize];
    
    //设置当前的用户信息
    RCUserInfo *_currentUserInfo = [[RCUserInfo alloc]initWithUserId:userId name:userName portrait:nil];
    
    
    [RCIMClient sharedRCIMClient].currentUserInfo = _currentUserInfo;
    
    [HUD dismiss];
    
    [RCDHTTPTOOL getUserInfoByUserID:userId
                          completion:^(RCUserInfo* user) {
                              [[RCIM sharedRCIM]refreshUserInfoCache:user withUserId:userId];
                              [DEFAULTS setObject:user.portraitUri forKey:@"userPortraitUri"];
                              [DEFAULTS setObject:user.name forKey:@"userNickName"];
                              [DEFAULTS synchronize];
                          }];
    //同步群组
    [RCDDataSource syncGroups];
    [RCDDataSource syncFriendList:^(NSMutableArray *friends) {}];
    BOOL notFirstTimeLogin = [DEFAULTS boolForKey:@"notFirstTimeLogin"];
    if (!notFirstTimeLogin) {
        [RCDDataSource cacheAllData:^{ //auto saved after completion.
            //                                                   [DEFAULTS setBool:YES forKey:@"notFirstTimeLogin"];
            //                                                   [DEFAULTS synchronize];
        }];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        UINavigationController *rootNavi = [storyboard instantiateViewControllerWithIdentifier:@"rootNavi"];
//        [ShareApplicationDelegate window].rootViewController = rootNavi;
        [self dismissViewControllerAnimated:YES completion:nil];
        
    });
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
