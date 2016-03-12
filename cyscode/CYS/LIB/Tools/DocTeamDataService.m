//
//  DocTeamDataService.m
//  CYS
//
//  Created by 谢阳晴 on 15/12/31.
//  Copyright © 2015年 谢阳晴. All rights reserved.
//

#import "DocTeamDataService.h"


@implementation DocTeamDataService


+(void)foundDocTeamName:(NSString *)name descStr:(NSString *)descstr block:(ResponseBlock)block{
   
    NSMutableDictionary *infodic=[[NSMutableDictionary alloc]init];
    [infodic setValue:name forKey:@"name"];
    [infodic setValue:descstr forKey:@"description"];
    
    NSString *urlstr=@"private/doctor/team/";
//    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"token"]) {
//        urlstr=@"private/app_ins/register";
//    }else{
//        urlstr=@"protected/app_ins/register";
//    }
    NSLog(@"%@",infodic);
    [[BaseDataService shareInstance] PostNetWorkJSONWithURLStr:urlstr whitdic:infodic theReturnBlock:^(id respondataarr) {
        NSDictionary *resultdic=(NSDictionary *)[respondataarr objectAtIndex:1];
        NSLog(@"%@",resultdic);
        if([[resultdic objectForKey:@"code"] intValue]==2000){
            
//            if ([[NSUserDefaults standardUserDefaults]objectForKey:@"token"]) {
//                block([resultdic objectForKey:@"result"]);
//            }else{
//                block(resultdic);
//            }
            
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
        }else if([[resultdic objectForKey:@"code"] intValue]==4445){
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"您暂无权限执行此操作"];
        }
    }];
    
}
+(void)deleteDocTeamWithId:(NSString *)teamid block:(ResponseBlock)block{
    
    
    NSString *suburlstr=@"private/doctor/team/delete/";
    NSString *urlstr=[NSString stringWithFormat:@"%@%@",suburlstr,teamid];
    //    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"token"]) {
    //        urlstr=@"private/app_ins/register";
    //    }else{
    //        urlstr=@"protected/app_ins/register";
    //    }
  NSLog(@"%@",urlstr);
    
//    [[BaseDataService shareInstance] GetNetWorkDataWithURLStr:urlstr theReturnBlock:^(id respondataarr) {
//        NSDictionary *resultdic=(NSDictionary *)[respondataarr objectAtIndex:1];
//        NSLog(@"%@",resultdic);
//        if([[resultdic objectForKey:@"code"] intValue]==2000){
//            
//            
//            block([resultdic objectForKey:@"result"]);
//            
//            
//        }else if([[resultdic objectForKey:@"code"] intValue]==4002){
//            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//            [[PublicTools shareInstance]creareNotificationUIView:@"验证码错误"];
//            
//        }else if([[resultdic objectForKey:@"code"] intValue]==4001){
//            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//            [[PublicTools shareInstance]creareNotificationUIView:@"手机号有误"];
//            
//        }else if([[resultdic objectForKey:@"code"] intValue]==4000){
//            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//            [[PublicTools shareInstance]creareNotificationUIView:@"加密错误"];
//            
//        }else if([[resultdic objectForKey:@"code"] intValue]==4010){
//            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//            [[PublicTools shareInstance]creareNotificationUIView:@" 用户锁定"];
//        }else if([[resultdic objectForKey:@"code"] intValue]==4005){
//            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//            [[PublicTools shareInstance]creareNotificationUIView:@"用户已存在"];
//        }else if([[resultdic objectForKey:@"code"] intValue]==4012){
//            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//            [[PublicTools shareInstance]creareNotificationUIView:@"您没有权限执行此操作"];
//        }
//        
//        
//    }];

    
    [[BaseDataService shareInstance] PostNetWorkJSONWithURLStr:urlstr whitdic:nil theReturnBlock:^(id respondataarr) {
        NSDictionary *resultdic=(NSDictionary *)[respondataarr objectAtIndex:1];
        NSLog(@"%@",resultdic);
        if([[resultdic objectForKey:@"code"] intValue]==2000){
            
            //            if ([[NSUserDefaults standardUserDefaults]objectForKey:@"token"]) {
            //                block([resultdic objectForKey:@"result"]);
            //            }else{
            //                block(resultdic);
            //            }
            
            block(resultdic);
            
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
+(void)getDocAllTeamblock:(ResponseBlock)block{
   
    NSString *urlstr=@"private/doctor/team/owned";
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
        }else if([[resultdic objectForKey:@"code"] intValue]==4445){
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"您暂无权限执行此操作"];
        }
        
        
    }];
}
+(void)getDocArrWithName:(NSString *)name pageNum:(NSInteger)pagenum block:(ResponseBlock)block{
    NSString *urlstr=[NSString stringWithFormat:@"private/doctor/?name=%@&page_num=%zd&page_size=20",name,pagenum];
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

+(void)invitedoctorWithdocID:(NSString *)docid teamId:(NSString *)teamid block:(ResponseBlock)block{
    NSString *suburlstr=@"private/doctor/team/invitation?";
    NSString *urlstr=[NSString stringWithFormat:@"%@team_id=%@&doctor_id=%@",suburlstr,teamid,docid];
    NSLog(@"%@",urlstr);
       [[BaseDataService shareInstance] PostNetWorkJSONWithURLStr:urlstr whitdic:nil theReturnBlock:^(id respondataarr) {
        NSDictionary *resultdic=(NSDictionary *)[respondataarr objectAtIndex:1];
        NSLog(@"%@",resultdic);
        if([[resultdic objectForKey:@"code"] intValue]==2000){
            
            block(resultdic);
            
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
+(void)getAllparticipatedTeamblock:(ResponseBlock)block{
   
    NSString *urlstr=@"private/doctor/team/participated";
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
        }else if([[resultdic objectForKey:@"code"] intValue]==4445){
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"您暂无权限执行此操作"];
        }
        
        
    }];
}
+(void)getAllInvitationsblock:(ResponseBlock)block{
    
     NSString *urlstr=@"private/doctor/team/invitation";
  //  NSLog(@"%@",urlstr);
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
+(void)getTeamMembersWithteamId:(NSString *)teamid block:(ResponseBlock)block{
  //  http://localhost:8080/api/private/doctor/team/3f7b63d8-1176-47b7-b9ee-e4b8a13eaff6/
    NSString *suburlstr=@"private/doctor/team/";
    NSString *urlstr=[NSString stringWithFormat:@"%@%@/",suburlstr,teamid];
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

+(void)docconfirminginvitationWithteamId:(NSString *)teamid  block:(ResponseBlock)block{
    NSString *suburlstr=@"private/doctor/team/invitation/confirm?team_id=";
    NSString *urlstr=[NSString stringWithFormat:@"%@%@",suburlstr,teamid];
    NSLog(@"%@",urlstr);
    [[BaseDataService shareInstance] PostNetWorkJSONWithURLStr:urlstr whitdic:nil theReturnBlock:^(id respondataarr) {
        NSDictionary *resultdic=(NSDictionary *)[respondataarr objectAtIndex:1];
        NSLog(@"%@",resultdic);
        if([[resultdic objectForKey:@"code"] intValue]==2000){
            
            block(resultdic);
            
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


+(void)deletingdoctorsfromteamWithteamId:(NSString *)teamid doctors:(NSMutableArray *)doctors block:(ResponseBlock)block;{
    //private/doctor/team/9256ab27-6639-461b-936d-87d56386fa0a/doctors/delete
    NSString *suburlstr=@"private/doctor/team/";
    NSString *urlstr=[NSString stringWithFormat:@"%@%@/doctors/delete",suburlstr,teamid];
    NSLog(@"%@",urlstr);
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:doctors,@"ids", nil];
    
    [[BaseDataService shareInstance]PostNetWorkJSONWithURLStr:urlstr whitdic:dic theReturnBlock:^(id respondataarr) {
  

        NSDictionary *resultdic=(NSDictionary *)[respondataarr objectAtIndex:1];
        NSLog(@"%@",resultdic);
        if([[resultdic objectForKey:@"code"] intValue]==2000){
            
            block(resultdic);
            
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
+(void)quitfromteamWithteamId:(NSString *)teamid block:(ResponseBlock)block{
    NSString *suburlstr=@"private/doctor/team/";
    NSString *urlstr=[NSString stringWithFormat:@"%@%@/doctors/quit",suburlstr,teamid];
    NSLog(@"%@",urlstr);
    [[BaseDataService shareInstance] PostNetWorkJSONWithURLStr:urlstr whitdic:nil theReturnBlock:^(id respondataarr) {
        NSDictionary *resultdic=(NSDictionary *)[respondataarr objectAtIndex:1];
        NSLog(@"%@",resultdic);
        if([[resultdic objectForKey:@"code"] intValue]==2000){
            
            block(resultdic);
            
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

+(void)getGroupinfoWithGroupId:(NSString *)groupId block:(ResponseBlock)block{
    
   // NSString *suburlstr=@"private/im/group?group_id=";
    NSString *urlstr=[NSString stringWithFormat:@"private/im/group?group_id=%@",groupId];
  //  NSLog(@"%@",urlstr);
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

+(void)UpdateGroupNameWithteamId:(NSString *)teamId name:(NSString *)namestr block:(ResponseBlock)block{
    NSMutableDictionary *infodic=[[NSMutableDictionary alloc]init];
    [infodic setValue:namestr forKey:@"name"];
    [infodic setValue:@"" forKey:@"description"];
    [infodic setValue:teamId forKey:@"id"];
    
    NSString *urlstr=@"private/doctor/team/";
    //    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"token"]) {
    //        urlstr=@"private/app_ins/register";
    //    }else{
    //        urlstr=@"protected/app_ins/register";
    //    }
    NSLog(@"%@",infodic);
    [[BaseDataService shareInstance] PostNetWorkJSONWithURLStr:urlstr whitdic:infodic theReturnBlock:^(id respondataarr) {
        NSDictionary *resultdic=(NSDictionary *)[respondataarr objectAtIndex:1];
        NSLog(@"%@",resultdic);
        if([[resultdic objectForKey:@"code"] intValue]==2000){
            
            //            if ([[NSUserDefaults standardUserDefaults]objectForKey:@"token"]) {
            //                block([resultdic objectForKey:@"result"]);
            //            }else{
            //                block(resultdic);
            //            }
            
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
        }
    }];

}

+(void)getBarCodeShareinfoblock:(ResponseBlock)block{
    NSString *urlstr=[NSString stringWithFormat:@"private/doctor/wxinvitedoctor"];
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

+(void)spamMsgTopatients:(NSArray *)patients msg:(NSString *)msgstr block:(ResponseBlock)block{
    
    
    NSDictionary *msgdic=[[NSDictionary alloc]initWithObjectsAndKeys:msgstr,@"text", nil];
    
    NSMutableArray *recipients=[[NSMutableArray alloc]init];
    for (NSDictionary *tmpdic in patients) {
        [recipients addObject:[tmpdic objectForKey:@"id"]];
    }
    
    
    NSMutableDictionary *infodic=[[NSMutableDictionary alloc]init];
    [infodic setValue:recipients forKey:@"recipients"];
    [infodic setValue:msgdic forKey:@"text_msg"];
    
    NSString *urlstr=@"private/doctor/im/publish";
       NSLog(@"%@",infodic);
    [[BaseDataService shareInstance] PostNetWorkJSONWithURLStr:urlstr whitdic:infodic theReturnBlock:^(id respondataarr) {
        NSDictionary *resultdic=(NSDictionary *)[respondataarr objectAtIndex:1];
        NSLog(@"%@",resultdic);
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
        }
    }];
    
}


@end
