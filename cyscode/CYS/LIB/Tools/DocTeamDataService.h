//
//  DocTeamDataService.h
//  CYS
//
//  Created by 谢阳晴 on 15/12/31.
//  Copyright © 2015年 谢阳晴. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ResponseBlock)(id);

@interface DocTeamDataService : NSObject

+(void)foundDocTeamName:(NSString *)name descStr:(NSString *)descstr block:(ResponseBlock)block;

+(void)deleteDocTeamWithId:(NSString *)teamid block:(ResponseBlock)block;

+(void)getDocAllTeamblock:(ResponseBlock)block;

+(void)getDocArrWithName:(NSString *)name pageNum:(NSInteger)pagenum block:(ResponseBlock)block;

+(void)invitedoctorWithdocID:(NSString *)docid teamId:(NSString *)teamid block:(ResponseBlock)block;

+(void)getAllparticipatedTeamblock:(ResponseBlock)block;

+(void)getAllInvitationsblock:(ResponseBlock)block;

+(void)getTeamMembersWithteamId:(NSString *)teamid  block:(ResponseBlock)block;

+(void)docconfirminginvitationWithteamId:(NSString *)teamid  block:(ResponseBlock)block;

+(void)deletingdoctorsfromteamWithteamId:(NSString *)teamid doctors:(NSMutableArray *)doctors block:(ResponseBlock)block;

+(void)quitfromteamWithteamId:(NSString *)teamid block:(ResponseBlock)block;

+(void)getGroupinfoWithGroupId:(NSString *)groupId block:(ResponseBlock)block;

+(void)UpdateGroupNameWithteamId:(NSString *)teamId name:(NSString *)namestr block:(ResponseBlock)block;

+(void)getBarCodeShareinfoblock:(ResponseBlock)block;

+(void)spamMsgTopatients:(NSArray *)patients msg:(NSString *)msgstr block:(ResponseBlock)block;

@end
