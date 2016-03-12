//
//  IMDataService.m
//  CYS
//
//  Created by 谢阳晴 on 16/1/26.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import "IMDataService.h"

@implementation IMDataService


+(void)getGroupDetailsWithPatientID:(NSString *)Patientid teamId:(NSString *)teamid block:(ResponseBlock)block{
    
    NSString *suburlstr=@"private/doctor/team/im/initiate?";
    
    NSString *urlstr=[NSString stringWithFormat:@"%@team_id=%@&patient_id=%@",suburlstr,teamid,Patientid];
    NSLog(@"%@",urlstr);
    [[BaseDataService shareInstance]PostNetWorkJSONWithURLStr:urlstr whitdic:nil theReturnBlock:^(id respondataarr) {
        
        
        NSDictionary *resultdic=(NSDictionary *)[respondataarr objectAtIndex:1];
       
        if([[resultdic objectForKey:@"code"] intValue]==2000){
            
           
              block([resultdic objectForKey:@"result"]);
            
            
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
            [[PublicTools shareInstance]creareNotificationUIView:@"用户不存在"];
        }else if([[resultdic objectForKey:@"code"] intValue]==4001){
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"用户信息有误"];
        }else if([[resultdic objectForKey:@"code"] intValue]==4005){
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"用户已存在"];
        }else if([[resultdic objectForKey:@"code"] intValue]==4012){
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"该团队名字已被使用"];
        }else if([[resultdic objectForKey:@"code"] intValue]==4012){
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"您没有权限执行此操作"];
        }
    }];

    
}
+(void)getListinggroupsForteamWithteamId:(NSString *)teamid block:(ResponseBlock)block{
    NSString *urlstr=[NSString stringWithFormat:@"private/doctor/team/im/groups?team_id=%@",teamid];
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
+(void)getListingIMInfofortargetIdWithtargetId:(NSString *)targetId block:(ResponseBlock)block{
    NSString *urlstr=[NSString stringWithFormat:@"private/im/info?im_id=%@",targetId];
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

+(void)getPersonalIMInfofortargetIdWithpatientId:(NSString *)patientId block:(ResponseBlock)block{
   
    ////private/doctor/im/initiate?patient_id=
   // NSString *suburlstr=@"private/doctor/team/im/initiate?";
    
    NSString *urlstr=[NSString stringWithFormat:@"private/doctor/im/initiate?patient_id=%@",patientId];
    
    [[BaseDataService shareInstance]PostNetWorkJSONWithURLStr:urlstr whitdic:nil theReturnBlock:^(id respondataarr) {
        
        
        NSDictionary *resultdic=(NSDictionary *)[respondataarr objectAtIndex:1];
        
        if([[resultdic objectForKey:@"code"] intValue]==2000){
            
            
            block([resultdic objectForKey:@"result"]);
            
            
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
            [[PublicTools shareInstance]creareNotificationUIView:@"用户不存在"];
        }else if([[resultdic objectForKey:@"code"] intValue]==4001){
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"用户信息有误"];
        }else if([[resultdic objectForKey:@"code"] intValue]==4005){
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"用户已存在"];
        }else if([[resultdic objectForKey:@"code"] intValue]==4012){
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"该团队名字已被使用"];
        }else if([[resultdic objectForKey:@"code"] intValue]==4012){
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"您没有权限执行此操作"];
        }
    }];

    
    
    
}


@end
