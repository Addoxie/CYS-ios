//
//  EnterPriceViewController.m
//  CYS
//
//  Created by 谢阳晴 on 16/1/30.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import "EnterPriceViewController.h"
#import "itemdetailbutton.h"



@interface EnterPriceViewController (){
    
    JGProgressHUD *HUD;
    NavBarView *mybarview;
}
@end


@implementation EnterPriceViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
 //   [self.navigationController.navigationBar setTranslucent:NO];
    UILabel *desclabel=[[UILabel alloc]init];
       desclabel.text=[NSString stringWithFormat:@"%@%zd",@"请根据您的情况\n如：您的职称、预期患者支付等\n设置收费定价这是最多不能超过¥",self.maxPrice];
    desclabel.frame=CGRectMake(10, 74, ScreenWidth-20, 0);
    
    desclabel.textAlignment=NSTextAlignmentLeft;
    desclabel.textColor=kimiColor(153, 153, 153, 1);
    desclabel.font=[UIFont systemFontOfSize:16.0];
    desclabel.backgroundColor=[UIColor clearColor];
    desclabel.numberOfLines=0;
    

    [desclabel setLineBreakMode: UILineBreakModeCharacterWrap];
    
    [desclabel sizeToFit];
    
    [self.view addSubview:desclabel];
    
    if (self.ismonth) {
        self.title=@"包月咨询收费设置";
    } else {
        if (self.isIM) {
            self.title=@"图文咨询收费设置";
        }else{
            self.title=@"电话咨询收费设置";
        }
    }
    
    
    
    
    // Do any additional setup after loading the view.
      self.view.backgroundColor=kimiColor(239, 239, 244, 1);
    _codetf1=[self getTextFieldWithFrame:CGRectMake(0, 140, ScreenWidth, 45) theneedSecure:NO];
    _codetf1.delegate=self;
    _codetf1.textColor=KBlackColor;
    _codetf1.backgroundColor=[UIColor whiteColor];
    _codetf1.text=self.oldname;
    _codetf1.keyboardType=UIKeyboardTypeNumberPad;
    _codetf1.clearButtonMode=UITextFieldViewModeAlways;
    _codetf1.returnKeyType=UIReturnKeyDone;
    
    KtfAddpaddingView(_codetf1);
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:)
                                                name:UITextFieldTextDidChangeNotification
                                              object:_codetf1];
    
    [self.view addSubview:_codetf1];
    
    
    
    mybarview=[[NavBarView alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, 64)];
    mybarview.delegate=self;
    mybarview.navbarTitle=@"设置价格";
    [mybarview setnavcanclecolor:[UIColor whiteColor]];
    [mybarview setnavcancletitle:@" 返回"];
    [mybarview setnavcancletimage:@"back"];
    
    mybarview.backgroundColor=KlightOrangeColor;
    [self.view addSubview:mybarview];
    UIView *bgv=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    bgv.backgroundColor=KlightOrangeColor;
    [self.view addSubview:bgv];
    
    UIButton *morebutton=[UIButton buttonWithType:UIButtonTypeCustom];
    morebutton.frame=CGRectMake(ScreenWidth-51, 29, 45, 30);
    
    [morebutton setTitle:@"保存" forState:UIControlStateNormal];
    //[canclebutton setImage:[UIImage imageNamed:@"backArrow.png"] forState:UIControlStateNormal];
    //[morebutton setImage:[UIImage imageNamed:@"tmp"] forState:UIControlStateNormal];
    [morebutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [morebutton addTarget:self action:@selector(morebuttonaction) forControlEvents:UIControlEventTouchUpInside];
    //morebutton.hidden=YES;
    
   // UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithCustomView:morebutton];
    [mybarview addSubview:morebutton];
   // self.navigationItem.rightBarButtonItem=item;

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
-(void)morebuttonaction{
    [_codetf1 resignFirstResponder];
    
    
    if (_codetf1.text.length==0) {
        [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
        [[PublicTools shareInstance]creareNotificationUIView:@"价格不能为空"];
        _codetf1.text=@"";
    }else if (![self myisPureInt:_codetf1.text]){
        [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
        [[PublicTools shareInstance]creareNotificationUIView:@"您输入的不是整数"];
        _codetf1.text=@"";
    }else if([_codetf1.text integerValue]>self.maxPrice){
        [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
        [[PublicTools shareInstance]creareNotificationUIView:@"您设置价格超出上限"];
        _codetf1.text=@"";
    }else{
        [self.delegate setCustomPrice:_codetf1.text];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }

    //[self.navigationController popViewControllerAnimated:YES];
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
    
}

//-(BOOL)textFieldShouldReturn:(UITextField *)textField{
//    [textField resignFirstResponder];
//    return YES;
//}
- (BOOL)myisPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
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
    
    
    if (![textField.text isEqualToString:@""]) {
        [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
        [[PublicTools shareInstance]creareNotificationUIView:@"价格不能为空"];
        textField.text=@"";
    }else if (![self myisPureInt:textField.text]){
        [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
        [[PublicTools shareInstance]creareNotificationUIView:@"您输入的不是整数"];
         textField.text=@"";
    }else if([textField.text integerValue]>self.maxPrice){
        [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
        [[PublicTools shareInstance]creareNotificationUIView:@"您设置价格超出上限"];
         textField.text=@"";
    }else{
        [self.delegate setCustomPrice:textField.text];
        
        [self.navigationController popViewControllerAnimated:YES];

    }
    
  

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
