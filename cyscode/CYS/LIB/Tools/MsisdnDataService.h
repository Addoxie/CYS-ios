//
//  MsisdnDataService.h
//  CYS
//
//  Created by 谢阳晴 on 15/12/14.
//  Copyright © 2015年 谢阳晴. All rights reserved.
//

#import "BaseDataService.h"

typedef void(^ResponseBlock)(id);

@interface MsisdnDataService : NSObject


+(void)getCaptchaCodeWithMsisdn:(NSString *)msisdn type:(NSInteger)type block:(ResponseBlock)block;
/*
 type=0 reg = 注册
 type=1 forgot=忘记密码
 type=2 chno=修改手机绑定
 
 */
+(void)verfyCaptchaCodeWithMsisdn:(NSString *)msisdn captcha:(NSString *)captcha block:(ResponseBlock)block;



+(void)dealForgotPasswordWithMsisdn:(NSString *)msisdn signature:(NSString *)signature password:(NSString *)password type:(NSInteger)type block:(ResponseBlock)block;
/*
 type=0 注册
 type=1 忘记密码
 */


@end
