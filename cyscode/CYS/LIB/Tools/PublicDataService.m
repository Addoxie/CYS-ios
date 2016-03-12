//
//  PublicDataService.m
//  CYS
//
//  Created by 谢阳晴 on 16/2/3.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import "PublicDataService.h"

@implementation PublicDataService
+(void)getHomePageInfoblock:(ResponseBlock)block{
    NSString *urlstr=[NSString stringWithFormat:@"private/doctor/patient/stats"];
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
+(void)getHomePageBannerblock:(ResponseBlock)block{
    NSString *urlstr=[NSString stringWithFormat:@"public/banner/config"];
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


+(void)getHomePageOutCallInfoblock:(ResponseBlock)block{
    
}

@end
