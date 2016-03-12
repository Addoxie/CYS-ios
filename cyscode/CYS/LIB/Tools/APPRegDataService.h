//
//  APPRegDataService.h
//  CYS
//
//  Created by 谢阳晴 on 15/12/28.
//  Copyright © 2015年 谢阳晴. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^ResponseBlock)(id);

@interface APPRegDataService : NSObject


+(void)regToken:(NSString *)apnstoken block:(ResponseBlock)block;

+(void)unregToken:(NSString *)apnstoken block:(ResponseBlock)block;

+(void)logoutactionblock:(ResponseBlock)block;
@end
