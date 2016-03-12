//
//  LoginDataService.h
//  ChatDemo-UI3.0
//
//  Created by 谢阳晴 on 15/12/9.
//  Copyright © 2015年 谢阳晴. All rights reserved.
//

#import "BaseDataService.h"

typedef void(^ResponseBlock)(id);

@interface LoginDataService : NSObject


+(void)loginWithUsername:(NSString *)username password:(NSString *)password block:(ResponseBlock)block;

+(void)regWithUsername:(NSString *)username password:(NSString *)password signature:(NSString *)signature block:(ResponseBlock)block;

+(void)getSelfIMInfoblock:(ResponseBlock)block;

+(void)getNewSelfIMInfoblock:(ResponseBlock)block;

+(void)updatingusermsisdnWitholdmask:(NSString *)oldmask newmask:(NSString *)newmask msisdn:(NSString *)msisdn block:(ResponseBlock)block;

+(void)updatinguserpasswordWitholdpw:(NSString *)oldpw newpw:(NSString *)newpw block:(ResponseBlock)block;


@end
