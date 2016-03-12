//
//  UpdatePhoneViewController.m
//  CYS
//
//  Created by 谢阳晴 on 16/2/2.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import "UpdatePhoneViewController.h"


@interface UpdatePhoneViewController (){
    UITextField *code1tf;
    UITextField *code2tf;
    UIButton *nextbutton;
    NSInteger i;
    UIButton *sentcodebutton;
    NSTimer *timer;
}

@end

@implementation UpdatePhoneViewController
-(void)viewDidLoad{
    [super viewDidLoad];
   
    if (self.isnewPhone) {
       self.title=@"修改手机号";
    } else {
         self.title=@"验证旧手机号";
    }
    self.view.backgroundColor=KBackgroundColor;
    
    if (self.isEnterPhone) {
        code1tf=[[UITextField alloc]initWithFrame:CGRectMake(0, 84, ScreenWidth, 50)];
        code1tf.delegate=self;
        code1tf.placeholder=@"请输入手机号";
        code1tf.layer.masksToBounds = YES;
        code1tf.layer.cornerRadius = 0.0;
        code1tf.layer.borderWidth = 0.0;
        //code1tf.secureTextEntry=YES;
        code1tf.keyboardType=UIKeyboardTypeNumberPad;
        code1tf.font=[UIFont systemFontOfSize:15.0];
        code1tf.tintColor=KlightOrangeColor;
        KtfAddpaddingView(code1tf);
        code1tf.layer.borderColor = [kimiColor(232, 232, 233, 1) CGColor];
        [self.view addSubview:code1tf];
        //  [code1tf addSubview:[[UIManager shareInstance]getlineviewWithFrame:CGRectMake(0, 49, ScreenWidth, 1) withimage:nil withbgcolor:KLineColor]];
        
        code1tf.leftViewMode = UITextFieldViewModeAlways;
        code1tf.leftView.bounds=CGRectMake(0, 0, 84, 50);
        
        UILabel *label=[[UILabel alloc]init];
        label.font=[UIFont systemFontOfSize:18.0];
        label.frame=CGRectMake(0, 0, 84, 50);
        label.text=[NSString stringWithFormat:@"  %@",@"手机号   "];
        label.textColor=KBlackColor;
        label.textAlignment=NSTextAlignmentLeft;
        label.backgroundColor=[UIColor clearColor];
        [code1tf.leftView addSubview:label];
        code1tf.backgroundColor=[UIColor whiteColor];
        
        
        nextbutton=[UIButton buttonWithType:UIButtonTypeCustom];
        nextbutton.frame=CGRectMake(30, 230+80, ScreenWidth-60, 50);
        
        nextbutton.layer.masksToBounds = YES;
        nextbutton.layer.cornerRadius = 6.0;
        nextbutton.layer.borderWidth = 1.0;
        nextbutton.layer.borderColor = [KlightOrangeColor CGColor];
        [nextbutton setTitle:@"下一步" forState:UIControlStateNormal];
        //nextbutton.userInteractionEnabled=NO;
        nextbutton.titleLabel.font=[UIFont systemFontOfSize:22.0];
        [nextbutton addTarget:self action:@selector(nextaction) forControlEvents:UIControlEventTouchUpInside];
        nextbutton.backgroundColor=KlightOrangeColor;
        [self.view addSubview:nextbutton];
        
        
    } else {
        
        code1tf=[[UITextField alloc]initWithFrame:CGRectMake(0, 84, ScreenWidth, 50)];
        code1tf.delegate=self;
        //code1tf.text=self.phoneNum;
        code1tf.layer.masksToBounds = YES;
        code1tf.layer.cornerRadius = 0.0;
        code1tf.layer.borderWidth = 0.0;
        //code1tf.secureTextEntry=YES;
        code1tf.font=[UIFont systemFontOfSize:15.0];
        code1tf.tintColor=KlightOrangeColor;
        KtfAddpaddingView(code1tf);
        code1tf.layer.borderColor = [kimiColor(232, 232, 233, 1) CGColor];
        [self.view addSubview:code1tf];
        [code1tf addSubview:[[UIManager shareInstance]getlineviewWithFrame:CGRectMake(0, 49, ScreenWidth, 1) withimage:nil withbgcolor:KLineColor]];
        
        code1tf.leftViewMode = UITextFieldViewModeAlways;
        code1tf.leftView.bounds=CGRectMake(0, 0, 84, 50);
        
        UILabel *label=[[UILabel alloc]init];
        label.font=[UIFont systemFontOfSize:18.0];
        label.frame=CGRectMake(0, 0, 84, 50);
      
        
        
        if (self.isnewPhone) {
            label.text=[NSString stringWithFormat:@"  %@",@"手机号  "];
        } else {
            label.text=[NSString stringWithFormat:@"  %@",@"旧手机号  "];
            
        }
        label.textColor=KBlackColor;
        label.textAlignment=NSTextAlignmentLeft;
        label.backgroundColor=[UIColor clearColor];
        [code1tf.leftView addSubview:label];
        code1tf.backgroundColor=[UIColor whiteColor];
        
        
        
        
        
        
        
        
        
        
        
        
        code2tf=[[UITextField alloc]initWithFrame:CGRectMake(0, 134, ScreenWidth, 50)];
        code2tf.delegate=self;
        code2tf.placeholder=@"请输入验证码 ";
        code2tf.tintColor=KlightOrangeColor;
        code2tf.layer.masksToBounds = YES;
        code2tf.layer.cornerRadius = 0.0;
        code2tf.layer.borderWidth = 0.0;
        code2tf.font=[UIFont systemFontOfSize:15.0];
       // code2tf.secureTextEntry=YES;
        KtfAddpaddingView(code2tf);
        code2tf.layer.borderColor = [kimiColor(232, 232, 233, 1) CGColor];
        [self.view addSubview:code2tf];
        
        code2tf.leftViewMode = UITextFieldViewModeAlways;
        code2tf.leftView.bounds=CGRectMake(0, 0, 84, 50);
        
        UILabel *label1=[[UILabel alloc]init];
        label1.font=[UIFont systemFontOfSize:18.0];
        label1.frame=CGRectMake(0, 0, 84, 50);
        label1.text=[NSString stringWithFormat:@"  %@",@"验证码   "];
        label1.textColor=KBlackColor;
        label1.textAlignment=NSTextAlignmentLeft;
        label1.backgroundColor=[UIColor clearColor];
        [code2tf.leftView addSubview:label1];
        code2tf.backgroundColor=[UIColor whiteColor];
        
        
        
        
        sentcodebutton=[UIButton buttonWithType:UIButtonTypeCustom];
        sentcodebutton.frame=CGRectMake(ScreenWidth-(ScreenWidth-60)/3*1, 134+5, (ScreenWidth-60)/3*1-10, 40);
        
        sentcodebutton.layer.masksToBounds = YES;
        sentcodebutton.layer.cornerRadius = 4.0;
        sentcodebutton.layer.borderWidth = 0.0;
        sentcodebutton.layer.borderColor = [KlightOrangeColor CGColor];
        [sentcodebutton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [sentcodebutton addTarget:self action:@selector(getnewCode:) forControlEvents:UIControlEventTouchUpInside];
        sentcodebutton.backgroundColor=KlightOrangeColor;
        sentcodebutton.titleLabel.font=[UIFont systemFontOfSize:13.0];
        [self.view addSubview:sentcodebutton];

        
        
        
        
       
        
        
        
        
        //[code2tf addSubview:[[UIManager shareInstance]getlineviewWithFrame:CGRectMake(0, 59, ScreenWidth-30, 1) withimage:nil withbgcolor:KLineColor]];
      
        nextbutton=[UIButton buttonWithType:UIButtonTypeCustom];
        nextbutton.frame=CGRectMake(30, 230+80, ScreenWidth-60, 50);
        
        nextbutton.layer.masksToBounds = YES;
        nextbutton.layer.cornerRadius = 6.0;
        nextbutton.layer.borderWidth = 1.0;
        nextbutton.layer.borderColor = [KlightOrangeColor CGColor];
       
        if (self.isnewPhone) {
             [nextbutton setTitle:@"完成" forState:UIControlStateNormal];
        } else {
             [nextbutton setTitle:@"下一步" forState:UIControlStateNormal];
        }
        //nextbutton.userInteractionEnabled=NO;
        nextbutton.titleLabel.font=[UIFont systemFontOfSize:22.0];
        [nextbutton addTarget:self action:@selector(nextaction) forControlEvents:UIControlEventTouchUpInside];
        nextbutton.backgroundColor=KlightOrangeColor;
        [self.view addSubview:nextbutton];
        
    }
    
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden=NO;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden=YES;
}

-(void)nextaction{
    
    
    
    
    if (self.isEnterPhone) {
        
        
        
        
        
        
        
        if (![self myisPureInt:code1tf.text]||code1tf.text.length!=11) {
            UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:nil message:@"请输入11位数手机号" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertview show];
        } else {
            
            JGProgressHUD *hud=[[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleDark];
            [hud showInView:self.view];
            [hud dismissAfterDelay:7];
            [MsisdnDataService getCaptchaCodeWithMsisdn:code1tf.text type:2 block:^(id respdic) {
                [hud dismiss];
                UpdatePhoneViewController *vc=[[UpdatePhoneViewController alloc]init];
                vc.isEnterPhone=NO;
                vc.phoneNum=code1tf.text;
                [self.navigationController pushViewController:vc animated:YES];
            }];
            
           
            
            
            
            
        }
        
        
        
        
        
        
    } else {
        [code1tf resignFirstResponder];
        [code2tf resignFirstResponder];
       // if ([code1tf.text isEqualToString:code2tf.text]) {
            if (![self myisPureInt:code2tf.text]||code2tf.text.length!=4) {
                UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:nil message:@"请输入：4位数的验证码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertview show];
            } else {
                
                
                //            [MsisdnDataService dealForgotPasswordWithMsisdn:self.phonenum signature:self.signature password:code2tf.text type:1 block:^(id resultdic) {
                //
                //                [[PublicTools shareInstance]setmyPview:self.view];
                //                [[PublicTools shareInstance]creareNotificationUIView:@"重设密码成功请重新登录"];
                //                [self.navigationController popToRootViewControllerAnimated:YES];
                //            }];
                
                JGProgressHUD *hud=[[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleDark];
                [hud showInView:self.view];
                [hud dismissAfterDelay:7];

                [MsisdnDataService verfyCaptchaCodeWithMsisdn:code1tf.text captcha:code2tf.text block:^(id dic) {
                    
                    NSLog(@"%@",dic);
                    
                    if (self.isnewPhone) {
                        
                        
                        
                    [LoginDataService updatingusermsisdnWitholdmask:self.signatrmask newmask:[dic objectForKey:@"signature"] msisdn:code1tf.text block:^(id respdic) {
                         NSLog(@"%@",respdic);
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"updatephone" object:code1tf.text];
                        [hud dismiss];
                        
                        
                        
                        
                        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                        
                        [defaults setObject:code1tf.text forKey:@"phonenum"];
                        [defaults setObject:[respdic objectForKey:@"token"] forKey:@"token"];
                     
                        [defaults synchronize];
                        
                        
                        
                        
                        
                        [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
                        [[PublicTools shareInstance]creareNotificationUIView:@"修改成功"];
                        UIViewController *vc=[self.navigationController.viewControllers objectAtIndex:1];
                        [self.navigationController popToViewController:vc animated:YES];
                    }];
                        
                        
                      

                    } else {
                        [hud dismiss];
                        UpdatePhoneViewController *vc=[[UpdatePhoneViewController alloc]init];
                        vc.isnewPhone=YES;
                        vc.isGetCode=YES;
                        vc.signatrmask=[dic objectForKey:@"signature"];
                        vc.phoneNum=code1tf.text;
                        [self.navigationController pushViewController:vc animated:YES];

                       
                    }
                    
                    
                    
                   
                }];
                
                
            }
//        } else {
//            UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:nil message:@"两次输入密码不一致" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alertview show];
//        }
        
    }
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (self.isEnterPhone) {
        
    } else {
        if (textField == code1tf) {
            [code2tf becomeFirstResponder];
        }else{
            [textField resignFirstResponder];
            
        }
        
    }
    return YES;
}
- (BOOL)myisPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
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
       

        [MsisdnDataService getCaptchaCodeWithMsisdn:code1tf.text type:2 block:^(id dic) {
            NSLog(@"%@",dic);
            
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
            [timer invalidate];
            [sentcodebutton setTitle:[NSString stringWithFormat:@"获取验证码"] forState:UIControlStateNormal];
            //  timelabel.text=@"请点击重新获取验证码";
            sentcodebutton.userInteractionEnabled=YES;
            
        }
        
    }



@end
