//
//  TeamListViewController.m
//  CYS
//
//  Created by 谢阳晴 on 16/1/20.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import "TeamListViewController.h"
#import "OpenModel.h"
#import "CutomUIButton.h"
#import "DoctorTeamViewController.h"

#import "RCDChatViewController.h"
#import "RCDataBaseManager.h"
#import "AFHttpTool.h"

#import "RCDGroupInfo.h"
#import "RCDChatListViewController.h"

#import "RCDHTTPTOOL.h"

#import "PatientChatViewController.h"




@interface TeamListViewController (){
    NSIndexPath *openedpath;
    CutomUIButton *commentLongRecognizer;
    NSTimer *timer;
    NSInteger timercount;
    NSMutableArray *openmodelarr;
    OpenModel *needopenmodel;
    CutomUIButton *commentmodel;
    NavBarView *mybarview;
    NSMutableArray *dataarr;
    NSMutableArray *_participatedTeamarr;
    NSMutableArray *_teamarr;
    UIView *blankView;
    
    
}
@property(nonatomic,retain)NSMutableArray *contents;

@end

@implementation TeamListViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    //self.isphone=NO;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadindex:) name:@"reloadindex" object:nil];

    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    
    self.title=@"咨询";
    [self.view addSubview:self.tableView];
   // [[RCIMClient sharedRCIMClient]setReceiveMessageDelegate:self object:nil];
    [[RCIM sharedRCIM]setReceiveMessageDelegate:self];
    
    [RCIM sharedRCIM].userInfoDataSource = self;
    [RCIM sharedRCIM].groupInfoDataSource = self;
    //  [RCIM sharedRCIM].enableMessageAttachUserInfo = false;
    //设置接收消息代理
    [RCIM sharedRCIM].receiveMessageDelegate=self;
    

    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(newmsg:) name:@"havenewIMmsg" object:nil];
    
    
    
    
    
    
    
    //
            UIView *headerview= [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
            //self.tableView.tableHeaderView =headerview;
            UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
            button.frame=headerview.frame;
           // [button setTitle:@"我的团队" forState:UIControlStateNormal];
            [button setTitleColor:KBlackColor forState:UIControlStateNormal];
            [button addTarget:self action:@selector(myteamaction) forControlEvents:UIControlEventTouchUpInside];
            [headerview addSubview:button];
    
            UILabel *itemlabel=[[UILabel alloc]initWithFrame:CGRectMake(15, 0, 90, 50)];
            itemlabel.text=@" 我的团队";
            itemlabel.textColor=KBlackColor;
            itemlabel.font=[UIFont boldSystemFontOfSize:18.0];
            // itemlabel.backgroundColor=KGreenColor;
            itemlabel.textAlignment=NSTextAlignmentLeft;
             [headerview addSubview:itemlabel];
    
    
            UIView *lineview=[[UIView alloc] initWithFrame:CGRectMake(0, 49.5, [UIScreen mainScreen].bounds.size.width, 0.5)];
            lineview.backgroundColor=KLineColor;
            lineview.alpha=0.3;
            [headerview addSubview:lineview];
    
    
    
    
    
    
     [self getconverstionsdata];
    
    
    
    
    
//    
//    self.grouparr1=[[NSMutableArray alloc]initWithArray:@[@"123456",@"123457",@"123458"]];
//    self.grouparr2=[[NSMutableArray alloc]initWithArray:@[@"123461",@"123462",@"123463"]];
//    NSMutableArray *arr3=[[NSMutableArray alloc]initWithArray:@[@"123471"]];
    
//    dataarr=[[NSMutableArray alloc]initWithArray:@[self.grouparr1,self.grouparr2,arr3]];
}
//-(void)creatediscussion{
//   
//    NSMutableString *discussionTitle = [NSMutableString string];
//    NSMutableArray *userIdList = [NSMutableArray new];
//    [userIdList addObject:@"dongbin"];
//     [userIdList addObject:@"yangqing"];
////    for (RCUserInfo *user in selectedUsers) {
////        [discussionTitle appendString:[NSString stringWithFormat:@"%@%@", user.name,@","]];
////        [userIdList addObject:user.userId];
////    }
////    [discussionTitle deleteCharactersInRange:NSMakeRange(discussionTitle.length - 1, 1)];
//    
//    [[RCIMClient sharedRCIMClient] createDiscussion:@"hahaah" userIdList:userIdList success:^(RCDiscussion *discussion) {
//        NSLog(@"create discussion ssucceed!");
//        dispatch_async(dispatch_get_main_queue(), ^{
//             NSLog(@"%@",discussion.discussionId);
//            RCDChatViewController *chat =[[RCDChatViewController alloc]init];
//            chat.targetId                      = discussion.discussionId;
//            chat.userName                    = discussion.discussionName;
//            chat.conversationType              = ConversationType_DISCUSSION;
//            chat.title                         = @"讨论组";
//            
//            self.tabBarController.navigationController.tabBarController.navigationController.navigationBar.hidden=NO;
//            [self.tabBarController.navigationController.tabBarController.navigationController pushViewController:chat animated:YES];
////            UITabBarController *tabbarVC = weakSelf.navigationController.viewControllers[0];
////            [weakSelf.navigationController popViewControllerAnimated:NO];
////            [tabbarVC.navigationController  pushViewController:chat animated:YES];
//        });
//    } error:^(RCErrorCode status) {
//        NSLog(@"create discussion Failed > %ld!", (long)status);
//    }];
//}
-(void)reloadindex:(NSNotification *)sender{
   
}

- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion{
    
    //    NSArray *myarr=[[RCDataBaseManager shareInstance] getAllUserInfo];
    //    RCUserInfo *model=(RCUserInfo *)[myarr objectAtIndex:i];
    //    i++;
    //     NSLog(@"portraitUri %@",model.portraitUri);
//    RCUserInfo *user = [[RCUserInfo alloc]init];
//    user.userId = userId;
//    user.name = @"东斌";
//    user.portraitUri = @"http://img.taopic.com/uploads/allimg/140119/234926-14011ZU35340.jpg";
//    
//    
//    //  if (userId==model.userId) {
//    return completion(user);
     NSLog(@"%@",userId);
    
    [UserDataService getUserInfofortargetIdWithtargetId:userId block:^(id userinfomodel) {
        UserInfoModel *model=(UserInfoModel *)userinfomodel;
        
        RCUserInfo *user = [[RCUserInfo alloc]init];
        user.userId = userId;
        user.name =model.username;
        user.portraitUri = model.pimgurl;
        
        NSLog(@"%@   %@",userId ,model.targetid);
        
        NSLog(@"%@",model.pimgurl);
        NSLog(@"%@",model.username);
        
        //  if (userId==model.userId) {
        return completion(user);
        
        //        [imagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.pimgurl]] placeholderImage:[UIImage imageNamed:kPlaceholderimage]];
        //        label.text=[NSString stringWithFormat:@"%@",model.username];
    }];

    
    //   }
    //  return completion(nil);
    
}
- (void)getGroupInfoWithGroupId:(NSString *)groupId completion:(void (^)(RCGroup *groupInfo))completion{
    
    //    NSArray *myarr= [RCDDataSource getAllGroupInfo:nil];
    //    RCGroup *model=(RCGroup *)[myarr objectAtIndex:i];
    //    i++;
    //    NSLog(@"portraitUri %@",model.portraitUri);
    
    RCGroup *user = [[RCGroup alloc]init];
    //    if (model) {
    //        <#statements#>
    //    }
    // if ([model.groupId isEqualToString:groupId]) {
    
    
    NSLog(@"%@",user.groupId);
    NSLog(@"%@",groupId);
    [UserDataService getGroupInfofortargetIdWithGroupId:groupId block:^(id usermodel) {
        GroupInfoModel *uinfomodel=(GroupInfoModel *)usermodel;
        NSLog(@"%@",uinfomodel.groupinfodic);
        NSLog(@"%@",uinfomodel.groupinfodic);
        
        user.groupId = groupId;
        user.groupName = [NSString stringWithFormat:@"%@团队",[[uinfomodel.groupinfodic objectForKey:@"team"] objectForKey:@"name"]];
        user.portraitUri = [[uinfomodel.groupinfodic objectForKey:@"owner"] objectForKey:@"icon_url"];
        
        return completion(user);
        
    }];

    
//    if ( [groupId isEqualToString:@"123456"]) {
//        user.groupId = @"123456";
//        user.groupName = @"1个神奇的群";
//        user.portraitUri = @"http://img.taopic.com/uploads/allimg/140119/234926-14011ZU35340.jpg";
//        
//    }else  if ( [groupId isEqualToString:@"123457"]) {
//        user.groupId = @"123457";
//        user.groupName = @"2个神奇的群";
//        user.portraitUri = @"http://img.taopic.com/uploads/allimg/140119/234926-14011ZU35340.jpg";
//        
//    }else  if ( [groupId isEqualToString:@"123458"]) {
//        user.groupId = @"123458";
//        user.groupName = @"3个神奇的群";
//        user.portraitUri = @"http://img.taopic.com/uploads/allimg/140119/234926-14011ZU35340.jpg";
//        
//    }else  if ( [groupId isEqualToString:@"123461"]) {
//        user.groupId = @"123461";
//        user.groupName = @"神奇的群1";
//        user.portraitUri = @"http://img.taopic.com/uploads/allimg/140119/234926-14011ZU35340.jpg";
//        
//    }else  if ( [groupId isEqualToString:@"123462"]) {
//        user.groupId = @"123462";
//        user.groupName = @"神奇的群2";
//        user.portraitUri = @"http://img.taopic.com/uploads/allimg/140119/234926-14011ZU35340.jpg";
//        
//    }else  if ( [groupId isEqualToString:@"123463"]) {
//        user.groupId = @"123463";
//        user.groupName = @"神奇的群3";
//        user.portraitUri = @"http://img.taopic.com/uploads/allimg/140119/234926-14011ZU35340.jpg";
//        
//    }else {
//        // user.groupId = @"123456";
//        user.groupName = @"神奇群【广州中心医院心内科胡大一】";
//        // NSString *contentStr = @"简介：hello world";
//        //  NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:contentStr];
//        //设置：在0-3个单位长度内的内容显示成红色
//        //[str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 3)];
//        //label.attributedText = str;
//        // user.groupName=str;
//        user.portraitUri = @"http://img.taopic.com/uploads/allimg/140119/234926-14011ZU35340.jpg";
//        
//    }
    
    
    
  //  return completion(user);
    //     }
    //  return completion(nil);
    
}
- (void)getUserInfoWithUserId:(NSString *)userId
                      inGroup:(NSString *)groupId
                   completion:(void (^)(RCUserInfo *userInfo))completion{
    RCUserInfo *user = [[RCUserInfo alloc]init];
    user.userId = userId;
    user.name = @"东斌";
    user.portraitUri = @"http://img.taopic.com/uploads/allimg/130724/240450-130H422422687.jpg";
    
    
    //  if (userId==model.userId) {
    return completion(user);
    
    
}



-(void)getconverstionsdata{
   dataarr=[[NSMutableArray alloc]initWithArray:[[RCIMClient sharedRCIMClient]getConversationList:@[@(ConversationType_GROUP)]]];

  //  RCConversation *cov=[dataarr objectAtIndex:0];
//   [[RCIMClient sharedRCIMClient]getDiscussion:cov.discussionId success:^(RCDiscussion *discussion) {
//       
//   } error:^(RCErrorCode status) {
//       
//   }];
//    NSLog(@"%@",cov.discussionName);
//      NSLog(@"%@",cov.discussionId);
    
    NSSortDescriptor*sorter=[[NSSortDescriptor alloc]initWithKey:@"receivedTime" ascending:YES];
    NSMutableArray *sortDescriptors=[[NSMutableArray alloc]initWithObjects:&sorter count:1];
    NSArray *sortArray=[dataarr sortedArrayUsingDescriptors:sortDescriptors];
    sortArray = (NSMutableArray *)[[sortArray reverseObjectEnumerator] allObjects];
//    for (RCConversation *cov in sortArray) {
//        //[dataarr addObject:<#(nonnull id)#>]
//    }
    
    dataarr=[[NSMutableArray alloc]initWithArray:sortArray];
    
    
    
    [blankView removeFromSuperview];
    
    if (dataarr.count==0) {
        
        blankView=[[UIView alloc]initWithFrame:self.tableView.bounds];
        
        
        blankView.backgroundColor=KBackgroundColor;
        UIImageView *blankimagev=[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/2.0-70/2.0, 150, 70, 55)];
        blankimagev.image=[UIImage imageNamed:@"no_chat"];
        
        [blankView addSubview:blankimagev];
        
        
        
        UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2.0-150/2.0, 220, 150, 30)];
        label1.text=@"暂无患者咨询";
        label1.textColor=KtextGrayColor;
        label1.textAlignment=NSTextAlignmentCenter;
        label1.font=[UIFont systemFontOfSize:16.0];
        
       
        [blankView addSubview:label1];

        
        
        
        [self.view addSubview:blankView];
        
    }else{
       [self.tableView reloadData];
    }
    
    
    
//    for (RCConversation *cov in dataarr) {
//        
//        NSLog(@"%@",cov.targetId);
//        
//        //分组
//        
//    }

}

-(void)myteamaction{
    
    DoctorTeamViewController *doctorteam=[[DoctorTeamViewController alloc]init];
//    doctorteam.teamarr=_teamarr;
//    doctorteam.participatedTeamarr=_participatedTeamarr;
//    doctorteam.invitationarr=self.invitationarr;
    
    self.tabBarController.navigationController.tabBarController.navigationController.navigationBar.hidden=NO;
    [self.tabBarController.navigationController.tabBarController.navigationController pushViewController:doctorteam animated:YES];
   // [self creatediscussion];
}


-(void)getallgroupdata{
//    JGProgressHUD *hud=[[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleDark];
//    [hud showInView:self.view];
//    [hud dismissAfterDelay:5];
//    
//    [DocTeamDataService getDocAllTeamblock:^(id responsearr) {
//        NSMutableArray *docteamarr=(NSMutableArray *)responsearr;
//        NSLog(@"%@",docteamarr);
//        _teamarr=[[NSMutableArray alloc]initWithArray:docteamarr];
//      //  [self.tableView reloadData];
//        // NSMutableArray *participatedTeamarr;
//        
//        [DocTeamDataService getAllparticipatedTeamblock:^(id responsearr1) {
//            NSMutableArray *participatedTeamarr=(NSMutableArray *)responsearr1;
//            _participatedTeamarr=participatedTeamarr;
//            [hud dismiss];
//           // [_teamarr addObjectsFromArray:_participatedTeamarr];
//            
//        }];
//        
//    }];
    
}
- (void)onRCIMReceiveMessage:(RCMessage *)message left:(int)left{
    
//    NSLog(@"%@",message.targetId);
//    BOOL havesame = NO;
//    NSMutableArray *turedataarr=[[NSMutableArray alloc]initWithArray:dataarr];
//        for (NSMutableArray *tmparr in dataarr) {
//            
//            
//            for (NSString *idstr in tmparr) {
//                if ([idstr isEqualToString:message.targetId]) {
//                    havesame=YES;
//                    //return;
//                }
//            
//            }
//            
//            
//          }
//    if (havesame==NO) {
//        [turedataarr addObject:@[message.targetId]];
//    }
//    [dataarr removeAllObjects];
//    dataarr=[[NSMutableArray alloc]initWithArray:turedataarr];
//    
//    
//    NSLog(@"%@",message.targetId);
    //[self.tableView reloadData];
    
 //   [self.tableView removeFromSuperview];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.tabBarController.tabBar.hidden=NO;
    //self.tabBarController.navigationController.tabBarController.navigationController.navigationBar.hidden=YES;
    [self getconverstionsdata];
   // [self.tableView reloadData];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 74.0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    
    return dataarr.count;
}
-(NSMutableArray *)willReloadTableData:(NSMutableArray *)dataSource
{
    //  NSLog(@"%@",self.extra);
    for (int i=0; i<dataSource.count; i++) {
        RCConversationModel *model = dataSource[i];
        //NSLog(@"origin %@",model.targetId);
    }
    
    for (int i=0; i<dataSource.count; i++) {
        RCConversationModel *model = dataSource[i];
        //        //筛选请求添加好友的系统消息，用于生成自定义会话类型的cell
        if(model.conversationType == ConversationType_SYSTEM && [model.lastestMessage isMemberOfClass:[RCContactNotificationMessage class]])
        {
            model.conversationModelType = RC_CONVERSATION_MODEL_TYPE_CUSTOMIZATION;
        }
        
        
        
        
        //      //  NSLog(@"%@",[model.targetId substringToIndex:5]);
        //        if (self.isgroup) {
        //            //for (NSString * targetid in self.grouparr) {
        //                if ([self.extra isEqualToString:[model.targetId substringToIndex:5]]) {
        //
        //                }else{
        //                //    NSLog(@"move%@",model.targetId);
        //                    [dataSource removeObject:model];
        //                }
        //
        //           // }
        //
        //
        //        }
        
    }
    //    NSMutableArray *turedataarr=[[NSMutableArray alloc]initWithArray:dataSource];
    //    for (RCConversationModel *model in dataSource) {
    //            if (self.isgroup) {
    //
    //            if ([self.extra isEqualToString:[model.targetId substringToIndex:5]]) {
    //
    //            }else{
    //
    //                [turedataarr removeObject:model];
    //            }
    //
    //
    //        }
    //
    //    }
    //    [dataSource removeAllObjects];
    //    dataSource=[[NSMutableArray alloc]initWithArray:turedataarr];
    //
    ////    for (int i=0; i<dataSource.count; i++) {
    ////        RCConversationModel *model = dataSource[i];
    ////        NSLog(@"inn %@",model.targetId);
    ////        if (self.isgroup) {
    ////
    ////                    NSLog(@"what %@ %@",self.extra,model.targetId);
    ////            
    ////            // }
    ////            
    ////            
    ////        }
    ////        
    ////    }
    return dataSource;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=nil;
    for (UIView *subv in cell.contentView.subviews) {
        [subv removeFromSuperview];
    }
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"usercell"];
    }
    
    RCConversation *cov=[dataarr objectAtIndex:indexPath.row];
    
    
    UIImageView *imagev;
    //=[[UIImageView alloc]init];
    
    
    imagev =[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 54, 54)];
    //   imagev.frame=CGRectMake(10, 8, 44, 44);
    
    
    
    
    imagev.clipsToBounds=YES;
    
    imagev.layer.masksToBounds=YES;
    imagev.layer.cornerRadius =22.0;
    imagev.layer.borderColor = [UIColor clearColor].CGColor;
    imagev.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    // imagev.image=[UIImage imageNamed:@"KAKA"];
    //  NSLog(@"%@",[NSString stringWithFormat:@"%@",[datadic objectForKey:@"icon"]]);
    
    
    
 
  
    
    
    [cell.contentView addSubview:imagev];
    
    UILabel *label=[[UILabel alloc]init];
    label.frame=CGRectMake(70, 8, 190, 30);
    //label.textColor=[];
    label.font=[UIFont boldSystemFontOfSize:16.0];
    label.backgroundColor=[UIColor clearColor];
    label.textAlignment=NSTextAlignmentLeft;
    [cell.contentView addSubview:label];
    
  
    
//    NSString *contentstring=[NSString stringWithFormat:@"%@",@"橙医生【胡大一医生团队】"];
//    
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:label.text];
//    NSString *temp = nil;
//    for(int i =0; i < [attributedString length]; i++)
//    {
//        temp = [label.text substringWithRange:NSMakeRange(i, 1)];
//        if( i>2  ){
//            [attributedString setAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//                                             KlightOrangeColor, NSForegroundColorAttributeName,
//                                             [UIFont boldSystemFontOfSize:15.0],NSFontAttributeName, nil]
//                                      range:NSMakeRange(i, 1)];
//        }else{
//            [attributedString setAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//                                             kimiColor(157, 157, 157, 1.0), NSForegroundColorAttributeName,
//                                             [UIFont boldSystemFontOfSize:13.0],NSFontAttributeName, nil]
//                                      range:NSMakeRange(i, 1)];
//        }
//    }
//    
//    label.attributedText = attributedString;
//    [label sizeToFit];
   // label.text=[NSString stringWithFormat:@"%@",cov.conversationTitle];
    //label.text=
    
    
    
    
    UILabel *detaillabel=[[UILabel alloc]init];
    detaillabel.frame=CGRectMake(70, 30, 250, 30);
    detaillabel.textColor=KlightOrangeColor;
    detaillabel.font=[UIFont systemFontOfSize:15.0];
    detaillabel.backgroundColor=[UIColor clearColor];
    detaillabel.textAlignment=NSTextAlignmentLeft;
    [cell.contentView addSubview:detaillabel];
    
    
    
     
 
    
    UILabel *desclabel=[[UILabel alloc]init];
    desclabel.frame=CGRectMake(70, 74-30, 180, 30);
    desclabel.textColor=KtextGrayColor;
    desclabel.font=[UIFont systemFontOfSize:13.0];
    desclabel.backgroundColor=[UIColor clearColor];
    [cell.contentView addSubview:desclabel];
    
 //   [RCIM sharedRCIM]groupUserInfoDataSource;
    
    
    
    
    
    [UserDataService getGroupInfofortargetIdWithGroupId:cov.targetId block:^(id ginfomodel) {
        GroupInfoModel *groupinfomodel=(GroupInfoModel *)ginfomodel;
        [imagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",groupinfomodel.pimgurl]] placeholderImage:[UIImage imageNamed:@"load_image2"]];
        NSLog(@"%@",groupinfomodel.groupinfodic);
        [[groupinfomodel.groupinfodic objectForKey:@"team"] objectForKey:@"name"];
        detaillabel.text=[NSString stringWithFormat:@"%@(%@的团队)",[[groupinfomodel.groupinfodic objectForKey:@"team"] objectForKey:@"name"],[[groupinfomodel.groupinfodic objectForKey:@"owner"] objectForKey:@"name"]];
        detaillabel.numberOfLines=1;
        [detaillabel sizeToFit];

        label.text=groupinfomodel.username;
        [label sizeToFit];
    }];
    
    
    NSLog(@"%@",cov.senderUserId);
    [UserDataService getUserInfofortargetIdWithtargetId:cov.senderUserId block:^(id userinfomodel) {
        UserInfoModel *model=(UserInfoModel *)userinfomodel;
       
        
        
        NSLog(@"%@",cov.draft);
        
        if (cov.draft.length!=0) {
            desclabel.text=[NSString stringWithFormat:@"【草稿】%@",cov.draft];
            desclabel.textColor=[UIColor redColor];
        }else{
            if ([cov.jsonDict objectForKey:@"longitude"]) {
                
                desclabel.text=[NSString stringWithFormat:@"%@：%@",model.username,@"【位置】"];
                
            }else if ([cov.jsonDict objectForKey:@"url"]){
                
                
                desclabel.text=[NSString stringWithFormat:@"%@：%@",model.username,@"【链接】"];
                
            }else if ([cov.jsonDict objectForKey:@"imageUri"]){
                
                
                desclabel.text=[NSString stringWithFormat:@"%@：%@",model.username,@"【图片】"];
                
            }else{
                
                desclabel.text=[NSString stringWithFormat:@"%@：%@",model.username,[cov.jsonDict objectForKey:@"content"]];
                
            }
            
            
        }

        
        
    }];
    
   
    
    
   
   // NSString *groupid;
//    if (indexPath.row==0) {
//         label.text=[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@",@"群组1"]];
//    } else {
    
  
  //  }
    
  //  CGSize *itemsize=KStringSize([NSString stringWithFormat:@"%i",cov.unreadMessageCount], 20, [UIFont boldSystemFontOfSize:13.0]);
    
    
    
    
    
  
    //if (indexPath.row==0) {
       // groupid=[self.grouparr1 objectAtIndex:indexPath.row];
    
////        for (NSString *groupid in tmparr ) {
//             RCConversation *cov=[[RCIMClient sharedRCIMClient]getConversation:ConversationType_GROUP targetId:groupid];
//            NSLog(@"row 0%i",cov.unreadMessageCount);
//            
        NSInteger unreadcount=cov.unreadMessageCount;
    //    }
        
//        
//    } else {
//        for (NSString *groupid in self.grouparr2 ) {
//            RCConversation *cov=[[RCIMClient sharedRCIMClient]getConversation:ConversationType_GROUP targetId:groupid];
//              NSLog(@"row 1%i",cov.unreadMessageCount);
//            unreadcount=unreadcount+cov.unreadMessageCount;
//        }
//
//    }
    
   
    
    UIFont *font=[UIFont systemFontOfSize:13.0];
    NSString *heightstr=[NSString stringWithFormat:@"%zd",unreadcount];
    CGRect strsize=[heightstr boundingRectWithSize:CGSizeMake(ScreenWidth, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    
    
    //            UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(myframe.origin.x, myframe.origin.y, strsize.size.width+10, 20.0)];
    CGFloat width;
    if (strsize.size.width+10.0<20.0) {
        width=20.0;
    }else{
        width=strsize.size.width+10.0;
    }
  //  msgcountlabel=[[UILabel alloc]initWithFrame:CGRectMake(140, 17,width , 20)];
    
    
    UILabel *unreadlabel=[[UILabel alloc]init];
    unreadlabel.frame=CGRectMake(ScreenWidth-50, 84/2.0-10.0, width, 20);
    unreadlabel.textColor=[UIColor whiteColor];
    unreadlabel.clipsToBounds=YES;
    unreadlabel.layer.masksToBounds=YES;
    unreadlabel.layer.cornerRadius =10.0;
    unreadlabel.layer.borderColor = [UIColor clearColor].CGColor;
    unreadlabel.layer.rasterizationScale = [UIScreen mainScreen].scale;
    unreadlabel.textAlignment=NSTextAlignmentCenter;
    unreadlabel.text=heightstr;
    unreadlabel.font=[UIFont boldSystemFontOfSize:13.0];
    unreadlabel.backgroundColor=[UIColor redColor];
    unreadlabel.hidden=YES;
    if (unreadcount>0) {
        unreadlabel.hidden=NO;
    }
    [cell.contentView addSubview:unreadlabel];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    
    return cell;
    
}
-(void)getGroupinfowithid{
    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//   RCDChatListViewController *vc=[[RCDChatListViewController alloc]initWithDisplayConversationTypes:@[@(ConversationType_GROUP)] collectionConversationType:nil];
//    vc.isgroup=YES;
//  
//   // if (indexPath.row==0) {
//      NSMutableArray *tmparr=[dataarr objectAtIndex:indexPath.row];
//      NSString *str=[tmparr objectAtIndex:0];
//      vc.extra=[str substringToIndex:5];
////    } else if(indexPath.row==0) {
////        vc.extra=@"12346";
////    }else if(indexPath.row==0) {
////        vc.extra=@"12346";
////    }
//      [vc refreshConversationTableViewIfNeeded];
//    self.tabBarController.navigationController.tabBarController.navigationController.navigationBar.hidden=NO;
//    [self.tabBarController.navigationController.tabBarController.navigationController pushViewController:vc animated:YES];
//
    
     RCConversation *cov=[dataarr objectAtIndex:indexPath.row];
//    RCDChatViewController *_conversationVC = [[RCDChatViewController alloc]init];
//    _conversationVC.conversationType = ConversationType_GROUP;
//   
//    _conversationVC.targetId = cov.targetId;
//    _conversationVC.userName = cov.conversationTitle;
//    _conversationVC.title = cov.conversationTitle;
//   // _conversationVC.conversation = cov;
//    _conversationVC.unReadMessage = cov.unreadMessageCount;
//    _conversationVC.enableNewComingMessageIcon=YES;//开启消息提醒
//    _conversationVC.enableUnreadMessageIcon=YES;
////    if (model.conversationType == ConversationType_SYSTEM) {
////        _conversationVC.userName = @"系统消息";
//        _conversationVC.title = @"系统消息";
//    }
    
    [UserDataService getGroupInfofortargetIdWithGroupId:cov.targetId block:^(id ginfomodel) {
       
        
        GroupInfoModel *groupinfomodel=(GroupInfoModel *)ginfomodel;
        
        
        NSLog(@"groupinfo %@",groupinfomodel.groupinfodic);
        
        
        RCConversationModel *model=[[RCConversationModel alloc]init];
        model.targetId=cov.targetId;
        model.conversationTitle=cov.conversationTitle;
        model.conversationType=ConversationType_GROUP;
        
        PatientChatViewController *conversationPageVC=[[PatientChatViewController alloc]initWithChatModel:model];
       
        conversationPageVC.title=groupinfomodel.username;
        conversationPageVC.model=model;
        conversationPageVC.isgroup=YES;
        NSLog(@"teamid%@",[[groupinfomodel.groupinfodic objectForKey:@"team"] objectForKey:@"id"]);
        conversationPageVC.teamid=[[groupinfomodel.groupinfodic objectForKey:@"team"] objectForKey:@"id"];
        conversationPageVC.teamdic=groupinfomodel.groupinfodic;
        conversationPageVC.patientd=[[groupinfomodel.groupinfodic objectForKey:@"patient"] objectForKey:@"id"];
        [conversationPageVC setupmorebutton];
      
        
//        ExampleViewController *conversationPageVC=[[ExampleViewController alloc]initWithChatModel:model];
//            conversationPageVC.vi=self;
//            conversationPageVC.delegate=self;
//            titlearr=@[@"1",@"2"];
//            vcarr=@[vc,vc1];

        
        self.navigationController.tabBarController.tabBar.hidden=YES;
        
        [self.navigationController.tabBarController.navigationController pushViewController:conversationPageVC animated:YES];
        

    }];

    
    
    
    
    
//    [[UINavigationBar appearance] setTintColor:KlightOrangeColor];
//    self.tabBarController.navigationController.tabBarController.navigationController.navigationBar.hidden=NO;
//    [self.tabBarController.navigationController.tabBarController.navigationController pushViewController:_conversationVC animated:YES];
    
    
    
    
}
-(void)newmsg:(NSNotification *)sender{
   // [self.tableView reloadData];
    [self getconverstionsdata];
}

@end
