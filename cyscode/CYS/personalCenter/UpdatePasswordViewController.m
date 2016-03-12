//
//  UpdatePasswordViewController.m
//  CYS
//
//  Created by 谢阳晴 on 16/2/2.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import "UpdatePasswordViewController.h"


@interface UpdatePasswordViewController (){
    UITextField *code1tf;
    UITextField *code2tf;
    UITextField *codetf;
     UIButton *nextbutton;
}

@end

@implementation UpdatePasswordViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.title=@"修改密码";
    self.view.backgroundColor=KBackgroundColor;
    
    if (self.isEnterOldPW) {
        codetf=[[UITextField alloc]initWithFrame:CGRectMake(0, 84, ScreenWidth, 50)];
        codetf.delegate=self;
        codetf.placeholder=@"请输入旧密码";
        codetf.layer.masksToBounds = YES;
        codetf.layer.cornerRadius = 0.0;
        codetf.layer.borderWidth = 0.0;
        codetf.secureTextEntry=YES;
        codetf.font=[UIFont systemFontOfSize:15.0];
        codetf.tintColor=KlightOrangeColor;
        KtfAddpaddingView(codetf);
        codetf.layer.borderColor = [kimiColor(232, 232, 233, 1) CGColor];
        [self.view addSubview:codetf];
      //  [codetf addSubview:[[UIManager shareInstance]getlineviewWithFrame:CGRectMake(0, 49, ScreenWidth, 1) withimage:nil withbgcolor:KLightLineColor]];
        
        codetf.leftViewMode = UITextFieldViewModeAlways;
        codetf.leftView.bounds=CGRectMake(0, 0, 104, 50);
        
        UILabel *label=[[UILabel alloc]init];
        label.font=[UIFont systemFontOfSize:18.0];
        label.frame=CGRectMake(0, 0, 104, 50);
        label.text=[NSString stringWithFormat:@"  %@",@"旧密码   "];
        label.textColor=KBlackColor;
        label.textAlignment=NSTextAlignmentLeft;
        label.backgroundColor=[UIColor clearColor];
        [codetf.leftView addSubview:label];
        codetf.backgroundColor=[UIColor whiteColor];
        
        
//        nextbutton=[UIButton buttonWithType:UIButtonTypeCustom];
//        nextbutton.frame=CGRectMake(30, 230+80, ScreenWidth-60, 50);
//        
//        nextbutton.layer.masksToBounds = YES;
//        nextbutton.layer.cornerRadius = 6.0;
//        nextbutton.layer.borderWidth = 1.0;
//        nextbutton.layer.borderColor = [KlightOrangeColor CGColor];
//        [nextbutton setTitle:@"下一步" forState:UIControlStateNormal];
//        //nextbutton.userInteractionEnabled=NO;
//        nextbutton.titleLabel.font=[UIFont systemFontOfSize:22.0];
//        [nextbutton addTarget:self action:@selector(nextaction) forControlEvents:UIControlEventTouchUpInside];
//        nextbutton.backgroundColor=KlightOrangeColor;
//        [self.view addSubview:nextbutton];
        
        
        code1tf=[[UITextField alloc]initWithFrame:CGRectMake(0, 84+70, ScreenWidth, 50)];
        code1tf.delegate=self;
        code1tf.placeholder=@"设置新登录密码:6-16位";
        code1tf.layer.masksToBounds = YES;
        code1tf.layer.cornerRadius = 0.0;
        code1tf.layer.borderWidth = 0.0;
        code1tf.secureTextEntry=YES;
        code1tf.font=[UIFont systemFontOfSize:15.0];
        code1tf.tintColor=KlightOrangeColor;
        KtfAddpaddingView(code1tf);
        code1tf.layer.borderColor = [kimiColor(232, 232, 233, 1) CGColor];
        [self.view addSubview:code1tf];
        [code1tf addSubview:[[UIManager shareInstance]getlineviewWithFrame:CGRectMake(0, 49, ScreenWidth, 1) withimage:nil withbgcolor:KLightLineColor]];
        
        code1tf.leftViewMode = UITextFieldViewModeAlways;
        code1tf.leftView.bounds=CGRectMake(0, 0, 104, 50);
        
        UILabel *label1=[[UILabel alloc]init];
        label1.font=[UIFont systemFontOfSize:18.0];
        label1.frame=CGRectMake(0, 0, 104, 50);
        label1.text=[NSString stringWithFormat:@"  %@",@"新密码   "];
        label1.textColor=KBlackColor;
        label1.textAlignment=NSTextAlignmentLeft;
        label1.backgroundColor=[UIColor clearColor];
        [code1tf.leftView addSubview:label1];
        code1tf.backgroundColor=[UIColor whiteColor];
        
        
        
        code2tf=[[UITextField alloc]initWithFrame:CGRectMake(0, 134+70, ScreenWidth, 50)];
        code2tf.delegate=self;
        code2tf.placeholder=@"再输入一次新密码";
        code2tf.tintColor=KlightOrangeColor;
        code2tf.layer.masksToBounds = YES;
        code2tf.layer.cornerRadius = 0.0;
        code2tf.layer.borderWidth = 0.0;
        code2tf.font=[UIFont systemFontOfSize:15.0];
        code2tf.secureTextEntry=YES;
        KtfAddpaddingView(code2tf);
        code2tf.layer.borderColor = [kimiColor(232, 232, 233, 1) CGColor];
        [self.view addSubview:code2tf];
        
        code2tf.leftViewMode = UITextFieldViewModeAlways;
        code2tf.leftView.bounds=CGRectMake(0, 0, 104, 50);
        
        UILabel *label2=[[UILabel alloc]init];
        label2.font=[UIFont systemFontOfSize:18.0];
        label2.frame=CGRectMake(0, 0, 104, 50);
        label2.text=[NSString stringWithFormat:@"  %@",@"确认密码   "];
        label2.textColor=KBlackColor;
        label2.textAlignment=NSTextAlignmentLeft;
        label2.backgroundColor=[UIColor clearColor];
        [code2tf.leftView addSubview:label2];
        code2tf.backgroundColor=[UIColor whiteColor];
        
        
        
        
        //[code2tf addSubview:[[UIManager shareInstance]getlineviewWithFrame:CGRectMake(0, 59, ScreenWidth-30, 1) withimage:nil withbgcolor:KLineColor]];
        
        nextbutton=[UIButton buttonWithType:UIButtonTypeCustom];
        nextbutton.frame=CGRectMake(30, 230+80+70, ScreenWidth-60, 50);
        
        nextbutton.layer.masksToBounds = YES;
        nextbutton.layer.cornerRadius = 6.0;
        nextbutton.layer.borderWidth = 1.0;
        nextbutton.layer.borderColor = [KlightOrangeColor CGColor];
        [nextbutton setTitle:@"修改密码" forState:UIControlStateNormal];
        //nextbutton.userInteractionEnabled=NO;
        nextbutton.titleLabel.font=[UIFont systemFontOfSize:22.0];
        [nextbutton addTarget:self action:@selector(nextaction) forControlEvents:UIControlEventTouchUpInside];
        nextbutton.backgroundColor=KlightOrangeColor;
        [self.view addSubview:nextbutton];
        

        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    } else {
        
        code1tf=[[UITextField alloc]initWithFrame:CGRectMake(0, 84, ScreenWidth, 50)];
        code1tf.delegate=self;
        code1tf.placeholder=@"设置新登录密码:6-16位";
        code1tf.layer.masksToBounds = YES;
        code1tf.layer.cornerRadius = 0.0;
        code1tf.layer.borderWidth = 0.0;
        code1tf.secureTextEntry=YES;
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
        label.text=[NSString stringWithFormat:@"  %@",@"新密码   "];
        label.textColor=KBlackColor;
        label.textAlignment=NSTextAlignmentLeft;
        label.backgroundColor=[UIColor clearColor];
        [code1tf.leftView addSubview:label];
        code1tf.backgroundColor=[UIColor whiteColor];
        
        
        
        
        
        
        
        
        
        
        
        
        code2tf=[[UITextField alloc]initWithFrame:CGRectMake(0, 134, ScreenWidth, 50)];
        code2tf.delegate=self;
        code2tf.placeholder=@"再输入一次新密码";
        code2tf.tintColor=KlightOrangeColor;
        code2tf.layer.masksToBounds = YES;
        code2tf.layer.cornerRadius = 0.0;
        code2tf.layer.borderWidth = 0.0;
        code2tf.font=[UIFont systemFontOfSize:15.0];
        code2tf.secureTextEntry=YES;
        KtfAddpaddingView(code2tf);
        code2tf.layer.borderColor = [kimiColor(232, 232, 233, 1) CGColor];
        [self.view addSubview:code2tf];
        
        code2tf.leftViewMode = UITextFieldViewModeAlways;
        code2tf.leftView.bounds=CGRectMake(0, 0, 104, 50);
        
        UILabel *label1=[[UILabel alloc]init];
        label1.font=[UIFont systemFontOfSize:18.0];
        label1.frame=CGRectMake(0, 0, 104, 50);
        label1.text=[NSString stringWithFormat:@"  %@",@"确认密码   "];
        label1.textColor=KBlackColor;
        label1.textAlignment=NSTextAlignmentLeft;
        label1.backgroundColor=[UIColor clearColor];
        [code2tf.leftView addSubview:label1];
        code2tf.backgroundColor=[UIColor whiteColor];

        
        
        
        //[code2tf addSubview:[[UIManager shareInstance]getlineviewWithFrame:CGRectMake(0, 59, ScreenWidth-30, 1) withimage:nil withbgcolor:KLineColor]];
        
        nextbutton=[UIButton buttonWithType:UIButtonTypeCustom];
        nextbutton.frame=CGRectMake(30, 230+80, ScreenWidth-60, 50);
        
        nextbutton.layer.masksToBounds = YES;
        nextbutton.layer.cornerRadius = 6.0;
        nextbutton.layer.borderWidth = 1.0;
        nextbutton.layer.borderColor = [KlightOrangeColor CGColor];
        [nextbutton setTitle:@"完成" forState:UIControlStateNormal];
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
    
    
    
    
    if (self.isEnterOldPW) {
        
        
        
        
        
        
        
        if (codetf.text.length<6||codetf.text.length>16) {
            UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:nil message:@"请输入：6-16位数的密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertview show];
        } else {
            
            [code1tf resignFirstResponder];
            [code2tf resignFirstResponder];
            if ([code1tf.text isEqualToString:code2tf.text]) {
                if (code2tf.text.length<6||code2tf.text.length>16) {
                    UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:nil message:@"输入密码的长度不对,请输入：6-16位数的密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
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
                    [hud dismissAfterDelay:2];
                    [LoginDataService updatinguserpasswordWitholdpw:codetf.text newpw:code2tf.text block:^(id rspcdic) {
                        NSLog(@"%@",rspcdic);
                        [hud dismiss];
//                        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//                        [defaults setObject:[rspcdic objectForKey:@"token"] forKey:@"token"];
//                        
//                        [defaults synchronize];

                        [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
                        
                        [[PublicTools shareInstance]crearebigNotificationUIView:@"修改成功,请重新登录"];
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"relogin" object:nil];
                        
                        UIViewController *vc=[self.navigationController.viewControllers objectAtIndex:1];
                        [self.navigationController popToViewController:vc animated:YES];
                        
                    }];
                    
                    
                }
            } else {
                UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:nil message:@"两次输入的新密码不一致" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertview show];
            }

            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            //            [MsisdnDataService dealForgotPasswordWithMsisdn:self.phonenum signature:self.signature password:code2tf.text type:1 block:^(id resultdic) {
            //
            //                [[PublicTools shareInstance]setmyPview:self.view];
            //                [[PublicTools shareInstance]creareNotificationUIView:@"重设密码成功请重新登录"];
            //                [self.navigationController popToRootViewControllerAnimated:YES];
            //            }];
            
            
            
            
            
            
            
            
            
//
//            UpdatePasswordViewController *vc=[[UpdatePasswordViewController alloc]init];
//            vc.isEnterOldPW=NO;
//            vc.oldPW=code1tf.text;
//            [self.navigationController pushViewController:vc animated:YES];
            
            
            
            
            
            

            
        }
        
        
        
        
        
        
    } else {
        [code1tf resignFirstResponder];
        [code2tf resignFirstResponder];
        if ([code1tf.text isEqualToString:code2tf.text]) {
            if (code2tf.text.length<6||code2tf.text.length>16) {
                UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:nil message:@"输入密码的长度不对,请输入：6-16位数的密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
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
                [hud dismissAfterDelay:3];
                [LoginDataService updatinguserpasswordWitholdpw:self.oldPW newpw:code2tf.text block:^(id rspcdic) {
                [hud dismiss];
                    [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
                    [[PublicTools shareInstance]creareNotificationUIView:@"修改成功"];
                    
                    NSLog(@"%@",rspcdic);
                    NSDictionary *dic=(NSDictionary *)rspcdic;
                     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    [defaults setObject:[dic objectForKey:@"token"] forKey:@"token"];
                
                    [defaults synchronize];
                    UIViewController *vc=[self.navigationController.viewControllers objectAtIndex:1];
                    [self.navigationController popToViewController:vc animated:YES];

                }];
                
                
            }
        } else {
            UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:nil message:@"两次输入密码不一致" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertview show];
        }

    }
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (self.isEnterOldPW) {
        
    } else {
        if (textField == code1tf) {
            [code2tf becomeFirstResponder];
        }else{
            [textField resignFirstResponder];
            
        }

    }
      return YES;
}


@end
