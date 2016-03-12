//
//  OrderDataService.m
//  CYS
//
//  Created by 谢阳晴 on 16/1/26.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import "OrderDataService.h"

@implementation OrderDataService
+(void)getAllOrderCountblock:(ResponseBlock)block{
    
    NSString *urlstr=[NSString stringWithFormat:@"private/order/countnew"];
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

+(void)CreateorderWithPatientID:(NSString *)Patientid doctorId:(NSString *)doctorId block:(ResponseBlock)block{
    
    NSString *suburlstr=@"public/order/test/patientdoctor?";
    
    NSString *urlstr=[NSString stringWithFormat:@"%@patient_id=%@&doctor_id=%@",suburlstr,Patientid,@"42e825cb-e2c8-4ba2-9710-e17fcaa4f021"];
    
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
+(void)getOrderDetailListWithServicetype:(NSInteger)type Statu:(NSInteger)statu block:(ResponseBlock)block{
    //http://localhost:8080/api/private/order/?service_type=0&status=1
    
    NSString *urlstr=[NSString stringWithFormat:@"private/order/?service_type=%zd&status=%zd",type,statu];
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
+(void)getALLOrderDetailListWithServicetype:(NSInteger)type block:(ResponseBlock)block{
    NSString *urlstr=[NSString stringWithFormat:@"private/order/?service_type=%zd",type];
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
+(void)setServicePriceWithServicetype:(NSString *)typestr price:(NSString *)pricestr status:(NSString *)statusstr block:(ResponseBlock)block{
    NSString *urlstr=[NSString stringWithFormat:@"%@",@"private/service/"];
    
    NSMutableDictionary *userinfodic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:pricestr,@"price",statusstr,@"status",typestr,@"service_type",nil];
    
    
    
    
    
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
        }else if([[resultdic objectForKey:@"code"] intValue]==4445){
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"您暂无权限执行此操作"];
        }
        
        
        
    }];

    
}
+(void)setFreeServicefreeperiod:(NSString *)free_period block:(ResponseBlock)block{
    NSString *urlstr=[NSString stringWithFormat:@"%@",@"private/service/"];
    
    NSMutableDictionary *userinfodic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:free_period,@"free_period",nil];
    
    
    
    
    
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
        }else if([[resultdic objectForKey:@"code"] intValue]==4445){
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"您暂无权限执行此操作"];
        }
        
        
        
    }];
    

}
+(void)getServiceDetailWithServicetype:(NSString *)typestr block:(ResponseBlock)block{
    NSString *urlstr=[NSString stringWithFormat:@"private/service/?service_type=%@",typestr];
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
+(void)getAllServiceConfigsblock:(ResponseBlock)block{
    NSString *urlstr=[NSString stringWithFormat:@"private/service/config"];
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

@end
