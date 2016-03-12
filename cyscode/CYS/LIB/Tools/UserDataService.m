//
//  UserDataService.m
//  CYS
//
//  Created by 谢阳晴 on 16/1/26.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import "UserDataService.h"
#import "UIImageView+AFNetworking.h"


@implementation UserDataService

+(void)getUserInfofortargetIdWithtargetId:(NSString *)targetId block:(ResponseBlock)block{
    
   NSArray *usermodelarr =[[UserDB shareInstance]findUsersWithTargetid:targetId];
    UserInfoModel *userinfomodel=[[UserInfoModel alloc ]init];
    if (usermodelarr.count>0) {
       UserModel *usermodel=[usermodelarr objectAtIndex:0];
        
        NSData *JSONData = [usermodel.userinfocontent dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
        userinfomodel.targetid=targetId;
        userinfomodel.pimgurl=[dic objectForKey:@"icon_url"];
        userinfomodel.username=[dic objectForKey:@"name"];
        
        block(userinfomodel);
        
    }else{
      [IMDataService getListingIMInfofortargetIdWithtargetId:targetId block:^(id userdic) {
        
          userinfomodel.targetid=targetId;
          
          NSDictionary *dic=(NSDictionary *)userdic;
        
          
         userinfomodel.pimgurl=[dic objectForKey:@"icon_url"];
         userinfomodel.username=[dic objectForKey:@"name"];
          
           UserModel *usermodel=[[UserModel alloc]init];
          
          NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
          
          NSString *contentstring=[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
          usermodel.targetid=targetId;
          usermodel.userinfocontent=contentstring;
          [[UserDB shareInstance]addUser:usermodel];
        
          block(userinfomodel);
          
      }];
    }
    
}



+(void)getGroupInfofortargetIdWithGroupId:(NSString *)groupId block:(ResponseBlock)block{
    
    NSArray *usermodelarr =[[UserDB shareInstance]findUsersWithTargetid:groupId];
    GroupInfoModel *userinfomodel=[[GroupInfoModel alloc ]init];
    if (usermodelarr.count>0) {
        UserModel *usermodel=[usermodelarr objectAtIndex:0];
        
        NSData *JSONData = [usermodel.userinfocontent dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
        userinfomodel.targetid=groupId;
        userinfomodel.pimgurl=[dic objectForKey:@"icon_url"];
        userinfomodel.username=[NSString stringWithFormat:@"%@",[[dic objectForKey:@"patient"] objectForKey:@"name"]];
        userinfomodel.groupinfodic=dic;
        NSLog(@"name:%@",dic);
        block(userinfomodel);
        
    }else{
        [DocTeamDataService getGroupinfoWithGroupId:groupId block:^(id userdic) {
            userinfomodel.targetid=groupId;
            
            NSDictionary *dic=(NSDictionary *)userdic;
            
             NSLog(@"name:%@",dic);
            userinfomodel.pimgurl=[dic objectForKey:@"icon_url"];
            userinfomodel.username=[NSString stringWithFormat:@"%@",[[dic objectForKey:@"patient"] objectForKey:@"name"]];
            userinfomodel.groupinfodic=dic;
            UserModel *usermodel=[[UserModel alloc]init];
            
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
            
            NSString *contentstring=[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            usermodel.targetid=groupId;
            usermodel.userinfocontent=contentstring;
            [[UserDB shareInstance]addUser:usermodel];
            
            block(userinfomodel);
            
        }];
    }
    

    
}


+(void)getDocInfoWithDocId:(NSString *)coderesult block:(ResponseBlock)block{
    NSString *urlstr=[NSString stringWithFormat:@"private/doctor/byqrcode?url_in_qr=%@",coderesult];
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
+(void)getSelfInfoWithblock:(ResponseBlock)block{
    NSString *urlstr=[NSString stringWithFormat:@"private/doctor/details"];
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

@end
