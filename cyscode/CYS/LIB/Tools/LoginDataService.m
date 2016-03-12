//
//  LoginDataService.m
//  ChatDemo-UI3.0
//
//  Created by 谢阳晴 on 15/12/9.
//  Copyright © 2015年 谢阳晴. All rights reserved.
//

#import "LoginDataService.h"

#define LOGINURL @"protected/user/login"
#define REGURL @"protected/user/register"
//http://localhost:8080/api/protected/user/register

@implementation LoginDataService

+(void)loginWithUsername:(NSString *)username password:(NSString *)password block:(ResponseBlock)block{
    NSMutableDictionary *userinfodic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:username,@"msisdn",password,@"password",@"DOCTOR",@"type", nil];
  
    [[BaseDataService shareInstance] PostNetWorkJSONWithURLStr:LOGINURL whitdic:userinfodic theReturnBlock:^(id respondataarr) {
        NSDictionary *resultdic=(NSDictionary *)[respondataarr objectAtIndex:1];
        
        if([[resultdic objectForKey:@"code"] intValue]==2000){
            block([resultdic objectForKey:@"result"]);
        }else if([[resultdic objectForKey:@"code"] intValue]==4003){
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"输入错误"];

        }else if([[resultdic objectForKey:@"code"] intValue]==4006){
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"无效的账户或者密码"];

        }else if([[resultdic objectForKey:@"code"] intValue]==4000){
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"加密错误"];

        }else if([[resultdic objectForKey:@"code"] intValue]==4010){
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@" 用户锁定"];
        }
        
        
        
    }];
}
+(void)regWithUsername:(NSString *)username password:(NSString *)password signature:(NSString *)signature block:(ResponseBlock)block{
    NSMutableDictionary *userinfodic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:username,@"msisdn",password,@"password",signature,@"signature",nil];
    
    [[BaseDataService shareInstance] PostNetWorkJSONWithURLStr:REGURL whitdic:userinfodic theReturnBlock:^(id respondataarr) {
        NSDictionary *resultdic=(NSDictionary *)[respondataarr objectAtIndex:1];
        
        if([[resultdic objectForKey:@"code"] intValue]==2000){
            block([resultdic objectForKey:@"result"]);
        }else if([[resultdic objectForKey:@"code"] intValue]==4003){
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"输入错误"];
            
        }else if([[resultdic objectForKey:@"code"] intValue]==4006){
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"密码或者账号错误"];
            
        }else if([[resultdic objectForKey:@"code"] intValue]==4000){
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"加密错误"];
            
        }else if([[resultdic objectForKey:@"code"] intValue]==4010){
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@" 用户锁定"];
        }
        
        
        
    }];
}
+(void)getSelfIMInfoblock:(ResponseBlock)block{
    NSString *urlstr=[NSString stringWithFormat:@"private/im/self"];
    NSLog(@"%@",urlstr);
    [[BaseDataService shareInstance] GetNetWorkDataWithURLStr:urlstr theReturnBlock:^(id respondataarr) {
        NSDictionary *resultdic=(NSDictionary *)[respondataarr objectAtIndex:1];
        NSLog(@"%@",resultdic);
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
+(void)getNewSelfIMInfoblock:(ResponseBlock)block{
    NSString *urlstr=[NSString stringWithFormat:@"private/im/self?refresh=true "];
    NSLog(@"%@",urlstr);
    [[BaseDataService shareInstance] GetNetWorkDataWithURLStr:urlstr theReturnBlock:^(id respondataarr) {
        NSDictionary *resultdic=(NSDictionary *)[respondataarr objectAtIndex:1];
        NSLog(@"%@",resultdic);
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

+(void)updatingusermsisdnWitholdmask:(NSString *)oldmask newmask:(NSString *)newmask msisdn:(NSString *)msisdn block:(ResponseBlock)block{
   
    
   // NSString *suburlstr=@"public/order/test/patientdoctor?";
    
    NSString *urlstr=[NSString stringWithFormat:@"%@",@"private/user/update"];
    
    NSMutableDictionary *userinfodic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:msisdn,@"new-msisdn",oldmask,@"old-msisdn-signature",newmask,@"new-msisdn-signature",nil];
    
    [[BaseDataService shareInstance] PostNetWorkJSONWithURLStr:urlstr whitdic:userinfodic theReturnBlock:^(id respondataarr) {
        NSDictionary *resultdic=(NSDictionary *)[respondataarr objectAtIndex:1];
        NSLog(@"%@",respondataarr);
        if([[resultdic objectForKey:@"code"] intValue]==2000){
            block([resultdic objectForKey:@"result"]);
        }else if([[resultdic objectForKey:@"code"] intValue]==4003){
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"输入错误"];
            
        }else if([[resultdic objectForKey:@"code"] intValue]==4006){
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"密码或者账号错误"];
            
        }else if([[resultdic objectForKey:@"code"] intValue]==4000){
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"加密错误"];
            
        }else if([[resultdic objectForKey:@"code"] intValue]==4010){
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@" 用户锁定"];
        }else{
          block(@"OK");
        }
        
        
        
    }];

}
+(void)updatinguserpasswordWitholdpw:(NSString *)oldpw newpw:(NSString *)newpw block:(ResponseBlock)block{
    
    
    NSString *urlstr=[NSString stringWithFormat:@"%@",@"private/user/update"];
    
    NSMutableDictionary *userinfodic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:oldpw,@"old-password",newpw,@"new-password",nil];
    
    
    
    
    
    [[BaseDataService shareInstance] PostNetWorkJSONWithURLStr:urlstr whitdic:userinfodic theReturnBlock:^(id respondataarr) {
        NSDictionary *resultdic=(NSDictionary *)[respondataarr objectAtIndex:1];
        
        if([[resultdic objectForKey:@"code"] intValue]==2000){
            block([resultdic objectForKey:@"result"]);
        }else if([[resultdic objectForKey:@"code"] intValue]==4003){
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"输入错误"];
            
        }else if([[resultdic objectForKey:@"code"] intValue]==4006){
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"旧密码错误"];
            
        }else if([[resultdic objectForKey:@"code"] intValue]==4000){
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"加密错误"];
            
        }else if([[resultdic objectForKey:@"code"] intValue]==4010){
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@" 用户锁定"];
        }
        
        
        
    }];
    

}

@end
