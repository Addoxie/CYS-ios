//
//  InvitefriendsViewController.h
//  ByShare
//
//  Created by 谢阳晴 on 14/12/5.
//  Copyright (c) 2014年 谢阳晴. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMessageComposeViewController.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@protocol InvitefriendsViewControllerdelegate <NSObject>

-(void)sentselectedcontacts:(NSMutableArray *)contactdataArr;

@end

@interface InvitefriendsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MFMessageComposeViewControllerDelegate,navbardelegate,UITextFieldDelegate>

@property(nonatomic,retain)NSMutableArray *dataArr;
@property(nonatomic,retain)NSArray *indexdataArr;
@property(nonatomic,retain)UITableView *tableView;
@property(nonatomic,retain)NSMutableDictionary *thedatadic;
@property(nonatomic,retain)NSMutableDictionary *tmpdatadic;
@property(nonatomic,retain)NSMutableDictionary *resultdatadic;
@property(nonatomic,assign)BOOL needsearch;
@property(nonatomic,retain)UITextField *textfield;

@property(nonatomic,retain)NSMutableArray *selecteddataArr;
@property(nonatomic,retain)NSMutableArray *haveselecteddataArr;
@property(nonatomic,assign) id <InvitefriendsViewControllerdelegate> delegate;
@end
