//
//  RCDChatViewController.h
//  RCloudMessage
//
//  Created by Liv on 15/3/13.
//  Copyright (c) 2015年 RongCloud. All rights reserved.
//

#import <RongIMKit/RongIMKit.h>



@protocol RCDChatViewControllerdelegate <NSObject>

-(void)chatViewDealtdataMethodname:(NSString *)methodname stringval:(NSString *)stringval;

@end



@interface RCDChatViewController : RCConversationViewController

/**
 *  会话数据模型
 */
@property (strong,nonatomic) RCConversationModel *conversation;

@property(nonatomic,assign) id <RCDChatViewControllerdelegate> delegate;

@end
