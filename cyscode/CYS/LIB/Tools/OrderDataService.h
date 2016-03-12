//
//  OrderDataService.h
//  CYS
//
//  Created by 谢阳晴 on 16/1/26.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ResponseBlock)(id);

@interface OrderDataService : NSObject
+(void)getAllOrderCountblock:(ResponseBlock)block;


+(void)getOrderDetailListWithServicetype:(NSInteger)type Statu:(NSInteger)statu block:(ResponseBlock)block;

+(void)getALLOrderDetailListWithServicetype:(NSInteger)type block:(ResponseBlock)block;


+(void)setServicePriceWithServicetype:(NSString *)typestr price:(NSString *)pricestr status:(NSString *)statusstr block:(ResponseBlock)block;
/*
 "service_type": 0, // 0 图文咨询，1电话，2包月
 "price": 100
 “status”: 0 表示关闭
 */


+(void)setFreeServicefreeperiod:(NSString *)free_period block:(ResponseBlock)block;

/*"free_period": 100 -1表示无限期*/


+(void)getServiceDetailWithServicetype:(NSString *)typestr block:(ResponseBlock)block;
/*
 "service_type": 0, // 0 图文咨询，1电话，2包月

 */

+(void)getAllServiceConfigsblock:(ResponseBlock)block;


#pragma create test order
+(void)CreateorderWithPatientID:(NSString *)Patientid doctorId:(NSString *)doctorId block:(ResponseBlock)block;
@end
