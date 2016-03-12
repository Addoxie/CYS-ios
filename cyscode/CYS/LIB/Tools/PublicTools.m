//
//  PublicTools.m
//  ByShare
//
//  Created by 谢阳晴 on 15/1/5.
//  Copyright (c) 2015年 谢阳晴. All rights reserved.
//

#import "PublicTools.h"
//#import <UIKit/UIKit.h>
//#import "AFNetworking.h"
//#import "ASIHTTPRequest.h"
//#import "ASIFormDataRequest.h"
//#include "Mybase64.h"
//#include <CommonCrypto/CommonDigest.h>
//#include <CommonCrypto/CommonHMAC.h>
//#import <CoreTelephony/CTTelephonyNetworkInfo.h>
//#import <CoreTelephony/CTCarrier.h>
//#import "GTMBase64.h"
//#include <sys/types.h>
//#include <sys/sysctl.h>
//#import "SDImageCache.h"


static PublicTools *instnce;

@implementation PublicTools


+ (id)shareInstance {
    if (instnce == nil) {
        //类实例化以便调用实例方法
        
        instnce = [[[self class] alloc] init];
    }
    return instnce;
}
-(void)setmyPview:(UIView *)pview{

    self.pview=pview;
}
//黑色提醒框
-(UIView *)creareNotificationUIView:(NSString *)string{
UIView *aView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
aView.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2,[UIScreen mainScreen].bounds.size.height - 150);
aView.backgroundColor = [UIColor blackColor];
aView.tag = 1000050;
aView.alpha = 0.9;
aView.layer.cornerRadius = 15;
UILabel *aMessage = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, aView.bounds.size.width, aView.bounds.size.height)];
aMessage.textAlignment = NSTextAlignmentCenter;
aMessage.text = string;
aMessage.textColor = [UIColor whiteColor];
aMessage.font = [UIFont fontWithName:@"DIN Alternate" size:12.0f];
[aView addSubview:aMessage];
[UIView beginAnimations:nil context:nil];
[UIView setAnimationDuration:3];
[_pview addSubview:aView];
[UIView commitAnimations];
[self performSelector:@selector(kstopView) withObject:self afterDelay:2.0];
    return aView;
}
-(UIView *)crearebigNotificationUIView:(NSString *)string{
    UIView *aView = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/2.0-150, 100, 300, 150)];
    //aView.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2,[UIScreen mainScreen].bounds.size.height - 150);
    aView.backgroundColor = [UIColor blackColor];
    aView.tag = 1000050;
    aView.alpha = 0.9;
    aView.layer.cornerRadius = 6.0;
    UILabel *aMessage = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, aView.bounds.size.width, aView.bounds.size.height)];
    aMessage.textAlignment = NSTextAlignmentCenter;
    aMessage.text = string;
    aMessage.textColor = [UIColor whiteColor];
    aMessage.font = [UIFont fontWithName:@"DIN Alternate" size:25.0f];
    [aView addSubview:aMessage];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:3];
    [_pview addSubview:aView];
    [UIView commitAnimations];
    [self performSelector:@selector(kstopView) withObject:self afterDelay:2.0];
    return aView;
}


-(void)kstopView{
UIView *aView = (UIView *)[self.pview viewWithTag:1000050];
[UIView beginAnimations:nil context:nil];
[UIView setAnimationDuration:1];
[aView removeFromSuperview];
[UIView commitAnimations];
}
-(UIView *)getNotificationRedPointViewWithFrame:(CGRect)redpointFrame{
    UIView *msgview=[[UIView alloc]initWithFrame:redpointFrame];
    msgview.clipsToBounds=YES;
    msgview.layer.masksToBounds=YES;
    msgview.layer.cornerRadius =5.0;
    msgview.layer.borderColor = [UIColor clearColor].CGColor;
    msgview.layer.rasterizationScale = [UIScreen mainScreen].scale;
    msgview.backgroundColor=[UIColor clearColor];
    AppDelegate *appdelegate=[[UIApplication sharedApplication] delegate];
    if (![appdelegate.msgcount isEqualToString:@"0"]) {
        
        msgview.backgroundColor=[UIColor redColor];
    }
    return msgview;

}

@end
