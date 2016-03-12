//
//  SearchNameViewController.m
//  CYS
//
//  Created by 谢阳晴 on 15/12/23.
//  Copyright © 2015年 谢阳晴. All rights reserved.
//

#import "SearchNameViewController.h"
#import "ContactManagerViewController.h"
#import "ContactPatientViewController.h"

@interface SearchNameViewController (){
    
    JGProgressHUD *HUD;
    NavBarView *mybarview;
}
@end


@implementation SearchNameViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=KBackgroundColor;
    _codetf1=[self getTextFieldWithFrame:CGRectMake(0, 70, ScreenWidth, 45) theneedSecure:NO];
    _codetf1.delegate=self;
    _codetf1.placeholder=@"输入姓名添加患者";
    _codetf1.textColor=KBlackColor;
    _codetf1.backgroundColor=[UIColor whiteColor];
    _codetf1.text=self.oldname;
    _codetf1.clearButtonMode=UITextFieldViewModeAlways;
    _codetf1.returnKeyType=UIReturnKeyDone;
    
    KtfAddpaddingView(_codetf1);
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:)
                                                name:UITextFieldTextDidChangeNotification
                                              object:_codetf1];
    
    [self.view addSubview:_codetf1];
    
   
       
    mybarview=[[NavBarView alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, 64)];
    mybarview.delegate=self;
    mybarview.navbarTitle=@"添加患者";
    [mybarview setnavcanclecolor:[UIColor whiteColor]];
    [mybarview setnavcancletitle:@" 返回"];
    [mybarview setnavcancletimage:@"back"];
    
    mybarview.backgroundColor=KlightOrangeColor;
    [self.view addSubview:mybarview];
    UIView *bgv=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    bgv.backgroundColor=KlightOrangeColor;
    [self.view addSubview:bgv];
    
    
     // [_codetf1 becomeFirstResponder];
    
    
}
-(void)addBody{
    [_codetf1 resignFirstResponder];
    
    NSString *toBeString = _codetf1.text;
    if ([self stringContainsEmoji:toBeString]) {
        [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
        [[PublicTools shareInstance]creareNotificationUIView:@"不允许输入特殊符号"];
        _codetf1.text=@"";
        [_codetf1 resignFirstResponder];
    } else {
        _codetf1.text=toBeString;
        if ([_codetf1.text isEqualToString:@""]) {
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"名字不能为空"];
        } else {
            
            
        }
        
    }
    
}
-(UITextField *)getTextFieldWithFrame:(CGRect)myframe theneedSecure:(BOOL)needsecure{
    UITextField *textf=[[UITextField alloc]initWithFrame:myframe];
    textf.layer.masksToBounds = YES;
    textf.layer.cornerRadius = 0.0;
    textf.layer.borderWidth = 1.0;
    textf.layer.borderColor = [[UIColor clearColor] CGColor];
    if (needsecure) {
        textf.secureTextEntry=YES;
    }
    return textf;
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [textField resignFirstResponder];
    ContactPatientViewController *editnamevc=[[ContactPatientViewController alloc]init];
    //editnamevc.isrootvc=NO;
    editnamevc.isaddpatient=YES;
    editnamevc.isneedadd=YES;
    editnamevc.isnotneedmoreaction=YES;
    editnamevc.needsave=YES;
    editnamevc.isnewteam=self.isnewteam;
    editnamevc.docteamid=self.docteamid;
    editnamevc.needsearchbar=YES;
   
    [self.navigationController pushViewController:editnamevc animated:YES];

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        HUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleLight];
        HUD.textLabel.text = @"";
        [HUD showInView:self.view];
        [HUD dismissAfterDelay:10.0];
        
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}
-(void)textFiledEditChanged:(NSNotification *)obj{
    //    UITextField *textField = (UITextField *)obj.object;
    //
    //    NSString *toBeString = textField.text;
    //    if ([self stringContainsEmoji:toBeString]) {
    //        [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
    //        [[PublicTools shareInstance]creareNotificationUIView:@"不允许输入特殊符号"];
    //        textField.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"nick-name"];
    //        [textField resignFirstResponder];
    //    } else {
    //        textField.text=toBeString;
    //    }
    
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:UITextFieldTextDidChangeNotification
                                                 object:_codetf1];
    
}
-(BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}

-(void)itemactionWithType:(NSInteger)typeindex{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[pimagev sd_setImageWithURL:[NSURL URLWithString:[self.alldic objectForKey:@"icon-url"]] placeholderImage:nil];
    self.navigationController.navigationBar.hidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
     self.navigationController.navigationBar.hidden=NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
