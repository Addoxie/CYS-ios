//
//  EditSpamContentViewController.m
//  CYS
//
//  Created by 谢阳晴 on 16/2/22.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import "EditSpamContentViewController.h"

@interface EditSpamContentViewController (){
    UITextView *code1tf;
    UITextView *code2tf;
    CGFloat contacttfheight;
    NSMutableArray *contacttmpnamearr;
    
    NSMutableArray *contacttmpidarr;
    UILabel *uilabel;

}


@end

@implementation EditSpamContentViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.view.backgroundColor=[UIColor whiteColor];
    contacttmpnamearr=[[NSMutableArray alloc]init];
    contacttmpidarr=[[NSMutableArray alloc]init];
    
    for (NSDictionary *dic in self.contactarr) {
        NSLog(@"%@",dic);
        if ([dic objectForKey:@"name"]) {
             [contacttmpnamearr addObject:[dic objectForKey:@"name"]];
        }
        if([dic objectForKey:@"user_id"]){
            [contacttmpidarr addObject:[dic objectForKey:@"user_id"]];
        }
       
      
        
    }
    
    NSString *namesstr=[contacttmpnamearr componentsJoinedByString:@","];
    UIFont *font=[UIFont systemFontOfSize:18.0];
    
    CGRect size=KStringSize(namesstr, ScreenWidth-20, font);
    
    
    
    
    UIView *bgv=[[UIView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, size.size.height+20+20+30)];
    bgv.backgroundColor=KBackgroundColor;
    [self.view addSubview:bgv];
    
    
    
    UILabel *detaillabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 64,ScreenWidth-20, 30)];
    detaillabel.text=[NSString stringWithFormat:@"信息分别发送给%zd位患者：",self.contactarr.count];
    detaillabel.textColor=KtextGrayColor;
    detaillabel.numberOfLines=1;
    
    detaillabel.textAlignment=NSTextAlignmentLeft;
    detaillabel.font=[UIFont systemFontOfSize:15.0];
    //detaillabel.userInteractionEnabled=NO;
    [self.view addSubview:detaillabel];

    
    
    
    
    code1tf=[[UITextView alloc]initWithFrame:CGRectMake(10, 74+20, ScreenWidth-20, size.size.height+30)];
   // code1tf.delegate=self;
   // code1tf.placeholder=@"手机号码";
    code1tf.layer.masksToBounds = YES;
    code1tf.layer.cornerRadius = 6.0;
    code1tf.layer.borderWidth = 1.0;
    code1tf.text=namesstr;
    code1tf.font=font;
    NSLog(@"%@",namesstr);
    code1tf.textColor=KtextGrayColor;
    code1tf.backgroundColor=KBackgroundColor;
  //  code1tf.layer.borderColor=KLightLineColor.CGColor;
  //  code1tf.keyboardType=UIKeyboardTypeNumberPad;
  //  code1tf.tintColor=KlightOrangeColor;
  //  KtfAddpaddingView(code1tf);
  //  code1tf.text=namesstr;
    code1tf.editable=NO;
    //code1tf.scrollEnabled=NO;
    code1tf.layer.borderColor = [KLineColor CGColor];
    [self.view addSubview:code1tf];
    
    [bgv addSubview:[[UIManager shareInstance]getlineviewWithFrame:CGRectMake(0, size.size.height+20+20-1+30, ScreenWidth, 1) withimage:nil withbgcolor:KLineColor]];
//    
//    [code1tf.leftView addSubview:pwimgView];
//    code1tf.leftViewMode = UITextFieldViewModeAlways;
//    code1tf.leftView.bounds=CGRectMake(0, 0, 40, 25);
    
    
    
    
    
    
    
    
    code2tf=[[UITextView alloc]initWithFrame:CGRectMake(0, bgv.frame.origin.y+bgv.frame.size.height, ScreenWidth, 160)];
    code2tf.delegate=self;
    code2tf.tintColor=KlightOrangeColor;
   // code2tf.placeholder=@"验证码";
    code2tf.layer.masksToBounds = YES;
    code2tf.layer.cornerRadius = 1.0;
    code2tf.layer.borderWidth = 0.0;
    code2tf.font=font;
    code2tf.returnKeyType=UIReturnKeySend;
    code2tf.textColor=KBlackColor;
//    code2tf.keyboardType=UIKeyboardTypeNumberPad;
//    KtfAddpaddingView(code2tf);
  //  code2tf.layer.borderColor = [kimiColor(232, 232, 233, 1) CGColor];
    [self.view addSubview:code2tf];
    
    
    uilabel=[[UILabel alloc]init];
    
    uilabel.frame =CGRectMake(18, bgv.frame.origin.y+bgv.frame.size.height+8, 200, 20);
    uilabel.text = @"请输入群发文字信息";
    uilabel.font=font;
    uilabel.textAlignment=NSTextAlignmentLeft;
    uilabel.enabled = NO;//lable必须设置为不可用
    uilabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:uilabel];

    self.view.backgroundColor=KBackgroundColor;
    //[code2tf becomeFirstResponder];

    
    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textViewEditChanged:)
//                                                name:@"UITextFieldTextDidChangeNotification"
//                                              object:code2tf];
}


-(void)textViewDidChange:(UITextView *)textView
{
  //  self.examineText =  textView.text;
    if (textView.text.length == 0) {
        uilabel.text = @"请输入群发文字信息";
    }else{
        uilabel.text = @"";
    }
}
- (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        
        
        if (textView.text.length>=0) {
            
            JGProgressHUD *hud=[[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleDark];
            [hud showInView:self.view];
            [hud dismissAfterDelay:5];
            [DocTeamDataService spamMsgTopatients:self.contactarr msg:textView.text block:^(id respdic) {
                [hud dismiss];
                NSDate *datenow = [NSDate date];
                NSString *timeSp = [NSString stringWithFormat:@"%zd", (long)[datenow timeIntervalSince1970]];
                
                NSLog(@"%@",timeSp);
                NSDictionary *contentdic=[[NSDictionary alloc]initWithObjectsAndKeys:self.contactarr,@"contacts",textView.text,@"msg", nil];
                NSString *contentstr=[self dictionaryToJson:contentdic];
                
                
                
                
                
                
                
                HistoryMsgModel *historymodel=[[HistoryMsgModel alloc]init];
                historymodel.messageid=timeSp;
                historymodel.messagecontent=contentstr;
                
                BOOL result=[[UserDB shareInstance]addmessage:historymodel];
                
                if (result) {
//                    ShowSpamContentViewController *editspamvc=[[ShowSpamContentViewController alloc]init];
//                    editspamvc.title=@"群发信息";
//                    editspamvc.contactarr=self.contactarr;
//                  UIViewController *vc=[self.navigationController.viewControllers objectAtIndex:1];
//                   [self.navigationController popToViewController:vc animated:YES];
                    
                    [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
                    [[PublicTools shareInstance]crearebigNotificationUIView:@"消息已发送"];
                    [code2tf resignFirstResponder];
                    UIViewController *viewCtl = self.navigationController.viewControllers[1];
                    
                    [self.navigationController popToViewController:viewCtl animated:YES];

                }

            }];
            
            
            
        } else {
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"消息不能为空"];
        }
        
        
        //在这里做你响应return键的代码
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    return YES;
}

@end
