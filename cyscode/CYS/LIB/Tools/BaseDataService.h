//
//  BaseDataService.h
//  ChatDemo-UI3.0
//
//  Created by 谢阳晴 on 15/12/9.
//  Copyright © 2015年 谢阳晴. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Urlreturnobjblock)(id);

@interface BaseDataService : NSObject
+ (id)shareInstance;
@property(nonatomic,retain)UIView *pview;

//网络数据抓取
-(void)GetNetWorkDataWithURLStr:(NSString *)URLstr theReturnBlock:(Urlreturnobjblock)block;

-(void)PostNetWorkDataWithURLStr:(NSString *)URLstr  whitdic:(NSMutableDictionary *)dic theReturnBlock:(Urlreturnobjblock)block;

-(void)PostNetWorkJSONWithURLStr:(NSString *)URLstr  whitdic:(NSMutableDictionary *)dic theReturnBlock:(Urlreturnobjblock)block;
-(void)PostNetWorkJSONWithURLStr:(NSString *)URLstr  whitdic:(NSMutableArray *)arr isArr:(BOOL)isArr theReturnBlock:(Urlreturnobjblock)block;

-(NSString *)hmacsMD5:(NSString *)text key:(NSString *)secret;
@property(nonatomic,retain)NSMutableArray *dataArr;

@end
