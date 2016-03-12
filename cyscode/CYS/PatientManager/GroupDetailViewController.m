//
//  GroupDetailViewController.m
//  CYS
//
//  Created by 谢阳晴 on 15/12/23.
//  Copyright © 2015年 谢阳晴. All rights reserved.
//

#import "GroupDetailViewController.h"
#import "SearchNameViewController.h"
#import "ContactManagerViewController.h"
#import "RCDChatViewController.h"
#import "AddDoctorViewController.h"
#import "ChineseString.h"
#import "ContactPatientViewController.h"
#import "itemdetailbutton.h"

#import "PatientChatViewController.h"

@interface GroupDetailViewController (){
  NavBarView *mybarview;
    UIView *buttonbgv;
    BOOL ismanager;
    UIControl *moreControl;
    BOOL haveshowmorebutton;
    NSInteger pagenum;
    UIButton *morebutton;
    BOOL havenext;
    NSMutableArray *dataarr;
    NSMutableArray *docarr;
    NSMutableArray *patientarr;
    NSMutableArray *tmpdocarr;
    NSMutableArray *tmppatientarr;
    BOOL haveshowdoc;
    BOOL haveshowpat;
    UILabel *groupnamelabel;
    UILabel *hotsplabel;
    NSMutableArray *pushpatientarr;
    UIImageView *docimagev;
    UIImageView *patientimagev;
    NSMutableArray *tmpCovTargetIDarr;
    JGProgressHUD *hud;
}
@property(nonatomic,assign)NSInteger dealcovcount;
@end

@implementation GroupDetailViewController
-(void)viewDidLoad{
    [super viewDidLoad];
   
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(addmembers:) name:@"addmembers" object:nil];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadpatientdata:) name:@"reloadpatientdata" object:nil];
    pagenum=0;
    
    self.view.backgroundColor=KBackgroundColor;
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64-20-12, ScreenWidth, ScreenHeight-64+20+12) style:UITableViewStyleGrouped];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.separatorColor=[UIColor clearColor];
    [self.view addSubview:self.tableView];
    ismanager=self.ismanager;
  
    
    self.tableView.backgroundColor=KBackgroundColor;
    
    
       //设置接收消息代理
    [RCIM sharedRCIM].receiveMessageDelegate=self;
    
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(newmsg:) name:@"havenewIMmsg" object:nil];
    
    groupnamelabel=[[UILabel alloc]init];
                            
    groupnamelabel.text=[NSString stringWithFormat:@"%@团队",@""];
    
    hotsplabel=[[UILabel alloc]initWithFrame:CGRectMake(70, 8, 220, 24)];
    
    hotsplabel.text=[NSString stringWithFormat:@"%@",@""];

    
    mybarview=[[NavBarView alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, 64)];
    mybarview.delegate=self;
    mybarview.navbarTitle=self.title;
    [mybarview setnavcanclecolor:[UIColor whiteColor]];
    [mybarview setnavcancletitle:@" 返回"];
    [mybarview setnavcancletimage:@"back"];
    mybarview.backgroundColor=KlightOrangeColor;
    [self.view addSubview:mybarview];
    
    //self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:morebutton];
    
    morebutton=[UIButton buttonWithType:UIButtonTypeCustom];
    morebutton.frame=CGRectMake(ScreenWidth-51, 29, 45, 30);
    
    [morebutton setTitle:@"管理" forState:UIControlStateNormal];
    //[canclebutton setImage:[UIImage imageNamed:@"backArrow.png"] forState:UIControlStateNormal];
   // [morebutton setImage:[UIImage imageNamed:@"tmp"] forState:UIControlStateNormal];
    [morebutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [morebutton addTarget:self action:@selector(morebuttonaction) forControlEvents:UIControlEventTouchUpInside];
    //morebutton.hidden=YES;
    [self.view addSubview:morebutton];
    
   // self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:morebutton];
    UIView *bgv=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    bgv.backgroundColor=KlightOrangeColor;
    [self.view addSubview:bgv];
    [self setupmoreview];
  //  self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:morebutton];
    [self getallmembers];
    [self getallpatient];
    
  //  [self getallmembers];
//    [self addHeader];
//    [self addFooter];
    
    
    docimagev=[[UIImageView alloc]initWithFrame:CGRectMake(5, 52/2.0-10/2.0+12, 9, 10)];
    docimagev.image=[UIImage imageNamed:@"expansion_1"];
    
    patientimagev=[[UIImageView alloc]initWithFrame:CGRectMake(5, 52/2.0-10/2.0+12, 9, 10)];
    patientimagev.image=[UIImage imageNamed:@"expansion_1"];

    
    [self.view bringSubviewToFront:self.tableView];
    [self.view bringSubviewToFront:mybarview];
    [self.view bringSubviewToFront:morebutton];
    
    
    
    
    NSMutableArray *tmpcovarr=[[NSMutableArray alloc]initWithArray:[[RCIMClient sharedRCIMClient]getConversationList:@[@(ConversationType_GROUP)]]];
    NSLog(@"%@",tmpcovarr);
    if (tmpdocarr.count>0) {
        hud=[[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleDark];
        [hud showInView:self.view];
        [hud dismissAfterDelay:15];
        tmpCovTargetIDarr=[[NSMutableArray alloc]init];
        self.dealcovcount=0;
        for (RCConversation *cov in tmpcovarr) {
            
            //        NSLog(@"cov.targetId)%@",cov.targetId);
            //         NSLog(@"cov.targetId)%@",cov.targetId);
            [DocTeamDataService getGroupinfoWithGroupId:cov.targetId block:^(id respdic) {
                //            NSLog(@"%@",[[respdic objectForKey:@"team"] objectForKey:@"id"]);
                //              NSLog(@"%@",respdic);
                if ([[self.datadic objectForKey:@"id"] isEqualToString:[[respdic objectForKey:@"team"] objectForKey:@"id"]]) {
                    //                NSLog(@"targethahaha%@   %@",[self.datadic objectForKey:@"id"],[[respdic objectForKey:@"team"] objectForKey:@"id"]);
                    //  NSLog(@"targethahaha %@",cov.targetId);
                    [tmpCovTargetIDarr addObject:cov.targetId];
                }
                             self.dealcovcount++;
                            if (self.dealcovcount==tmpcovarr.count) {
                                [hud dismiss];
                            }
                
                
            }];
        }

    }
    
    // Do any additional setup after loading the view.
}
-(void)reloadpatientdata:(NSNotification *)sender{
    [PatientDataService getTeamPatientsWithteamId:[self.datadic objectForKey:@"id"] pageNum:0 block:^(id respdic) {
        NSLog(@"%@",respdic);
        
        NSMutableArray *turenamearr=[[NSMutableArray alloc]init];
        NSArray *sourcearr=[[NSArray alloc]initWithArray:[respdic objectForKey:@"content"]];
        
        // NSMutableArray *tmparr=[[NSMutableArray alloc]init];
        
        NSMutableArray *sorttmpnamearr=[ChineseString SortArray:sourcearr];
        
        for (NSString *name in sorttmpnamearr) {
            for (NSDictionary *sortdic in sourcearr) {
                if ([name isEqualToString:[sortdic objectForKey:@"name"]]) {
                    [turenamearr addObject:sortdic];
                }
            }
        }
        
        
        _indexarr=[[NSMutableArray alloc]init];
        
        for (NSString *name in sorttmpnamearr) {
            if (![_indexarr containsObject:[self firstCharactor:name]]) {
                [_indexarr addObject:[self firstCharactor:name]];
            }
        }
        
        
        
        NSMutableArray *turedataarr=[[NSMutableArray alloc]init];
        
        for (NSString *indexstr in _indexarr) {
            //NSMutableDictionary *turedatadic=[[NSMutableDictionary alloc]init];
            //[turedatadic setObject:indexstr forKey:@"indexTitle"];
            //[indexarr addObject:[self firstCharactor:name]];
            //  NSMutableArray *tmparr=[[NSMutableArray alloc]init];
            for (NSDictionary *sortdic in turenamearr) {
                if ([indexstr isEqualToString:[self firstCharactor:[sortdic objectForKey:@"name"]]]) {
                    [turedataarr addObject:sortdic];
                }
            }
            // [turedatadic setObject:tmparr forKey:@"data"];
            // [turedataarr addObject:tmparr];
        }
        patientarr=[[NSMutableArray alloc]initWithArray:turedataarr];
        pushpatientarr=[[NSMutableArray alloc]initWithArray:turedataarr];
        tmppatientarr=[[NSMutableArray alloc]init];
        //[tmppatientarr addObjectsFromArray:turedataarr];
        //[hud dismiss];
        [self.tableView reloadData];
        
        
    }];

}
-(void)getallmembers{
   // NSLog(@"%@",self.datadic);
    
    
    
    hud=[[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleDark];
    [hud showInView:self.view];
    [hud dismissAfterDelay:5];
    NSLog(@"%@",self.datadic);
    [DocTeamDataService getTeamMembersWithteamId:[self.datadic objectForKey:@"id"] block:^(id doctorDatadic) {
        NSLog(@"%@",doctorDatadic);
         [hud dismiss];
        
        self.teammemberarr=[[NSMutableArray alloc]initWithArray:[doctorDatadic objectForKey:@"members"]];
        self.ownerdatadic=[doctorDatadic objectForKey:@"owner"];
        groupnamelabel.text=[NSString stringWithFormat:@"%@团队",[[doctorDatadic objectForKey:@"owner"] objectForKey:@"name"]];
        //        //[self.tableView reloadData];
        hotsplabel.text=[doctorDatadic objectForKey:@"name"];
        //        

        NSMutableArray *turenamearr=[[NSMutableArray alloc]init];
        NSArray *dicarray=(NSArray *)[doctorDatadic objectForKey:@"members"];
        for (NSDictionary *dic in dicarray) {
            [turenamearr addObject:[dic objectForKey:@"doctor"]];
        }
       
        [turenamearr insertObject:self.ownerdatadic atIndex:0];
        
        docarr=[[NSMutableArray alloc]initWithArray:turenamearr ];
       
        //  [docarr insertObject:self.ownerdatadic atIndex:0];
        tmpdocarr=[[NSMutableArray alloc]init];
        // [tmpdocarr addObjectsFromArray:tmpdocarr];
       // [self.tableView reloadData];
        
        
        
        [self showdocaction];
        [self.tableView reloadData];
        
       // return ;
        
        
//        
//        NSLog(@"%@",self.teammemberarr);
//        NSLog(@"%@",self.ownerdatadic);
////        self.teammemberarr=[[NSMutableArray alloc]initWithArray:[doctorDatadic objectForKey:@"members"]];
////        self.ownerdatadic=[doctorDatadic objectForKey:@"owner"];
//        
//        groupnamelabel.text=[NSString stringWithFormat:@"%@团队",[[doctorDatadic objectForKey:@"owner"] objectForKey:@"name"]];
//        //[self.tableView reloadData];
//        hotsplabel.text=[[doctorDatadic objectForKey:@"owner"] objectForKey:@"hospital"];
//        
//        NSMutableArray *tmparr=[[NSMutableArray alloc]init];
//        
//        NSMutableArray *tmpnamearr=[[NSMutableArray alloc]init];
//        NSMutableArray *tmptimearr=[[NSMutableArray alloc]init];
//        
//        for (NSDictionary *dic in self.teammemberarr) {
//            //  [tmparr addObject:[dic objectForKey:@"doctor"]];
//            
//            
//            
//            if ( [[dic objectForKey:@"status"] integerValue]==0) {
//                NSDictionary *tmpdic=[dic objectForKey:@"doctor"];
//                NSMutableDictionary *mdic=[[NSMutableDictionary alloc]initWithDictionary:tmpdic];
//                [mdic setValue:@"0" forKey:@"status"];
//                [tmptimearr addObject:mdic];
//            } else {
//                NSDictionary *tmpdic=[dic objectForKey:@"doctor"];
//                NSMutableDictionary *mdic=[[NSMutableDictionary alloc]initWithDictionary:tmpdic];
//                [mdic setValue:@"1" forKey:@"status"];
//                
//                [tmpnamearr addObject:mdic];
//            }
//            
//            
//        }
//        
//        NSMutableArray *sorttmpnamearr=[ChineseString SortArray:tmpnamearr];
//        
//        
//      //  NSLog(@"%@",sorttmpnamearr);
//        
//        NSMutableArray *turenamearr=[[NSMutableArray alloc]init];
//        for (NSString *name in sorttmpnamearr) {
//            for (NSDictionary *sortdic in tmpnamearr) {
//                if ([name isEqualToString:[sortdic objectForKey:@"name"]]) {
//                    [turenamearr addObject:sortdic];
//                }
//            }
//        }
//        NSMutableArray *turetimearr=[[NSMutableArray alloc]init];
//        
//        for (NSMutableDictionary *mdic in tmptimearr) {
//            [turetimearr insertObject:mdic atIndex:0];
//            
//        }
//        
//        [tmparr addObjectsFromArray:turenamearr];
//        
//        [tmparr addObjectsFromArray:turetimearr];
//        
//        [tmparr insertObject:self.ownerdatadic atIndex:0];
//        
//        
//        docarr=[[NSMutableArray alloc]initWithArray:tmparr];
//        NSLog(@"%d",docarr.count);
//      //  [docarr insertObject:self.ownerdatadic atIndex:0];
//        tmpdocarr=[[NSMutableArray alloc]init];
//       // [tmpdocarr addObjectsFromArray:tmpdocarr];
//       [self.tableView reloadData];
//        
//        
//        
//        [self showdocaction];
//        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }];
    
}
-(void)addmembers:(NSNotification *)sender{
    [DocTeamDataService getTeamMembersWithteamId:[self.datadic objectForKey:@"id"] block:^(id doctorDatadic) {
        
        self.teammemberarr=[[NSMutableArray alloc]initWithArray:[doctorDatadic objectForKey:@"members"]];
        self.ownerdatadic=[doctorDatadic objectForKey:@"owner"];
        NSMutableArray *turenamearr=[[NSMutableArray alloc]init];
        NSArray *dicarray=(NSArray *)[doctorDatadic objectForKey:@"members"];
        for (NSDictionary *dic in dicarray) {
            [turenamearr addObject:[dic objectForKey:@"doctor"]];
        }
        
        [turenamearr insertObject:self.ownerdatadic atIndex:0];
        
        docarr=[[NSMutableArray alloc]initWithArray:turenamearr ];
        
        //  [docarr insertObject:self.ownerdatadic atIndex:0];
        tmpdocarr=[[NSMutableArray alloc]init];
        // [tmpdocarr addObjectsFromArray:tmpdocarr];
        [self.tableView reloadData];
        
        
        
  //      [self showdocaction];

        
//        self.teammemberarr=[[NSMutableArray alloc]initWithArray:[doctorDatadic objectForKey:@"members"]];
//        self.ownerdatadic=[doctorDatadic objectForKey:@"owner"];
//        [self.teammemberarr insertObject:self.ownerdatadic atIndex:0];
//        groupnamelabel.text=[NSString stringWithFormat:@"%@团队",[[doctorDatadic objectForKey:@"owner"] objectForKey:@"name"]];
//        //[self.tableView reloadData];
//        hotsplabel.text=[[doctorDatadic objectForKey:@"owner"] objectForKey:@"hospital"];
//        
//        NSMutableArray *tmparr=[[NSMutableArray alloc]init];
//        
//        NSMutableArray *tmpnamearr=[[NSMutableArray alloc]init];
//        NSMutableArray *tmptimearr=[[NSMutableArray alloc]init];
//        
//        for (NSDictionary *dic in self.teammemberarr) {
//            //  [tmparr addObject:[dic objectForKey:@"doctor"]];
//            
//            
//            
//            if ( [[dic objectForKey:@"status"] integerValue]==0) {
//                NSDictionary *tmpdic=[dic objectForKey:@"doctor"];
//                NSMutableDictionary *mdic=[[NSMutableDictionary alloc]initWithDictionary:tmpdic];
//                [mdic setValue:@"0" forKey:@"status"];
//                [tmptimearr addObject:mdic];
//            } else {
//                NSDictionary *tmpdic=[dic objectForKey:@"doctor"];
//                NSMutableDictionary *mdic=[[NSMutableDictionary alloc]initWithDictionary:tmpdic];
//                [mdic setValue:@"1" forKey:@"status"];
//                
//                [tmpnamearr addObject:mdic];
//            }
//            
//            
//        }
//        
//        NSMutableArray *sorttmpnamearr=[ChineseString SortArray:tmpnamearr];
//        
//        
//        NSLog(@"%@",sorttmpnamearr);
//        
//        NSMutableArray *turenamearr=[[NSMutableArray alloc]init];
//        for (NSString *name in sorttmpnamearr) {
//            for (NSDictionary *sortdic in tmpnamearr) {
//                if ([name isEqualToString:[sortdic objectForKey:@"name"]]) {
//                    [turenamearr addObject:sortdic];
//                }
//            }
//        }
//        NSMutableArray *turetimearr=[[NSMutableArray alloc]init];
//        
//        for (NSMutableDictionary *mdic in tmptimearr) {
//            [turetimearr insertObject:mdic atIndex:0];
//            
//        }
//        
//        [tmparr addObjectsFromArray:turenamearr];
//        
//        [tmparr addObjectsFromArray:turetimearr];
//        
//        [tmparr insertObject:self.ownerdatadic atIndex:0];
//        
//        docarr=[[NSMutableArray alloc]initWithArray:tmparr];
//        tmpdocarr=[[NSMutableArray alloc]init];
//        // [tmpdocarr addObjectsFromArray:tmpdocarr];
//        [self.tableView reloadData];
//       // haveshowdoc=!haveshowdoc;
//       //  [self showdocaction];
        
        
        
        
        
        
        
    }];

}
-(void)getteamgroups{
    
    
    
    

    
    
    
    
    [IMDataService getListinggroupsForteamWithteamId:[self.datadic objectForKey:@"id"] block:^(id resparr) {
        _imarr=[[NSMutableArray alloc]initWithArray:resparr];
        
        
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
        NSMutableArray *tmparr=[[NSMutableArray alloc]init];
        for (RCConversation *cov in dataarr) {
            
            if ([_imarr containsObject:cov.targetId]) {
                [tmparr addObject:cov];
            }
            
        }
         dataarr=[[NSMutableArray alloc]initWithArray:tmparr];
       
        [self.tableView reloadData];

        
        
    }];
    
    
    
    
}
-(void)getconverstionsdata{
       //    for (RCConversation *cov in dataarr) {
    //
    //        NSLog(@"%@",cov.targetId);
    //        
    //        //分组
    //        
    //    }
    
}


-(void)morebuttonaction{
    //更多
    if (haveshowmorebutton==YES) {
        [buttonbgv removeFromSuperview];
        [moreControl removeFromSuperview];
        haveshowmorebutton=NO;
        
    } else {
        
        moreControl=[[UIControl alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        moreControl.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        [moreControl addTarget:self action:@selector(moreControlaction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:moreControl];
        [self.view addSubview:buttonbgv];
      
       
        
        haveshowmorebutton=YES;
    }
    
}
-(void)moreControlaction:(UIControl *)control{
    [control removeFromSuperview];
    [buttonbgv removeFromSuperview];
   
    haveshowmorebutton=NO;
    
}
-(void)setupmoreview{
    
    if (ismanager==NO) {
        
        
        buttonbgv=[[UIView alloc]initWithFrame:CGRectMake(ScreenWidth-135, 66, 130, 45*1)];
        buttonbgv.layer.cornerRadius=4.0;
        buttonbgv.backgroundColor=[UIColor whiteColor];
       // buttonbgv.alpha=0.7;
        
        
        
        
        NSArray *namearr=@[@"退出团队"];
        NSArray *moreimagearr=@[@"dismiss",@"tmp",@"tmp",@"xinxiaoxiliebiao"];
        for (int i=0; i<1; i++) {
            
            UIImageView *imagev;
            
            imagev =[[UIImageView alloc]initWithFrame:CGRectMake(13, 45*i+12.5, 22, 20)];
            
            
            
            
            
            imagev.clipsToBounds=YES;
            
            imagev.layer.masksToBounds=YES;
            imagev.layer.cornerRadius =0.0;
            imagev.layer.borderColor = [UIColor clearColor].CGColor;
            imagev.layer.rasterizationScale = [UIScreen mainScreen].scale;
            
            // imagev.image=[UIImage imageNamed:@"KAKA"];
            //  NSLog(@"%@",[NSString stringWithFormat:@"%@",[datadic objectForKey:@"icon"]]);
            imagev.image=[UIImage imageNamed:[moreimagearr objectAtIndex:i]];
            [buttonbgv addSubview:imagev];
            
            UILabel *label=[[UILabel alloc]init];
            label.frame=CGRectMake(50, 45*i+7, 70, 30);
            label.textColor=KBlackColor;
            label.textAlignment=NSTextAlignmentLeft;
            label.font=[UIFont boldSystemFontOfSize:15.0];
            label.backgroundColor=[UIColor clearColor];
            label.text=[NSString stringWithFormat:@"%@",[namearr objectAtIndex:i]];
            [buttonbgv addSubview:label];
            
            
            
            
            UIButton *morebutton1=[UIButton buttonWithType:UIButtonTypeCustom];
            morebutton1.frame=CGRectMake(0, 45*i, 130, 45);
            morebutton1.tag=1000000+i;
            //  [morebutton1 setImage:[UIImage imageNamed:[moreimagearr objectAtIndex:i]] forState:UIControlStateNormal];
            //UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
            [morebutton1 setImageEdgeInsets:UIEdgeInsetsMake(12, 15, 12, 130-21-15)];
            //[morebutton1 setTitle:[NSString stringWithFormat:@"%@",[namearr objectAtIndex:i]] forState:UIControlStateNormal];
            morebutton1.layer.borderWidth=1.0;
            morebutton1.layer.borderColor=[UIColor clearColor].CGColor;
            morebutton1.titleLabel.font=[UIFont boldSystemFontOfSize:19.0];
            //[canclebutton setImage:[UIImage imageNamed:@"backArrow.png"] forState:UIControlStateNormal];
            //[morebutton setImage:[UIImage imageNamed:@"backarrow.png"] forState:UIControlStateNormal];
            [morebutton1 setTitleColor:KBlackColor forState:UIControlStateNormal];
            [morebutton1 addTarget:self action:@selector(buttonaction:) forControlEvents:UIControlEventTouchUpInside];
            [buttonbgv addSubview:morebutton1];

            if (i!=0) {
                UIView *linev=[[UIView alloc]initWithFrame:CGRectMake(0, 45-0.7, 130, 0.7)];
                linev.backgroundColor=KLineColor;
                [morebutton1 addSubview:linev];
            }
        }

    } else {
        buttonbgv=[[UIView alloc]initWithFrame:CGRectMake(ScreenWidth-135, 66, 130, 45*3)];
        buttonbgv.layer.cornerRadius=4.0;
        buttonbgv.backgroundColor=[UIColor whiteColor];
//        buttonbgv.alpha=0.7;
        
//        triageleview=[[TriangleView alloc]init];
//        
//        triageleview.topPoint=CGPointMake(ScreenWidth-51, 66);
//        triageleview.leftPoint=CGPointMake(ScreenWidth-51-5, 80);
//        triageleview.rightPoint=CGPointMake(ScreenWidth-51+5, 80);
//        triageleview.backgroundColor=[UIColor whiteColor];
        
//        const CGFloat kArrowWidth = 10;
        
        // Draw Bezier arrow on top consists of 3 points
       //@"添加患者",@"删除患者",@"添加医生",@"删除医生",
        NSArray *namearr=@[@"修改名称",@"删除医生",@"解散团队"];
        NSArray *moreimagearr=@[@"edit_name",@"delete_doc",@"dismiss",@"yuyueqianwang",@"xinxiaoxiliebiao"];
        for (int i=0; i<3; i++) {
            
            
            
            
            UIImageView *imagev;
            
            imagev =[[UIImageView alloc]initWithFrame:CGRectMake(13, 45*i+12.5, 22, 20)];
            
            
            
            
            
            imagev.clipsToBounds=YES;
            
            imagev.layer.masksToBounds=YES;
            imagev.layer.cornerRadius =0.0;
            imagev.layer.borderColor = [UIColor clearColor].CGColor;
            imagev.layer.rasterizationScale = [UIScreen mainScreen].scale;
            
            // imagev.image=[UIImage imageNamed:@"KAKA"];
            //  NSLog(@"%@",[NSString stringWithFormat:@"%@",[datadic objectForKey:@"icon"]]);
            imagev.image=[UIImage imageNamed:[moreimagearr objectAtIndex:i]];
            [buttonbgv addSubview:imagev];
            
            UILabel *label=[[UILabel alloc]init];
            label.frame=CGRectMake(50, 45*i+7, 70, 30);
            label.textColor=KBlackColor;
            label.textAlignment=NSTextAlignmentLeft;
            label.font=[UIFont boldSystemFontOfSize:15.0];
            label.backgroundColor=[UIColor clearColor];
            label.text=[NSString stringWithFormat:@"%@",[namearr objectAtIndex:i]];
            [buttonbgv addSubview:label];
            

            
            
            UIButton *morebutton1=[UIButton buttonWithType:UIButtonTypeCustom];
            morebutton1.frame=CGRectMake(0, 45*i, 130, 45);
            morebutton1.tag=1000000+i;
          //  [morebutton1 setImage:[UIImage imageNamed:[moreimagearr objectAtIndex:i]] forState:UIControlStateNormal];
            //UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
            [morebutton1 setImageEdgeInsets:UIEdgeInsetsMake(12, 15, 12, 130-21-15)];
            //[morebutton1 setTitle:[NSString stringWithFormat:@"%@",[namearr objectAtIndex:i]] forState:UIControlStateNormal];
            morebutton1.layer.borderWidth=1.0;
            morebutton1.layer.borderColor=[UIColor clearColor].CGColor;
            morebutton1.titleLabel.font=[UIFont boldSystemFontOfSize:19.0];
            //[canclebutton setImage:[UIImage imageNamed:@"backArrow.png"] forState:UIControlStateNormal];
            //[morebutton setImage:[UIImage imageNamed:@"backarrow.png"] forState:UIControlStateNormal];
            [morebutton1 setTitleColor:KBlackColor forState:UIControlStateNormal];
            [morebutton1 addTarget:self action:@selector(buttonaction:) forControlEvents:UIControlEventTouchUpInside];
            [buttonbgv addSubview:morebutton1];
            if (i!=2) {
                UIView *linev=[[UIView alloc]initWithFrame:CGRectMake(0, 45-0.7, 130, 0.7)];
                linev.backgroundColor=KLineColor;
                [morebutton1 addSubview:linev];
            }
        }

    }
    
}
-(void)buttonaction:(UIButton *)button{
    [moreControl removeFromSuperview];
    [buttonbgv removeFromSuperview];
   
    haveshowmorebutton=NO;

    
    
    
    
    
    if (ismanager==NO) {
       if (button.tag==1000000) {
//            NSLog(@"%@",self.datadic);
        
        UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"将移出您加入团队的患者" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertview.tag=3001;
        [alertview show];
        
        }else{
                ContactPatientViewController *editnamevc=[[ContactPatientViewController alloc]init];
                //editnamevc.isrootvc=NO;
                
                editnamevc.delegate=self;
                editnamevc.isaddpatient=YES;
                editnamevc.docteamid=[self.datadic objectForKey:@"id"];
                editnamevc.needsearchbar=NO;
                
                //editnamevc.isrootvc=NO;
                
                // if (self.ismanager==NO) {
                editnamevc.isnotneedmoreaction=NO;
                // }
                
                //editnamevc.docteamid=[self.datadic objectForKey:@"id"];
                NSMutableArray *tmparr=[[NSMutableArray alloc]init];
                
                
                
                for (NSDictionary *dic in self.patientarr) {
                    
                    [tmparr addObject:dic];
                }
                
                editnamevc.dataArr=tmparr;
                editnamevc.isaddshowall=YES;
                
                [editnamevc setlistisedit:YES];
                editnamevc.isalledit=YES;
            
                [self.navigationController pushViewController:editnamevc animated:YES];

//       
        }
    } else {
        
        //能管理
        
        if(button.tag==1000000){
//            SearchNameViewController *editnamevc=[[SearchNameViewController alloc]init];
//            //editnamevc.isrootvc=NO;
//            
//            [self.navigationController pushViewController:editnamevc animated:YES];
            
            
//            ContactPatientViewController *editnamevc=[[ContactPatientViewController alloc]init];
//            //editnamevc.isrootvc=NO;
//            
//            editnamevc.delegate=self;
//            editnamevc.isaddpatient=YES;
//            editnamevc.docteamid=[self.datadic objectForKey:@"id"];
//            editnamevc.needsearchbar=NO;
//            
//            //editnamevc.isrootvc=NO;
//            
//            // if (self.ismanager==NO) {
//            editnamevc.isnotneedmoreaction=NO;
//            // }
//            
//            editnamevc.docteamid=[self.datadic objectForKey:@"id"];
//            NSMutableArray *tmparr=[[NSMutableArray alloc]init];
//            
//            
//            
//            for (NSDictionary *dic in self.patientarr) {
//                
//                [tmparr addObject:dic];
//            }
//            
//            editnamevc.dataArr=tmparr;
//            editnamevc.isaddshowall=YES;
//            
//            [editnamevc setlistisedit:YES];
//             editnamevc.isalledit=YES;
//            [self.navigationController pushViewController:editnamevc animated:YES];

            GroupRenameViewController *editnamevc=[[GroupRenameViewController alloc]init];
            //editnamevc.isrootvc=NO;
            editnamevc.delegate=self;
            editnamevc.datadic=self.datadic;
            NSLog(@"%@",self.datadic);
            editnamevc.tagstr=[self.datadic objectForKey:@"name"];
            //  editnamevc.docteamid=[self.datadic objectForKey:@"id"];
            [self.navigationController pushViewController:editnamevc animated:YES];
            
            
            
        }else if (button.tag==1000001){
            
              [self deletedocaction];
            
            
          

           
            
        }else if (button.tag==1000002){
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"是否解散该团队？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            
            [alertView show];

        }
//            ContactManagerViewController *editnamevc=[[ContactManagerViewController alloc]init];
//            //editnamevc.isrootvc=NO;
//            editnamevc.isaddpatient=NO;
//            editnamevc.docteamid=[self.datadic objectForKey:@"id"];
//           
//            
//            NSMutableArray *tmparr=[[NSMutableArray alloc]init];
//            NSLog(@"%@",self.teammemberarr);
//            
//            
//            
//            for (NSDictionary *dic in self.teammemberarr) {
//                [tmparr addObject:[dic objectForKey:@"doctor"]];
//            }
//            
//             // [tmparr insertObject:self.ownerdatadic atIndex:0 ];
//            editnamevc.dataArr=tmparr;
//            
//            editnamevc.isaddshowall=YES;
//            [self.navigationController pushViewController:editnamevc animated:YES];
//            
//        }else if (button.tag==1000004){
        
            //      }

        
      

        
    }
}
-(void)addwithdic:(NSDictionary *)tagdic{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadindex" object:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"reloaddocteam" object:nil];
    groupnamelabel.text=[NSString stringWithFormat:@"%@团队",[tagdic objectForKey:@"name"]];
  //  groupnamelabel.text=[tagdic objectForKey:@"name"];
  //  self.title=[tagdic objectForKey:@"name"];
    self.title=@"团队详情";
     [mybarview setnavtitle:self.title];
    [self.tableView reloadData];
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    if (alertView.tag==3001) {
        if (buttonIndex==0) {
            
        }else if (buttonIndex==1) {
            [DocTeamDataService quitfromteamWithteamId:[self.datadic objectForKey:@"id"] block:^(id respdic) {
                [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
                [[PublicTools shareInstance]creareNotificationUIView:@"已退出"];
                
                for (NSString *covtargetid in tmpCovTargetIDarr) {
                    
                            [[RCIMClient sharedRCIMClient]clearMessages:ConversationType_GROUP targetId:covtargetid];
                            [[RCIMClient sharedRCIMClient]removeConversation:ConversationType_GROUP targetId:covtargetid];
                            
                
                }

                
//                for (RCConversation *cov in tmparr) {
//                    [[RCIMClient sharedRCIMClient]clearMessages:ConversationType_PRIVATE targetId:cov.targetId];
//                    [[RCIMClient sharedRCIMClient]removeConversation:ConversationType_PRIVATE targetId:cov.targetId];
//                }
//                
//                NSArray *tmparr1=[[NSMutableArray alloc]initWithArray:[[RCIMClient sharedRCIMClient]getConversationList:@[@(ConversationType_GROUP)]]];
//                
//                for (RCConversation *cov in tmparr1) {
//                    [[RCIMClient sharedRCIMClient]clearMessages:ConversationType_GROUP targetId:cov.targetId];
//                    [[RCIMClient sharedRCIMClient]removeConversation:ConversationType_GROUP targetId:cov.targetId];
//                }
//
                
                [self.delegate deleteAndRelaodDic:self.datadic];
               
                [self.navigationController popViewControllerAnimated:YES];
                
            }];

            
        }else if (buttonIndex==2) {
            //删除
            [DocTeamDataService quitfromteamWithteamId:[self.datadic objectForKey:@"id"] block:^(id respdic) {
                [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
                [[PublicTools shareInstance]creareNotificationUIView:@"已退出"];
                for (NSString *covtargetid in tmpCovTargetIDarr) {
                    
                    [[RCIMClient sharedRCIMClient]clearMessages:ConversationType_GROUP targetId:covtargetid];
                    [[RCIMClient sharedRCIMClient]removeConversation:ConversationType_GROUP targetId:covtargetid];
                    
                    
                }
//                for (RCConversation *cov in tmparr) {
//                    [[RCIMClient sharedRCIMClient]clearMessages:ConversationType_PRIVATE targetId:cov.targetId];
//                    [[RCIMClient sharedRCIMClient]removeConversation:ConversationType_PRIVATE targetId:cov.targetId];
//                }
//                
//                NSArray *tmparr1=[[NSMutableArray alloc]initWithArray:[[RCIMClient sharedRCIMClient]getConversationList:@[@(ConversationType_GROUP)]]];
//                
//                for (RCConversation *cov in tmparr1) {
//                    [[RCIMClient sharedRCIMClient]clearMessages:ConversationType_GROUP targetId:cov.targetId];
//                    [[RCIMClient sharedRCIMClient]removeConversation:ConversationType_GROUP targetId:cov.targetId];
//                }

                
                [self.delegate deleteAndRelaodDic:self.datadic];
                [self.navigationController popViewControllerAnimated:YES];
                
            }];

           
        }

    } else {
        if (buttonIndex==1) {
            
            hud=[[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleDark];
            [hud showInView:self.view];
            [hud dismissAfterDelay:5];
            
//            [DocTeamDataService getGroupinfoWithGroupId:[self.datadic objectForKey:@"id"] block:^(id respdic) {
//                NSLog(@"%@",respdic);
//                 NSLog(@"%@",respdic);
//            }];
            [DocTeamDataService deleteDocTeamWithId:[self.datadic objectForKey:@"id"] block:^(id dic) {
                
                
                
                [hud dismiss];
                for (NSString *covtargetid in tmpCovTargetIDarr) {
                    
                    [[RCIMClient sharedRCIMClient]clearMessages:ConversationType_GROUP targetId:covtargetid];
                    [[RCIMClient sharedRCIMClient]removeConversation:ConversationType_GROUP targetId:covtargetid];
                    
                    
                }
                [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadindex" object:nil];
                [self.delegate deleteAndRelaodDic:self.datadic];
                [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
                [[PublicTools shareInstance]creareNotificationUIView:@"解散成功"];
                [self.navigationController popViewControllerAnimated:YES];
                
               
            }];
            
        }
    }
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getteamgroups];
     self.navigationController.navigationBar.hidden=YES;
}
-(void)newmsg:(NSNotification *)sender{
    // [self.tableView reloadData];
   [self getteamgroups];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
     self.navigationController.navigationBar.hidden=NO;
}
-(void)itemactionWithType:(NSInteger)typeindex{
    if (self.isnewteam) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    if (section==1||section==0) {
//        return 12.0;
//    }else{
//         return 0.0;
//    }
//   
//}
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    if (section==1||section==0) {
//        UIView *bgv=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 12)];
//        bgv.backgroundColor=kimiColor(240, 239, 245, 1);
//        return bgv;
//    }else{
//        return nil;
//        
//    }
//   
//    
//}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0;
    } else if (section==1) {
        return 64;
    }else{
        return 64;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *bgv=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    bgv.backgroundColor=[UIColor whiteColor];
    UIView *bgtopv=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 12)];
    bgtopv.backgroundColor=KBackgroundColor;
    [bgv addSubview:bgtopv];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(20, 12, ScreenWidth-80, 52)];
    label.backgroundColor=[UIColor whiteColor];
    if (section==0) {
        UIView *bgv=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
        bgv.backgroundColor=[UIColor whiteColor];
        //label.text=@" 团队摘要";
        return bgv;
    }else if (section==1) {
        
        
        label.text=@" 医生";
        
        label.textColor=KBlackColor;
        label.font=[UIFont systemFontOfSize:18.0];
        label.backgroundColor=[UIColor whiteColor];
        [bgv addSubview:label];
        
        docimagev.backgroundColor=[UIColor whiteColor];
        [bgv addSubview:docimagev];
//        UIView *linev=[[UIView alloc]initWithFrame:CGRectMake(0, 69, ScreenWidth, 1)];
//        linev.backgroundColor=KBackgroundColor;
//        [bgv addSubview:linev];
        
        if (section==1) {
            UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
            button.frame=bgv.frame;
            [button addTarget:self action:@selector(showdocaction) forControlEvents:UIControlEventTouchUpInside];
            [bgv addSubview:button];
            
            
            UILabel *namelabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-55, 12, 50, 52)];
            namelabel.text=[NSString stringWithFormat:@"%zd",docarr.count];
            namelabel.font=[UIFont boldSystemFontOfSize:14.0];
            namelabel.textColor=KtextGrayColor;
            namelabel.textAlignment=NSTextAlignmentRight;
            [bgv addSubview:namelabel];
            
            
            
        }else if (section==2) {
            UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
            button.frame=bgv.frame;
            [button addTarget:self action:@selector(showpataction) forControlEvents:UIControlEventTouchUpInside];
            [bgv addSubview:button];
            
            UILabel *namelabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-55, 12, 50, 52)];
            namelabel.text=[NSString stringWithFormat:@"%zd",patientarr.count];
            namelabel.font=[UIFont boldSystemFontOfSize:14.0];
            namelabel.textColor=KtextGrayColor;
            namelabel.textAlignment=NSTextAlignmentRight;
            [bgv addSubview:namelabel];
            
        }else{
            
        }
        return bgv;

        
    }else{
        
        
        label.text=@" 患者";
        label.textColor=KBlackColor;
        label.font=[UIFont systemFontOfSize:18.0];
        label.backgroundColor=[UIColor whiteColor];
        [bgv addSubview:label];
        
       
        patientimagev.backgroundColor=[UIColor whiteColor];
        [bgv addSubview:patientimagev];
//        UIView *linev=[[UIView alloc]initWithFrame:CGRectMake(0, 69, ScreenWidth, 1)];
//        linev.backgroundColor=KBackgroundColor;
//        [bgv addSubview:linev];
        if (section==1) {
            UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
            button.frame=bgv.frame;
            [button addTarget:self action:@selector(showdocaction) forControlEvents:UIControlEventTouchUpInside];
            [bgv addSubview:button];
            
            
            UILabel *namelabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-55,12, 50, 52)];
            namelabel.text=[NSString stringWithFormat:@"%zd",docarr.count];
            namelabel.font=[UIFont boldSystemFontOfSize:14.0];
            namelabel.textColor=KtextGrayColor;
            namelabel.textAlignment=NSTextAlignmentRight;
            [bgv addSubview:namelabel];
            
            
            
        }else if (section==2) {
            UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
            button.frame=bgv.frame;
            [button addTarget:self action:@selector(showpataction) forControlEvents:UIControlEventTouchUpInside];
            [bgv addSubview:button];
            
            UILabel *namelabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-55, 12, 50, 52)];
            namelabel.text=[NSString stringWithFormat:@"%zd",patientarr.count];
            namelabel.font=[UIFont boldSystemFontOfSize:14.0];
            namelabel.textColor=KtextGrayColor;
            namelabel.textAlignment=NSTextAlignmentRight;
            [bgv addSubview:namelabel];
            
        }else{
            
        }
        return bgv;

       // label.text=@" 受邀请信息";
    }
    
}


-(void)showdocaction{
    
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
        docimagev.image=[UIImage imageNamed:@"expansion_2"];
        
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
        docimagev.image=[UIImage imageNamed:@"expansion_1"];
        
        
        
        
        
        
        
    }
    
    
    
    
}
-(void)showpataction{
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
        patientimagev.image=[UIImage imageNamed:@"expansion_2"];
        
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
        patientimagev.image=[UIImage imageNamed:@"expansion_1"];

   
    }
    
    
}








-(void)allmemeberaction{
    
    AddDoctorViewController *adddocVC=[[AddDoctorViewController alloc]init];
    adddocVC.docteamid=[self.datadic objectForKey:@"id"];
    [self.navigationController pushViewController:adddocVC animated:YES];
    
//    ContactManagerViewController *editnamevc=[[ContactManagerViewController alloc]init];
//    editnamevc.delegate=self;
//    //editnamevc.isrootvc=NO;
//    editnamevc.isaddpatient=NO;
//   
//    if (self.ismanager==NO) {
//         editnamevc.isnotneedmoreaction=YES;
//    }
//    editnamevc.isneedload=YES;
//    
//   
//    editnamevc.docteamid=[self.datadic objectForKey:@"id"];
//    NSMutableArray *tmparr=[[NSMutableArray alloc]init];
//    
//     NSMutableArray *tmpnamearr=[[NSMutableArray alloc]init];
//     NSMutableArray *tmptimearr=[[NSMutableArray alloc]init];
//    
//    for (NSDictionary *dic in self.teammemberarr) {
//      //  [tmparr addObject:[dic objectForKey:@"doctor"]];
//        
//        
//       
//        if ( [[dic objectForKey:@"status"] integerValue]==0) {
//            NSDictionary *tmpdic=[dic objectForKey:@"doctor"];
//            NSMutableDictionary *mdic=[[NSMutableDictionary alloc]initWithDictionary:tmpdic];
//            [mdic setValue:@"0" forKey:@"status"];
//            [tmptimearr addObject:mdic];
//        } else {
//              NSDictionary *tmpdic=[dic objectForKey:@"doctor"];
//            NSMutableDictionary *mdic=[[NSMutableDictionary alloc]initWithDictionary:tmpdic];
//            [mdic setValue:@"1" forKey:@"status"];
//
//            [tmpnamearr addObject:mdic];
//        }
//        
//        
//    }
//    
//    NSMutableArray *sorttmpnamearr=[ChineseString SortArray:tmpnamearr];
//    
//    
//    NSLog(@"%@",sorttmpnamearr);
//    
//    NSMutableArray *turenamearr=[[NSMutableArray alloc]init];
//    for (NSString *name in sorttmpnamearr) {
//        for (NSDictionary *sortdic in tmpnamearr) {
//            if ([name isEqualToString:[sortdic objectForKey:@"name"]]) {
//                [turenamearr addObject:sortdic];
//            }
//        }
//    }
//     NSMutableArray *turetimearr=[[NSMutableArray alloc]init];
//    
//    for (NSMutableDictionary *mdic in tmptimearr) {
//        [turetimearr insertObject:mdic atIndex:0];
//        
//    }
//    
//    [tmparr addObjectsFromArray:turenamearr];
//    
//    [tmparr addObjectsFromArray:turetimearr];
//    
//     [tmparr insertObject:self.ownerdatadic atIndex:0];
//    
//    editnamevc.dataArr=tmparr;
//    editnamevc.isaddshowall=YES;
//    [self.navigationController pushViewController:editnamevc animated:YES];
}
-(void)deletedocaction{
        ContactManagerViewController *editnamevc=[[ContactManagerViewController alloc]init];
        editnamevc.delegate=self;
        //editnamevc.isrootvc=NO;
        editnamevc.isaddpatient=NO;
    
        if (self.ismanager==NO) {
             editnamevc.isnotneedmoreaction=YES;
        }
        editnamevc.isneedload=YES;
        editnamevc.isfromTeamDetail=YES;
    
        editnamevc.docteamid=[self.datadic objectForKey:@"id"];
        NSMutableArray *tmparr=[[NSMutableArray alloc]init];
    
         NSMutableArray *tmpnamearr=[[NSMutableArray alloc]init];
         NSMutableArray *tmptimearr=[[NSMutableArray alloc]init];
    
        for (NSDictionary *dic in self.teammemberarr) {
          //  [tmparr addObject:[dic objectForKey:@"doctor"]];
    
    
    
            if ( [[dic objectForKey:@"status"] integerValue]==0) {
                NSDictionary *tmpdic=[dic objectForKey:@"doctor"];
                NSMutableDictionary *mdic=[[NSMutableDictionary alloc]initWithDictionary:tmpdic];
                [mdic setValue:@"0" forKey:@"status"];
                [tmptimearr addObject:mdic];
            } else {
                  NSDictionary *tmpdic=[dic objectForKey:@"doctor"];
                NSMutableDictionary *mdic=[[NSMutableDictionary alloc]initWithDictionary:tmpdic];
                [mdic setValue:@"1" forKey:@"status"];
    
                [tmpnamearr addObject:mdic];
            }
    
    
        }
    
        NSMutableArray *sorttmpnamearr=[ChineseString SortArray:tmpnamearr];
    
    
        NSLog(@"%@",sorttmpnamearr);
    
        NSMutableArray *turenamearr=[[NSMutableArray alloc]init];
        for (NSString *name in sorttmpnamearr) {
            for (NSDictionary *sortdic in tmpnamearr) {
                if ([name isEqualToString:[sortdic objectForKey:@"name"]]) {
                    [turenamearr addObject:sortdic];
                }
            }
        }
         NSMutableArray *turetimearr=[[NSMutableArray alloc]init];
    
        for (NSMutableDictionary *mdic in tmptimearr) {
            [turetimearr insertObject:mdic atIndex:0];
    
        }
    
        [tmparr addObjectsFromArray:turenamearr];
    
        [tmparr addObjectsFromArray:turetimearr];
        
         [tmparr insertObject:self.ownerdatadic atIndex:0];
        
        editnamevc.dataArr=tmparr;
        editnamevc.isaddshowall=YES;
    editnamevc.isdeletedoc=YES;
      // [editnamevc deleteaction];
        [self.navigationController pushViewController:editnamevc animated:YES];
}
-(void)reloadmembers{
    [self showdocaction];
   [self getallmembers];
    [self showpataction];
    [self getallpatient];
    
}
-(void)allPatientaction{
//    ContactPatientViewController *editnamevc=[[ContactPatientViewController alloc]init];
//    //editnamevc.isrootvc=NO;
//   
//    NSLog(@"%@",self.teamid);
//    editnamevc.delegate=self;
//    editnamevc.isaddpatient=YES;
//    editnamevc.docteamid=self.teamid;
//    editnamevc.needsearchbar=NO;
//   NSLog(@"%@",editnamevc.docteamid);
//    //editnamevc.isrootvc=NO;
//    
//   // if (self.ismanager==NO) {
//    editnamevc.isnotneedmoreaction=NO;
//   // }
//    
//    NSMutableArray *tmparr=[[NSMutableArray alloc]init];
//    
//   
//    
//    for (NSDictionary *dic in pushpatientarr) {
//        
//        [tmparr addObject:dic];
//    }
//    NSLog(@"%@",pushpatientarr);
//      NSLog(@"%@",self.patientarr);
//    NSLog(@"%@",patientarr);
//     NSLog(@"%@",tmparr);
//    editnamevc.patientdataArr=tmparr;
//    editnamevc.isaddshowall=YES;

    
    ContactPatientViewController *editnamevc=[[ContactPatientViewController alloc]init];
    //editnamevc.isrootvc=NO;
    editnamevc.isaddpatient=YES;
    editnamevc.isneedadd=YES;
    editnamevc.isnotneedmoreaction=YES;
    editnamevc.needsave=YES;
    editnamevc.isnewteam=self.isnewteam;
    editnamevc.docteamid=self.teamid;
   // editnamevc.needsearchbar=YES;
    
    [self.navigationController pushViewController:editnamevc animated:YES];
    

    

    
  //  [self.navigationController pushViewController:editnamevc animated:YES];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section==0) {
        return 2;
    } else if(section==1){
        if (haveshowdoc) {
             return docarr.count;
        }else{
             return tmpdocarr.count;
       
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
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return 64;
        } else {
            return 44;
        }
        
    } else {
        return 52;
    }

   
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=nil;
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"myviewcell"];
    }
    if (indexPath.section==0) {
       // cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.row==0) {
            for (int i=0; i<1; i++) {
                // NSDictionary *tmpmemberdic;
                NSDictionary *memberdic;
                if (i==0) {
                    memberdic=self.ownerdatadic;
                }else{
                    memberdic =[[self.teammemberarr objectAtIndex:i-1] objectForKey:@"doctor"];
                }
                
                
                
                
                UIView *bgv=[[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/4*i, 0, ScreenWidth/4, 90)];
                
                UIImageView *imagev=[[UIImageView alloc]initWithFrame:CGRectMake(12, 8, 48, 48)];
                [imagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[memberdic objectForKey:@"icon"]]] placeholderImage:[UIImage imageNamed:@"myteam_1"]];
                imagev.backgroundColor=[UIColor whiteColor];
                imagev.clipsToBounds=YES;
                
                imagev.layer.masksToBounds=YES;
                imagev.layer.cornerRadius =24.0;
                imagev.layer.borderWidth=1.0;
                imagev.layer.borderColor = KLineColor.CGColor;
                imagev.layer.rasterizationScale = [UIScreen mainScreen].scale;
                
                [bgv addSubview:imagev];
                
               
                hotsplabel.font=[UIFont systemFontOfSize:17.0];
                hotsplabel.textColor=KlightBlackColor;
                hotsplabel.textAlignment=NSTextAlignmentLeft;
                [bgv addSubview:hotsplabel];
                [cell addSubview:bgv];
                
//                UILabel *groupnamelabel=[[UILabel alloc]initWithFrame:CGRectMake(imagev.frame.origin.x+imagev.frame.size.width+10, 65-30, ScreenWidth/4, 30)];
                
                groupnamelabel.frame=CGRectMake(70, imagev.center.y, ScreenWidth/2, 24);
               // groupnamelabel.text=[NSString stringWithFormat:@"%@团队",self.title];
                groupnamelabel.font=[UIFont systemFontOfSize:13.0];
                groupnamelabel.textAlignment=NSTextAlignmentLeft;
                groupnamelabel.textColor=KtextGrayColor;
                [bgv addSubview:groupnamelabel];
                [cell addSubview:bgv];

//                if (i>0) {
//                    
//                    
//                    NSLog(@"%@",[[self.teammemberarr objectAtIndex:i-1] objectForKey:@"status"]);
//                    if ([[[self.teammemberarr objectAtIndex:i-1] objectForKey:@"status"] integerValue]==0) {
//                        UILabel *statelabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/4/2-25+25, 40, 40, 15)];
//                        statelabel.text=@"待加入";
//                        statelabel.textColor=[UIColor whiteColor];
//                        statelabel.layer.cornerRadius=6.0;
//                        statelabel.font=[UIFont systemFontOfSize:9.0];
//                        statelabel.textAlignment=NSTextAlignmentCenter;
//                        statelabel.backgroundColor=KGreenColor;
//                        [bgv addSubview:statelabel];
//                        
//                        [cell addSubview:bgv];
//                        
//                    }
//                }
//                
                
//                UILabel *namelabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 58, ScreenWidth/4, 30)];
//                namelabel.text=[NSString stringWithFormat:@"%@",[memberdic objectForKey:@"name"]?[memberdic objectForKey:@"name"]:@""];
//                namelabel.font=[UIFont systemFontOfSize:13.0];
//                namelabel.textAlignment=NSTextAlignmentCenter;
//                [bgv addSubview:namelabel];
//                [cell addSubview:bgv];
            }
            
            
            
            
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            UIView *linev=[[UIView alloc]initWithFrame:CGRectMake(0, 63.3, ScreenWidth, 0.7)];
            linev.backgroundColor=KLineColor;
            [cell addSubview:linev];

            
        }else{
            
            
            
            itemdetailbutton *sentbutton=[itemdetailbutton buttonWithType:UIButtonTypeCustom];
            sentbutton.frame=CGRectMake(0, 0, ScreenWidth/2.0, 44);
            [sentbutton setTitle:@"  邀请医生" forState:UIControlStateNormal];
            [sentbutton setImage:[UIImage imageNamed:@"invite_doc"] forState:UIControlStateNormal];
            sentbutton.tag=100;
            
            [sentbutton setTitleColor:KlightBlackColor forState:UIControlStateNormal];
            [sentbutton setTitleColor:KlightOrangeColor forState:UIControlStateSelected];
            
            [sentbutton addTarget:self action:@selector(allmemeberaction) forControlEvents:UIControlEventTouchUpInside];
            sentbutton.backgroundColor=[UIColor whiteColor];
            [cell addSubview:sentbutton];
            
           // sentbutton.selected=YES;
         
            sentbutton.titleLabel.font=[UIFont systemFontOfSize:18.0];

            
            
            itemdetailbutton *sentbutton1=[itemdetailbutton buttonWithType:UIButtonTypeCustom];
            sentbutton1.frame=CGRectMake(ScreenWidth/2.0, 0, ScreenWidth/2.0, 44);
            [sentbutton1 setTitle:@"  邀请患者" forState:UIControlStateNormal];
            [sentbutton1 setImage:[UIImage imageNamed:@"invite_patient"] forState:UIControlStateNormal];
            sentbutton1.tag=101;
            
            [sentbutton1 setTitleColor:KlightBlackColor forState:UIControlStateNormal];
            [sentbutton1 setTitleColor:KlightOrangeColor forState:UIControlStateSelected];
            
            [sentbutton1 addTarget:self action:@selector(allPatientaction) forControlEvents:UIControlEventTouchUpInside];
            sentbutton1.backgroundColor=[UIColor whiteColor];
            [cell addSubview:sentbutton1];
            
            
            
            sentbutton1.titleLabel.font=[UIFont systemFontOfSize:18.0];
            
            
            
            UIView *lineview=[[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/2.0-0.7/2.0, 0, 0.7, 44)];
            lineview.backgroundColor=KLineColor;
            [cell addSubview:lineview];
            
//
//            masklineview =[[UIView alloc]initWithFrame:CGRectMake(0, 60+63.7-5, ScreenWidth/2.0, 5.0)];
//            masklineview.backgroundColor=KlightOrangeColor;
//            [self.view addSubview:masklineview];
            
            
       
        }
        
    }else if (indexPath.section==1) {
        //医生
        
        
        NSMutableDictionary *datadic=[docarr objectAtIndex:indexPath.row];
     
        
        
        
        NSLog(@"%zd %@ ",indexPath.row,datadic);
        
        
        
        // cell.imageView.image=[UIImage imageNamed:@"KAKA"];
        UIImageView *imagev;
        //=[[UIImageView alloc]init];
        
//        if (self.isaddpatient) {
//            imagev =[[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 44, 44)];
//            imagev.frame=CGRectMake(10, 0, 44, 44);
//            
//        }else{
            imagev =[[UIImageView alloc]initWithFrame:CGRectMake(12, 52/2.0-40/2.0, 40, 40)];
            //   imagev.frame=CGRectMake(10, 8, 44, 44);
            
//        }
        
        
        
        imagev.clipsToBounds=YES;
        
        imagev.layer.masksToBounds=YES;
        imagev.layer.cornerRadius =20.0;
        imagev.layer.borderColor = [UIColor clearColor].CGColor;
        imagev.layer.rasterizationScale = [UIScreen mainScreen].scale;
        
        // imagev.image=[UIImage imageNamed:@"KAKA"];
        //  NSLog(@"%@",[NSString stringWithFormat:@"%@",[datadic objectForKey:@"icon"]]);
        
        
        NSLog(@"%@",datadic);
        [imagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[datadic objectForKey:@"icon"]]] placeholderImage:[UIImage imageNamed:kPlaceholderimage]];
        [cell addSubview:imagev];
        
        UILabel *label=[[UILabel alloc]init];
        
        
//        if (self.isaddpatient) {
//            label.frame=CGRectMake(60, 7, 60, 30);
//            
//        }else{
            label.frame=CGRectMake(60, 11, 200, 30);
            
    //    }
        label.textColor=KlightBlackColor;
        label.font=[UIFont systemFontOfSize:18.0];
        label.backgroundColor=[UIColor whiteColor];
        [cell addSubview:label];
        //label.text=
        NSString *contentstring=[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@",[datadic objectForKey:@"name"]]];
        //
        NSMutableAttributedString *astring=[[NSMutableAttributedString alloc]initWithString:contentstring];
        //
        //
        //
        label.attributedText=astring;
        
        [imagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[datadic objectForKey:@"icon"]]] placeholderImage:[UIImage imageNamed:kPlaceholderimage]];
        label.text=[datadic objectForKey:@"name"];
        
//        [UserDataService getUserInfofortargetIdWithtargetId:[datadic objectForKey:@"id"] block:^(id userinfomodel) {
//            UserInfoModel *model=(UserInfoModel *)userinfomodel;
//            [imagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.pimgurl]] placeholderImage:[UIImage imageNamed:kPlaceholderimage]];
//            label.text=model.username;
//            
//            
//        }];

        
        if (indexPath.row!=0) {
            if ([datadic objectForKey:@"status"] ) {
                if ([[datadic objectForKey:@"status"]isEqualToString:@"0"]) {
                    
                    UILabel *sentbuttonlabel=[[UILabel alloc]init];
                    // sentbutton.frame=CGRectMake(ScreenWidth-90, 5, 80, 40-6);
                    sentbuttonlabel.frame=CGRectMake(ScreenWidth-70, 11, 60, 30);
                    sentbuttonlabel.text=@"待加入";
                    sentbuttonlabel.textColor=[UIColor grayColor];
                    sentbuttonlabel.font=[UIFont boldSystemFontOfSize:13.0];
                    [cell addSubview:sentbuttonlabel];
                    //                if (isedit) {
                    //                    sentbuttonlabel.hidden=YES;
                    //                }else{
                    //                    sentbuttonlabel.hidden=NO;
                    //                }
                    
                }else if ([[datadic objectForKey:@"status"]isEqualToString:@"1"]){
                    
                    
                }
                
            }

        }
        
        
        if (indexPath.row!=docarr.count-1) {
            
            UIView *linev=[[UIView alloc]initWithFrame:CGRectMake(label.frame.origin.x, 51.3, ScreenWidth-65, 0.7)];
            linev.backgroundColor=KLineColor;
            [cell addSubview:linev];
        }

        cell.selectionStyle=UITableViewCellSelectionStyleNone;
//        
//        RCConversation *cov=[dataarr objectAtIndex:indexPath.row];
//        
//        
//        UIImageView *imagev;
//        //=[[UIImageView alloc]init];
//        
//        
//        imagev =[[UIImageView alloc]initWithFrame:CGRectMake(10, 8, 44, 44)];
//        //   imagev.frame=CGRectMake(10, 8, 44, 44);
//        
//        
//        
//        
//        imagev.clipsToBounds=YES;
//        
//        imagev.layer.masksToBounds=YES;
//        imagev.layer.cornerRadius =22.0;
//        imagev.layer.borderColor = [UIColor clearColor].CGColor;
//        imagev.layer.rasterizationScale = [UIScreen mainScreen].scale;
//        
//        // imagev.image=[UIImage imageNamed:@"KAKA"];
//        //  NSLog(@"%@",[NSString stringWithFormat:@"%@",[datadic objectForKey:@"icon"]]);
//     //   [imagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@""]] placeholderImage:[UIImage imageNamed:kPlaceholderimage]];
//        [cell.contentView addSubview:imagev];
//        
//        UILabel *label=[[UILabel alloc]init];
//        label.frame=CGRectMake(60, 8, 190, 30);
//        label.textColor=KBlackColor;
//        label.font=[UIFont systemFontOfSize:16.0];
//        label.backgroundColor=[UIColor clearColor];
//        label.textAlignment=NSTextAlignmentLeft;
//        [cell.contentView addSubview:label];
//        
//      //  label.text=[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"橙医生"]];
////        [UserDataService getUserInfofortargetIdWithtargetId:cov.senderUserId block:^(id userinfomodel) {
////            UserInfoModel *model=(UserInfoModel *)userinfomodel;
////            [imagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.pimgurl]] placeholderImage:[UIImage imageNamed:kPlaceholderimage]];
////            label.text=[NSString stringWithFormat:@"%@",model.username];
////        }];
//        
//        //    NSString *contentstring=[NSString stringWithFormat:@"%@",@"橙医生【胡大一医生团队】"];
//        //
//        //    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:label.text];
//        //    NSString *temp = nil;
//        //    for(int i =0; i < [attributedString length]; i++)
//        //    {
//        //        temp = [label.text substringWithRange:NSMakeRange(i, 1)];
//        //        if( i>2  ){
//        //            [attributedString setAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//        //                                             KlightOrangeColor, NSForegroundColorAttributeName,
//        //                                             [UIFont boldSystemFontOfSize:15.0],NSFontAttributeName, nil]
//        //                                      range:NSMakeRange(i, 1)];
//        //        }else{
//        //            [attributedString setAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//        //                                             kimiColor(157, 157, 157, 1.0), NSForegroundColorAttributeName,
//        //                                             [UIFont boldSystemFontOfSize:13.0],NSFontAttributeName, nil]
//        //                                      range:NSMakeRange(i, 1)];
//        //        }
//        //    }
//        //
//        //    label.attributedText = attributedString;
//        [label sizeToFit];
//        // label.text=[NSString stringWithFormat:@"%@",cov.conversationTitle];
//        //label.text=
//        
//        
//        
//        
//        UILabel *detaillabel=[[UILabel alloc]init];
//        detaillabel.frame=CGRectMake(60, 30, 250, 30);
//        detaillabel.textColor=KlightOrangeColor;
//        detaillabel.font=[UIFont systemFontOfSize:12.0];
//        detaillabel.backgroundColor=[UIColor clearColor];
//        detaillabel.textAlignment=NSTextAlignmentLeft;
//        [cell.contentView addSubview:detaillabel];
//        
//        detaillabel.text=[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"中国人民解放军总医院（301医院）全军唯一一所医院办学单位"]];
//        detaillabel.numberOfLines=2;
//        [detaillabel sizeToFit];
//        
//        
//        
//        
//        
//        UILabel *desclabel=[[UILabel alloc]init];
//        desclabel.frame=CGRectMake(60, 84-30, 180, 30);
//        desclabel.textColor=KLineColor;
//        desclabel.font=[UIFont systemFontOfSize:13.0];
//        desclabel.backgroundColor=[UIColor clearColor];
//        [cell.contentView addSubview:desclabel];
//        
//        //   [RCIM sharedRCIM]groupUserInfoDataSource;
//        
//        //NSLog(@"%@",cov.draft);
//        
//        
//        [UserDataService getGroupInfofortargetIdWithGroupId:cov.targetId block:^(id ginfomodel) {
//            GroupInfoModel *groupinfomodel=(GroupInfoModel *)ginfomodel;
//            [imagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",groupinfomodel.pimgurl]] placeholderImage:[UIImage imageNamed:kPlaceholderimage]];
//            NSLog(@"%@",groupinfomodel.username);
//            label.text=groupinfomodel.username;
//            [label sizeToFit];
//        }];
//        
//        [UserDataService getUserInfofortargetIdWithtargetId:cov.senderUserId block:^(id userinfomodel) {
//            UserInfoModel *model=(UserInfoModel *)userinfomodel;
////            [imagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.pimgurl]] placeholderImage:[UIImage imageNamed:kPlaceholderimage]];
////            label.text=[NSString stringWithFormat:@"%@",model.username];
//            
//            
//            NSLog(@"%@",cov.draft);
//            if (cov.draft.length!=0) {
//                desclabel.text=[NSString stringWithFormat:@"【草稿】%@",cov.draft];
//                desclabel.textColor=[UIColor redColor];
//            }else{
//                if ([cov.jsonDict objectForKey:@"longitude"]) {
//                    
//                    desclabel.text=[NSString stringWithFormat:@"%@：%@",model.username,@"【位置】"];
//                    
//                }else if ([cov.jsonDict objectForKey:@"url"]){
//                    
//                    
//                    desclabel.text=[NSString stringWithFormat:@"%@：%@",model.username,@"【链接】"];
//                    
//                }else if ([cov.jsonDict objectForKey:@"imageUri"]){
//                    
//                    
//                    desclabel.text=[NSString stringWithFormat:@"%@：%@",model.username,@"【图片】"];
//                    
//                }else{
//                    
//                    desclabel.text=[NSString stringWithFormat:@"%@：%@",model.username,[cov.jsonDict objectForKey:@"content"]];
//                    
//                }
//                
//                
//            }
//            
//            
//            
//        }];
//        
        
        
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
//        NSInteger unreadcount=cov.unreadMessageCount;
//        //    }
//        
//        //
//        //    } else {
//        //        for (NSString *groupid in self.grouparr2 ) {
//        //            RCConversation *cov=[[RCIMClient sharedRCIMClient]getConversation:ConversationType_GROUP targetId:groupid];
//        //              NSLog(@"row 1%i",cov.unreadMessageCount);
//        //            unreadcount=unreadcount+cov.unreadMessageCount;
//        //        }
//        //
//        //    }
//        
//        
//        
//        UIFont *font=[UIFont systemFontOfSize:13.0];
//        NSString *heightstr=[NSString stringWithFormat:@"%zd",unreadcount];
//        CGRect strsize=[heightstr boundingRectWithSize:CGSizeMake(ScreenWidth, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
//        
//        
//        //            UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(myframe.origin.x, myframe.origin.y, strsize.size.width+10, 20.0)];
//        CGFloat width;
//        if (strsize.size.width+10.0<20.0) {
//            width=20.0;
//        }else{
//            width=strsize.size.width+10.0;
//        }
//        //  msgcountlabel=[[UILabel alloc]initWithFrame:CGRectMake(140, 17,width , 20)];
//        
//        
//        UILabel *unreadlabel=[[UILabel alloc]init];
//        unreadlabel.frame=CGRectMake(ScreenWidth-50, 84/2.0-10.0, width, 20);
//        unreadlabel.textColor=[UIColor whiteColor];
//        unreadlabel.clipsToBounds=YES;
//        unreadlabel.layer.masksToBounds=YES;
//        unreadlabel.layer.cornerRadius =10.0;
//        unreadlabel.layer.borderColor = [UIColor clearColor].CGColor;
//        unreadlabel.layer.rasterizationScale = [UIScreen mainScreen].scale;
//        unreadlabel.textAlignment=NSTextAlignmentCenter;
//        unreadlabel.text=heightstr;
//        unreadlabel.font=[UIFont boldSystemFontOfSize:13.0];
//        unreadlabel.backgroundColor=[UIColor redColor];
//        unreadlabel.hidden=YES;
//        if (unreadcount>0) {
//            unreadlabel.hidden=NO;
//        }
//        [cell.contentView addSubview:unreadlabel];
//        cell.selectionStyle=UITableViewCellSelectionStyleNone;
//        
//        
//        
        
        
        
        
        
        
//        NSDictionary *memberdic =[self.patientarr objectAtIndex:indexPath.row] ;
//        
//        
//        
//        
//        UIImageView *imagev=[[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 60, 60)];
//        imagev.image=[UIImage imageNamed:@"KAKA"];
//        imagev.backgroundColor=[UIColor whiteColor];
//        imagev.clipsToBounds=YES;
//        
//        imagev.layer.masksToBounds=YES;
//        imagev.layer.cornerRadius =30.0;
//        imagev.layer.borderWidth=0.0;
//        imagev.layer.borderColor = KLineColor.CGColor;
//        imagev.layer.rasterizationScale = [UIScreen mainScreen].scale;
//        
//        [cell addSubview:imagev];
//        
//        
//        
//        
//        
//        
//        
//        
//        UILabel *namelabel=[[UILabel alloc]initWithFrame:CGRectMake(80, 25, 100, 30)];
//        namelabel.text=[NSString stringWithFormat:@"%@",[memberdic objectForKey:@"name"]];
//        namelabel.font=[UIFont boldSystemFontOfSize:18.0];
//        namelabel.textColor=KBlackColor;
//        namelabel.textAlignment=NSTextAlignmentLeft;
//        [cell addSubview:namelabel];
//        
////        UILabel *desclabel=[[UILabel alloc]initWithFrame:CGRectMake(80, 45, 175, 30)];
////        desclabel.text=@"上周血压高到爆 卧槽！";
////        desclabel.textColor=KLineColor;
////        desclabel.font=[UIFont systemFontOfSize:12.0];
////        desclabel.textAlignment=NSTextAlignmentLeft;
////        [cell addSubview:desclabel];
//
//        
//        UILabel *timelabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-70, 45, 65, 30)];
//        timelabel.text=@"12-23 11:52";
//        timelabel.textColor=KLineColor;
//        timelabel.font=[UIFont systemFontOfSize:10.0];
//        timelabel.textAlignment=NSTextAlignmentRight;
       // [cell addSubview:timelabel];
       // cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
        
        
        
        
//        UIView *linev=[[UIView alloc]initWithFrame:CGRectMake(15, 50, ScreenWidth-15, 0.7)];
//        linev.backgroundColor=KLineColor;
//        [cell addSubview:linev];
        
        
        
        
    }else if(indexPath.section==2){
//        UIButton *invitebutton=[[UIManager shareInstance]getbuttonWithtitle:@"加入" theFrame:CGRectMake(ScreenWidth-90, 10, 80, 30) theButtonImage:nil];
//        invitebutton.layer.cornerRadius=4.0;
//        invitebutton.backgroundColor=KlightOrangeColor;
//        invitebutton.tag=indexPath.row;
//        [invitebutton addTarget:self action:@selector(inviteactioin:) forControlEvents:UIControlEventTouchUpInside];
//        
//        [cell addSubview:invitebutton];
//        cell.detailTextLabel.text=@"扶贫济困";
//        
//        cell.detailTextLabel.textColor=KLineColor;
        
        
        NSMutableDictionary *datadic;
        
        
        NSLog(@"%@",patientarr);
        // cell.imageView.image=[UIImage imageNamed:@"KAKA"];
        UIImageView *imagev;
        
        
//        if (self.isneedadd&&self.isaddpatient&&self.needsave) {
//            datadic =[[dataarr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
//        }else{
            datadic =[patientarr objectAtIndex:indexPath.row];
     //   }
        //=[[UIImageView alloc]init];
//        
//        if (self.isaddpatient) {
//            imagev =[[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 44, 44)];
//            imagev.frame=CGRectMake(10, 0, 44, 44);
//            
//        }else{
            imagev =[[UIImageView alloc]initWithFrame:CGRectMake(12, 51/2.0-40/2.0, 40, 40)];
            //   imagev.frame=CGRectMake(10, 8, 44, 44);
            
     //   }
        
        
        
        imagev.clipsToBounds=YES;
        
        imagev.layer.masksToBounds=YES;
        imagev.layer.cornerRadius =20.0;
        imagev.layer.borderColor = [UIColor clearColor].CGColor;
        imagev.layer.rasterizationScale = [UIScreen mainScreen].scale;
        
        // imagev.image=[UIImage imageNamed:@"KAKA"];
        //  NSLog(@"%@",[NSString stringWithFormat:@"%@",[datadic objectForKey:@"icon"]]);
        [imagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[datadic objectForKey:@"icon"]]] placeholderImage:[UIImage imageNamed:kPlaceholderimage]];
        [cell addSubview:imagev];
        
        UILabel *label=[[UILabel alloc]init];
        
        
//        if (self.isaddpatient) {
//            label.frame=CGRectMake(60, 7, 60, 30);
//            
//        }else{
            label.frame=CGRectMake(60, 11, 200, 30);
            
       // }
        label.textColor=KlightBlackColor;
        label.font=[UIFont systemFontOfSize:18.0];
        label.backgroundColor=[UIColor whiteColor];
        [cell addSubview:label];
        //label.text=
        NSString *contentstring=[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@",[datadic objectForKey:@"name"]]];
        //
        NSMutableAttributedString *astring=[[NSMutableAttributedString alloc]initWithString:contentstring];
        //
        //
        label.attributedText=astring;
        
//        [UserDataService getUserInfofortargetIdWithtargetId:[datadic objectForKey:@"id"] block:^(id userinfomodel) {
//            UserInfoModel *model=(UserInfoModel *)userinfomodel;
//            [imagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.pimgurl]] placeholderImage:[UIImage imageNamed:kPlaceholderimage]];
//            label.text=model.username;
//            
//            
//        }];
        
        
        
        [imagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[datadic objectForKey:@"icon"]]] placeholderImage:[UIImage imageNamed:kPlaceholderimage]];
        label.text=[datadic objectForKey:@"name"];

        
        
        
//        
//        UIView *linev=[[UIView alloc]initWithFrame:CGRectMake(15, 50, ScreenWidth-15, 0.7)];
//        linev.backgroundColor=KLineColor;
//        [cell addSubview:linev];

        
        
        
        if (indexPath.row!=patientarr.count-1) {
            
            UIView *linev=[[UIView alloc]initWithFrame:CGRectMake(label.frame.origin.x, 51.3, ScreenWidth-65, 0.7)];
            linev.backgroundColor=KLineColor;
            [cell addSubview:linev];
        }

        
        
        
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
        
        
    }
    
   // cell.textLabel.text=@"haha";
    return cell;
}
-(void)inviteactioin:(UIButton *)button{
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[self.tableView cellForRowAtIndexPath:indexPath];
    cell.selected=NO;
    if (indexPath.section==0) {
        
    }else if (indexPath.section==1) {
//        RCConversation *cov=[dataarr objectAtIndex:indexPath.row] ;
//        RCDChatViewController *_conversationVC = [[RCDChatViewController alloc] init];
//        _conversationVC.conversationType = ConversationType_GROUP;
//        _conversationVC.targetId = cov.targetId;
//        _conversationVC.userName =cov.conversationTitle;
//        _conversationVC.title = cov.conversationTitle;;
//      //  _conversationVC.conversation = model;
//        _conversationVC.unReadMessage =0;
//      // self.navigationController.navigationBar.hidden=NO;
//        [self.navigationController pushViewController:_conversationVC animated:YES];
//
        
    }else if (indexPath.section==2) {
        NSDictionary *datadic =[patientarr objectAtIndex:indexPath.row];
//        if (self.isaddpatient&&!isedit) {
//            // NSLog(@"%@",datadic);
//            
            hud=[[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleDark];
            [hud showInView:self.view];
            [hud dismissAfterDelay:5];
        
        
//        [UserDataService getGroupInfofortargetIdWithGroupId:cov.targetId block:^(id ginfomodel) {
//       
//        }];
        
            [IMDataService getGroupDetailsWithPatientID:[datadic objectForKey:@"id"] teamId:[self.datadic objectForKey:@"id"] block:^(id responsedic) {
                
                NSDictionary *imdic=(NSDictionary *)responsedic;
                NSLog(@"%@",imdic);
                
                
                [[NSNotificationCenter defaultCenter]postNotificationName:@"havenewIMmsg" object:nil];
                
                NSMutableDictionary *userdatadic;
                userdatadic =[patientarr objectAtIndex:indexPath.row];
                RCConversationModel *cmodel=[[RCConversationModel alloc]init];
                cmodel.targetId= [imdic objectForKey:@"target_id"];
                cmodel.conversationTitle=[NSString stringWithFormat:@"%@(%@)",[imdic objectForKey:@"name"],[userdatadic objectForKey:@"name"]];
                cmodel.conversationType=ConversationType_GROUP;
                NSLog(@"%@",self.datadic);
                
                PatientChatViewController *conversationPageVC=[[PatientChatViewController alloc]initWithChatModel:cmodel];
                conversationPageVC.model=cmodel;
                conversationPageVC.isgroup=YES;
                conversationPageVC.teamid=[self.datadic objectForKey:@"id"];
                conversationPageVC.teamdic=self.datadic;
                conversationPageVC.patientd=[datadic objectForKey:@"id"];
                conversationPageVC.title=[NSString stringWithFormat:@"%@(%@)",[imdic objectForKey:@"name"],[userdatadic objectForKey:@"name"]];
                //[conversationPageVC setupmorebutton];
                
                // [[UINavigationBar appearance] setTintColor:KlightOrangeColor];
                [self.navigationController pushViewController:conversationPageVC animated:YES];
                
                
//                userdatadic =[patientarr objectAtIndex:indexPath.row];
//                [UserDataService getUserInfofortargetIdWithtargetId:[userdatadic objectForKey:@"id"] block:^(id userinfomodel) {
//                    [hud dismiss];
//                    UserInfoModel *model=(UserInfoModel *)userinfomodel;
//                    
//                    
//                    
//                    
//                    RCConversationModel *cmodel=[[RCConversationModel alloc]init];
//                    cmodel.targetId= [imdic objectForKey:@"id"];
//                    cmodel.conversationTitle=[NSString stringWithFormat:@"%@(%@)",[imdic objectForKey:@"name"],model.username];
//                    cmodel.conversationType=ConversationType_GROUP;
//                    
//                    PatientChatViewController *conversationPageVC=[[PatientChatViewController alloc]initWithChatModel:cmodel];
//                    conversationPageVC.model=cmodel;
//                    
//                    [[UINavigationBar appearance] setTintColor:KlightOrangeColor];
//                      [self.navigationController pushViewController:conversationPageVC animated:YES];
////                    self.tabBarController.navigationController.tabBarController.navigationController.navigationBar.hidden=NO;
////                    [self.tabBarController.navigationController.tabBarController.navigationController pushViewController:conversationPageVC animated:YES];
////                    
////
////                    
////                    
////                    
//////                    
//////                    RCDChatViewController *_conversationVC = [[RCDChatViewController alloc]init];
//////                    _conversationVC.conversationType = ConversationType_GROUP;
//////                    
//////                    _conversationVC.targetId = [imdic objectForKey:@"id"];
//////                    _conversationVC.userName = [imdic objectForKey:@"name"];
//////                    _conversationVC.title =model.username;
//////                    _conversationVC.enableNewComingMessageIcon=YES;//开启消息提醒
//////                    _conversationVC.enableUnreadMessageIcon=YES;
////                    [[UINavigationBar appearance] setTintColor:KlightOrangeColor];
////                    
//                    
//                    
////                    [self.navigationController pushViewController:_conversationVC animated:YES];
//
////                    [imagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.pimgurl]] placeholderImage:[UIImage imageNamed:kPlaceholderimage]];
////                    label.text=model.username;
//                    
//                    
//                }];

                
//                if (self.isnewteam) {
//                    
//                    RCDChatViewController *_conversationVC = [[RCDChatViewController alloc]init];
//                    _conversationVC.conversationType = ConversationType_GROUP;
//                    
//                    _conversationVC.targetId = [imdic objectForKey:@"id"];
//                    _conversationVC.userName = [imdic objectForKey:@"name"];
//                    _conversationVC.title = [imdic objectForKey:@"name"];
//                    _conversationVC.enableNewComingMessageIcon=YES;//开启消息提醒
//                    _conversationVC.enableUnreadMessageIcon=YES;
//                    [[UINavigationBar appearance] setTintColor:KlightOrangeColor];
//                    
//                    
//                    
//                    [self.navigationController pushViewController:_conversationVC animated:YES];
//                }else{
                
                           //      }
                
            }];
            
            
            
            
            
            
       // }

   
    }
}
- (void)addHeader
{
    __unsafe_unretained typeof(self) vc = self;
    // 添加下拉刷新头部控件
    [vc.tableView addHeaderWithCallback:^{
        
        
            //if (haveNextPage) {
            pagenum=0;
            [PatientDataService getTeamPatientsWithteamId:[self.datadic objectForKey:@"id"] pageNum:pagenum block:^(id resultArrDic) {
                
                self.patientarr=[resultArrDic objectForKey:@"content"];
                
                if ([[resultArrDic objectForKey:@"has_next"] boolValue]==true) {
                    havenext=YES;
                    pagenum++;
                } else {
                    havenext=NO;
                }
                [self.tableView reloadData];
                [vc.tableView headerEndRefreshing];
            }];
            //        } else {
            //            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            //            [[PublicTools shareInstance]creareNotificationUIView:@"没有更多数据了"];
            //
            //
            //        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // [vc.collectionView reloadData];
            // 结束刷新
            [vc.tableView headerEndRefreshing];
        });
    }];
    
    //  #warning 自动刷新(一进入程序就下拉刷新)
    // [vc.tableView headerBeginRefreshing];
}

- (void)addFooter
{
    __unsafe_unretained typeof(self) vc = self;
    
    
    
    
    
    // 添加上拉刷新尾部控件
    [vc.tableView addFooterWithCallback:^{
        
        
        
      
            if (havenext) {
                NSLog(@"%zd",pagenum);
                [PatientDataService getTeamPatientsWithteamId:[self.datadic objectForKey:@"id"] pageNum:pagenum block:^(id resultArrDic)  {
                    
                     NSMutableArray *dataarr=[resultArrDic objectForKey:@"content"];
                    
                    
                    
                    //[self.dataArr addObject:[dic objectForKey:@"content"]];
                    if (dataarr.count!=0) {
                        NSMutableArray *mutaArray = [[NSMutableArray alloc] init];
                        [mutaArray addObjectsFromArray:self.patientarr];
                        for (NSMutableDictionary *mydic in [resultArrDic objectForKey:@"content"]) {
                            [mutaArray addObject:mydic];
                        }
                        self.patientarr= [[NSMutableArray alloc] init];
                        [self.patientarr removeAllObjects];
                        self.patientarr = mutaArray;
                        
                    }
                    
                    
                    
                    
                    if ([[resultArrDic objectForKey:@"has_next"] boolValue]==true) {
                        havenext=YES;
                        pagenum++;
                    } else {
                        havenext=NO;
                    }
                    [self.tableView reloadData];
                    [vc.tableView footerEndRefreshing];
                }];
            } else {
                [self.tableView reloadData];
                [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
                [[PublicTools shareInstance]creareNotificationUIView:@"没有更多数据了"];
                [vc.tableView footerEndRefreshing];
                
                
            }
        
        // 进入刷新状态就会回调这个Block
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [vc.tableView reloadData];
            // 结束刷新
            [vc.tableView footerEndRefreshing];
        });
    }];
}
-(void)headaction:(itemdetailbutton *)button{
    
}

-(void)getallpatient{
//    JGProgressHUD *hud=[[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleDark];
//    [hud showInView:self.view];
//    [hud dismissAfterDelay:5];
    [PatientDataService getTeamPatientsWithteamId:[self.datadic objectForKey:@"id"] pageNum:0 block:^(id respdic) {
        NSLog(@"%@",respdic);
        
        NSMutableArray *turenamearr=[[NSMutableArray alloc]init];
        NSArray *sourcearr=[[NSArray alloc]initWithArray:[respdic objectForKey:@"content"]];
        
        // NSMutableArray *tmparr=[[NSMutableArray alloc]init];
        
        NSMutableArray *sorttmpnamearr=[ChineseString SortArray:sourcearr];
        
        for (NSString *name in sorttmpnamearr) {
            for (NSDictionary *sortdic in sourcearr) {
                if ([name isEqualToString:[sortdic objectForKey:@"name"]]) {
                    [turenamearr addObject:sortdic];
                }
            }
        }
        
        
        _indexarr=[[NSMutableArray alloc]init];
        
        for (NSString *name in sorttmpnamearr) {
            if (![_indexarr containsObject:[self firstCharactor:name]]) {
                [_indexarr addObject:[self firstCharactor:name]];
            }
        }
        
        
        
        NSMutableArray *turedataarr=[[NSMutableArray alloc]init];
        
        for (NSString *indexstr in _indexarr) {
            //NSMutableDictionary *turedatadic=[[NSMutableDictionary alloc]init];
            //[turedatadic setObject:indexstr forKey:@"indexTitle"];
            //[indexarr addObject:[self firstCharactor:name]];
          //  NSMutableArray *tmparr=[[NSMutableArray alloc]init];
            for (NSDictionary *sortdic in turenamearr) {
                if ([indexstr isEqualToString:[self firstCharactor:[sortdic objectForKey:@"name"]]]) {
                    [turedataarr addObject:sortdic];
                }
            }
            // [turedatadic setObject:tmparr forKey:@"data"];
           // [turedataarr addObject:tmparr];
        }
        patientarr=[[NSMutableArray alloc]initWithArray:turedataarr];
        pushpatientarr=[[NSMutableArray alloc]initWithArray:turedataarr];
        tmppatientarr=[[NSMutableArray alloc]init];
        //[tmppatientarr addObjectsFromArray:turedataarr];
        //[hud dismiss];
     //   [self.tableView reloadData];
         [self showpataction];
        [self.tableView reloadData];
        
    }];

}
- (NSString *)firstCharactor:(NSString *)aString
{
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:aString];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *pinYin = [str capitalizedString];
    //获取并返回首字母
    return [pinYin substringToIndex:1];
    
}


@end
