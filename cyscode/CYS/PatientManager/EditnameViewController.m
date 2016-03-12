//
//  EditnameViewController.m
//  ZDE
//
//  Created by NX on 15/8/26.
//  Copyright (c) 2015年 谢阳晴. All rights reserved.
//

#import "EditnameViewController.h"
#import "AddMyGroupViewController.h"
#import "GroupDetailViewController.h"


@interface EditnameViewController (){
    UITextField *codetf1;
    JGProgressHUD *HUD;
    NavBarView *mybarview;
}

@end

@implementation EditnameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=KBackgroundColor;
    codetf1=[self getTextFieldWithFrame:CGRectMake(0, 70, ScreenWidth, 45) theneedSecure:NO];
    codetf1.delegate=self;
    codetf1.textColor=KBlackColor;
    codetf1.backgroundColor=[UIColor whiteColor];
    codetf1.text=self.oldname;
    codetf1.placeholder=@"输入团队名字创建团队";
    codetf1.clearButtonMode=UITextFieldViewModeAlways;
    codetf1.returnKeyType=UIReturnKeyDone;
    
    KtfAddpaddingView(codetf1);
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:)
                                                name:UITextFieldTextDidChangeNotification
                                              object:codetf1];

    [self.view addSubview:codetf1];
    
    [codetf1 becomeFirstResponder];
    
    mybarview=[[NavBarView alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, 64)];
    mybarview.delegate=self;
    mybarview.navbarTitle=@"创建团队";
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
    //[morebutton setImage:[UIImage imageNamed:@"more.png"] forState:UIControlStateNormal];
    [morebutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    morebutton.titleLabel.font=[UIFont systemFontOfSize:17];
    [morebutton addTarget:self action:@selector(addBody) forControlEvents:UIControlEventTouchUpInside];
    
    
    [mybarview addSubview:morebutton];
    
    // Do any additional setup after loading the view.
}
-(void)addBody{
    [codetf1 resignFirstResponder];
    
    
    
    
    
    
    
    
    
    
    NSString *toBeString = codetf1.text;
    if ([self stringContainsEmoji:toBeString]) {
        [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
        [[PublicTools shareInstance]creareNotificationUIView:@"不允许输入特殊符号"];
        codetf1.text=@"";
        [codetf1 resignFirstResponder];
    } else {
        codetf1.text=toBeString;
        if ([codetf1.text isEqualToString:@""]) {
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"名字不能为空"];
        } else {
            
            
            
            
           
            
            UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"您确定用《%@》创建团队吗",toBeString] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alertview show];
            
            
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
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        HUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleLight];
        
        [HUD showInView:self.view];
        [HUD dismissAfterDelay:10.0];
        [DocTeamDataService foundDocTeamName:codetf1.text descStr:@"hahahahahahhahhahaahaha" block:^(id responsedic) {
            [HUD dismiss];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadindex" object:nil];
            NSLog(@"%@",responsedic);
            [[NSNotificationCenter defaultCenter]postNotificationName:@"reloaddocteam" object:nil];
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"创建团队成功"];
            NSString *toBeString = codetf1.text;
            
            
            
            
            NSDictionary *dic=[[NSDictionary alloc]initWithObjectsAndKeys:[responsedic objectForKey:@"id"],@"id", nil];
            NSLog(@"haha :%@",dic);
            GroupDetailViewController *groupvc=[[GroupDetailViewController alloc]init];
          //  groupvc.delegate=self;
            groupvc.datadic=dic;
            groupvc.teamid=[dic objectForKey:@"id"];
            groupvc.title=[dic objectForKey:@"name"];
            groupvc.ismanager=YES;
            groupvc.isnewteam=YES;
            [self.navigationController pushViewController:groupvc animated:YES];
            
            
            
            
//            AddMyGroupViewController *editnamevc=[[AddMyGroupViewController alloc]init];
//            //editnamevc.isrootvc=NO;
//            editnamevc.docteamid=[responsedic objectForKey:@"id"];
//            editnamevc.title=toBeString;
//            [self.navigationController pushViewController:editnamevc animated:YES];
            
        }];
        
        
        

        
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
                                                 object:codetf1];
    
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
   // self.navigationController.navigationBar.hidden=NO;
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
