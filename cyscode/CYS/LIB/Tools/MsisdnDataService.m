//
//  MsisdnDataService.m
//  CYS
//
//  Created by 谢阳晴 on 15/12/14.
//  Copyright © 2015年 谢阳晴. All rights reserved.
//

#import "MsisdnDataService.h"

#define GETCAPTCHAURL @"protected/msisdn/verify"

#define VERFYCAPTCHAURL @"protected/msisdn/verify-code"



@implementation MsisdnDataService


+(void)getCaptchaCodeWithMsisdn:(NSString *)msisdn type:(NSInteger)type block:(ResponseBlock)block{
    
    NSString *urlstr=[[NSString alloc]init];
    if (type==0) {
        urlstr=[[NSString alloc]initWithFormat:@"%@?msisdn=%@&purpose=%@",GETCAPTCHAURL,msisdn,@"reg"];
    }else if (type==1){
        urlstr=[[NSString alloc]initWithFormat:@"%@?msisdn=%@&purpose=%@",GETCAPTCHAURL,msisdn,@"forgot"];
    }else if (type==2){
        urlstr=[[NSString alloc]initWithFormat:@"%@?msisdn=%@&purpose=%@",GETCAPTCHAURL,msisdn,@"chno"];
    }
    NSLog(@"%@",urlstr);
    [[BaseDataService shareInstance] GetNetWorkDataWithURLStr:urlstr theReturnBlock:^(id respondataarr) {
        NSArray *myarr=(NSArray *)respondataarr;
        if (myarr.count>1) {
            
            NSDictionary *resultdic=(NSDictionary *)[respondataarr objectAtIndex:1];
            if([[resultdic objectForKey:@"code"] intValue]==2000){
                NSLog(@"%@",resultdic);
                block(resultdic);
            }else if([[resultdic objectForKey:@"code"] intValue]==4001){
                [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
                [[PublicTools shareInstance]creareNotificationUIView:@"您输入的手机号有误"];
                
            }else if([[resultdic objectForKey:@"code"] intValue]==4024){
                [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
                [[PublicTools shareInstance]creareNotificationUIView:@"该手机号尚未注册"];
                
            }else if([[resultdic objectForKey:@"code"] intValue]==4000){
                [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
                [[PublicTools shareInstance]creareNotificationUIView:@"加密错误"];
                
            }else if([[resultdic objectForKey:@"code"] intValue]==4010){
                [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
                [[PublicTools shareInstance]creareNotificationUIView:@" 用户锁定"];
            }else if([[resultdic objectForKey:@"code"] intValue]==4005){
                [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
                [[PublicTools shareInstance]creareNotificationUIView:@"用户已存在"];
            }

        }else{
                block(@"ok");
        }
        

    }];
    
   
}
+(void)verfyCaptchaCodeWithMsisdn:(NSString *)msisdn captcha:(NSString *)captcha block:(ResponseBlock)block{
    
    
     NSString *urlstr=[[NSString alloc]initWithFormat:@"%@?msisdn=%@&code=%@",VERFYCAPTCHAURL,msisdn,captcha];
    NSLog(@"%@",urlstr);
    [[BaseDataService shareInstance] GetNetWorkDataWithURLStr:urlstr theReturnBlock:^(id respondataarr) {
        NSDictionary *resultdic=(NSDictionary *)[respondataarr objectAtIndex:1];
        if([[resultdic objectForKey:@"code"] intValue]==2000){
            block([resultdic objectForKey:@"result"]);
        }else if([[resultdic objectForKey:@"code"] intValue]==4002){
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"验证码错误"];
            
        }else if([[resultdic objectForKey:@"code"] intValue]==4001){
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"手机号有误"];
            
        }else if([[resultdic objectForKey:@"code"] intValue]==4000){
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"加密错误"];
            
        }else if([[resultdic objectForKey:@"code"] intValue]==4010){
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@" 用户锁定"];
        }else if([[resultdic objectForKey:@"code"] intValue]==4005){
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"用户已存在"];
        }
        
        
    }];

}
+(void)dealForgotPasswordWithMsisdn:(NSString *)msisdn signature:(NSString *)signature password:(NSString *)password type:(NSInteger)type block:(ResponseBlock)block{
   
     NSMutableDictionary *userinfodic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:password,@"password",signature,@"signature",msisdn,@"msisdn",@"DOCTOR",@"type", nil];
    
     NSString *urlstr=[[NSString alloc]init];
    if (type==0) {
       urlstr=@"protected/user/register";
    }else{
       urlstr=@"protected/user/forgot-password";
    }
    NSLog(@"%@",userinfodic);
    [[BaseDataService shareInstance] PostNetWorkJSONWithURLStr:urlstr whitdic:userinfodic theReturnBlock:^(id respondataarr) {
        NSDictionary *resultdic=(NSDictionary *)[respondataarr objectAtIndex:1];
        
        if([[resultdic objectForKey:@"code"] intValue]==2000){
            
            if (type==0) {
              block([resultdic objectForKey:@"result"]);
            }else{
              block(resultdic);
            }
            
        }else if([[resultdic objectForKey:@"code"] intValue]==4003){
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"输入错误"];
            
        }else if([[resultdic objectForKey:@"code"] intValue]==4004){
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"签名错误"];
            
        }else if([[resultdic objectForKey:@"code"] intValue]==4000){
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"加密错误"];
            
        }else if([[resultdic objectForKey:@"code"] intValue]==4010){
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"用户锁定"];
        }else if([[resultdic objectForKey:@"code"] intValue]==4001){
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"用户不存在"];
        }else if([[resultdic objectForKey:@"code"] intValue]==4005){
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"该手机号已注册"];
        }
    }];

    
    
}

@end
