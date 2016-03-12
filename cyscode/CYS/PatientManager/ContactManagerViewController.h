//
//  ContactManagerViewController.h
//  CYS
//
//  Created by 谢阳晴 on 15/12/23.
//  Copyright © 2015年 谢阳晴. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MobClick.h"

@protocol ContactManagerViewControllerdelegate <NSObject>

-(void)reloadmembers;

@end


@interface ContactManagerViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,navbardelegate,UITextFieldDelegate,UIAlertViewDelegate>

@property(nonatomic,retain)NSMutableArray *dataArr;
@property(nonatomic,retain)NSMutableArray *frienddataArr;
@property(nonatomic,retain)NSArray *indexdataArr;
@property(nonatomic,retain)UITableView *tableView;
@property(nonatomic,retain)NSMutableDictionary *thedatadic;
@property(nonatomic,retain)NSMutableDictionary *tmpdatadic;
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
@property(nonatomic,assign)BOOL isneedload;
@property(nonatomic,assign)BOOL isdeletedoc;
@property(nonatomic,assign)BOOL isfromTeamDetail;
@property(nonatomic,assign)id <ContactManagerViewControllerdelegate> delegate;
@property(nonatomic,retain)NSMutableArray *teammemberarr;
@property(nonatomic,retain)NSDictionary *ownerdatadic;
-(void)deleteaction;

@end
