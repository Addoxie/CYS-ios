//
//  PublicTools.h
//  ByShare
//
//  Created by 谢阳晴 on 15/1/5.
//  Copyright (c) 2015年 谢阳晴. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"


//typedef enum {
//    NetWorkType_None = 0,
//    NetWorkType_WIFI,
//    NetWorkType_2G,
//    NetWorkType_3G,
//    NetWorkType_4G,
//} NewNetWorkType;

typedef void(^Urlreturnobjblock)(id);

@interface PublicTools : NSObject{
    id mybaseobj;
     BOOL havenew;
}
+ (id)shareInstance;
@property(nonatomic,retain)UIView *pview;

-(void)setmyPview:(UIView *)pview;
//黑色提醒框
-(UIView *)creareNotificationUIView:(NSString *)string;

-(UIView *)getNotificationRedPointViewWithFrame:(CGRect)redpointFrame;

-(UIView *)crearebigNotificationUIView:(NSString *)string;



@end
