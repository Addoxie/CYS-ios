//
//  APPRegDataService.m
//  CYS
//
//  Created by 谢阳晴 on 15/12/28.
//  Copyright © 2015年 谢阳晴. All rights reserved.
//

#import "APPRegDataService.h"
#import "GTMBase64.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

@implementation APPRegDataService
+(void)regToken:(NSString *)apnstoken block:(ResponseBlock)block{
     NSString *identifierForVendor = [[UIDevice currentDevice].identifierForVendor UUIDString];
     NSString *osvlstr =[NSString stringWithFormat:@"ios %.2f",[[[UIDevice currentDevice] systemVersion] floatValue]];
     NSString *applicationid=[NSString stringWithFormat:@"ios%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]] ;
     NSMutableDictionary *infodic=[[NSMutableDictionary alloc]init];
     [infodic setValue:apnstoken forKey:@"push_token"];
     [infodic setValue:identifierForVendor forKey:@"device_id"];
     [infodic setValue:applicationid forKey:@"application_id"];
     [infodic setObject:@(0) forKey:@"os_type"];
    
   // [infodic setValue:KGetDefaultstr(@"userid") forKey:@"userid"];
    
     [infodic setValue:osvlstr forKey:@"os_version"];
    //[infodic setValue:@"12345678902" forKey:@"user_id"];
   

    NSString *urlstr=[[NSString alloc]init];
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"token"]) {
        
         [infodic setObject:KGetDefaultstr(@"doctor-id") forKey:@"user_id"];
        
        urlstr=@"private/app_ins/register";
    }else{
        urlstr=@"protected/app_ins/register";
    }
    NSLog(@"%@",infodic);
    [[BaseDataService shareInstance] PostNetWorkJSONWithURLStr:urlstr whitdic:infodic theReturnBlock:^(id respondataarr) {
        NSDictionary *resultdic=(NSDictionary *)[respondataarr objectAtIndex:1];
          NSLog(@"%@",resultdic);
        if([[resultdic objectForKey:@"code"] intValue]==2000){
            
            if ([[NSUserDefaults standardUserDefaults]objectForKey:@"token"]) {
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
            [[PublicTools shareInstance]creareNotificationUIView:@"用户不存在"];
        }else if([[resultdic objectForKey:@"code"] intValue]==4001){
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"用户信息有误"];
        }else if([[resultdic objectForKey:@"code"] intValue]==4005){
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"用户已存在"];
        }
    }];

}

+(void)unregToken:(NSString *)apnstoken block:(ResponseBlock)block{
    
}
-(NSString *)getNetWorkType{
    UIApplication *application = [UIApplication sharedApplication];
    NSArray *subviews = [[[application valueForKey:@"statusBar"] valueForKey:@"foregroundView"]subviews];
    NSNumber *dataNetWorkItemView = nil;
    for (id subView in subviews) {
        if ([subView isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            dataNetWorkItemView = subView;
            break;
        }
    }
    NSString *typestr=[[NSString alloc]init];
    //  //NSLog(@"%zd",[[dataNetWorkItemView valueForKey:@"dataNetworkType"]integerValue]);
    // NewNetWorkType networkType = NetWorkType_None;
    switch ([[dataNetWorkItemView valueForKey:@"dataNetworkType"]integerValue]) {
        case 0:
            //NSLog(@"No wifi or cellular");
            // networkType = NetWorkType_None;
            typestr=@"No wifi or cellular";
            break;
            
        case 1:
            //NSLog(@"2G");
            //   networkType = NetWorkType_2G;
            typestr=@"2G";
            break;
            
        case 2:
            //NSLog(@"3G");
            //  networkType = NetWorkType_3G;
            typestr=@"3G";
            break;
        case 3:
            //NSLog(@"4G");
            //  networkType = NetWorkType_3G;
            typestr=@"4G";
            break;
        default:
            //NSLog(@"Wifi");
            // networkType = NetWorkType_WIFI;
            typestr=@"Wifi";
            break;
    }
    return typestr;
}

-(NSString *)getIOSVersion
{
    return [NSString stringWithFormat:@"ios %.2f",[[[UIDevice currentDevice] systemVersion] floatValue]];
}
-(NSString *)getuniqueString{
    NSString *identifierForVendor = [[UIDevice currentDevice].identifierForVendor UUIDString];
   // NSString *identifierForAdvertising = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
    return identifierForVendor;
}
-(NSString *)getcarrierName{
    CTTelephonyNetworkInfo *telephonyInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [telephonyInfo subscriberCellularProvider];
    NSString *currentCountry=[carrier carrierName];
    NSData *data = [currentCountry dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    data = [GTMBase64 encodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    //NSLog(@"%@",base64String);
    return base64String;
}
-(NSString *)getCurrentDeviceModel{
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G (A1203)";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G (A1241/A1324)";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS (A1303/A1325)";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4 (A1349)";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S (A1387/A1431)";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5 (A1428)";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (A1429/A1442)";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (A1456/A1532)";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (A1507/A1516/A1526/A1529)";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (A1453/A1533)";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (A1457/A1518/A1528/A1530)";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus (A1522/A1524)";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6 (A1549/A1586)";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G (A1213)";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G (A1288)";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G (A1318)";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G (A1367)";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G (A1421/A1509)";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G (A1219/A1337)";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2 (A1395)";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2 (A1396)";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2 (A1397)";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2 (A1395+New Chip)";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G (A1432)";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G (A1454)";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G (A1455)";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (A1416)";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (A1403)";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3 (A1430)";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4 (A1458)";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4 (A1459)";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4 (A1460)";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air (A1474)";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air (A1475)";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air (A1476)";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G (A1489)";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G (A1490)";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G (A1491)";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    return platform;
}
+(void)logoutactionblock:(ResponseBlock)block{
    //
    
    NSString *identifierForVendor = [[UIDevice currentDevice].identifierForVendor UUIDString];
    NSString *osvlstr =[NSString stringWithFormat:@"ios %.2f",[[[UIDevice currentDevice] systemVersion] floatValue]];
    NSString *applicationid=[NSString stringWithFormat:@"ios%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]] ;
    NSMutableDictionary *infodic=[[NSMutableDictionary alloc]init];
    [infodic setValue:KGetDefaultstr(@"pushtoken") forKey:@"push_token"];
    [infodic setValue:identifierForVendor forKey:@"device_id"];
    [infodic setValue:applicationid forKey:@"application_id"];
    [infodic setObject:@(0) forKey:@"os_type"];
    
    // [infodic setValue:KGetDefaultstr(@"userid") forKey:@"userid"];
    
    [infodic setValue:osvlstr forKey:@"os_version"];
    
    NSString *urlstr=@"private/user/logout";
      NSLog(@"%@",infodic);
    [[BaseDataService shareInstance] PostNetWorkJSONWithURLStr:urlstr whitdic:infodic theReturnBlock:^(id respdicarr) {
        NSMutableArray *tmparr=(NSMutableArray *)respdicarr;
        NSDictionary *resultdic=[tmparr objectAtIndex:1];
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
        }
    }];
    

    
}
@end
