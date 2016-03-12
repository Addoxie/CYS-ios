//
//  UserDataService.h
//  CYS
//
//  Created by 谢阳晴 on 16/1/26.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ResponseBlock)(id);

@interface UserDataService : NSObject


+(void)getUserInfofortargetIdWithtargetId:(NSString *)targetId block:(ResponseBlock)block;

+(void)getGroupInfofortargetIdWithGroupId:(NSString *)groupId block:(ResponseBlock)block;


+(void)getDocInfoWithDocId:(NSString *)coderesult block:(ResponseBlock)block;


+(void)getSelfInfoWithblock:(ResponseBlock)block;

@end
