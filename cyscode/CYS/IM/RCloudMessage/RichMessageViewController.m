//
//  RichMessageViewController.m
//  CYS
//
//  Created by 谢阳晴 on 15/12/29.
//  Copyright © 2015年 谢阳晴. All rights reserved.
//

#import "RichMessageViewController.h"
#import <RongIMKit/RongIMKit.h>

@interface RichMessageViewController ()

@end

@implementation RichMessageViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
//    RCRichContentMessage *richmessage=[RCRichContentMessage messageWithTitle:@"给你发张图片" digest:@"美丽的图片" imageURL:@"http://pic.wenwen.soso.com/p/20090604/20090604081203-1107810136.jpg" url:@"http://pic.wenwen.soso.com/p/20090604/20090604081203-1107810136.jpg" extra:@"haha"];
//    
//    [[RCIMClient sharedRCIMClient]sendMessage:ConversationType_PRIVATE targetId:@"dongbin" content:richmessage pushContent:@"给你发张图片" pushData:nil success:^(long messageId) {
//        [self.navigationController popViewControllerAnimated:YES];
//        
//    } error:^(RCErrorCode nErrorCode, long messageId) {
//        NSLog(@"haha");
//    }];

}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    RCRichContentMessage *richmessage=[RCRichContentMessage messageWithTitle:@"给你发张图片" digest:@"美丽的图片" imageURL:@"http://pic.wenwen.soso.com/p/20090604/20090604081203-1107810136.jpg" url:@"http://pic.wenwen.soso.com/p/20090604/20090604081203-1107810136.jpg" extra:@"haha"];
    
    [[RCIMClient sharedRCIMClient]sendMessage:ConversationType_PRIVATE targetId:@"dongbin" content:richmessage pushContent:@"给你发张图片" pushData:nil success:^(long messageId) {
        
       //  [self.navigationController popViewControllerAnimated:YES];
    } error:^(RCErrorCode nErrorCode, long messageId) {
        NSLog(@"haha");
    }];

}
@end
