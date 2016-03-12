//
//  GroupRenameViewController.m
//  CYS
//
//  Created by 谢阳晴 on 16/2/1.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import "GroupRenameViewController.h"

//@implementation GroupRenameViewController




@interface GroupRenameViewController (){
    NavBarView *mybarview;
}

@end


@implementation GroupRenameViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor=KBackgroundColor;
    
    self.title=@"修改标签";
    codetf1=[[UITextField alloc]initWithFrame:CGRectMake(0, 70, ScreenWidth, 45)];
    codetf1.delegate=self;
    codetf1.textColor=KBlackColor;
    codetf1.text=self.tagstr;
    codetf1.layer.cornerRadius=5.0;
    codetf1.backgroundColor=[UIColor whiteColor];
    codetf1.clearButtonMode=UITextFieldViewModeAlways;
    codetf1.returnKeyType=UIReturnKeyDone;
    codetf1.tintColor=KlightOrangeColor;
    [self.view addSubview:codetf1];
    
    
    
    
    
    
    mybarview=[[NavBarView alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, 64)];
    mybarview.delegate=self;
    mybarview.navbarTitle=@"修改团队名字";
    [mybarview setnavcanclecolor:[UIColor whiteColor]];
    [mybarview setnavcancletitle:@" 返回"];
    [mybarview setnavcancletimage:@"back"];
    mybarview.backgroundColor=KlightOrangeColor;
    [self.view addSubview:mybarview];
    UIView *bgv=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    bgv.backgroundColor=KlightOrangeColor;
    [self.view addSubview:bgv];
    
    
    
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
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if ([textField.text isEqualToString:@""]) {
        
        [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
        [[PublicTools shareInstance]creareNotificationUIView:@"输入为空"];
        
    }else{
        
        
//        if (![self myisPureInt:codetf1.text]||codetf1.text.length!=11) {
//            [[PublicTools shareInstance]setmyPview:self.view];
//            [[PublicTools shareInstance]creareNotificationUIView:@"请输入手机号"];
//        }else{
        JGProgressHUD *hud=[[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleDark];
        [hud showInView:self.view];
        [hud dismissAfterDelay:5];

          [DocTeamDataService UpdateGroupNameWithteamId:[self.datadic objectForKey:@"id"] name:codetf1.text block:^(id respdic) {
              [hud dismiss];
              
              
              [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
              [[PublicTools shareInstance]creareNotificationUIView:@"修改成功"];

              NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:codetf1.text,@"name", nil];
              
              [self.delegate addwithdic:dic];
              
              [self.navigationController popViewControllerAnimated:YES];

          }];
        
        
        
        
        
                      //
            //        NSString *urlstring=[NSString stringWithFormat:@"public/msisdn/verify?msisdn=%@",code1tf.text];
            //        [[PublicTools shareInstance]GetNetWorkDataWithURLStr:urlstring theReturnBlock:^(id obj) {
            //            if (obj!=nil) {
            
            //        [MsisdnDataService getCaptchaCodeWithMsisdn:code1tf.text type:1 block:^(id dic) {
            //            [[PublicTools shareInstance]setmyPview:self.view];
            //            [[PublicTools shareInstance]creareNotificationUIView:@"验证码已发送"];
            //
            //
            //        }];
            //
            
            //            [[PublicTools shareInstance]setmyPview:self.view];
            //            [[PublicTools shareInstance]creareNotificationUIView:@"已发送"];
            
      //  }
        
        
        //
        //        if (self.isadd) {
        //            // NSDictionary *dic=[[NSDictionary alloc]initWithObjectsAndKeys:textField.text,@"tag", nil];
        //
        //            [PatientDataService addTagWithTagstr:textField.text block:^(id respdic) {
        //                NSDictionary *dic=(NSDictionary *)respdic;
        //                [self.delegate addwithdic:dic];
        //                [self.navigationController popViewControllerAnimated:YES];
        //            }];
        //
        //        } else {
        //            [PatientDataService updateTagWithTagid:self.tagid tagStr:textField.text block:^(id respdic) {
        //                [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
        //                [[PublicTools shareInstance]creareNotificationUIView:@"修改成功"];
        //                [self.delegate reloadrenametags];
        //                [self.navigationController popViewControllerAnimated:YES];
        //
        //            }];
        //
        //        }
    }
    return YES;
}
- (BOOL)myisPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}
@end
