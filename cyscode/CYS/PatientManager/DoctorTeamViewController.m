//
//  DoctorTeamViewController.m
//  CYS
//
//  Created by 谢阳晴 on 15/12/23.
//  Copyright © 2015年 谢阳晴. All rights reserved.
//

#import "DoctorTeamViewController.h"
#import "GroupDetailViewController.h"
#import "InviteMessageListViewController.h"

@interface DoctorTeamViewController ()
{
    NSMutableArray *dataarr;
    BOOL haveshowdoc;
    BOOL haveshowpat;
    NSMutableArray *docarr;
    NSMutableArray *patientarr;
    NSMutableArray *tmpdocarr;
    NSMutableArray *tmppatientarr;
    UIImageView *showmydocimagev;
    UIImageView *showpartdocimagev;
}
@property(nonatomic,retain)UITableView *tableView;
@end


@implementation DoctorTeamViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor=KBackgroundColor;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloaddocteam:) name:@"reloaddocteam" object:nil];
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 12, ScreenWidth, ScreenHeight-12) style:UITableViewStyleGrouped];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.separatorColor=[UIColor clearColor];
    [self.view addSubview:self.tableView];
    NSArray *arr=(NSArray *)self.teamarr;
    self.teamarr=[[NSMutableArray alloc]initWithArray:arr];
  // NSLog(@"%@",self.teamarr);
    self.title=@"医生团队";
//    UIButton *morebutton=[UIButton buttonWithType:UIButtonTypeCustom];
//    morebutton.frame=CGRectMake(0, 0, 35, 30);
//    
//    [morebutton setTitle:@"创建" forState:UIControlStateNormal];
//    //[canclebutton setImage:[UIImage imageNamed:@"backArrow.png"] forState:UIControlStateNormal];
//    //[morebutton setImage:[UIImage imageNamed:@"tmp"] forState:UIControlStateNormal];
//    [morebutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [morebutton addTarget:self action:@selector(morebuttonaction) forControlEvents:UIControlEventTouchUpInside];
    //morebutton.hidden=YES;
    // [mybarview addSubview:morebutton];
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"创建" style:UIBarButtonItemStylePlain target:self action:@selector(morebuttonaction)];
                                           
//    UIView *bgv=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
//    bgv.backgroundColor=[UIColor whiteColor];
//    [self.view addSubview:bgv];
//    
 //   self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:morebutton];
    
//    JGProgressHUD *hud=[[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleDark];
//    [hud showInView:self.view];
//    [hud dismissAfterDelay:5];
    
     [self regetdata];
    
    self.tableView.backgroundColor=KBackgroundColor;
    
    
    
}
-(void)reloaddocteam:(NSNotification *)sender{
     [self regetdata];
}
-(void)morebuttonaction{
    EditnameViewController *editnamevc=[[EditnameViewController alloc]init];
    //editnamevc.isrootvc=NO;
    editnamevc.delegate=self;
    //    UIStoryboard *storyboard =
    //    [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //    UITabBarController *roottabbarvc = [storyboard
    //                                        instantiateViewControllerWithIdentifier:@"MainTabbarVC"];
    //    //                self.window.rootViewController = rootNavi;
    //    //roottabbarvc.navigationController.navigationBar.hidden=NO;
    self.navigationController.navigationBar.hidden=NO;
    //    if (self.isRoot) {
    //        [self.tabBarController.navigationController.tabBarController.navigationController pushViewController:editnamevc animated:YES];
    //    } else {
    [self.navigationController pushViewController:editnamevc animated:YES];

}
-(void)changenameWithNamestr:(NSString *)name{
   
    
}
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    
//    self.navigationController.navigationBar.hidden=NO;
//}
//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    self.navigationController.navigationBar.hidden=YES;
//}

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
    [self.tableView reloadData];
    
    //    for (RCConversation *cov in dataarr) {
    //
    //        NSLog(@"%@",cov.targetId);
    //        
    //        //分组
    //        
    //    }
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 12.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kHeightgetFloat(88);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *bgv=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, kHeightgetFloat(88))];
    bgv.backgroundColor=[UIColor whiteColor];
//    UIView *bgtopv=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
//    bgtopv.backgroundColor=KBackgroundColor;
//    [bgv addSubview:bgtopv];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(25, 0, ScreenWidth-80, kHeightgetFloat(88))];
    if (section==0) {
        label.frame=CGRectMake(10, 0, ScreenWidth-80, kHeightgetFloat(88));
         label.text=[NSString stringWithFormat:@" 受邀请信息"];
        
        UIImageView *imagev1=[[UIImageView alloc]init];
        //=[[UIImageView alloc]init];
        imagev1.frame=CGRectMake(ScreenWidth-18, kHeightgetFloat(88)/2.0-8, 10, 16);
        imagev1.image=[UIImage imageNamed:@"arrow"];
        
        imagev1.clipsToBounds=YES;
        
        imagev1.layer.masksToBounds=YES;
        imagev1.layer.cornerRadius =4.0;
        imagev1.layer.borderColor = [UIColor clearColor].CGColor;
        imagev1.layer.rasterizationScale = [UIScreen mainScreen].scale;
        label.textColor=KBlackColor;
        label.font=[UIFont systemFontOfSize:16.0];
        label.backgroundColor=[UIColor whiteColor];
        [bgv addSubview:label];
        
        // imagev.image=[UIImage imageNamed:@"KAKA"];
        //  NSLog(@"%@",[NSString stringWithFormat:@"%@",[datadic objectForKey:@"icon"]]);
        
        
        [bgv addSubview:imagev1];
        UILabel *namelabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-75, 0, 50, kHeightgetFloat(88))];
        namelabel.text=[NSString stringWithFormat:@"%zd",_invitationarr.count];
        namelabel.font=[UIFont boldSystemFontOfSize:14.0];
        namelabel.textColor=KtextGrayColor;
        namelabel.textAlignment=NSTextAlignmentRight;
        [bgv addSubview:namelabel];

    }else if (section==1) {
         label.text=@" 我的团队";
        showmydocimagev=[[UIImageView alloc]initWithFrame:CGRectMake(10, kHeightgetFloat(88)/2.0-10/2.0, 9, 10)];
        showmydocimagev.image=[UIImage imageNamed:@"expansion_2"];
        showmydocimagev.backgroundColor=[UIColor whiteColor];
        [bgv addSubview:showmydocimagev];
        label.textColor=KtextGrayColor;
        label.font=[UIFont systemFontOfSize:16.0];
        label.backgroundColor=[UIColor whiteColor];
        [bgv addSubview:label];
        
        UILabel *namelabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-60, 0, 50, kHeightgetFloat(88))];
        namelabel.text=[NSString stringWithFormat:@"%zd",docarr.count];
        namelabel.font=[UIFont boldSystemFontOfSize:14.0];
        namelabel.textColor=KtextGrayColor;
        namelabel.textAlignment=NSTextAlignmentRight;
        [bgv addSubview:namelabel];

    }else{
         label.text=@" 已加入的团队";
        showpartdocimagev=[[UIImageView alloc]initWithFrame:CGRectMake(10, kHeightgetFloat(88)/2.0-10/2.0, 9, 10)];
        showpartdocimagev.image=[UIImage imageNamed:@"expansion_2"];
        showpartdocimagev.backgroundColor=[UIColor whiteColor];
        [bgv addSubview:showpartdocimagev];
        label.textColor=KtextGrayColor;
        label.font=[UIFont systemFontOfSize:16.0];
        label.backgroundColor=[UIColor whiteColor];
        [bgv addSubview:label];
        
        UILabel *namelabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-60, 0, 50, kHeightgetFloat(88))];
        namelabel.text=[NSString stringWithFormat:@"%zd",patientarr.count];
        namelabel.font=[UIFont boldSystemFontOfSize:14.0];
        namelabel.textColor=KtextGrayColor;
        namelabel.textAlignment=NSTextAlignmentRight;
        [bgv addSubview:namelabel];
        

    }
    
   
   
    
    
    
    if (section==0) {
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=bgv.frame;
        [button addTarget:self action:@selector(inviteaction) forControlEvents:UIControlEventTouchUpInside];
        [bgv addSubview:button];
//        UILabel *namelabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-55, 20, 50, 50)];
//        namelabel.text=[NSString stringWithFormat:@"%zd",patientarr.count];
//        namelabel.font=[UIFont boldSystemFontOfSize:14.0];
//        namelabel.textColor=KLineColor;
//        namelabel.textAlignment=NSTextAlignmentRight;
//        [bgv addSubview:namelabel];

    }else if (section==1) {
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=bgv.frame;
        [button addTarget:self action:@selector(showmydocaction) forControlEvents:UIControlEventTouchUpInside];
        [bgv addSubview:button];

    }else{
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=bgv.frame;
        [button addTarget:self action:@selector(showpartdocaction) forControlEvents:UIControlEventTouchUpInside];
        [bgv addSubview:button];

    }
    
    
//    
//    UIView *linev=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
//    linev.backgroundColor=KBackgroundColor;
//    [bgv addSubview:linev];
    
    
    
    return bgv;
}

-(void)inviteaction{
    
    
    InviteMessageListViewController *groupvc=[[InviteMessageListViewController alloc]init];
    groupvc.invitationarr=_invitationarr;
    
    [self.navigationController pushViewController:groupvc animated:YES];
    
}
-(void)showmydocaction{
    
    
    
    
    
    if (haveshowdoc) {
        haveshowdoc=NO;
        
        
        NSInteger contentCount = [docarr count];
        //
        NSMutableArray* rowToInsert = [[NSMutableArray alloc] init];
        
        for (NSUInteger i = 0; i < contentCount; i++) {
            
            NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:i inSection:1];
            
            [rowToInsert addObject:indexPathToInsert];
            
        }
        
        
        [self.tableView beginUpdates];
        // tmpdocarr=docarr;
        [tmpdocarr removeAllObjects];
        [self.tableView deleteRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
        self.tableView.userInteractionEnabled=YES;
        showmydocimagev.image=[UIImage imageNamed:@"expansion_2"];
        
    }else{
        // docarr=tmpdocarr;
        haveshowdoc=YES;
        
        //  NSLog(@"%@",tmpdocarr);
        NSInteger contentCount = [docarr count];
        //
        NSMutableArray* rowToInsert = [[NSMutableArray alloc] init];
        
        for (NSUInteger i = 0; i < contentCount; i++) {
            
            NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:i inSection:1];
            
            [rowToInsert addObject:indexPathToInsert];
            
        }
        
        [self.tableView beginUpdates];
        // docarr=tmpdocarr;
        [self.tableView insertRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
        [self.tableView endUpdates];
        self.tableView.userInteractionEnabled=YES;
        
        
        
        showmydocimagev.image=[UIImage imageNamed:@"expansion_1"];
        
        
        
    }
    

    
    
    
    

}
-(void)showpartdocaction{
    if (haveshowpat) {
        haveshowpat=NO;
        
        
        NSInteger contentCount = [patientarr count];
        //
        NSMutableArray* rowToInsert = [[NSMutableArray alloc] init];
        
        for (NSUInteger i = 0; i < contentCount; i++) {
            
            NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:i inSection:2];
            
            [rowToInsert addObject:indexPathToInsert];
            
        }
        
        
        [self.tableView beginUpdates];
        [tmppatientarr removeAllObjects];
        [self.tableView deleteRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
        self.tableView.userInteractionEnabled=YES;
        showpartdocimagev.image=[UIImage imageNamed:@"expansion_2"];
        
    }else{
        
        haveshowpat=YES;
        //   haveshowdoc=YES;
        
        
        NSInteger contentCount = [patientarr count];
        //
        NSMutableArray* rowToInsert = [[NSMutableArray alloc] init];
        
        for (NSUInteger i = 0; i < contentCount; i++) {
            
            NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:i inSection:2];
            
            [rowToInsert addObject:indexPathToInsert];
            
        }
        
        [self.tableView beginUpdates];
        // patientarr=tmppatientarr;
        [self.tableView insertRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
        [self.tableView endUpdates];
        self.tableView.userInteractionEnabled=YES;
        showpartdocimagev.image=[UIImage imageNamed:@"expansion_1"];
        
        
    }

}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section==0) {
         return 0;
    }else if(section==1){
        if (haveshowdoc) {
            return docarr.count;
        }else{
            return 0;
            
        }
        
    }else{
        if (haveshowpat) {
            return patientarr.count;
        } else {
            return 0;
            
        }
        
    }

   
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        return kHeightgetFloat(88);
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=nil;
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"myviewcell"];
    }
    
    if (indexPath.section==0) {
        
        
        
        
        NSDictionary *dic=(NSDictionary *)[self.invitationarr objectAtIndex:indexPath.row];
        
        UIImageView *imagev;
        //=[[UIImageView alloc]init];
        
        
        imagev =[[UIImageView alloc]initWithFrame:CGRectMake(10, kHeightgetFloat(88)/2.0-28/2.0, 28, 28)];
        //   imagev.frame=CGRectMake(10, 8, 44, 44);
        
        
        
        imagev.clipsToBounds=YES;
        
        imagev.layer.masksToBounds=YES;
        imagev.layer.cornerRadius =20.0;
        imagev.layer.borderColor = [UIColor clearColor].CGColor;
        imagev.layer.rasterizationScale = [UIScreen mainScreen].scale;
        [imagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@""]] placeholderImage:[UIImage imageNamed:kPlaceholderimage]];
        [cell addSubview:imagev];
        
        
        
        UILabel *label=[[UILabel alloc]init];
        label.frame=CGRectMake(50, kHeightgetFloat(88)/2.0-25/2.0, 180, 25);
        label.textColor=KBlackColor;
        label.textAlignment=NSTextAlignmentLeft;
        label.font=[UIFont systemFontOfSize:16.0];
        // label.backgroundColor=[UIColor whiteColor];
        [cell addSubview:label];
        label.text=[[dic objectForKey:@"owner"] objectForKey:@"name"]?[NSString stringWithFormat:@"%@",[[dic objectForKey:@"owner"] objectForKey:@"name"]]:@"";
        
        
        
        UILabel *desclabel=[[UILabel alloc]init];
        
        desclabel.frame=CGRectMake(50, kHeightgetFloat(88)/2.0-30/2.0, 180, 30);
        desclabel.textColor=KLineColor;
        desclabel.font=[UIFont systemFontOfSize:13.0];
        desclabel.textAlignment=NSTextAlignmentLeft;
        // desclabel.backgroundColor=[UIColor whiteColor];
        [cell addSubview:desclabel];
        desclabel.text=[NSString stringWithFormat:@"邀请您加入%@",[[dic objectForKey:@"team"] objectForKey:@"name"]];
        
        UIButton *invitebutton=[[UIManager shareInstance]getbuttonWithtitle:@"" theFrame:CGRectMake(ScreenWidth-90, 10, 80, 30) theButtonImage:nil];
        NSLog(@"%@",[dic objectForKey:@"status"]);
        
        [invitebutton setTitle:@"加入" forState:UIControlStateNormal];
        
        invitebutton.layer.cornerRadius=4.0;
        
        invitebutton.tag=indexPath.row;
        invitebutton.backgroundColor=KlightOrangeColor;
        [invitebutton addTarget:self action:@selector(inviteactioin:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell addSubview:invitebutton];
        

        
        
        
        
        
           }else if (indexPath.section==1) {
               
               NSDictionary *dic=(NSDictionary *)[self.teamarr objectAtIndex:indexPath.row];
                NSLog(@"%@",dic);
               UIImageView *imagev;
               //=[[UIImageView alloc]init];
               
               
               imagev =[[UIImageView alloc]initWithFrame:CGRectMake(kWidthgetFloat(24), kHeightgetFloat(88)/2.0-28/2.0, kWidthgetFloat(56), kHeightgetFloat(56))];
               //   imagev.frame=CGRectMake(10, 8, 44, 44);
               
               
               
               imagev.clipsToBounds=YES;
               
               imagev.layer.masksToBounds=YES;
               imagev.layer.cornerRadius =14.0;
               imagev.layer.borderColor = [UIColor clearColor].CGColor;
               imagev.layer.rasterizationScale = [UIScreen mainScreen].scale;
               [imagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@""]] placeholderImage:[UIImage imageNamed:@"myteam_1"]];
               [cell addSubview:imagev];
               
               UILabel *label=[[UILabel alloc]init];
               label.frame=CGRectMake(kWidthgetFloat(24+56+16), kHeightgetFloat(88)/2.0-25/2.0, 180, 25);
               label.textColor=KBlackColor;
               label.textAlignment=NSTextAlignmentLeft;
               label.font=[UIFont systemFontOfSize:16.0];
               // label.backgroundColor=[UIColor whiteColor];
               [cell addSubview:label];
               label.text=[dic objectForKey:@"name"];
               


//               NSLog(@"%@",dic);
//               cell.textLabel.text=[dic objectForKey:@"name"];
//               cell.detailTextLabel.text=[dic objectForKey:@"description"];
//               
//               cell.detailTextLabel.textColor=KLineColor;
//               
//               cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

        
      

        
      //  cell.textLabel.text=@"haha";
        
       // cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
         //      cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
               if (indexPath.row!=docarr.count-1) {
                   UIView *linev=[[UIView alloc]initWithFrame:CGRectMake(kWidthgetFloat(24+56+16), kHeightgetFloat(88)-0.7, ScreenWidth-50, 0.7)];
                   linev.backgroundColor=KLineColor;
                   [cell addSubview:linev];
               }
             
    }else{
        
        NSDictionary *dic=(NSDictionary *)[self.participatedTeamarr objectAtIndex:indexPath.row];
        UIImageView *imagev;
        //=[[UIImageView alloc]init];
        
        
        imagev =[[UIImageView alloc]initWithFrame:CGRectMake(kWidthgetFloat(24), kHeightgetFloat(88)/2.0-28/2.0, kWidthgetFloat(56), kHeightgetFloat(56))];
        //   imagev.frame=CGRectMake(10, 8, 44, 44);
        
        
        
        imagev.clipsToBounds=YES;
        
        imagev.layer.masksToBounds=YES;
        imagev.layer.cornerRadius =14.0;
        imagev.layer.borderColor = [UIColor clearColor].CGColor;
        imagev.layer.rasterizationScale = [UIScreen mainScreen].scale;
        [imagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@""]] placeholderImage:[UIImage imageNamed:@"join_team_1"]];
        [cell addSubview:imagev];
        
        UILabel *label=[[UILabel alloc]init];
        label.frame=CGRectMake(kWidthgetFloat(24+56+16), kHeightgetFloat(88)/2.0-25/2.0, 180, 25);
        label.textColor=KBlackColor;
        label.textAlignment=NSTextAlignmentLeft;
        label.font=[UIFont systemFontOfSize:16.0];
        // label.backgroundColor=[UIColor whiteColor];
        [cell addSubview:label];
        label.text=[dic objectForKey:@"name"];
        
        
        
        //               NSLog(@"%@",dic);
        //               cell.textLabel.text=[dic objectForKey:@"name"];
        //               cell.detailTextLabel.text=[dic objectForKey:@"description"];
        //
        //               cell.detailTextLabel.textColor=KLineColor;
        //
        //               cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
        
        
        
        
        //  cell.textLabel.text=@"haha";
        
        // cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        //      cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.row!=docarr.count-1) {
            UIView *linev=[[UIView alloc]initWithFrame:CGRectMake(kWidthgetFloat(24+56+16), kHeightgetFloat(88)-0.7, ScreenWidth-50, 0.7)];
            linev.backgroundColor=KLineColor;
            [cell addSubview:linev];
        }
//
//        NSLog(@"%@",dic);
//        cell.textLabel.text=[NSString stringWithFormat:@"%@(%@)",[dic objectForKey:@"name"],[[dic objectForKey:@"owner"] objectForKey:@"name"]];
//        cell.detailTextLabel.text=[dic objectForKey:@"description"];
//        
//        cell.detailTextLabel.textColor=KLineColor;
//        
     //  cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    
    return cell;
}
-(void)inviteactioin:(UIButton *)button{
     NSDictionary *dic=(NSDictionary *)[self.invitationarr objectAtIndex:button.tag];
    [DocTeamDataService docconfirminginvitationWithteamId:[dic objectForKey:@"team_id"] block:^(id respdic) {
        [button setTitle:@"已加入" forState:UIControlStateNormal];
        button.backgroundColor=[UIColor whiteColor];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        button.userInteractionEnabled=NO;
         [self regetdata];

    }];
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick endEvent:@"doctor_team"];
    self.navigationController.navigationBar.hidden=NO;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[self.tableView cellForRowAtIndexPath:indexPath];
    cell.selected=NO;
    if (indexPath.section==1) {
//        NSDictionary *dic=(NSDictionary *)[self.teamarr objectAtIndex:indexPath.row];
       
//        cell.textLabel.text=[dic objectForKey:@"name"];
        
        selectedindex=indexPath.row;
        NSDictionary *dic=(NSDictionary *)[self.teamarr objectAtIndex:indexPath.row];
        NSLog(@"haha :%@",dic);
        GroupDetailViewController *groupvc=[[GroupDetailViewController alloc]init];
        groupvc.delegate=self;
        groupvc.datadic=dic;
        groupvc.teamid=[dic objectForKey:@"id"];
        groupvc.title=[dic objectForKey:@"name"];
        groupvc.teamarr=self.teamarr;
        groupvc.ismanager=YES;
        [self.navigationController pushViewController:groupvc animated:YES];
        
        
        
    }else if (indexPath.section==2) {
        
        selectedindex=indexPath.row;
        NSDictionary *dic=(NSDictionary *)[self.participatedTeamarr objectAtIndex:indexPath.row];
        NSLog(@"%@",dic);
       
       
        GroupDetailViewController *groupvc=[[GroupDetailViewController alloc]init];
        groupvc.delegate=self;
        groupvc.datadic=dic;
        groupvc.teamid=[dic objectForKey:@"id"];
        groupvc.title=[NSString stringWithFormat:@"%@(%@)",[dic objectForKey:@"name"],[[dic objectForKey:@"owner"] objectForKey:@"name"]];
        groupvc.teamarr=self.teamarr;
        groupvc.ismanager=NO;
        [self.navigationController pushViewController:groupvc animated:YES];
        

    }
    self.navigationController.navigationBar.hidden=NO;
}
-(void)deleteAndRelaodDic:(NSDictionary *)dic{
    
    [self regetdata];
//    [self.teamarr removeObjectAtIndex:selectedindex];
//    if (self.teamarr.count==0) {
//         [self.navigationController popToRootViewControllerAnimated:YES];
//    }else{
//         [self.tableView reloadData];
//    }
    
   
}
-(void)regetdata{
    JGProgressHUD *hud=[[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleDark];
    [hud showInView:self.view];
    [hud dismissAfterDelay:5];
    
    [DocTeamDataService getDocAllTeamblock:^(id responsearr) {
        NSMutableArray *docteamarr=(NSMutableArray *)responsearr;
        NSLog(@"%@",docteamarr);
        _teamarr=docteamarr;
        docarr=[[NSMutableArray alloc]initWithArray:docteamarr];
        [self.tableView reloadData];
        // NSMutableArray *participatedTeamarr;
        
        [DocTeamDataService getAllparticipatedTeamblock:^(id responsearr1) {
            NSMutableArray *participatedTeamarr=(NSMutableArray *)responsearr1;
            _participatedTeamarr=participatedTeamarr;
            patientarr=[[NSMutableArray alloc]initWithArray:participatedTeamarr];

            [self.tableView reloadData];
            [DocTeamDataService getAllInvitationsblock:^(id responsearr2) {
                NSMutableArray *invitationarr=(NSMutableArray *)responsearr2;
                [hud dismiss];
                _invitationarr=invitationarr;
                [self.tableView reloadData];
                
                [self showmydocaction];
                [self showpartdocaction];
            }];
            
        }];
        
    }];

}
@end
