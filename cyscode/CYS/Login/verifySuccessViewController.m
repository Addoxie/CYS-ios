//
//  verifySuccessViewController.m
//  ZDE
//
//  Created by 谢阳晴 on 15/5/19.
//  Copyright (c) 2015年 谢阳晴. All rights reserved.
//

#import "verifySuccessViewController.h"
#import "SuccessViewController.h"

@interface verifySuccessViewController (){
    UILabel *masklb;
    UILabel *phonenumlb;
    UILabel *masklb1;
    UIButton *getcodebutton;
    UIButton *verifybutton;
    UILabel *timelabel;
    NSInteger i;
    NSTimer *timer;
    
}


@end

@implementation verifySuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    masklb1=[[UILabel alloc]initWithFrame:CGRectMake(30, 100, ScreenWidth-60, 35)];
    masklb1.text=@"验证通过！请设置密码";
    masklb1.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:masklb1];
    
    self.usernametf=[[UITextField alloc]initWithFrame:CGRectMake(ScreenWidth/2-ScreenWidth/3, 180, ScreenWidth/3*2, 40)];
    self.usernametf.delegate=self;
    self.usernametf.placeholder=@" 输入6~16位的登录密码";
    self.usernametf.secureTextEntry=YES;
    self.usernametf.layer.borderWidth=1.0;
    self.usernametf.layer.borderColor=[UIColor blackColor].CGColor;
    [self.usernametf becomeFirstResponder];
    
    [self.view addSubview:self.usernametf];
    
    verifybutton=[UIButton buttonWithType:UIButtonTypeCustom];
    verifybutton.frame=CGRectMake(ScreenWidth/2-ScreenWidth/4/2, ScreenHeight/2-20,ScreenWidth/4,40);
    verifybutton.alpha=0.8;
    [verifybutton setTitle:@"验证手机" forState:UIControlStateNormal];
    verifybutton.titleLabel.font=[UIFont systemFontOfSize:16.0];
    [verifybutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    verifybutton.backgroundColor=[UIColor redColor];
    verifybutton.layer.masksToBounds = YES;
    verifybutton.layer.cornerRadius = 8.0;
    verifybutton.layer.borderWidth = 1.0;
    verifybutton.layer.borderColor = [[UIColor clearColor] CGColor];
    
    [verifybutton addTarget:self action:@selector(verifythecode) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:verifybutton];

    // Do any additional setup after loading the view.
}
-(void)verifythecode{
    
    
    if (self.usernametf.text.length>=6&&self.usernametf.text.length<=16) {
        SuccessViewController *successvc=[[SuccessViewController alloc]init];
        successvc.title=@"注册完成";
        [self.navigationController pushViewController:successvc animated:YES];
    }else{
        [[PublicTools shareInstance]setmyPview:self.view];
        [[PublicTools shareInstance]creareNotificationUIView:@"输入6~16位的登录密码"];
      
        
    }
}
- (BOOL)myisPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
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
