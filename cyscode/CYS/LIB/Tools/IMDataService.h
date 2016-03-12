//
//  IMDataService.h
//  CYS
//
//  Created by 谢阳晴 on 16/1/26.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ResponseBlock)(id);

@interface IMDataService : NSObject

+(void)getGroupDetailsWithPatientID:(NSString *)Patientid teamId:(NSString *)teamid block:(ResponseBlock)block;

+(void)getListinggroupsForteamWithteamId:(NSString *)teamid block:(ResponseBlock)block;

+(void)getListingIMInfofortargetIdWithtargetId:(NSString *)targetId block:(ResponseBlock)block;

+(void)getPersonalIMInfofortargetIdWithpatientId:(NSString *)patientId block:(ResponseBlock)block;
@end
