//
//  SetPasswordViewController.m
//  CYS
//
//  Created by 谢阳晴 on 15/12/10.
//  Copyright © 2015年 谢阳晴. All rights reserved.
//

#import "SetPasswordViewController.h"
#import "PubilcViewController.h"



@interface SetPasswordViewController ()
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
    UIImageView *pwimgView;
    UIImageView *pwimgView1;

}
@end
@implementation SetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    pwimgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_code_1"]];
    pwimgView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_code_1"]];
    
    pwimgView.frame = CGRectMake(15, 0, 20, 25);
    pwimgView1.frame = CGRectMake(15, 0, 20, 25);

    self.view.backgroundColor=[UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    
    code1tf=[[UITextField alloc]initWithFrame:CGRectMake(30, 160, ScreenWidth-60, 60)];
    code1tf.delegate=self;
    code1tf.placeholder=@"设置登录密码:6-16位";
    code1tf.layer.masksToBounds = YES;
    code1tf.layer.cornerRadius = 6.0;
    code1tf.layer.borderWidth = 0.0;
    code1tf.secureTextEntry=YES;
    code1tf.tintColor=KlightOrangeColor;
    KtfAddpaddingView(code1tf);
    code1tf.layer.borderColor = [kimiColor(232, 232, 233, 1) CGColor];
    [self.view addSubview:code1tf];
    [code1tf addSubview:[[UIManager shareInstance]getlineviewWithFrame:CGRectMake(0, 59, ScreenWidth-30, 1) withimage:nil withbgcolor:KLineColor]];
    
    [code1tf.leftView addSubview:pwimgView];
    code1tf.leftViewMode = UITextFieldViewModeAlways;
    code1tf.leftView.bounds=CGRectMake(0, 0, 40, 25);
    
    code2tf=[[UITextField alloc]initWithFrame:CGRectMake(30, 230, ScreenWidth-60, 60)];
    code2tf.delegate=self;
    code2tf.placeholder=@"再输入一次密码";
    code2tf.tintColor=KlightOrangeColor;
    code2tf.layer.masksToBounds = YES;
    code2tf.layer.cornerRadius = 6.0;
    code2tf.layer.borderWidth = 0.0;
    code2tf.secureTextEntry=YES;
    KtfAddpaddingView(code2tf);
    code2tf.layer.borderColor = [kimiColor(232, 232, 233, 1) CGColor];
    [self.view addSubview:code2tf];
    [code2tf addSubview:[[UIManager shareInstance]getlineviewWithFrame:CGRectMake(0, 59, ScreenWidth-30, 1) withimage:nil withbgcolor:KLineColor]];
    [code2tf.leftView addSubview:pwimgView1];
    code2tf.leftViewMode = UITextFieldViewModeAlways;
    code2tf.leftView.bounds=CGRectMake(0, 0, 40, 25);
    
    nextbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    nextbutton.frame=CGRectMake(30, 230+80, ScreenWidth-60, 50);
    
    nextbutton.layer.masksToBounds = YES;
    nextbutton.layer.cornerRadius = 6.0;
    nextbutton.layer.borderWidth = 1.0;
    nextbutton.layer.borderColor = [KlightOrangeColor CGColor];
    [nextbutton setTitle:@"注册" forState:UIControlStateNormal];
    //nextbutton.userInteractionEnabled=NO;
    nextbutton.titleLabel.font=[UIFont systemFontOfSize:22.0];
    [nextbutton addTarget:self action:@selector(nextaction) forControlEvents:UIControlEventTouchUpInside];
    nextbutton.backgroundColor=KlightOrangeColor;
    [self.view addSubview:nextbutton];
    
    
    // Do any additional setup after loading the view.
    mybarview=[[NavBarView alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, 64)];
    mybarview.delegate=self;
    mybarview.navbarTitle=@"设置密码";
    [mybarview setnavcanclecolor:[UIColor orangeColor]];
    [mybarview setnavcancletitle:@" 返回"];
    [mybarview setnavcancletimage:@"back"];
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
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [code1tf resignFirstResponder];
    [code2tf resignFirstResponder];
    
}
-(void)nextaction{
    [code1tf resignFirstResponder];
    [code2tf resignFirstResponder];
    if ([code1tf.text isEqualToString:code2tf.text]) {
        if (code2tf.text.length<6||code2tf.text.length>16) {
            UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:nil message:@"输入密码的长度不对,请输入：6-16位数的密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertview show];
        } else {
            
            [MsisdnDataService dealForgotPasswordWithMsisdn:self.phonenum signature:self.signature password:code2tf.text type:0 block:^(id resultdic) {
                
                
                
                
                NSLog(@"%@",resultdic);
                [self performSelector:@selector(poptoViewRootVC) withObject:nil afterDelay:2.0];
                [[PublicTools shareInstance]setmyPview:self.view];
                [[PublicTools shareInstance]crearebigNotificationUIView:@"已注册成功"];

              
              
            }];
            
        }
    } else {
        UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:nil message:@"两次输入密码不一致" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertview show];
    }
    
}
-(void)poptoViewRootVC{
      [self.navigationController popToRootViewControllerAnimated:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == code1tf) {
        [code2tf becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
        
    }
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField==code1tf) {
        
        if (![textField.text isEqualToString:@""]) {
            pwimgView.image=[UIImage imageNamed:@"login_code_2"];
        }else{
            pwimgView.image=[UIImage imageNamed:@"login_code_1"];
        }
        
    }else{
        if (![textField.text isEqualToString:@""]) {
            pwimgView1.image=[UIImage imageNamed:@"login_code_2"];
        }else{
            pwimgView1.image=[UIImage imageNamed:@"login_code_1"];
        }
    }
   
}
@end
