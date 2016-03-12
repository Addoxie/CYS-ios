//
//  ForPWViewController.m
//  ZDE
//
//  Created by NX on 15/6/15.
//  Copyright (c) 2015年 谢阳晴. All rights reserved.
//

#import "ForPWViewController.h"
#import "ResetPWViewController.h"

@interface ForPWViewController (){
    
    NavBarView *mybarview;
    UIImageView *phoneimageview;
    UIImageView *newpwimageview;
    UIImageView *successimageview;
    UIImageView *bigsuccessimagev;
    UIView *lineview1;
    UIView *lineview2;
    
    UITextField *code1tf;
    UITextField *code2tf;
   
    UIButton *nextbutton;
    UIButton *sentcodebutton;
    NSInteger i;
    NSTimer *timer;
    UIImageView *pwimgView;
    UIImageView *pwimgView1;
}

@end

@implementation ForPWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    pwimgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_phone_1"]];
    pwimgView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_qrcode_1"]];
    
    pwimgView.frame = CGRectMake(15, 0, 20, 25);
    pwimgView1.frame = CGRectMake(15, 0, 20, 25);
    
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    code1tf=[[UITextField alloc]initWithFrame:CGRectMake(30, 160, ScreenWidth-60, 60)];
    code1tf.delegate=self;
    code1tf.placeholder=@"手机号码";
    code1tf.layer.masksToBounds = YES;
    code1tf.layer.cornerRadius = 6.0;
    code1tf.layer.borderWidth = 0.0;
   
    code1tf.keyboardType=UIKeyboardTypeNumberPad;
    code1tf.tintColor=KlightOrangeColor;
     KtfAddpaddingView(code1tf);
    code1tf.layer.borderColor = [kimiColor(232, 232, 233, 1) CGColor];
    [self.view addSubview:code1tf];
    
     [code1tf addSubview:[[UIManager shareInstance]getlineviewWithFrame:CGRectMake(0, 59, ScreenWidth-30, 1) withimage:nil withbgcolor:KLineColor]];
    
    [code1tf.leftView addSubview:pwimgView];
    code1tf.leftViewMode = UITextFieldViewModeAlways;
    code1tf.leftView.bounds=CGRectMake(0, 0, 40, 25);
    
    
    
    
    
    code2tf=[[UITextField alloc]initWithFrame:CGRectMake(30, 230, (ScreenWidth-60)/3*2, 60)];
    code2tf.delegate=self;
    code2tf.tintColor=KlightOrangeColor;
    code2tf.placeholder=@"验证码";
    code2tf.layer.masksToBounds = YES;
    code2tf.layer.cornerRadius = 6.0;
    code2tf.layer.borderWidth = 0.0;
        code2tf.keyboardType=UIKeyboardTypeNumberPad;
     KtfAddpaddingView(code2tf);
    code2tf.layer.borderColor = [kimiColor(232, 232, 233, 1) CGColor];
    [self.view addSubview:code2tf];
    
    [code2tf addSubview:[[UIManager shareInstance]getlineviewWithFrame:CGRectMake(0, 59, ScreenWidth-30, 1) withimage:nil withbgcolor:KLineColor]];
    [code2tf.leftView addSubview:pwimgView1];
    code2tf.leftViewMode = UITextFieldViewModeAlways;
    code2tf.leftView.bounds=CGRectMake(0, 0, 40, 25);

    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textViewEditChanged:)
                                                name:@"UITextFieldTextDidChangeNotification"
                                              object:code2tf];
    
    sentcodebutton=[UIButton buttonWithType:UIButtonTypeCustom];
    sentcodebutton.frame=CGRectMake((ScreenWidth-60)/3*2+30+10, 230, (ScreenWidth-60)/3*1-10, 50);
    
    sentcodebutton.layer.masksToBounds = YES;
    sentcodebutton.layer.cornerRadius = 4.0;
    sentcodebutton.layer.borderWidth = 0.0;
    sentcodebutton.layer.borderColor = [KlightOrangeColor CGColor];
    [sentcodebutton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [sentcodebutton addTarget:self action:@selector(getnewCode:) forControlEvents:UIControlEventTouchUpInside];
    sentcodebutton.backgroundColor=KlightOrangeColor;
    sentcodebutton.titleLabel.font=[UIFont systemFontOfSize:13.0];
    [self.view addSubview:sentcodebutton];
    
    nextbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    nextbutton.frame=CGRectMake(30, 260+50, ScreenWidth-60, 50);
    
    nextbutton.layer.masksToBounds = YES;
    nextbutton.layer.cornerRadius = 6.0;
    nextbutton.layer.borderWidth = 0.0;
    nextbutton.layer.borderColor = [KlightOrangeColor CGColor];
    [nextbutton setTitle:@"提交" forState:UIControlStateNormal];
     nextbutton.userInteractionEnabled=NO;
    nextbutton.titleLabel.font=[UIFont systemFontOfSize:22.0];
    [nextbutton addTarget:self action:@selector(nextaction) forControlEvents:UIControlEventTouchUpInside];
    nextbutton.backgroundColor=[UIColor grayColor];
    [self.view addSubview:nextbutton];



    // Do any additional setup after loading the view.
    mybarview=[[NavBarView alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, 64)];
    mybarview.delegate=self;
    mybarview.navbarTitle=@"忘记密码";
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
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [code1tf resignFirstResponder];
    [code2tf resignFirstResponder];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField==code1tf) {
        if (![self myisPureInt:code1tf.text]||code1tf.text.length!=11) {
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

- (void)textViewEditChanged:(NSNotification *)sender{
    if (code2tf.text.length>=4) {
        nextbutton.userInteractionEnabled=YES;
        nextbutton.layer.borderColor = [KGreenColor CGColor];
        nextbutton.backgroundColor=KlightOrangeColor;
    }else{
        nextbutton.userInteractionEnabled=NO;
        nextbutton.backgroundColor=[UIColor grayColor];
        nextbutton.layer.borderColor = [[UIColor grayColor] CGColor];
   
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getcaptchaaction{
}
-(void)nextaction{
    [code1tf resignFirstResponder];
    [code2tf resignFirstResponder];
   [MsisdnDataService verfyCaptchaCodeWithMsisdn:code1tf.text captcha:code2tf.text block:^(id dic) {
       NSLog(@"%@",dic);
       ResetPWViewController *resetpwvc=[[ResetPWViewController alloc]init];
       resetpwvc.phonenum=code1tf.text;
       resetpwvc.signature=[dic objectForKey:@"signature"];
       [self.navigationController pushViewController:resetpwvc animated:YES];
   }];
    
}
-(void)getnewCode:(UIButton *)button{
    
    
    [code1tf resignFirstResponder];
    [code2tf resignFirstResponder];
    if (![self myisPureInt:code1tf.text]||code1tf.text.length!=11) {
        [[PublicTools shareInstance]setmyPview:self.view];
        [[PublicTools shareInstance]creareNotificationUIView:@"请输入手机号"];
    }else{
//        
//        NSString *urlstring=[NSString stringWithFormat:@"public/msisdn/verify?msisdn=%@",code1tf.text];
//        [[PublicTools shareInstance]GetNetWorkDataWithURLStr:urlstring theReturnBlock:^(id obj) {
//            if (obj!=nil) {
        
        [MsisdnDataService getCaptchaCodeWithMsisdn:code1tf.text type:1 block:^(id dic) {
            [[PublicTools shareInstance]setmyPview:self.view];
            [[PublicTools shareInstance]creareNotificationUIView:@"验证码已发送"];

            
        }];
        
        
        
        
        
                i=60;
                [sentcodebutton setTitle:[NSString stringWithFormat:@"请等待%zd秒",60] forState:UIControlStateNormal];
                timer=[NSTimer timerWithTimeInterval:1 target:self selector:@selector(timeraction:) userInfo:nil repeats:YES];
                
                [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
                sentcodebutton.userInteractionEnabled=NO;
                i=60;
                sentcodebutton.backgroundColor=[UIColor grayColor];
                sentcodebutton.layer.borderColor=[UIColor grayColor].CGColor;
                //                        NSLog(@"%@",obj);
                //  NSDictionary *dic=(NSDictionary *)obj;
                //                        verifyViewController *verifyvc=[[verifyViewController alloc]init];
                //                        verifyvc.title=NSLocalizedString(@"Register", nil);
                //                        verifyvc.phonenum=self.usernametf.text;
                //                        [self.navigationController pushViewController:verifyvc animated:YES];
//            } else {
//                [[PublicTools shareInstance]setmyPview:self.view];
//                [[PublicTools shareInstance]creareNotificationUIView:@"数据错误"];
//            }
//        }];
    }
    

   
    // Do any additional setup after loading the view.
    
    
}
-(void)timeraction:(NSTimer *)timer{
    
    if (i>0) {
        i--;
        
        sentcodebutton.userInteractionEnabled=NO;
        //timelabel.text=[NSString stringWithFormat:@"%zd秒后 可重新获取验证码",i];
        [sentcodebutton setTitle:[NSString stringWithFormat:@"请等待%zd秒",i] forState:UIControlStateNormal];
    }else{
        sentcodebutton.backgroundColor=KlightOrangeColor;
        sentcodebutton.layer.borderColor=KlightOrangeColor.CGColor;
        [sentcodebutton setTitle:[NSString stringWithFormat:@"获取验证码"] forState:UIControlStateNormal];
      //  timelabel.text=@"请点击重新获取验证码";
        [timer invalidate];
        sentcodebutton.userInteractionEnabled=YES;
        
    }
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)myisPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
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
