//
//  UserDB.h
//  UserDemo
//
//  Created by wei.chen on 13-2-27.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//
#import "BaseDB.h"
#import "UserModel.h"
#import "HistoryMsgModel.h"

@interface UserDB : BaseDB

+ (id)shareInstance;

//创建用户表
- (void)createTable;

//添加用户
- (BOOL)addUser:(UserModel *)userModel;

- (NSArray *)findUsersWithTargetid:(NSString *)targetid;
- (BOOL)deletemsgWithMsgType:(NSString *)targetid;
- (NSArray *)findUsers;
- (BOOL)deletemsgWithMsgID:(NSString *)msgID;
- (BOOL)deleteAll;


//群发消息
- (BOOL)addmessage:(HistoryMsgModel *)msgModel;
- (NSArray *)findMsgs;
- (BOOL)deletemsgWithMsgid:(NSString *)messageid;
- (BOOL)deleteAllmsg;
@end
