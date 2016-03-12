//
//  PatientDataService.m
//  CYS
//
//  Created by 谢阳晴 on 16/1/8.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import "PatientDataService.h"

@implementation PatientDataService


+(void)getPatientArrWithName:(NSString *)name pageNum:(NSInteger)pagenum block:(ResponseBlock)block{
   
    NSString *urlstr=[NSString stringWithFormat:@"private/doctor/patient/?name=%@&page_num=%zd&page_size=20",name,pagenum];
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


+(void)getallPatientsblock:(ResponseBlock)block{
   //total_records
    NSString *urlstr=[NSString stringWithFormat:@"private/doctor/patient/?name=""&page_num=%zd&page_size=1",0];
   // NSLog(@"%@",urlstr);
    [[BaseDataService shareInstance] GetNetWorkDataWithURLStr:urlstr theReturnBlock:^(id respondataarr) {
        NSDictionary *resultdic=(NSDictionary *)[respondataarr objectAtIndex:1];
        NSLog(@"%@",resultdic);
        if([[resultdic objectForKey:@"code"] intValue]==2000){
            
            
            NSString *urlstr1=[NSString stringWithFormat:@"private/doctor/patient/?name=""&page_num=%zd&page_size=%@",0,[[resultdic objectForKey:@"result"] objectForKey:@"total_records"]];
            // NSLog(@"%@",urlstr);
            [[BaseDataService shareInstance] GetNetWorkDataWithURLStr:urlstr1 theReturnBlock:^(id respondataarr1) {
                NSDictionary *resultdic1=(NSDictionary *)[respondataarr1 objectAtIndex:1];
                block([resultdic1 objectForKey:@"result"]);
                
            }];
            
            
           // block([resultdic objectForKey:@"result"]);
            
            
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

+(void)invitePatientWithPatientID:(NSMutableArray *)Patients teamId:(NSString *)teamid block:(ResponseBlock)block{
    
    
    //http://localhost:8080/api/private/doctor/team/f7109a20-1dee-436e-b8a3-60a82afaf868/patient
    NSString *suburlstr=@"private/doctor/team/";
    NSString *urlstr=[NSString stringWithFormat:@"%@%@/patient",suburlstr,teamid];
    NSLog(@"%@",urlstr);
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:Patients,@"ids", nil];
    
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

+(void)getTeamPatientsWithteamId:(NSString *)teamid pageNum:(NSInteger)pagenum block:(ResponseBlock)block{
    
   // http://localhost:8080/api/private/doctor/team/f7109a20-1dee-436e-b8a3-60a82afaf868/patient?page_num=0&page_size=10
    NSString *urlstr=[NSString stringWithFormat:@"private/doctor/team/%@/patient?page_num=%zd&page_size=200000",teamid,pagenum];
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

+(void)invitePatientToDoctorPatientId:(NSString *)PatientId doctor:(NSString *)doctorID block:(ResponseBlock)block{
    //http://localhost:8080/api/public/patient/test/addtodoctor?patient_id=2a4717a0-1b8a-4fc7-b677-25db0079f6fc&doctor_id=eb4cca3c-8cc6-4d1b-a824-31106666abc5
    NSString *suburlstr=@"public/patient/test/addtodoctor?";
    NSString *urlstr=[NSString stringWithFormat:@"%@patient_id=%@&doctor_id=%@",suburlstr,PatientId,doctorID];
    
    [[BaseDataService shareInstance]PostNetWorkJSONWithURLStr:urlstr whitdic:nil theReturnBlock:^(id respondataarr) {
        
        
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
+(void)deletePatientWithPatientID:(NSMutableArray *)Patients teamId:(NSString *)teamid block:(ResponseBlock)block{
    NSString *suburlstr=@"private/doctor/team/";
    NSString *urlstr=[NSString stringWithFormat:@"%@%@/patient/delete",suburlstr,teamid];
    NSLog(@"%@",urlstr);
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:Patients,@"ids", nil];
    
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

#pragma 患者库
+(void)PatientAddTagsWithTags:(NSMutableArray *)tags PatientId:(NSString *)patientid block:(ResponseBlock)block{
    
 //   NSString *suburlstr=@"private/doctor/patient/tag/add?tag=";
    NSString *urlstr=[NSString stringWithFormat:@"private/doctor/patient/tag/set?patient_id=%@",patientid];
    NSLog(@"%@",urlstr);
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:tags,@"tags", nil];
    
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
        }else if([[resultdic objectForKey:@"code"] intValue]==4021){
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]crearebigNotificationUIView:@"该操作需要团队创建人操作"];
        }
    }];
    
    

    
}
+(void)getAlltagsblock:(ResponseBlock)block{
   
    NSString *urlstr=[NSString stringWithFormat:@"private/doctor/tags"];
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
+(void)getPatientTagsWithPatientId:(NSString *)PatientId block:(ResponseBlock)block{
    NSString *urlstr=[NSString stringWithFormat:@"private/doctor/patient/tags?patient_id=%@",PatientId];
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
+(void)getTagPatientsWithTagid:(NSString *)tagid block:(ResponseBlock)block{
    
    NSString *urlstr;
    if (tagid==nil) {
          urlstr=[NSString stringWithFormat:@"private/doctor/tags/patient?tag_id="];
    }else{
          urlstr=[NSString stringWithFormat:@"private/doctor/tags/patient?tag_id=%@",tagid];
   
    }
    
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
        }else if([[resultdic objectForKey:@"code"] intValue]==4445){
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"您暂无权限执行此操作"];
        }
        
        
    }];

    
}
+(void)getPatientCountofDoctorTagsblock:(ResponseBlock)block{
   
    NSString *urlstr=[NSString stringWithFormat:@"private/doctor/tags/patient/count"];
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

+(void)updateTagWithTagid:(NSString *)tagid tagStr:(NSString *)tagstr block:(ResponseBlock)block{
    
    NSMutableDictionary *infodic=[[NSMutableDictionary alloc]init];
    [infodic setValue:tagid forKey:@"id"];
    [infodic setValue:tagstr forKey:@"tag"];
    [infodic setValue:@"0" forKey:@"sort_num"];
    
    
    NSString *urlstr=@"private/doctor/tags/update";
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
        }else if([[resultdic objectForKey:@"code"] intValue]==4445){
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"您暂无权限执行此操作"];
        }
    }];

    
}


+(void)deleteTagWithTagid:(NSString *)tagid block:(ResponseBlock)block{
    //private/doctor/tags/085b40a9-ab55-4aed-967e-97355945bc11/delete
    
    NSString *urlstr=[NSString stringWithFormat:@"private/doctor/tags/%@/delete",tagid];
    NSLog(@"%@",urlstr);
  ///  NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:tags,@"tags", nil];
    
    [[BaseDataService shareInstance]PostNetWorkJSONWithURLStr:urlstr whitdic:nil theReturnBlock:^(id respondataarr) {
        
        
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
        }else if([[resultdic objectForKey:@"code"] intValue]==4445){
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"您暂无权限执行此操作"];
        }else if([[resultdic objectForKey:@"code"] intValue]==4445){
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"您暂无权限执行此操作"];
        }
    }];
    

    
}

+(void)orderTagWithTags:(NSArray *)tagsarr block:(ResponseBlock)block{
//    "url": "http://localhost:8080/api/private/doctor/tags/reorder",
//    "json": {
//        "ids": [
//                "e8e970f2-8a38-479c-9141-27e516566948",
//                "92203d20-96cf-41a2-80ff-7479efd3c7ff",
//                "7a79c529-aef9-4a58-a74f-0f238f65a524",
//                "1dd90da6-d0ab-4fc9-82e0-132359edba3c",
//                "eaa3e591-4ff5-48af-9a9c-049fcbb0c3dc"
//                ]
    
    
    NSString *urlstr=[NSString stringWithFormat:@"private/doctor/tags/reorder"];
   // NSLog(@"%@",urlstr);
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:tagsarr,@"ids", nil];
    
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
        }else if([[resultdic objectForKey:@"code"] intValue]==4445){
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"您暂无权限执行此操作"];
        }
    }];
    

    
}
+(void)addTagWithTagstr:(NSString *)tagstr block:(ResponseBlock)block{
    NSString *urlstr=[NSString stringWithFormat:@"private/doctor/tags/?tag=%@",tagstr];
    NSLog(@"%@",urlstr);
    ///  NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:tags,@"tags", nil];
    
    [[BaseDataService shareInstance]PostNetWorkJSONWithURLStr:urlstr whitdic:nil theReturnBlock:^(id respondataarr) {
        
        
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
        }else if([[resultdic objectForKey:@"code"] intValue]==4012){
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"您没有权限执行此操作"];
        }else if([[resultdic objectForKey:@"code"] intValue]==4021){
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]crearebigNotificationUIView:@"该操作需要团队创建人操作"];
        }else if([[resultdic objectForKey:@"code"] intValue]==4445){
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"您暂无权限执行此操作"];
        }
    }];

}
+(void)getInvitePatientsShareInfoblock:(ResponseBlock)block{
    
    // NSString *suburlstr=@"private/im/group?group_id=";
    NSString *urlstr=[NSString stringWithFormat:@"private/doctor/wxqrcodeshare"];
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


+(void)InvitePatientsWithMsisdns:(NSArray *)msisdns ShareInfoblock:(ResponseBlock)block{
    
    NSString *urlstr=[NSString stringWithFormat:@"private/doctor/sms_invite_patient"];
    NSLog(@"%@",urlstr);
     NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:msisdns,@"msisdns", nil];
    
    [[BaseDataService shareInstance]PostNetWorkJSONWithURLStr:urlstr whitdic:dic theReturnBlock:^(id respondataarr) {
        
        
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
        }else if([[resultdic objectForKey:@"code"] intValue]==4012){
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"您没有权限执行此操作"];
        }else if([[resultdic objectForKey:@"code"] intValue]==4445){
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"您暂无权限执行此操作"];
        }
    }];

    
}

@end
