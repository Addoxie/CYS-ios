//
//  PatientDataService.h
//  CYS
//
//  Created by 谢阳晴 on 16/1/8.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import <Foundation/Foundation.h>



typedef void(^ResponseBlock)(id);


@interface PatientDataService : NSObject

+(void)getPatientArrWithName:(NSString *)name pageNum:(NSInteger)pagenum block:(ResponseBlock)block;

+(void)invitePatientWithPatientID:(NSMutableArray *)Patients teamId:(NSString *)teamid block:(ResponseBlock)block;

+(void)getTeamPatientsWithteamId:(NSString *)teamid pageNum:(NSInteger)pagenum block:(ResponseBlock)block;

+(void)invitePatientToDoctorPatientId:(NSString *)PatientId doctor:(NSString *)doctorID block:(ResponseBlock)block;

+(void)deletePatientWithPatientID:(NSMutableArray *)Patients teamId:(NSString *)teamid block:(ResponseBlock)block;

+(void)getallPatientsblock:(ResponseBlock)block;

+(void)getInvitePatientsShareInfoblock:(ResponseBlock)block;

+(void)InvitePatientsWithMsisdns:(NSArray *)msisdns ShareInfoblock:(ResponseBlock)block;

#pragma 患者库

+(void)PatientAddTagsWithTags:(NSMutableArray *)tags PatientId:(NSString *)patientid block:(ResponseBlock)block;

+(void)getAlltagsblock:(ResponseBlock)block;

+(void)getPatientTagsWithPatientId:(NSString *)PatientId block:(ResponseBlock)block;

+(void)getTagPatientsWithTagid:(NSString *)tagid block:(ResponseBlock)block;

+(void)getPatientCountofDoctorTagsblock:(ResponseBlock)block;

+(void)updateTagWithTagid:(NSString *)tagid tagStr:(NSString *)tagstr block:(ResponseBlock)block;

+(void)deleteTagWithTagid:(NSString *)tagid block:(ResponseBlock)block;

+(void)orderTagWithTags:(NSArray *)tagsarr block:(ResponseBlock)block;

+(void)addTagWithTagstr:(NSString *)tagstr block:(ResponseBlock)block;

@end
