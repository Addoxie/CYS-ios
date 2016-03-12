//
//  UserUIcontrol.m
//  ZDE
//
//  Created by NX on 15/6/16.
//  Copyright (c) 2015年 谢阳晴. All rights reserved.
//

#import "UserUIcontrol.h"

@implementation UserUIcontrol

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self!=nil) {
        self.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        self.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        //[self addview];
        haveshow=NO;
    }
    return self;
    
}
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (haveshow==NO) {
        [self addview];
        haveshow=YES;
    }
    
   
}
-(void)layoutSubviews{
    
}

-(void)addview{
    NSLog(@"control");
//    UIView *bgview=[[UIView alloc]initWithFrame:CGRectMake(30, ScreenHeight/2-150/2, ScreenWidth-60, 150)];
//    bgview.backgroundColor=[UIColor whiteColor];
//    bgview.layer.masksToBounds = YES;
//    bgview.layer.cornerRadius = 6.0;
//    bgview.layer.borderWidth = 1.0;
//    bgview.layer.borderColor = [[UIColor whiteColor] CGColor];
//    
//    
//    
//    UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
//    button.frame=CGRectMake(0, 100, ScreenWidth-60, 50);
//    button.backgroundColor=[UIColor whiteColor];
//    button.layer.masksToBounds = YES;
//    button.layer.cornerRadius = 0.0;
//    button.layer.borderWidth = 1.0;
//    button.layer.borderColor = [[UIColor clearColor] CGColor];
//    [button setTitle:@"取消" forState:UIControlStateNormal];
//    // [button setTitleColor:[UIColor bl] forState:UIControlStateNormal];
//    button.titleLabel.font=[UIFont systemFontOfSize:22];
//    [button addTarget:self action:@selector(canclebuttonaction) forControlEvents:UIControlEventTouchUpInside];
//    [bgview addSubview:button];
//    
//    [self addSubview:bgview];
  //  NSLog(@"%@",self.controlType);
    if (self.controlType==Getphoto) {
         NSLog(@"control");
        UIView *bgview=[[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-150, ScreenWidth-0, 150)];
        bgview.backgroundColor=[UIColor whiteColor];
        bgview.layer.masksToBounds = YES;
        bgview.layer.cornerRadius = 0.0;
        bgview.layer.borderWidth = 1.0;
        bgview.layer.borderColor = [[UIColor whiteColor] CGColor];
        
        UIButton *DCbutton=[UIButton buttonWithType:UIButtonTypeCustom];
        DCbutton.frame=CGRectMake(0, 0, ScreenWidth-0, 50);
        DCbutton.backgroundColor=[UIColor whiteColor];
        DCbutton.layer.masksToBounds = YES;
        DCbutton.layer.cornerRadius = 0.0;
        DCbutton.layer.borderWidth = 1.0;
        DCbutton.layer.borderColor = [[UIColor clearColor] CGColor];
        [DCbutton setTitle:@"拍照" forState:UIControlStateNormal];
         [DCbutton setTitleColor:KBlackColor forState:UIControlStateNormal];
        DCbutton.titleLabel.font=[UIFont boldSystemFontOfSize:19];
        [DCbutton addTarget:self action:@selector(DCbuttonaction) forControlEvents:UIControlEventTouchUpInside];
        [bgview addSubview:DCbutton];
        
        UIButton *albumbutton=[UIButton buttonWithType:UIButtonTypeCustom];
        albumbutton.frame=CGRectMake(0, 50, ScreenWidth, 50);
        albumbutton.backgroundColor=[UIColor whiteColor];
        albumbutton.layer.masksToBounds = YES;
        albumbutton.layer.cornerRadius = 0.0;
        albumbutton.layer.borderWidth = 1.0;
        albumbutton.layer.borderColor = [[UIColor clearColor] CGColor];
        [albumbutton setTitle:@"从本地选择" forState:UIControlStateNormal];
         [albumbutton setTitleColor:KBlackColor forState:UIControlStateNormal];
        albumbutton.titleLabel.font=[UIFont boldSystemFontOfSize:19];
        [albumbutton addTarget:self action:@selector(albumbuttonaction) forControlEvents:UIControlEventTouchUpInside];
        [bgview addSubview:albumbutton];
      
        
        UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
        button.frame=CGRectMake(0, 100, ScreenWidth-0, 50);
        button.backgroundColor=[UIColor whiteColor];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 0.0;
        button.layer.borderWidth = 1.0;
        button.layer.borderColor = [[UIColor clearColor] CGColor];
        [button setTitle:@"取消" forState:UIControlStateNormal];
       // [button setTitleColor:[UIColor bl] forState:UIControlStateNormal];
        button.titleLabel.font=[UIFont boldSystemFontOfSize:21];
        [button addTarget:self action:@selector(canclebuttonaction) forControlEvents:UIControlEventTouchUpInside];
        [bgview addSubview:button];
        UIView *lineview=[[UIView alloc]initWithFrame:CGRectMake(0, 50-0.5/2.0, ScreenWidth-0, 0.5)];
        lineview.backgroundColor=[UIColor grayColor];
        [bgview addSubview:lineview];
        
        UIView *lineview1=[[UIView alloc]initWithFrame:CGRectMake(0, 100-0.5/2.0, ScreenWidth-0, 0.5)];
        lineview1.backgroundColor=[UIColor grayColor];
        [bgview addSubview:lineview1];
        
        [self addSubview:bgview];

        
    }else if(self.controlType==GetNewpassword){
        
        UIView *bgview=[[UIView alloc]initWithFrame:CGRectMake(30, ScreenHeight/2-350/2, ScreenWidth-60, 350)];
        bgview.backgroundColor=[UIColor whiteColor];
        bgview.layer.masksToBounds = YES;
        bgview.layer.cornerRadius = 4.0;
        bgview.layer.borderWidth = 1.0;
        bgview.layer.borderColor = [[UIColor whiteColor] CGColor];
        UIColor *blackcolor=kimiColor(112, 112, 112, 1);
        [bgview addSubview:[self getLabelWithFrame:CGRectMake(10, 10, ScreenWidth-60-20, 36) theText:@"原密码" Withcolor:blackcolor]];
        
        codetf=[self getTextFieldWithFrame:CGRectMake(10, 46, ScreenWidth-60-20, 45) theneedSecure:YES];
        codetf.delegate=self;
        codetf.returnKeyType=UIReturnKeyDone;
         KtfAddpaddingView(codetf);
        [bgview addSubview:codetf];
        
       
        [bgview addSubview:[self getLabelWithFrame:CGRectMake(10, 10+350/3*1-10-15, ScreenWidth-60-20, 36) theText:@"新密码" Withcolor:blackcolor]];
        
        codetf1=[self getTextFieldWithFrame:CGRectMake(10, 46+350/3*1-5-15, ScreenWidth-60-20, 45) theneedSecure:YES];
        codetf1.delegate=self;
        codetf1.returnKeyType=UIReturnKeyDone;

         KtfAddpaddingView(codetf1);
        [bgview addSubview:codetf1];
        
        [bgview addSubview:[self getLabelWithFrame:CGRectMake(10, 10+350/3*2-10-30, ScreenWidth-60-20, 36) theText:@"重复新密码" Withcolor:blackcolor]];
        
        codetf2=[self getTextFieldWithFrame:CGRectMake(10, 46+350/3*2-5-30, ScreenWidth-60-20, 45) theneedSecure:YES];
        codetf2.delegate=self;
        codetf2.returnKeyType=UIReturnKeyDone;

          KtfAddpaddingView(codetf2);
        [bgview addSubview:codetf2];
        
        
        
        UIButton *canclebutton=[UIButton buttonWithType:UIButtonTypeSystem];
        canclebutton.frame=CGRectMake(0,bgview.frame.size.height-50, bgview.frame.size.width/2, 50);
        canclebutton.backgroundColor=[UIColor whiteColor];
        canclebutton.tag=100000;
        canclebutton.layer.masksToBounds = YES;
        canclebutton.layer.cornerRadius = 3.0;
        canclebutton.layer.borderWidth = 1.0;
        canclebutton.layer.borderColor = [[UIColor clearColor] CGColor];
        [canclebutton setTitle:@"取消" forState:UIControlStateNormal];
        canclebutton.titleLabel.font=[UIFont systemFontOfSize:21];
        //[canclebutton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        //        button.titleLabel.font=KBoldFont(19.0);
        [canclebutton addTarget:self action:@selector(canclebuttonaction) forControlEvents:UIControlEventTouchUpInside];
        [bgview addSubview:canclebutton];
        
        UIButton *surebutton=[UIButton buttonWithType:UIButtonTypeSystem];
        surebutton.frame=CGRectMake(bgview.frame.size.width/2,bgview.frame.size.height-50, bgview.frame.size.width/2, 50);;
        surebutton.backgroundColor=[UIColor whiteColor];
        surebutton.tag=100001;
        surebutton.layer.masksToBounds = YES;
        surebutton.layer.cornerRadius = 3.0;
        surebutton.layer.borderWidth = 1.0;
        surebutton.layer.borderColor = [[UIColor clearColor] CGColor];
        [surebutton setTitle:@"确定" forState:UIControlStateNormal];
        surebutton.titleLabel.font=[UIFont systemFontOfSize:21];
        //[surebutton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        //        [button setTitleColor:KBlackColor forState:UIControlStateNormal];
        //        button.titleLabel.font=KBoldFont(19.0);
        [surebutton addTarget:self action:@selector(surebuttonaction) forControlEvents:UIControlEventTouchUpInside];
        [bgview addSubview:surebutton];
        bgview.layer.masksToBounds = YES;
        bgview.layer.cornerRadius = 3.0;
        bgview.layer.borderWidth = 1.0;
        bgview.layer.borderColor = [[UIColor whiteColor] CGColor];
        [self addSubview:bgview];
        
        UIView *lineview=[[UIView alloc]initWithFrame:CGRectMake(0, bgview.frame.size.height-50, bgview.frame.size.width, 0.5)];
        lineview.backgroundColor=[UIColor grayColor];
        [bgview addSubview:lineview];
        
        UIView *lineview1=[[UIView alloc]initWithFrame:CGRectMake(bgview.frame.size.width/2-0.25, bgview.frame.size.height-50, 0.5, 50)];
        lineview1.backgroundColor=[UIColor grayColor];
        [bgview addSubview:lineview1];
        [self addSubview:bgview];


    }else if(self.controlType==Getnewphone){
        UIView *bgview=[[UIView alloc]initWithFrame:CGRectMake(30, ScreenHeight/2-160/2, ScreenWidth-60, 160)];
        bgview.backgroundColor=[UIColor whiteColor];
        bgview.layer.masksToBounds = YES;
        bgview.layer.cornerRadius = 4.0;
        bgview.layer.borderWidth = 1.0;
        bgview.layer.borderColor = [[UIColor whiteColor] CGColor];
        UIColor *blackcolor=[UIColor blackColor];
        UILabel *titlelabel=[self getLabelWithFrame:CGRectMake(10, 10, ScreenWidth-60-20, 36) theText:@"修改手机绑定" Withcolor:blackcolor];
        titlelabel.textAlignment=NSTextAlignmentCenter;
        [bgview addSubview:titlelabel];
        codetf=[self getTextFieldWithFrame:CGRectMake(10, 50, ScreenWidth-60-20, 50) theneedSecure:YES];
        codetf.placeholder=@"请输入您的登录密码";
         codetf.delegate=self;
         KtfAddpaddingView(codetf);
        [bgview addSubview:codetf];
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(0, 110, ScreenWidth-60, 50);
        button.backgroundColor=[UIColor whiteColor];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 0.0;
        button.layer.borderWidth = 1.0;
        button.layer.borderColor = [[UIColor clearColor] CGColor];
        [button setTitle:@"下一步" forState:UIControlStateNormal];
         [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        button.titleLabel.font=[UIFont boldSystemFontOfSize:21];
        [button addTarget:self action:@selector(nextbuttonaction) forControlEvents:UIControlEventTouchUpInside];
        [bgview addSubview:button];
        UIView *lineview=[[UIView alloc]initWithFrame:CGRectMake(0, 160-45, ScreenWidth-60, 0.5)];
        lineview.backgroundColor=[UIColor grayColor];
        [bgview addSubview:lineview];
        
        [self addSubview:bgview];


        
        
    }
//        
//    }else if(self.contentType==4){
//        
//    }else if(self.contentType==5){
//        
//    }else if(self.contentType==6){
//        
//    }else if(self.contentType==7){
//        
//    }
    
}
-(void)canclebuttonaction{
    [self removeFromSuperview];
}
-(void)DCbuttonaction{
    [self.delegate controlDCtypeIsAlbum:NO];
     [self removeFromSuperview];
    
}
-(void)nextbuttonaction{
   
//    //[UIApplication sharedApplication].keyWindow;
//    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"phonenum"]!=nil) {
//        
//        NSMutableDictionary *mydic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"phonenum"],@"msisdn",codetf.text,@"password", nil];
//       
//       // NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:mydic,@"user-info",nil];
//        [[PublicTools shareInstance]PostNetWorkJSONWithURLStr:@"protected/user/login" whitdic:mydic theReturnBlock:^(id respondataarr){
//            
//            NSArray *dataarr=(NSArray *)respondataarr;
//           
//            if ([[[dataarr objectAtIndex:0] stringValue]isEqualToString:@"200"]) {
//                
//                
//                for (UIView *subview in self.subviews) {
//                    [subview removeFromSuperview];
//                }
//                NSDictionary *dic=(NSDictionary *)[dataarr objectAtIndex:1];
//                NSLog(@"%@",dic);
//                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//                [defaults setObject:[dic objectForKey:@"token"] forKey:@"token"];
//                [defaults setObject:[dic objectForKey:@"msisdn"] forKey:@"phonenum"];
//                [defaults setObject:[dic objectForKey:@"gender"] forKey:@"gender"];
//                [defaults setObject:[dic objectForKey:@"icon-url"] forKey:@"icon-url"];
//                [defaults setObject:[dic objectForKey:@"nick-name"] forKey:@"nick-name"];
//                [defaults synchronize];
//                
//                 NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"phonenum"]);
//                NSString *urlstring=[NSString stringWithFormat:@"protected/msisdn/verify?msisdn=%@&purpose=chno",[[NSUserDefaults standardUserDefaults]objectForKey:@"phonenum"]];
//                [[PublicTools shareInstance]GetNetWorkDataWithURLStr:urlstring theReturnBlock:^(id respondataarr) {
//                    
//                    NSArray *dataarr=(NSArray *)respondataarr;
//                    
//                    // NSDictionary *dic=(NSDictionary *)[dataarr objectAtIndex:1];
//                    if ([[[dataarr objectAtIndex:0] stringValue]isEqualToString:@"200"]) {
//                        
//                        [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//                        [[PublicTools shareInstance]creareNotificationUIView:@"验证码短信已发送"];
//                    }else{
//                        
//                    }
//                    //  NSDictionary *dic=(NSDictionary *)obj;
//                    
//                    
//                }];
//                
//                
//                
//                UIView *bgview=[[UIView alloc]initWithFrame:CGRectMake(30, ScreenHeight/2-215/2, ScreenWidth-60, 215)];
//                bgview.backgroundColor=[UIColor whiteColor];
//                bgview.layer.masksToBounds = YES;
//                bgview.layer.cornerRadius = 4.0;
//                bgview.layer.borderWidth = 1.0;
//                bgview.layer.borderColor = [[UIColor whiteColor] CGColor];
//                UIColor *bluecolor=[UIColor blueColor];
//                UIColor *blackcolor=[UIColor blackColor];
//                UILabel *titlelabel=[self getLabelWithFrame:CGRectMake(10, 10, ScreenWidth-60-20, 36) theText:[NSString stringWithFormat:@"验证手机:%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"phonenum"]] Withcolor:bluecolor];
//                titlelabel.textAlignment=NSTextAlignmentCenter;
//                [bgview addSubview:titlelabel];
//                UILabel *titlelabel1=[self getLabelWithFrame:CGRectMake(10, 36, ScreenWidth-60-20, 36) theText:[NSString stringWithFormat:@"%@",@"已向您的手机发送了一条验证消息"] Withcolor:blackcolor];
//                titlelabel1.textAlignment=NSTextAlignmentCenter;
//                [bgview addSubview:titlelabel1];
//                
//                UILabel *titlelabel2=[self getLabelWithFrame:CGRectMake(10, 62, ScreenWidth-60-20, 36) theText:[NSString stringWithFormat:@"%@",@"请于下方输入收到的验证码"] Withcolor:blackcolor];
//                titlelabel2.textAlignment=NSTextAlignmentCenter;
//                [bgview addSubview:titlelabel2];
//                
//                codetf=[self getTextFieldWithFrame:CGRectMake(10, 105, ScreenWidth-60-20, 50) theneedSecure:YES];
//                codetf.placeholder=@"请输入手机验证码";
//                codetf.secureTextEntry=NO;
//                codetf.delegate=self;
//                 KtfAddpaddingView(codetf);
//                [bgview addSubview:codetf];
//                //    UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
//                //    button.frame=CGRectMake(0, 215-50, ScreenWidth-60, 50);
//                //    button.backgroundColor=[UIColor whiteColor];
//                //    button.layer.masksToBounds = YES;
//                //    button.layer.cornerRadius = 0.0;
//                //    button.layer.borderWidth = 1.0;
//                //    button.layer.borderColor = [[UIColor clearColor] CGColor];
//                //    [button setTitle:@"下一步" forState:UIControlStateNormal];
//                //    // [button setTitleColor:[UIColor bl] forState:UIControlStateNormal];
//                //    button.titleLabel.font=[UIFont systemFontOfSize:19];
//                //    [button addTarget:self action:@selector(nextbuttonaction) forControlEvents:UIControlEventTouchUpInside];
//                //    [bgview addSubview:button];
//                UIButton *canclebutton=[UIButton buttonWithType:UIButtonTypeCustom];
//                canclebutton.frame=CGRectMake(0,215-50, bgview.frame.size.width/2, 50);
//                canclebutton.backgroundColor=[UIColor whiteColor];
//                // canclebutton.tag=100000;
//                canclebutton.layer.masksToBounds = YES;
//                canclebutton.layer.cornerRadius = 4.0;
//                canclebutton.layer.borderWidth = 1.0;
//                canclebutton.layer.borderColor = [[UIColor clearColor] CGColor];
//                [canclebutton setTitle:@"验证" forState:UIControlStateNormal];
//                canclebutton.titleLabel.font=[UIFont systemFontOfSize:21];
//                [canclebutton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//                //        button.titleLabel.font=KBoldFont(19.0);
//                [canclebutton addTarget:self action:@selector(verifyaction) forControlEvents:UIControlEventTouchUpInside];
//                [bgview addSubview:canclebutton];
//                
//                getcodebutton=[UIButton buttonWithType:UIButtonTypeCustom];
//                getcodebutton.frame=CGRectMake(bgview.frame.size.width/2,215-50, bgview.frame.size.width/2, 50);;
//                getcodebutton.backgroundColor=[UIColor whiteColor];
//                //getcodebutton.tag=100001;
//                getcodebutton.layer.masksToBounds = YES;
//                getcodebutton.layer.cornerRadius = 4.0;
//                getcodebutton.layer.borderWidth = 1.0;
//                getcodebutton.layer.borderColor = [[UIColor clearColor] CGColor];
//                [getcodebutton setTitle:@"重新获取(60)" forState:UIControlStateNormal];
//                
//                getcodebutton.titleLabel.font=[UIFont systemFontOfSize:21];
//                getcodebutton.userInteractionEnabled=NO;
//                [getcodebutton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//                //        [button setTitleColor:KBlackColor forState:UIControlStateNormal];
//                //        button.titleLabel.font=KBoldFont(19.0);
//                [getcodebutton addTarget:self action:@selector(getnewcodeaction) forControlEvents:UIControlEventTouchUpInside];
//                [bgview addSubview:getcodebutton];
//                i=60;
//                timer=[NSTimer timerWithTimeInterval:1 target:self selector:@selector(timeraction:) userInfo:nil repeats:YES];
//                
//                [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
//                
//                bgview.layer.masksToBounds = YES;
//                bgview.layer.cornerRadius = 4.0;
//                bgview.layer.borderWidth = 1.0;
//                bgview.layer.borderColor = [[UIColor whiteColor] CGColor];
//                
//                
//                UIView *lineview=[[UIView alloc]initWithFrame:CGRectMake(0, 215-51, ScreenWidth-60, 0.5)];
//                lineview.backgroundColor=[UIColor grayColor];
//                [bgview addSubview:lineview];
//                UIView *lineview1=[[UIView alloc]initWithFrame:CGRectMake(bgview.frame.size.width/2-0.25, bgview.frame.size.height-50, 0.5, 50)];
//                lineview1.backgroundColor=[UIColor grayColor];
//                [bgview addSubview:lineview1];
//                [self addSubview:bgview];
//
//            }else{
//                 NSDictionary *dic=(NSDictionary *)[dataarr objectAtIndex:1];
//                if ([[[dic objectForKey:@"status"] stringValue] isEqualToString:@"4000"]) {
//                    [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//                    [[PublicTools shareInstance]creareNotificationUIView:@"签名错误"];
//                    
//                }else if ([[[dic objectForKey:@"status"] stringValue] isEqualToString:@"4001"]){
//                    [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//                    [[PublicTools shareInstance]creareNotificationUIView:@"数据错误"];
//                }else if ([[[dic objectForKey:@"status"] stringValue]isEqualToString:@"4002"]){
//                    [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//                    [[PublicTools shareInstance]creareNotificationUIView:@"数据错误"];
//                }else if ([[[dic objectForKey:@"status"] stringValue]isEqualToString:@"4003"]){
//                    [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//                    [[PublicTools shareInstance]creareNotificationUIView:@"参数错误"];
//                    
//                }else if ([[[dic objectForKey:@"status"] stringValue] isEqualToString:@"4004"]){
//                    [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//                    [[PublicTools shareInstance]creareNotificationUIView:@"手机号码签名错误"];
//                    
//                }else if ([[[dic objectForKey:@"status"] stringValue]isEqualToString:@"4005"]){
//                    [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//                    [[PublicTools shareInstance]creareNotificationUIView:@"手机号码已被注册过"];
//                    
//                }else if ([[[dic objectForKey:@"status"] stringValue] isEqualToString:@"4006"]){
//                    [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//                    [[PublicTools shareInstance]creareNotificationUIView:@"登录失败，手机号码或者密码错误"];
//                    
//                }else if ([[[dic objectForKey:@"status"] stringValue] isEqualToString:@"4007"]){
//                    [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//                    [[PublicTools shareInstance]creareNotificationUIView:@"数据错误"];
//                    
//                }else if ([[[dic objectForKey:@"status"] stringValue] isEqualToString:@"4008"]){
//                    [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//                    [[PublicTools shareInstance]creareNotificationUIView:@"数据错误"];
//                    
//                }else if ([[[dic objectForKey:@"status"] stringValue] isEqualToString:@"4009"]){
//                    [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//                    [[PublicTools shareInstance]creareNotificationUIView:@"数据错误"];
//                }else if ([[[dic objectForKey:@"status"] stringValue] isEqualToString:@"4010"]){
//                    [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//                    [[PublicTools shareInstance]creareNotificationUIView:@"用户被锁"];
//                    
//                }else if ([[[dic objectForKey:@"status"] stringValue]isEqualToString:@"5002"]){
//                    [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//                    [[PublicTools shareInstance]creareNotificationUIView:@"数据错误"];
//                }else if ([[[dic objectForKey:@"status"] stringValue] isEqualToString:@"5001"]){
//                    [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//                    [[PublicTools shareInstance]creareNotificationUIView:@"数据错误"];
//                    
//                }
//                
//            }
//
//        }];
//    
//    }
//    
}
-(void)albumbuttonaction{
    [self.delegate controlDCtypeIsAlbum:YES];
    [self removeFromSuperview];
}
-(UILabel *)getLabelWithFrame:(CGRect)myframe theText:(NSString *)mytext Withcolor:(UIColor *)mycolor{
    UILabel *label=[[UILabel alloc]initWithFrame:myframe];
    label.text=mytext;
    label.textColor=KBlackColor;
    label.font=[UIFont boldSystemFontOfSize:18.0];
    label.textAlignment=NSTextAlignmentLeft;
    return label;
}
-(UITextField *)getTextFieldWithFrame:(CGRect)myframe theneedSecure:(BOOL)needsecure{
    UITextField *textf=[[UITextField alloc]initWithFrame:myframe];
    textf.layer.masksToBounds = YES;
    textf.layer.cornerRadius = 4.0;
    textf.layer.borderWidth = 1.0;
    textf.layer.borderColor = [kimiColor(232, 232, 233, 1) CGColor];
    if (needsecure) {
        textf.secureTextEntry=YES;
    }
    return textf;
    
}
-(void)verifyaction{
    
    
//    NSString *urlstring=[NSString stringWithFormat:@"protected/msisdn/verify-code?msisdn=%@&code=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"phonenum"],codetf.text];
//    [[PublicTools shareInstance]GetNetWorkDataWithURLStr:urlstring theReturnBlock:^(id respondataarr) {
//        NSArray *dataarr=(NSArray *)respondataarr;
//        NSLog(@"%@",respondataarr);
//        // NSDictionary *dic=(NSDictionary *)[dataarr objectAtIndex:1];
//        if ([[[dataarr objectAtIndex:0] stringValue]isEqualToString:@"200"]) {
//            for (UIView *subview in self.subviews) {
//                [subview removeFromSuperview];
//            }
//
//            NSDictionary *dic=(NSDictionary *)[dataarr objectAtIndex:1];
//            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//            
//            [defaults setObject:[dic objectForKey:@"signature"] forKey:@"oldsignature"];
//            [defaults setObject:[dic objectForKey:@"msisdn"] forKey:@"phonenum"];
//            [defaults synchronize];
//            UIView *bgview=[[UIView alloc]initWithFrame:CGRectMake(30, ScreenHeight/2-215/2, ScreenWidth-60, 215)];
//            bgview.backgroundColor=[UIColor whiteColor];
//            bgview.layer.masksToBounds = YES;
//            bgview.layer.cornerRadius = 4.0;
//            bgview.layer.borderWidth = 1.0;
//            bgview.layer.borderColor = [[UIColor whiteColor] CGColor];
//            UIColor *bluecolor=[UIColor blueColor];
//            // UIColor *blackcolor=[UIColor blackColor];
//            UILabel *titlelabel=[self getLabelWithFrame:CGRectMake(10, 10, ScreenWidth-60-20, 36) theText:@"修改手机绑定" Withcolor:bluecolor];
//            titlelabel.textAlignment=NSTextAlignmentCenter;
//            [bgview addSubview:titlelabel];
//            codetf=[self getTextFieldWithFrame:CGRectMake(10, 50, ScreenWidth-60-20, 50) theneedSecure:YES];
//            codetf.delegate=self;
//            codetf.placeholder=@"请输入新的手机号码";
//            codetf.secureTextEntry=NO;
//            KtfAddpaddingView(codetf);
//            [bgview addSubview:codetf];
//            codetf1=[self getTextFieldWithFrame:CGRectMake(10, 110, ScreenWidth-60-20-110, 50) theneedSecure:YES];
//            codetf1.delegate=self;
//            codetf1.placeholder=@"输入短信验证码";
//            codetf1.secureTextEntry=NO;
//            KtfAddpaddingView(codetf1);
//            [bgview addSubview:codetf1];
//            
//            newgetcodebutton=[UIButton buttonWithType:UIButtonTypeCustom];
//            newgetcodebutton.frame=CGRectMake(10+ScreenWidth-60-20-110+10,110, bgview.frame.size.width-(10+ScreenWidth-60-20-110+10)-10, 50);
//            newgetcodebutton.backgroundColor=[UIColor whiteColor];
//            //getcodebutton.tag=100001;
//            newgetcodebutton.layer.masksToBounds = YES;
//            newgetcodebutton.layer.cornerRadius = 4.0;
//            newgetcodebutton.layer.borderWidth = 1.0;
//            newgetcodebutton.layer.borderColor = [[UIColor clearColor] CGColor];
//            [newgetcodebutton setTitle:@"获取验证码" forState:UIControlStateNormal];
//            
//            newgetcodebutton.titleLabel.font=[UIFont boldSystemFontOfSize:14];
//            // newgetcodebutton.userInteractionEnabled=NO;
//            [newgetcodebutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            //        [button setTitleColor:KBlackColor forState:UIControlStateNormal];
//            //        button.titleLabel.font=KBoldFont(19.0);
//            newgetcodebutton.backgroundColor=KGreenColor;
//            [newgetcodebutton addTarget:self action:@selector(newgetnewcodeaction) forControlEvents:UIControlEventTouchUpInside];
//            [bgview addSubview:newgetcodebutton];
//            
//            UIButton *canclebutton=[UIButton buttonWithType:UIButtonTypeCustom];
//            canclebutton.frame=CGRectMake(0,215-45, bgview.frame.size.width, 45);
//            canclebutton.backgroundColor=[UIColor whiteColor];
//            // canclebutton.tag=100000;
//            canclebutton.layer.masksToBounds = YES;
//            canclebutton.layer.cornerRadius = 4.0;
//            canclebutton.layer.borderWidth = 1.0;
//            canclebutton.layer.borderColor = [[UIColor clearColor] CGColor];
//            [canclebutton setTitle:@"验证" forState:UIControlStateNormal];
//            canclebutton.titleLabel.font=[UIFont systemFontOfSize:21];
//            [canclebutton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//            
//            //        button.titleLabel.font=KBoldFont(19.0);
//            [canclebutton addTarget:self action:@selector(newverifyaction) forControlEvents:UIControlEventTouchUpInside];
//            [bgview addSubview:canclebutton];
//            
//            UIView *lineview=[[UIView alloc]initWithFrame:CGRectMake(0, 215-45, ScreenWidth-60, 0.5)];
//            lineview.backgroundColor=[UIColor grayColor];
//            [bgview addSubview:lineview];
//            
//            [self addSubview:bgview];
//
//        }else{
//            NSDictionary *dic=(NSDictionary *)[dataarr objectAtIndex:1];
//            if ([[[dic objectForKey:@"status"] stringValue] isEqualToString:@"4000"]) {
//                [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//                [[PublicTools shareInstance]creareNotificationUIView:@"签名错误"];
//                
//            }else if ([[[dic objectForKey:@"status"] stringValue] isEqualToString:@"4001"]){
//                [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//                [[PublicTools shareInstance]creareNotificationUIView:@"手机号码不存在"];
//            }else if ([[[dic objectForKey:@"status"] stringValue] isEqualToString:@"4002"]){
//                [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//                [[PublicTools shareInstance]creareNotificationUIView:@"验证码错误"];
//            }else if ([[[dic objectForKey:@"status"] stringValue] isEqualToString:@"4003"]){
//                [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//                [[PublicTools shareInstance]creareNotificationUIView:@"要改新密码要提供旧密码"];
//                
//            }else if ([[[dic objectForKey:@"status"] stringValue] isEqualToString:@"4004"]){
//                [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//                [[PublicTools shareInstance]creareNotificationUIView:@"手机号码签名错误"];
//                
//            }else if ([[[dic objectForKey:@"status"] stringValue] isEqualToString:@"4005"]){
//                [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//                [[PublicTools shareInstance]creareNotificationUIView:@"手机号码已被注册过"];
//                
//            }else if ([[[dic objectForKey:@"status"] stringValue] isEqualToString:@"4006"]){
//                [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//                [[PublicTools shareInstance]creareNotificationUIView:@"手机号码错误"];
//                
//            }else if ([[[dic objectForKey:@"status"] stringValue]isEqualToString:@"4007"]){
//                [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//                [[PublicTools shareInstance]creareNotificationUIView:@"数据错误"];
//                
//            }else if ([[[dic objectForKey:@"status"] stringValue] isEqualToString:@"4008"]){
//                [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//                [[PublicTools shareInstance]creareNotificationUIView:@"数据错误"];
//                
//            }else if ([[[dic objectForKey:@"status"] stringValue] isEqualToString:@"4009"]){
//                [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//                [[PublicTools shareInstance]creareNotificationUIView:@"旧密码错误"];
//            }else if ([[[dic objectForKey:@"status"] stringValue] isEqualToString:@"4010"]){
//                [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//                [[PublicTools shareInstance]creareNotificationUIView:@"用户被锁"];
//                
//            }else if ([[[dic objectForKey:@"status"] stringValue] isEqualToString:@"5002"]){
//                [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//                [[PublicTools shareInstance]creareNotificationUIView:@"Icon存储错误"];
//            }else if ([[[dic objectForKey:@"status"] stringValue] isEqualToString:@"5001"]){
//                [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//                [[PublicTools shareInstance]creareNotificationUIView:@"数据错误"];
//                
//            }
//
//        }
//    }];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    
    CGPoint touchPoint = [touch locationInView:self];
    if (self.controlType==Getnewphone) {
        if((ScreenHeight/2-185/2)>touchPoint.y||(ScreenHeight/2-185/2+185)<touchPoint.y){
            [self removeFromSuperview];
        }
    }
    [codetf resignFirstResponder];
    [codetf1 resignFirstResponder];
     [codetf2 resignFirstResponder];
        
    
    
}
-(void)newverifyaction{
//     NSLog(@"verify");
//    NSLog(@"%@",codetf.text);
//    NSLog(@"%@",codetf1.text);
//    NSString *urlstring=[NSString stringWithFormat:@"protected/msisdn/verify-code?msisdn=%@&code=%@",codetf.text,codetf1.text];
//    [[PublicTools shareInstance]GetNetWorkDataWithURLStr:urlstring theReturnBlock:^(id respondataarr) {
//        NSArray *dataarr=(NSArray *)respondataarr;
//        NSLog(@"%@",respondataarr);
//        // NSDictionary *dic=(NSDictionary *)[dataarr objectAtIndex:1];
//        if ([[[dataarr objectAtIndex:0] stringValue]isEqualToString:@"200"]) {
//            
//            
//            
//            NSDictionary *dic=(NSDictionary *)[dataarr objectAtIndex:1];
//            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//            
//            [defaults setObject:[dic objectForKey:@"signature"] forKey:@"newsignature"];
//            [defaults setObject:[dic objectForKey:@"msisdn"] forKey:@"phonenum"];
//            [defaults synchronize];
//            
//            NSMutableDictionary *userinfodic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"oldsignature"],@"old-msisdn-signature",[[NSUserDefaults standardUserDefaults]objectForKey:@"newsignature"],@"new-msisdn-signature",codetf.text,@"new-msisdn", nil];
//            //NSLog(@"%@",dic);
//            //NSLog(@"%@",self.pimg);
//            NSMutableDictionary *newphonedic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:userinfodic,@"user-info",nil];
//            [[PublicTools shareInstance]PostNetWorkDataWithURLStr:@"private/user/update" whitdic:newphonedic theReturnBlock:^(id respondataarr) {
//                //        if (respondata==nil) {
//                //            [self.navigationController popToRootViewControllerAnimated:YES];
//                //        }
//                // NSLog(@"%@",respondataarr);
//                
//                NSArray *dataarr=(NSArray *)respondataarr;
//                
//                if ([[[dataarr objectAtIndex:0] stringValue]isEqualToString:@"200"]) {
//                    for (UIView *subview in self.subviews) {
//                        [subview removeFromSuperview];
//                    }
//                    [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//                    [[PublicTools shareInstance]creareNotificationUIView:@"更改成功"];
//
//                    UIView *bgview=[[UIView alloc]initWithFrame:CGRectMake(30, ScreenHeight/2-185/2, ScreenWidth-60, 185)];
//                    bgview.backgroundColor=[UIColor whiteColor];
//                    bgview.layer.masksToBounds = YES;
//                    bgview.layer.cornerRadius = 4.0;
//                    bgview.layer.borderWidth = 1.0;
//                    bgview.layer.borderColor = [[UIColor whiteColor] CGColor];
//                    UIColor *bluecolor=[UIColor blueColor];
//                    UIColor *blackcolor=[UIColor blackColor];
//                    UIColor *graycolor=[UIColor grayColor];
//                    UILabel *titlelabel=[self getLabelWithFrame:CGRectMake(10, 10, ScreenWidth-60-20, 36) theText:[NSString stringWithFormat:@"%@",@"修改手机绑定成功!"] Withcolor:bluecolor];
//                    titlelabel.textAlignment=NSTextAlignmentCenter;
//                    [bgview addSubview:titlelabel];
//                    UILabel *titlelabel1=[self getLabelWithFrame:CGRectMake(10, 36, ScreenWidth-60-20, 36) theText:[NSString stringWithFormat:@"已绑定新的手机号%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"phonenum"]] Withcolor:blackcolor];
//                    titlelabel1.textAlignment=NSTextAlignmentCenter;
//                    [bgview addSubview:titlelabel1];
//                    
//                    UILabel *titlelabel2=[self getLabelWithFrame:CGRectMake(10, 62, ScreenWidth-60-20, 36) theText:[NSString stringWithFormat:@"%@",@"你可以使用该信号进行登录"] Withcolor:graycolor];
//                    titlelabel2.textAlignment=NSTextAlignmentCenter;
//                    [bgview addSubview:titlelabel2];
//                    UILabel *titlelabel3=[self getLabelWithFrame:CGRectMake(10, 90, ScreenWidth-60-20, 36) theText:[NSString stringWithFormat:@"%@",@"旧号码不可用于登录"] Withcolor:graycolor];
//                    titlelabel3.textAlignment=NSTextAlignmentCenter;
//                    [bgview addSubview:titlelabel3];
//                    UIButton *canclebutton=[UIButton buttonWithType:UIButtonTypeCustom];
//                    canclebutton.frame=CGRectMake(0,185-45, bgview.frame.size.width, 45);
//                    canclebutton.backgroundColor=[UIColor whiteColor];
//                    // canclebutton.tag=100000;
//                    canclebutton.layer.masksToBounds = YES;
//                    canclebutton.layer.cornerRadius = 4.0;
//                    canclebutton.layer.borderWidth = 1.0;
//                    canclebutton.layer.borderColor = [[UIColor clearColor] CGColor];
//                    [canclebutton setTitle:@"确定" forState:UIControlStateNormal];
//                    canclebutton.titleLabel.font=[UIFont systemFontOfSize:19];
//                    [canclebutton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//                    //        button.titleLabel.font=KBoldFont(19.0);
//                    [canclebutton addTarget:self action:@selector(newcanclebuttonaction) forControlEvents:UIControlEventTouchUpInside];
//                    [bgview addSubview:canclebutton];
//                    
//                    UIView *lineview=[[UIView alloc]initWithFrame:CGRectMake(0, 185-45, ScreenWidth-60, 0.5)];
//                    lineview.backgroundColor=[UIColor grayColor];
//                    [bgview addSubview:lineview];
//                    [self addSubview:bgview];
//                    
//                }else{
//                    [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//                    [[PublicTools shareInstance]creareNotificationUIView:@"操作错误"];
//                }
//                
//                
//            }];
//
//            
//        }else{
//                    NSDictionary *dic=(NSDictionary *)[dataarr objectAtIndex:1];
//                    if ([[[dic objectForKey:@"status"] stringValue] isEqualToString:@"4000"]) {
//                        [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//                        [[PublicTools shareInstance]creareNotificationUIView:@"签名错误"];
//            
//                    }else if ([[[dic objectForKey:@"status"] stringValue]isEqualToString:@"4001"]){
//                        [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//                        [[PublicTools shareInstance]creareNotificationUIView:@"手机号码不存在"];
//                    }else if ([[[dic objectForKey:@"status"] stringValue] isEqualToString:@"4002"]){
//                        [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//                        [[PublicTools shareInstance]creareNotificationUIView:@"数据错误"];
//                    }else if ([[[dic objectForKey:@"status"] stringValue] isEqualToString:@"4003"]){
//                        [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//                        [[PublicTools shareInstance]creareNotificationUIView:@"要改新密码要提供旧密码"];
//            
//                    }else if ([[[dic objectForKey:@"status"] stringValue] isEqualToString:@"4004"]){
//                        [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//                        [[PublicTools shareInstance]creareNotificationUIView:@"手机号码签名错误"];
//            
//                    }else if ([[[dic objectForKey:@"status"] stringValue] isEqualToString:@"4005"]){
//                        [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//                        [[PublicTools shareInstance]creareNotificationUIView:@"手机号码已被注册过"];
//            
//                    }else if ([[[dic objectForKey:@"status"] stringValue] isEqualToString:@"4006"]){
//                        [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//                        [[PublicTools shareInstance]creareNotificationUIView:@"手机号码错误"];
//            
//                    }else if ([[[dic objectForKey:@"status"] stringValue] isEqualToString:@"4007"]){
//                        [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//                        [[PublicTools shareInstance]creareNotificationUIView:@"数据错误"];
//            
//                    }else if ([[[dic objectForKey:@"status"] stringValue] isEqualToString:@"4008"]){
//                        [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//                        [[PublicTools shareInstance]creareNotificationUIView:@"数据错误"];
//            
//                    }else if ([[[dic objectForKey:@"status"] stringValue] isEqualToString:@"4009"]){
//                        [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//                        [[PublicTools shareInstance]creareNotificationUIView:@"旧密码错误"];
//                    }else if ([[[dic objectForKey:@"status"] stringValue]isEqualToString:@"4010"]){
//                        [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//                        [[PublicTools shareInstance]creareNotificationUIView:@"用户被锁"];
//            
//                    }else if ([[[dic objectForKey:@"status"] stringValue] isEqualToString:@"5002"]){
//                        [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//                        [[PublicTools shareInstance]creareNotificationUIView:@"Icon存储错误"];
//                    }else if ([[[dic objectForKey:@"status"] stringValue] isEqualToString:@"5001"]){
//                        [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//                        [[PublicTools shareInstance]creareNotificationUIView:@"数据错误"];
//                        
//                    }
//
//            
//        }
//    }];
//
//
//    NSArray *dataarr=(NSArray *)respondataarr;
//    NSDictionary *dic=(NSDictionary *)[dataarr objectAtIndex:1];
//    if ([[dataarr objectAtIndex:0]isEqualToString:@"200"]) {
//        
//    }else{
//        if ([[[dic objectForKey:@"status"] stringValue]isEqualToString:@"4000"]) {
//            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//            [[PublicTools shareInstance]creareNotificationUIView:@"签名错误"];
//            
//        }else if ([[[dic objectForKey:@"status"] stringValue]isEqualToString:@"4001"]){
//            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//            [[PublicTools shareInstance]creareNotificationUIView:@"手机号码不存在"];
//        }else if ([[[dic objectForKey:@"status"] stringValue]isEqualToString:@"4002"]){
//            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//            [[PublicTools shareInstance]creareNotificationUIView:@"数据错误"];
//        }else if ([[[dic objectForKey:@"status"] stringValue]isEqualToString:@"4003"]){
//            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//            [[PublicTools shareInstance]creareNotificationUIView:@"要改新密码要提供旧密码"];
//            
//        }else if ([[[dic objectForKey:@"status"] stringValue]isEqualToString:@"4004"]){
//            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//            [[PublicTools shareInstance]creareNotificationUIView:@"手机号码签名错误"];
//            
//        }else if ([[[dic objectForKey:@"status"] stringValue]isEqualToString:@"4005"]){
//            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//            [[PublicTools shareInstance]creareNotificationUIView:@"手机号码已被注册过"];
//            
//        }else if ([[[dic objectForKey:@"status"] stringValue]isEqualToString:@"4006"]){
//            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//            [[PublicTools shareInstance]creareNotificationUIView:@"手机号码错误"];
//            
//        }else if ([[[dic objectForKey:@"status"] stringValue]isEqualToString:@"4007"]){
//            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//            [[PublicTools shareInstance]creareNotificationUIView:@"数据错误"];
//            
//        }else if ([[[dic objectForKey:@"status"] stringValue]isEqualToString:@"4008"]){
//            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//            [[PublicTools shareInstance]creareNotificationUIView:@"数据错误"];
//            
//        }else if ([[[dic objectForKey:@"status"] stringValue]isEqualToString:@"4009"]){
//            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//            [[PublicTools shareInstance]creareNotificationUIView:@"旧密码错误"];
//        }else if ([[[dic objectForKey:@"status"] stringValue]isEqualToString:@"4010"]){
//            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//            [[PublicTools shareInstance]creareNotificationUIView:@"用户被锁"];
//            
//        }else if ([[[dic objectForKey:@"status"] stringValue]isEqualToString:@"5002"]){
//            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//            [[PublicTools shareInstance]creareNotificationUIView:@"Icon存储错误"];
//        }else if ([[[dic objectForKey:@"status"] stringValue]isEqualToString:@"5001"]){
//            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//            [[PublicTools shareInstance]creareNotificationUIView:@"数据错误"];
//            
//        }
//        
//    }

    
    
}
-(void)newcanclebuttonaction{
    [super removeFromSuperview];
    
    
    
    
    
    
    [self.delegate controlchanagephone:codetf.text];
}
-(void)getnewcodeaction{
    NSLog(@"getcode");
    NSString *urlstring=[NSString stringWithFormat:@"protected/msisdn/verify?msisdn=%@&purpose=chno",[[NSUserDefaults standardUserDefaults]objectForKey:@"phonenum"]];
//    [[PublicTools shareInstance]GetNetWorkDataWithURLStr:urlstring theReturnBlock:^(id obj) {
//        if (obj!=nil) {
//            NSLog(@"%@",obj);
//            //  NSDictionary *dic=(NSDictionary *)obj;
//        } else {
//            [[PublicTools shareInstance]setmyPview:self];
//            [[PublicTools shareInstance]creareNotificationUIView:@"数据错误"];
//        }
//    }];
    getcodebutton.userInteractionEnabled=NO;
    i=60;
    [getcodebutton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    getcodebutton.backgroundColor=[UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    
}
-(void)newgetnewcodeaction{
     NSLog(@"new code");
    [codetf resignFirstResponder];
    [codetf1 resignFirstResponder];
    
    if (![self myisPureInt:codetf.text]||codetf.text.length!=11) {
        [[PublicTools shareInstance]setmyPview:self];
        [[PublicTools shareInstance]creareNotificationUIView:NSLocalizedString(@"enterphonenum", nil)];
    }else{
        
         NSLog(@"%@",codetf.text);
//        NSString *urlstring=[NSString stringWithFormat:@"protected/msisdn/verify?msisdn=%@&purpose=chno",codetf.text];
//        [[PublicTools shareInstance]GetNetWorkDataWithURLStr:urlstring theReturnBlock:^(id obj) {
//            if (obj!=nil) {
//                NSLog(@"%@",obj);
//                //  NSDictionary *dic=(NSDictionary *)obj;
//            } else {
//                [[PublicTools shareInstance]setmyPview:self];
//                [[PublicTools shareInstance]creareNotificationUIView:@"数据错误"];
//            }
//        }];
        getcodebutton.userInteractionEnabled=NO;
      //  i=60;
        [getcodebutton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        getcodebutton.backgroundColor=[UIColor whiteColor];
        
    newgetcodebutton.userInteractionEnabled=NO;
    j=60;
    newtimer=[NSTimer timerWithTimeInterval:1 target:self selector:@selector(newtimeraction:) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:newtimer forMode:NSDefaultRunLoopMode];
    [newgetcodebutton setTitle:[NSString stringWithFormat:@"重新获取(%zd)",60] forState:UIControlStateNormal];
   // newgetcodebutton.backgroundColor=[UIColor grayColor];
    }

}
-(void)newtimeraction:(NSTimer *)timer{
    if (j>0) {
        j--;
        
        newgetcodebutton.userInteractionEnabled=NO;
        // timelabel.text=[NSString stringWithFormat:@"%zd秒后 可重新获取验证码",i];
        [newgetcodebutton setTitle:[NSString stringWithFormat:@"重新获取(%zd)",j] forState:UIControlStateNormal];
    }else{
        newgetcodebutton.backgroundColor=KGreenColor;
        [newgetcodebutton setTitle:[NSString stringWithFormat:@"获取验证码"] forState:UIControlStateNormal];
        // timelabel.text=@"请点击重新获取验证码";
        newgetcodebutton.userInteractionEnabled=YES;
        
    }
}
-(void)timeraction:(NSTimer *)timer{
    
    if (i>0) {
        i--;
        
        getcodebutton.userInteractionEnabled=NO;
       // timelabel.text=[NSString stringWithFormat:@"%zd秒后 可重新获取验证码",i];
        [getcodebutton setTitle:[NSString stringWithFormat:@"重新获取(%zd)",i] forState:UIControlStateNormal];
    }else{
        getcodebutton.backgroundColor=KGreenColor;
        [getcodebutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
      [getcodebutton setTitle:[NSString stringWithFormat:@"获取验证码"] forState:UIControlStateNormal];
       // timelabel.text=@"请点击重新获取验证码";
        getcodebutton.userInteractionEnabled=YES;
        
    }
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)surebuttonaction{
   if (codetf2.text.length<6||codetf2.text.length>16) {
            UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:nil message:@"输入密码的长度不对,请输入：6-16位数的密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertview show];
        } else {
           // NSLog(@"1:%@  2%@:",codetf1.text,codetf2.text);
            if (![codetf1.text isEqualToString:codetf2.text]) {
                UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:nil message:@"两次密码不一样" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertview show];
            }else{
                NSMutableDictionary *userinfodic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:codetf2.text,@"new-password",codetf.text,@"old-password", nil];
                //NSLog(@"%@",dic);
                //NSLog(@"%@",self.pimg);
                   NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:userinfodic,@"user-info",nil];
//                [[PublicTools shareInstance]PostNetWorkDataWithURLStr:@"private/user/update" whitdic:dic theReturnBlock:^(id respondataarr) {
//                    //        if (respondata==nil) {
//                    //            [self.navigationController popToRootViewControllerAnimated:YES];
//                    //        }
//                   // NSLog(@"%@",respondataarr);
//                    
//                    NSArray *dataarr=(NSArray *)respondataarr;
//                    
//                    if ([[[dataarr objectAtIndex:0] stringValue]isEqualToString:@"200"]) {
//                        
//                        [self.delegate controlchanagepassWord];
//                        [self removeFromSuperview];
//
//                        
//                    }else{
//                   
//                    }
//
//                    
//                }];
                
                
           }
    }
}
- (BOOL)myisPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}
@end
