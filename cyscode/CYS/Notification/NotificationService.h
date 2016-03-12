//
//  NotificationService.h
//  CYS
//
//  Created by 谢阳晴 on 16/2/25.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ResponseBlock)(id);

@interface NotificationService : NSObject
+(void)findUnreadMessagesWithMsgType:(NSString *)msgtype block:(ResponseBlock)block;

+(void)getAllUnreadMessagesCountblock:(ResponseBlock)block;

@end
