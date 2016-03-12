//
//  UserDB.m
//  UserDemo
//
//  Created by wei.chen on 13-2-27.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "UserDB.h"

static UserDB *instnce;

@implementation UserDB

+ (id)shareInstance {
    if (instnce == nil) {
        instnce = [[[self class] alloc] init];
    }
    return instnce;
}

- (void)createTable {
    
    NSString *sql = @"CREATE TABLE IF NOT EXISTS userinfotable (targetid TEXT primary key,userinfocontent TEXT);";
    NSString *msgsql = @"CREATE TABLE IF NOT EXISTS messagetable (messageid TEXT primary key,messagecontent TEXT);";
    [self createTable:sql];
    [self createTable:msgsql];
   
}


- (BOOL)addUser:(UserModel *)userModel {
   
    NSString *sql = @"INSERT OR REPLACE INTO userinfotable (targetid,userinfocontent) VALUES (?,?)";
   

    NSArray *params = [NSArray arrayWithObjects:userModel.targetid,
                                                userModel.userinfocontent,nil];
    
    
    
    
    
    
   BOOL res=[self dealData:sql paramsarray:params];
   
// [self newloadcommentmsg];
    return res;
   
}

- (BOOL)addmessage:(HistoryMsgModel *)msgModel{
    NSString *sql = @"INSERT OR REPLACE INTO messagetable (messageid,messagecontent) VALUES (?,?)";
    
    
    NSArray *params = [NSArray arrayWithObjects:msgModel.messageid,
                       msgModel.messagecontent,nil];
    
    
    
    
    
    
    BOOL res=[self dealData:sql paramsarray:params];
    
    // [self newloadcommentmsg];
    return res;

}



- (NSArray *)findUsersWithTargetid:(NSString *)targetid{
   // [self newloadcommentmsg];
   
    NSString *str=@"SELECT targetid,userinfocontent FROM userinfotable WHERE targetid=";
    NSString *sql=[NSString stringWithFormat:@"%@'%@'",str,targetid];

  
   // NSLog(@"%@",sql);
    NSArray *data = [self selectData:sql columns:2];
    
    NSMutableArray *users = [NSMutableArray array];
    for (NSArray *row in data) {
        NSString *targetid = [row objectAtIndex:0];
        NSString *userinfocontent = [row objectAtIndex:1];
      
        
        UserModel *user = [[UserModel alloc] init];
        user.targetid = targetid;
        user.userinfocontent = userinfocontent;
        [users addObject:user];
        
    }
    users=(NSMutableArray *)[[users reverseObjectEnumerator] allObjects];
    return users;

}
- (NSArray *)findUsers {
    NSString *sql = @"SELECT targetid,userinfocontent  FROM userinfotable";
    NSArray *data = [self selectData:sql columns:3];

    NSMutableArray *users = [NSMutableArray array];
    for (NSArray *row in data) {
        NSString *targetid = [row objectAtIndex:0];
        NSString *userinfocontent = [row objectAtIndex:1];
        
        
        UserModel *user = [[UserModel alloc] init];
        user.targetid = targetid;
        user.userinfocontent = userinfocontent;
        [users addObject:user];
        
    }
    //  [self newloadcommentmsg];
    
    return users;
}


- (NSArray *)findMsgs{
    NSString *sql = @"SELECT messageid,messagecontent FROM messagetable ORDER BY messageid";
    NSArray *data = [self selectData:sql columns:3];
    
    NSMutableArray *users = [NSMutableArray array];
    for (NSArray *row in data) {
        NSString *msgid = [row objectAtIndex:0];
        NSString *msgcontent = [row objectAtIndex:1];
        
        
        HistoryMsgModel *user = [[HistoryMsgModel alloc] init];
        user.messageid = msgid;
        user.messagecontent = msgcontent;
        [users addObject:user];
        
    }
    //  [self newloadcommentmsg];
    
    return users;

}







- (BOOL)deletemsgWithMsgType:(NSString *)targetid{
    NSString *str=@"DELETE FROM userinfotable WHERE targetid = ";
    
    NSString *sql=[str stringByAppendingFormat:@"'%@'",targetid];
    return [self dealData:sql paramsarray:nil];

}

- (BOOL)deletemsgWithMsgid:(NSString *)messageid{
    NSString *str=@"DELETE FROM messagetable WHERE messageid = ";
    
    NSString *sql=[str stringByAppendingFormat:@"'%@'",messageid];
    return [self dealData:sql paramsarray:nil];
    
}




//- (BOOL)deletemsgWithMsgID:(NSString *)msgID{
//    NSString *str=@"DELETE FROM userinfotable WHERE msgid = ";
//    
//    NSString *sql=[str stringByAppendingFormat:@"'%@'",msgID];
//    return [self dealData:sql paramsarray:nil];
//
//}
- (BOOL)deleteAll{
    NSString *str=@"DELETE FROM userinfotable";
    return [self dealData:str paramsarray:nil];
    
}
- (BOOL)deleteAllmsg{
    NSString *str=@"DELETE FROM messagetable";
    return [self dealData:str paramsarray:nil];
    
}

@end
