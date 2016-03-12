//
//  ContactPatientViewController.h
//  CYS
//
//  Created by 谢阳晴 on 16/1/7.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RongIMKit/RongIMKit.h>

#import "PatientChatViewController.h"

@protocol ContactPatientViewControllerdelegate <NSObject>

-(void)reloaPatients;

@end

@interface ContactPatientViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,navbardelegate,UITextFieldDelegate>


@property(nonatomic,retain)NSMutableArray *dataArr;
@property(nonatomic,retain)NSMutableArray *patientdataArr;
@property(nonatomic,retain)NSArray *indexdataArr;
@property(nonatomic,retain)UITableView *tableView;
@property(nonatomic,retain)NSMutableDictionary *thedatadic;
@property(nonatomic,retain)NSMutableDictionary *tmpdatadic;
@property(nonatomic,retain)NSMutableDictionary *teamdic;
@property(nonatomic,retain)NSMutableDictionary *resultdatadic;
@property(nonatomic,assign)BOOL needsearch;
@property(nonatomic,assign)BOOL isaddpatient;
@property(nonatomic,assign)BOOL isneedadd;
@property(nonatomic,assign)BOOL isnotneedmoreaction;
@property(nonatomic,retain)NSString *docteamid;
@property(nonatomic,retain)UITextField *textfield;
@property(nonatomic,assign)BOOL hideRbtn;
@property(nonatomic,assign)BOOL isaddshowall;
@property(nonatomic,assign)BOOL iswoner;
@property(nonatomic,assign)BOOL needsave;
@property(nonatomic,assign)BOOL isnewteam;
@property(nonatomic,assign)BOOL needsearchbar;
@property(nonatomic,assign)BOOL isalledit;
@property(nonatomic,assign)id <ContactPatientViewControllerdelegate> delegate;
-(void)setlistisedit:(BOOL)listisedit;
@end
