//
//  MainTabBarController.m
//  CYS
//
//  Created by 谢阳晴 on 15/12/14.
//  Copyright © 2015年 谢阳晴. All rights reserved.
//

#import "MainTabBarController.h"
#import "LogintocysViewController.h"
#import "DVSwitch.h"
#import "RCDChatListViewController.h"
#import "PatientManagerViewController.h"
#import "MyspaceViewController.h"

#import "AddPatientViewController.h"

#import <RongIMKit/RongIMKit.h>

#import <RongIMLib/RongIMLib.h>

#import "TeamListViewController.h"

#import "DoctorTeamViewController.h"

#import "AddPatientViewController.h"
#import "PatientListViewController.h"

#import "THTinderNavigationController.h"

#import "PersonalCenterViewController.h"

#import "WMPageController.h"

#import "FaceOrderViewController.h"

@interface MainTabBarController (){
    RCDChatListViewController *vc;
    TeamListViewController *vc1;
    UIView *rightredview;
    UIView *leftredview;
    UINavigationController *rootNavi;
    NSInteger selectindex;
    NSMutableArray *teamarr;
    UITabBarController *roottabbarvc;
    
        UIView *buttonbgv;
        BOOL haveshowmorebutton;
        UIControl *moreControl;
    MsgModel *publicmsgmodel;
    UISegmentedControl *segmentView;
    NSArray *titlearr;
    NSArray *vcarr;
   // RFSegmentView *segmentView;
    THTinderNavigationController *tinderNavigationController;
    LXDSegmentControl * selectControl;
    WMPageController *pageVC;
    UINavigationController *pmnav1;
    NSString *msgtype;
    HomeViewController *homevc;
    PersonalCenterViewController *myspacevc;
    UIView *redpointview;
    UIView *redpointview1;
   

}
@property(nonatomic,retain)DVSwitch *switcher;

@end

@implementation MainTabBarController
-(void)viewDidLoad{
    selectindex=2;
    publicmsgmodel=[[MsgModel alloc]init];
    
    self.navigationController.navigationBar.hidden=YES;
    teamarr=[[NSMutableArray alloc]init];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(newmsg:) name:@"havenewIMmsg" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadindex:) name:@"reloadindex" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(relogin) name:@"relogin" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloginupdateinfo) name:@"reloginupdateinfo" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(newsystemmsg:) name:@"havenewSystemMsg" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(systemmsg:) name:@"haveSystemMsg" object:nil];
//     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(newgroupmsg:) name:@"havenewIMGroupmsg" object:nil];

    [self setupmoreview];
    
    homevc=[[HomeViewController alloc]init];
    homevc.title=@"我的诊所";
//    homevc.tabBarItem.image=[UIImage imageNamed:@"home_1"];
//    homevc.tabBarItem.selectedImage=[UIImage imageNamed:@"home_2"];
    homevc.tabBarItem.image = [[UIImage imageNamed:@"home_1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    homevc.tabBarItem.selectedImage = [[UIImage imageNamed:@"home_2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
//    PatientManagerViewController *patientManagerVC=[[PatientManagerViewController alloc]init];
//    
//    patientManagerVC.title=@"患者管理";
    
    
    
    UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    
    rootNavi = [storyboard instantiateViewControllerWithIdentifier:@"rootNavi"];
    roottabbarvc = (UITabBarController *)[[rootNavi viewControllers]objectAtIndex:0];
    
  //  NSLog(@"%@",[[rootNavi viewControllers] objectAtIndex:0]);
    
    
    
    rootNavi.title=@"患者管理";
    
   // PatientManagerViewController *vc=[[PatientManagerViewController alloc]init];
//    //设置要显示的会话类型
//    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),@(ConversationType_DISCUSSION), @(ConversationType_APPSERVICE), @(ConversationType_PUBLICSERVICE),@(ConversationType_GROUP),@(ConversationType_SYSTEM)]];
//    
//    //聚合会话类型
//    [self setCollectionConversationType:@[@(ConversationType_GROUP),@(ConversationType_DISCUSSION)]];
//
    vc=[[RCDChatListViewController alloc]initWithDisplayConversationTypes:@[@(ConversationType_PRIVATE)] collectionConversationType:nil];
    vc.isgroup=NO;
    //vc1=[[RCDChatListViewController alloc]initWithDisplayConversationTypes:@[@(ConversationType_GROUP)] collectionConversationType:nil];
   // vc1=[[TeamListViewController alloc]initWithDisplayConversationTypes:@[@(ConversationType_GROUP)] collectionConversationType:nil];
    vc1=[[TeamListViewController alloc]init];
   // vc1.isgroup=YES;
    
    

//    tinderNavigationController = [[THTinderNavigationController alloc] init];
//    tinderNavigationController.delegate=self;
//    tinderNavigationController.tabBarItem.title=@"咨询";
//    tinderNavigationController.viewControllers = @[
//                                                   vc,
//                                                   vc1
//                                                   ];
    
    
    
    
    
    NSArray *viewControllers =@[
                                vc,
                                vc1
                                ];
        NSArray *titles = @[@"", @"" ];
    
        pageVC = [[WMPageController alloc] initWithViewControllerClasses:viewControllers andTheirTitles:titles];
        pageVC.titleSizeSelected = 15;
        pageVC.needrightbtn=NO;
        pageVC.delegate=self;
        pageVC.pageAnimatable = YES;
        pageVC.menuHeight=0.01;
        pageVC.isViewInstance=YES;
        //pageVC.progressHeight=60.0;
        pageVC.itemsWidths=@[@(ScreenWidth/2.0),@(ScreenWidth/2.0)];
        pageVC.menuBGColor=[UIColor whiteColor];
        pageVC.menuViewStyle = WMMenuViewStyleLine;
        pageVC.titleColorSelected =KBackgroundColor;
        pageVC.titleColorNormal = KBlackColor;
        pageVC.progressColor = [UIColor clearColor];
        // pageVC.progressHeight=;
        // pageVC.itemsWidths = @[@(70),@(70),@(70)]; // 这里可以设置不同的宽度


    
  //  [tinderNavigationController reloadData];
//    ExampleViewController *pmvc1=[[ExampleViewController alloc]init];
//    pmvc.datasouce=self;
//    pmvc.delegate=self;
//    titlearr=@[@"1",@"2"];
//    vcarr=@[vc,vc1];
    
   // tinderNavigationController.title=@"咨询";
    pmnav1=[[UINavigationController alloc]initWithRootViewController:pageVC];
    pmnav1.tabBarItem.image=[[UIImage imageNamed:@"chat_1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    pmnav1.tabBarItem.selectedImage=[[UIImage imageNamed:@"chat_2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
  //  [pmnav1.navigationBar setTranslucent:NO];
    // [pmnav1.navigationBar setBarTintColor:kimiColor(255, 128, 0, 1.0)];
 //   pmvc.isRoot=YES;
   // (RCDChatListViewController *)[roottabbarvc.viewControllers objectAtIndex:0];
    
     
    
   // NSArray *vcarr=roottabbarvc.viewControllers;
//    NSMutableArray *newtabbararr=[[NSMutableArray alloc]initWithArray:vcarr];
//    [newtabbararr insertObject:vc atIndex:0];
//    [newtabbararr insertObject:vc1 atIndex:1];
//    [newtabbararr insertObject:pmvc atIndex:2];
    
    
    
    
    
//    
//    roottabbarvc.viewControllers=(NSArray *)newtabbararr;
//    
//    roottabbarvc.tabBar.frame=CGRectMake(0, 0, ScreenWidth,49);
//
    
    
    JGProgressHUD *hud=[[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleDark];
    [hud showInView:self.view];
      [hud dismissAfterDelay:5];
    [DocTeamDataService getDocAllTeamblock:^(id responsearr) {
        NSMutableArray *docteamarr=(NSMutableArray *)responsearr;
        
        
        // NSMutableArray *participatedTeamarr;
        
        [DocTeamDataService getAllparticipatedTeamblock:^(id responsearr1) {
            NSMutableArray *participatedTeamarr=(NSMutableArray *)responsearr1;
            
            
            [DocTeamDataService getAllInvitationsblock:^(id responsearr2) {
                NSMutableArray *invitationarr=(NSMutableArray *)responsearr2;
                [hud dismiss];
                if (docteamarr.count==0&&participatedTeamarr.count==0&&invitationarr.count==0) {
                    selectindex=2;
                    //roottabbarvc.selectedIndex=2;
                } else {
                    selectindex=1;
                    //roottabbarvc.selectedIndex=1;
                    teamarr=docteamarr;
//                    vc1.teamarr=teamarr;
//                    vc1.invitationarr=invitationarr;
//                    vc1.participatedTeamarr=participatedTeamarr;
                    
                }
                
            }];
            
        }];

    }];
    
    CGRect frame = CGRectMake(ScreenWidth/2.0-200/2.0, 5, 200, 35.f);
    NSArray * items = @[@"我的咨询", @"团队咨询"];
    
    LXDSegmentControlConfiguration * select = [LXDSegmentControlConfiguration configurationWithControlType: LXDSegmentControlTypeSelectBlock items: items];
    select.cornerRadius=35.0/2.0;
  //  select.slideBlockColor=KlightOrangeColor;
    select.itemBackgroundColor=KlightOrangeColor;
    select.itemSelectedColor=[UIColor whiteColor];
    select.itemTextColor=[UIColor whiteColor];
    select.itemSelectedTextColor=KlightOrangeColor;
    select.cornerColor=[UIColor whiteColor];
    selectControl = [LXDSegmentControl segmentControlWithFrame: frame configuration: select delegate: self];
    //[self.view addSubview: selectControl];

    
    
    
    //pmnav1.navigationItem.titleView=selectControl;
    [pmnav1.navigationBar addSubview:selectControl];
    pmnav1.navigationBar.tintColor=KlightOrangeColor;
    pmnav1.navigationBar.barTintColor=KlightOrangeColor;
    pmnav1.title=@"咨询";
    //    self.switcher = [[DVSwitch alloc] initWithStringsArray:@[@"我的患者", @"患者团队"]];
//    self.switcher.frame = CGRectMake(60, 5, self.view.frame.size.width -120, 35);
//    self.switcher.cornerRadius=35/2.0;
//    self.switcher.backgroundColor=KLineColor;
//    self.switcher.font=[UIFont boldSystemFontOfSize:18];
//    self.switcher.labelTextColorInsideSlider=KlightOrangeColor;
//    self.switcher.labelTextColorOutsideSlider=KBackgroundColor;
//    [pmnav1.navigationBar addSubview:self.switcher];
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth-45, 7, 45, 30)];
 //   [rightBtn setTitle:@"更多" forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"chat_more"] forState:UIControlStateNormal];
    
    
    rightBtn.titleLabel.font=[UIFont boldSystemFontOfSize:13.0];
    [rightBtn addTarget:self action:@selector(showMenu:) forControlEvents:UIControlEventTouchUpInside];
    //UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [pmnav1.navigationBar addSubview:rightBtn];

    
    
    
//    [self.switcher setPressedHandler:^(NSUInteger index) {
//        
//      
//      //  roottabbarvc.selectedIndex=7;
//      
//        
//       // NSLog(@"Did press position on first switch at index: %lu", (unsigned long)index);
//        
//    }];
////
//
//    UINavigationController*patientMnav=[[UINavigationController alloc]initWithRootViewController:roottabbarvc];
    
    
    
//        UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth-40, 5, 35, 30)];
//        [rightBtn setImage:[UIImage imageNamed:@"+"] forState:UIControlStateNormal];
//        rightBtn.titleLabel.font=[UIFont boldSystemFontOfSize:20.0];
//        [rightBtn addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
////        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
//        [rightBtn setTintColor:KlightOrangeColor];
//         [rootNavi.navigationBar addSubview:rightBtn];


    
    
    
    
    
    
    leftredview=[[UIView alloc]initWithFrame:CGRectMake(100-12, 35/2.0-5.0, 10, 10)];
   // leftredview.backgroundColor=KRedColor;
    rightredview=[[UIView alloc]initWithFrame:CGRectMake(selectControl.frame.size.width-12, 35/2.0-5.0, 10, 10)];
    
   // rightredview.backgroundColor=KRedColor;
    
//    [selectControl addSubview:leftredview];
//    [selectControl addSubview:rightredview];
    
    
    
    
    //
    TOOLViewController *toolVC=[[TOOLViewController alloc]init];
    toolVC.title=@"工具箱";
    UINavigationController*toolnav=[[UINavigationController alloc]initWithRootViewController:toolVC];
    toolnav.tabBarItem.image=[[UIImage imageNamed:@"toolbox_1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    toolnav.tabBarItem.selectedImage=[[UIImage imageNamed:@"toolbox_2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    
    
  //  MyspaceViewController
    
    myspacevc=[[PersonalCenterViewController alloc]init];
 
    myspacevc.title=@"我";
    UINavigationController*myspacenav=[[UINavigationController alloc]initWithRootViewController:myspacevc];
    myspacenav.tabBarItem.image=[[UIImage imageNamed:@"me_1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    myspacenav.tabBarItem.selectedImage=[[UIImage imageNamed:@"me_2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
 //    [myspacenav.navigationBar setTranslucent:NO];
    
     self.viewControllers=@[homevc,pmnav1,toolnav,myspacenav];
    self.msgcount=@"0";
//     [self.navigationController.navigationBar setTranslucent:NO];
    self.tabBar.selectedImageTintColor=KlightOrangeColor;
    //[self showlogin];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self newmsg:nil];
}




-(void)WMPageControllerScrollViewToIndex:(NSInteger)index{
    [selectControl setCurrentSelectedIndex:index];
}
-(void)segmentControl:(LXDSegmentControl *)segmentControl didSelectAtIndex:(NSUInteger)index{
    
                if (index==0) {
                   pageVC.selectIndex=0;
                  //  [tinderNavigationController setCurrentPage:0 animated:YES];
                   
                   // [tinderNavigationController reloadData];
                }else{
                    pageVC.selectIndex=1;
                    //[tinderNavigationController setCurrentPage:1 animated:YES];
                    // [tinderNavigationController reloadData];
                }
    
}

//- (NSInteger)numberOfPageInFJSlidingController:(FJSlidingController *)fjSlidingController{
//    return 2;
//}
//// index -> UIViewController
//- (UIViewController *)fjSlidingController:(FJSlidingController *)fjSlidingController controllerAtIndex:(NSInteger)index{
//    return [vcarr objectAtIndex:index];
//}
//// index -> Title
//- (NSString *)fjSlidingController:(FJSlidingController *)fjSlidingController titleAtIndex:(NSInteger)index{
//    return @"";
//}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
    NSString *tonkenstr=KGetDefaultstr(@"token");
    if (tonkenstr.length<=0) {
        NSLog(@"%@",KGetDefaultstr(@"token"));
        LogintocysViewController *cysloginvc=[[LogintocysViewController alloc]init];
        cysloginvc.title=@"登录";
        UINavigationController*cysloginnav=[[UINavigationController alloc]initWithRootViewController:cysloginvc];
        [self presentViewController:cysloginnav animated:YES completion:nil];
    }
    
//    [redpointview removeFromSuperview];
//    
//    redpointview=[[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/4.0/2.0+15, 5, 10, 10)];
//    redpointview.backgroundColor=[UIColor redColor];
//    redpointview.layer.cornerRadius=5.0;
//    [self.tabBar addSubview:redpointview];
//    
//    [redpointview1 removeFromSuperview];
//    redpointview1=[[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/4.0*3+ScreenWidth/4.0/2.0+15, 5, 10, 10)];
//    redpointview1.backgroundColor=[UIColor redColor];
//    redpointview1.layer.cornerRadius=5.0;
//    [self.tabBar addSubview:redpointview1];
    
//     NSLog(@"%@",KGetDefaultstr(@"usertitle"));
//     NSLog(@"%@",KGetDefaultstr(@"nick-name"));
//     NSLog(@"%@",KGetDefaultstr(@"userhospital"));
//     NSLog(@"%@",KGetDefaultstr(@"department"));
////
//    NSString *titlestr=KGetDefaultstr(@"usertitle");
//    NSString *namestr=KGetDefaultstr(@"nick-name");
//    NSString *userhospitalstr=KGetDefaultstr(@"userhospital");
//    NSString *departmentstr=KGetDefaultstr(@"department");
//    if (titlestr<=0||namestr<=0||userhospitalstr<=0||departmentstr<=0) {
//        PubilcViewController *VC=[[PubilcViewController alloc]init];
//        VC.isreg=YES;
//        
//        //http://192.168.1.117:8080/view/authentication.html
//         // VC.urslstr=[NSString stringWithFormat:@"http://192.168.1.117:8080/view/authentication.html"];
//        VC.urslstr=[NSString stringWithFormat:@"%@%@",k_webbaseurl,@"authentication.html"];
//        // @"http://rm.chengyisheng.com.cn:8080/app_web/app_doctor_web/view/authentication.html";
//        //        UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:VC];
//        //        UIViewController *basevc=[self.viewControllers objectAtIndex:self.selectedIndex];
//        [self.navigationController pushViewController:VC animated:YES];
//    }
//
//
//            PubilcViewController *VC=[[PubilcViewController alloc]init];
//            VC.isreg=YES;
//            VC.urslstr=[NSString stringWithFormat:@"http://192.168.1.117:8080/view/authentication.html"];
//            // @"http://rm.chengyisheng.com.cn:8080/app_web/app_doctor_web/view/authentication.html";
//            //        UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:VC];
//            //        UIViewController *basevc=[self.viewControllers objectAtIndex:self.selectedIndex];
//            [self.navigationController pushViewController:VC animated:YES];

    
//    if (!KGetDefaultstr(@"usertitle")||!KGetDefaultstr(@"nick-name")||!KGetDefaultstr(@"userhospital")) {
//        PubilcViewController *VC=[[PubilcViewController alloc]init];
//        VC.isreg=YES;
//        VC.urslstr=[NSString stringWithFormat:@"%@%@",k_webbaseurl,@"upload.html"];
//        // @"http://rm.chengyisheng.com.cn:8080/app_web/app_doctor_web/view/authentication.html";
//        //        UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:VC];
//        //        UIViewController *basevc=[self.viewControllers objectAtIndex:self.selectedIndex];
//        [self.navigationController pushViewController:VC animated:YES];
//    }
    

}
-(void)THTinderShowCurrentPageIndex:(NSInteger)currentPageIndex{
  //  [self.switcher forceSelectedIndex:currentPageIndex animated:YES];
  //  [segmentView setSelectedIndex:currentPageIndex];
    [selectControl setCurrentSelectedIndex:currentPageIndex];
}

//-(void)mypatientaction{
//    //WMPageController *pageController = [self p_defaultController];
//    //    NSArray *viewControllers = @[[UIViewController class], [UIViewController class], [UIViewController class], [UIViewController class]];
//    //    NSArray *titles = @[@"通知", @"赞与感谢", @"私信" ,@"haah"];
//    
//    WMPageController *pageController = [self pageControllerStyleFlood];
//    pageController.navigationController.navigationBar.backgroundColor=[UIColor whiteColor];
//    pageController.title = @"患者库";
//    
//    self.tabBarController.navigationController.tabBarController.navigationController.navigationBar.hidden=NO;
//    [self.tabBarController.navigationController.tabBarController.navigationController pushViewController:pageController animated:YES];
//    
//    
//    
//}
//- (WMPageController *)pageControllerStyleFlood {
////    NSArray *viewControllers = @[[PatientListViewController class],[NameListViewController class], [MyfansViewController class]];
////    NSArray *titles = @[@"标签查找", @"姓名排序" ,@"我的粉丝"];
////    
////    WMPageController *pageVC = [[WMPageController alloc] initWithViewControllerClasses:viewControllers andTheirTitles:titles];
////    pageVC.titleSizeSelected = 15;
////    pageVC.needrightbtn=YES;
////    pageVC.pageAnimatable = YES;
////    pageVC.menuHeight=60.0;
////    //pageVC.progressHeight=60.0;
////    pageVC.itemsWidths=@[@(ScreenWidth/3.0),@(ScreenWidth/3.0),@(ScreenWidth/3.0)];
////    pageVC.menuBGColor=[UIColor whiteColor];
////    pageVC.menuViewStyle = WMMenuViewStyleLine;
////    pageVC.titleColorSelected =KBackgroundColor;
////    pageVC.titleColorNormal = KBlackColor;
////    pageVC.progressColor = [UIColor clearColor];
////    // pageVC.progressHeight=;
////    // pageVC.itemsWidths = @[@(70),@(70),@(70)]; // 这里可以设置不同的宽度
////    return pageVC;
//}






-(void)reloadindex:(NSNotification *)sender{
    
    
//    [self.switcher removeFromSuperview];
//    [rootNavi.navigationBar addSubview:self.switcher];
    JGProgressHUD *hud=[[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleDark];
    [hud showInView:self.view];
    [hud dismissAfterDelay:7];
    
    
    [[RCIMClient sharedRCIMClient]connectWithToken:[[NSUserDefaults standardUserDefaults]objectForKey:@"im-token"] success:^(NSString *userId) {
        NSLog(@"rc成功");
        
    } error:^(RCConnectErrorCode status) {
        NSLog(@"rc失败");
    } tokenIncorrect:^{
        
        [LoginDataService getNewSelfIMInfoblock:^(id respdic) {
            NSLog(@"%@",respdic);
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:[respdic objectForKey:@"im_id"] forKey:@"im-id"];
            [defaults setObject:[respdic objectForKey:@"im_reg_id"] forKey:@"im-token"];
            [defaults synchronize];
            [self login:[[NSUserDefaults standardUserDefaults]objectForKey:@"im-id"] password:@"123456"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadindex" object:nil];
            
        }];
        
        //待处理
        NSLog(@"rc token错误");
        
    }];

    
    
    
    
    
    [DocTeamDataService getDocAllTeamblock:^(id responsearr) {
        NSMutableArray *docteamarr=(NSMutableArray *)responsearr;
       
        
       // NSMutableArray *participatedTeamarr;
        
        [DocTeamDataService getAllparticipatedTeamblock:^(id responsearr1) {
              NSMutableArray *participatedTeamarr=(NSMutableArray *)responsearr1;
            
            
            [DocTeamDataService getAllInvitationsblock:^(id responsearr2) {
                 NSMutableArray *invitationarr=(NSMutableArray *)responsearr2;
                [hud dismiss];
                if (docteamarr.count==0&&participatedTeamarr.count==0&&invitationarr.count==0) {
                    selectindex=2;
                    roottabbarvc.selectedIndex=2;
                } else {
                    selectindex=1;
                    roottabbarvc.selectedIndex=1;
                    teamarr=docteamarr;
//                    vc1.teamarr=teamarr;
//                    vc1.invitationarr=invitationarr;
//                    vc1.participatedTeamarr=participatedTeamarr;
                    
                }

            }];
            
            
            
            
            
            
            
            
        }];
        
        
       
        
               
    }];
    
//    [defaults setObject:[dic objectForKey:@"msisdn"] forKey:@"phonenum"];
//    [defaults setObject:[dic objectForKey:@"doctor-id"] forKey:@"doctor-id"];
//    [defaults setObject:[[dic objectForKey:@"doctor-info"] objectForKey:@"icon"] forKey:@"icon-url"];
//    [defaults setObject:[[dic objectForKey:@"doctor-info"] objectForKey:@"name"] forKey:@"nick-name"];
//    [defaults setObject:[[dic objectForKey:@"doctor-info"] objectForKey:@"id"] forKey:@"userid"];
//    [defaults setObject:[[dic objectForKey:@"doctor-info"] objectForKey:@"title"] forKey:@"usertitle"];
//    [defaults setObject:[[dic objectForKey:@"doctor-info"] objectForKey:@"hospital"] forKey:@"userhospital"];
    
//      NSLog(@"%@",KGetDefaultstr(@"usertitle"));
//      NSLog(@"%@",KGetDefaultstr(@"nick-name"));
//      NSLog(@"%@",KGetDefaultstr(@"userhospital"));
    
//
    
    
}
-(void)reloginupdateinfo{
    [UserDataService getSelfInfoWithblock:^(id respdic) {
        NSDictionary *dic=[[NSDictionary alloc]initWithDictionary:respdic];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        //        [defaults setObject:[dic objectForKey:@"token"] forKey:@"token"];
        //        [defaults setObject:[dic objectForKey:@"msisdn"] forKey:@"phonenum"];
        //[defaults setObject:[dic objectForKey:@"doctor-id"] forKey:@"doctor-id"];
        [defaults setObject:[dic objectForKey:@"icon"] forKey:@"icon-url"];
        [defaults setObject:[dic objectForKey:@"name"] forKey:@"nick-name"];
        [defaults setObject:[dic objectForKey:@"id"] forKey:@"userid"];
        [defaults setObject:[dic objectForKey:@"title"] forKey:@"usertitle"];
        [defaults setObject:[dic objectForKey:@"hospital"] forKey:@"userhospital"];
        
        //        if ([[dic objectForKey:@"hospital"]isEqualToString:@"AUDIT_PASSED"]) {
        //            //HAVEPASS;
        //        }
        [defaults setObject:[dic objectForKey:@"status"] forKey:@"userstatus"];
        
        [defaults setObject:[dic objectForKey:@"cheng_num"] forKey:@"usercheng_num"];
        
        //          [defaults setObject:[[dic objectForKey:@"im-reg-id"] objectForKey:@"im_id"] forKey:@"im-id"];
        //          [defaults setObject:[[dic objectForKey:@"im-reg-id"] objectForKey:@"im_reg_id"] forKey:@"im-token"];
        [defaults synchronize];
        
        NSString *titlestr=KGetDefaultstr(@"usertitle");
        NSString *namestr=KGetDefaultstr(@"nick-name");
        NSString *userhospitalstr=KGetDefaultstr(@"userhospital");
        NSString *departmentstr=KGetDefaultstr(@"department");
        
        if (titlestr.length<=0||namestr.length<=0||userhospitalstr.length<=0||departmentstr.length<=0) {
            PubilcViewController *VC=[[PubilcViewController alloc]init];
            VC.isreg=YES;
            
            //http://192.168.1.117:8080/view/authentication.html
            // VC.urslstr=[NSString stringWithFormat:@"http://192.168.1.117:8080/view/authentication.html"];
            VC.urslstr=[NSString stringWithFormat:@"%@%@",k_webbaseurl,@"authentication.html"];
            // @"http://rm.chengyisheng.com.cn:8080/app_web/app_doctor_web/view/authentication.html";
            //        UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:VC];
            //        UIViewController *basevc=[self.viewControllers objectAtIndex:self.selectedIndex];
            [self.navigationController pushViewController:VC animated:YES];
        }
        
        
        
    }];

    
}

- (void)login:(NSString *)userName password:(NSString *)password
{
    RCNetworkStatus stauts=[[RCIMClient sharedRCIMClient]getCurrentNetworkStatus];
    
    if (RC_NotReachable == stauts) {
        // _errorMsgLb.text=@"当前网络不可用，请检查！";
        return;
    } else {
        // _errorMsgLb.text=@"";
    }
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey :@"UserCookies"];
    [self loginRongCloud:@"haha@chengyisheng.com" token:[[NSUserDefaults standardUserDefaults]objectForKey:@"im-token"] password:password];
    
}
- (void)loginRongCloud:(NSString *)userName token:(NSString *)token password:(NSString *)password
{
    token=[[NSUserDefaults standardUserDefaults]objectForKey:@"im-token"];
    NSLog(@"%@",token);
    //登陆融云服务器
    [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
        
    } error:^(RCConnectErrorCode status) {
        
        
        
    } tokenIncorrect:^{
        NSLog(@"IncorrectToken");
        
        
    }];
}

-(void)showMenu:(UIButton *)button{
//    PatientManagerViewController *adddoctorteamVC=[[PatientManagerViewController alloc]init];
//    adddoctorteamVC.title=@"创建团队";
//    
//    self.navigationController.navigationBar.hidden=NO;
//    [self.navigationController pushViewController:adddoctorteamVC animated:YES];
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


//- (IBAction)showMenu:(UIButton *)sender {
//    
//    
//    if (haveshowmorebutton==YES) {
//        [buttonbgv removeFromSuperview];
//        [moreControl removeFromSuperview];
//        haveshowmorebutton=NO;
//        
//    } else {
//        
//        moreControl=[[UIControl alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight)];
//        moreControl.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
//        [moreControl addTarget:self action:@selector(moreControlaction:) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:moreControl];
//        [self.view addSubview:buttonbgv];
//        
//        
//        
//        haveshowmorebutton=YES;
//    }
//    
//    
//    
//}
//
//-(void)morebuttonaction{
//    //更多
//    if (haveshowmorebutton==YES) {
//        [buttonbgv removeFromSuperview];
//        [moreControl removeFromSuperview];
//        haveshowmorebutton=NO;
//        
//    } else {
//        
//        moreControl=[[UIControl alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight)];
//        moreControl.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
//        [moreControl addTarget:self action:@selector(moreControlaction:) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:moreControl];
//        [self.view addSubview:buttonbgv];
//        
//        
//        
//        haveshowmorebutton=YES;
//    }
//    
//}
-(void)moreControlaction:(UIControl *)control{
    [control removeFromSuperview];
    [buttonbgv removeFromSuperview];
    
    haveshowmorebutton=NO;
    
}
-(void)setupmoreview{
    
    buttonbgv=[[UIView alloc]initWithFrame:CGRectMake(ScreenWidth-155, 66, 150, 45*4)];
    buttonbgv.layer.cornerRadius=4.0;
    buttonbgv.backgroundColor=[UIColor whiteColor];
    // buttonbgv.alpha=0.7;
    
    
    
    
    NSArray *namearr=@[@"我的患者库",@"添加个人患者",@"医生团队",@"创建医生团队"];
    NSArray *moreimagearr=@[@"patient_warehouse",@"add_patient",@"doc_team_nav",@"establish_team"];
    for (int i=0; i<4; i++) {
        
        
        
        
        UIImageView *imagev;
        
        imagev =[[UIImageView alloc]initWithFrame:CGRectMake(13, 45*i+12.5, 23, 20)];
      
        
        
        
        
//        imagev.clipsToBounds=YES;
//        
//        imagev.layer.masksToBounds=YES;
//       // imagev.layer.cornerRadius =22.0;
//        imagev.layer.borderColor = [UIColor clearColor].CGColor;
//        imagev.layer.rasterizationScale = [UIScreen mainScreen].scale;
        
        // imagev.image=[UIImage imageNamed:@"KAKA"];
        //  NSLog(@"%@",[NSString stringWithFormat:@"%@",[datadic objectForKey:@"icon"]]);
        imagev.image=[UIImage imageNamed:[moreimagearr objectAtIndex:i]];
        [buttonbgv addSubview:imagev];
        
        UILabel *label=[[UILabel alloc]init];
        label.frame=CGRectMake(50, 45*i+7, 90, 30);
        label.textColor=KBlackColor;
        label.textAlignment=NSTextAlignmentLeft;
        label.font=[UIFont boldSystemFontOfSize:15.0];
        label.backgroundColor=[UIColor clearColor];
        label.text=[NSString stringWithFormat:@"%@",[namearr objectAtIndex:i]];
        [buttonbgv addSubview:label];
        

        
        
        
        
        
        
        
        
        UIButton *morebutton1=[UIButton buttonWithType:UIButtonTypeCustom];
        morebutton1.frame=CGRectMake(0, 45*i, 150, 45);
        morebutton1.tag=1000000+i;
       //[morebutton1 setImage:[UIImage imageNamed:[moreimagearr objectAtIndex:i]] forState:UIControlStateNormal];
        //UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
       // [morebutton1 setImageEdgeInsets:UIEdgeInsetsMake(12, 15, 12, 150-21-15)];
        //[morebutton1 setTitle:[NSString stringWithFormat:@"%@",[namearr objectAtIndex:i]] forState:UIControlStateNormal];
        morebutton1.layer.borderWidth=1.0;
        morebutton1.layer.borderColor=[UIColor clearColor].CGColor;
        morebutton1.titleLabel.font=[UIFont boldSystemFontOfSize:16.0];
        //[canclebutton setImage:[UIImage imageNamed:@"backArrow.png"] forState:UIControlStateNormal];
       // [morebutton1 setImage:[UIImage imageNamed:[moreimagearr objectAtIndex:i]] forState:UIControlStateNormal];
        [morebutton1 setTitleColor:KBlackColor forState:UIControlStateNormal];
        [morebutton1 addTarget:self action:@selector(buttonaction:) forControlEvents:UIControlEventTouchUpInside];
        [buttonbgv addSubview:morebutton1];
        if (i!=3) {
            UIView *linev=[[UIView alloc]initWithFrame:CGRectMake(8, 45-1.3, 150-16, 1.3)];
            linev.backgroundColor=KLightLineColor;
            [morebutton1 addSubview:linev];
        }
    }
}
-(void)buttonaction:(UIButton *)button{
    [moreControl removeFromSuperview];
    [buttonbgv removeFromSuperview];
    
    haveshowmorebutton=NO;
    
    if (button.tag==1000000) {
        PatientListViewController *addpvc=[[PatientListViewController alloc]init];
        //        doctorteam.teamarr=self.teamarr;
        //        doctorteam.participatedTeamarr=self.participatedTeamarr;
        //        doctorteam.invitationarr=self.invitationarr;
        self.navigationController.navigationBar.hidden=NO;
        //
        [self.navigationController pushViewController:addpvc animated:YES];
        

        
    } else if (button.tag==1000001) {
        
        AddPatientViewController *addpvc=[[AddPatientViewController alloc]init];
        //        doctorteam.teamarr=self.teamarr;
        //        doctorteam.participatedTeamarr=self.participatedTeamarr;
        //        doctorteam.invitationarr=self.invitationarr;
         self.navigationController.navigationBar.hidden=NO;
        //
        [self.navigationController pushViewController:addpvc animated:YES];

        
    }else if (button.tag==1000002) {
        
        DoctorTeamViewController *doctorteam=[[DoctorTeamViewController alloc]init];
//        doctorteam.teamarr=self.teamarr;
//        doctorteam.participatedTeamarr=self.participatedTeamarr;
//        doctorteam.invitationarr=self.invitationarr;
         self.navigationController.navigationBar.hidden=NO;
//        
       [self.navigationController pushViewController:doctorteam animated:YES];
        
    }else if (button.tag==1000003) {
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
    
    
    
    
    
    
    
    
    
    
    
}









-(void)newmsg:(NSNotification *)sender{
   
    
    
   // leftredview=[[UIView alloc]initWithFrame:CGRectMake(10, 5, 10, 10)];
  //  leftredview.backgroundColor=[UIColor redColor];
    leftredview.layer.cornerRadius=5.0;
    NSInteger groupcount1=(NSInteger)[[RCIMClient sharedRCIMClient]getUnreadCount:@[@(ConversationType_PRIVATE)]];
    if (groupcount1>0) {
       leftredview.backgroundColor=[UIColor redColor];
        
    }else{
      leftredview.backgroundColor=[UIColor clearColor];
    }
    
    
    
    
  
   
    NSInteger groupcount2=(NSInteger)[[RCIMClient sharedRCIMClient]getUnreadCount:@[@(ConversationType_GROUP)]];
    rightredview.layer.cornerRadius=5.0;
    if (groupcount2>0) {
       rightredview.backgroundColor=[UIColor redColor];
        
    }else{
       rightredview.backgroundColor=[UIColor clearColor];
    }
    
    
    [selectControl addSubview:leftredview];
    [selectControl addSubview:rightredview];
    
    NSInteger groupcount=(NSInteger)[[RCIMClient sharedRCIMClient]getTotalUnreadCount];
 //   NSInteger groupcount=groupcount1+groupcount2;
    //(NSInteger)[[RCIMClient sharedRCIMClient]getTotalUnreadCount];
    
    UINavigationController *tabvc=[self.viewControllers objectAtIndex:1];
    if (groupcount>0) {
        NSString *value=[NSString stringWithFormat:@"%zd",groupcount];
        
        // UINavigationController *rootNavi=[self.viewControllers objectAtIndex:1];
        pmnav1.tabBarItem.badgeValue=value;
        
    }else{
        pmnav1.tabBarItem.badgeValue=nil;
    }

    
    
    
    
}
-(void)newprivatemsg:(NSNotification *)sender{


}
-(void)newgroupmsg:(NSNotification *)sender{
    
    
}

-(void)relogin{
    NSUserDefaults *userd = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [userd dictionaryRepresentation];
    for (NSString *key in [dic allKeys]) {
        if (![key isEqualToString:@"pushtoken"]&&![key isEqualToString:@"isneedpush"]&&![key isEqualToString:@"isneedshow"]&&![key isEqualToString:@"firstStart"]&&![key isEqualToString:@"localasttime"]) {
            [userd removeObjectForKey:key];
            [userd synchronize];
            
        }
        
    }
    
    //  NSMutableArray  *logoutdataarr=[[NSMutableArray alloc]initWithArray:[[RCIMClient sharedRCIMClient]getConversationList:@[@(ConversationType_GROUP)]]];
    
    //    for (RCConversation *cov in logoutdataarr) {
    //        [[RCIMClient sharedRCIMClient] clearMessages:ConversationType_GROUP
    //                                            targetId:cov.targetId];
    //
    //    }
    //    NSMutableArray  *logoutdataarr1=[[NSMutableArray alloc]initWithArray:[[RCIMClient sharedRCIMClient]getConversationList:@[@(ConversationType_PRIVATE)]]];
    //
    //    for (RCConversation *cov in logoutdataarr1) {
    //        [[RCIMClient sharedRCIMClient] clearMessages:ConversationType_PRIVATE
    //                                            targetId:cov.targetId];
    //
    //    }
    //
    
    [[RCIMClient sharedRCIMClient]clearConversations:[[RCIMClient sharedRCIMClient]getConversationList:@[@(ConversationType_GROUP),@(ConversationType_PRIVATE)]]];
    
    
    [[RCIM sharedRCIM]disconnect];
    
//    [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//    [[PublicTools shareInstance]creareNotificationUIView:@"已注销"];
    
    
    
    LogintocysViewController *cysloginvc=[[LogintocysViewController alloc]init];
    cysloginvc.title=@"登录";
    UINavigationController*cysloginnav=[[UINavigationController alloc]initWithRootViewController:cysloginvc];
    [self presentViewController:cysloginnav animated:YES completion:nil];

}

#pragma msgaction
-(void)systemmsg:(NSNotification *)sender{
    
    
     [redpointview removeFromSuperview];
     [redpointview1 removeFromSuperview];
    if (![self.ordermsgcount isEqualToString:@"0"]) {
        redpointview=[[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/4.0/2.0+8, 7, 8, 8)];
        redpointview.backgroundColor=[UIColor redColor];
        redpointview.clipsToBounds=YES;
        redpointview.layer.masksToBounds=YES;
        redpointview.layer.cornerRadius =4.0;
        redpointview.layer.borderColor = [UIColor clearColor].CGColor;
        redpointview.layer.rasterizationScale = [UIScreen mainScreen].scale;

        
        
        
        
        
        [self.tabBar addSubview:redpointview];
    }
    if (![self.msgcount isEqualToString:@"0"]) {
        
        redpointview=[[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/4.0/2.0+8, 7, 8, 8)];
        redpointview.backgroundColor=[UIColor redColor];
        redpointview.clipsToBounds=YES;
        redpointview.layer.masksToBounds=YES;
        redpointview.layer.cornerRadius =4.0;
        redpointview.layer.borderColor = [UIColor clearColor].CGColor;
        redpointview.layer.rasterizationScale = [UIScreen mainScreen].scale;
        [self.tabBar addSubview:redpointview];
        
        
        redpointview1=[[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/4.0*3+ScreenWidth/4.0/2.0+10, 7, 8, 8)];
        redpointview1.backgroundColor=[UIColor redColor];
        redpointview1.clipsToBounds=YES;
        redpointview1.layer.masksToBounds=YES;
        redpointview1.layer.cornerRadius =4.0;
        redpointview1.layer.borderColor = [UIColor clearColor].CGColor;
        redpointview1.layer.rasterizationScale = [UIScreen mainScreen].scale;
        [self.tabBar addSubview:redpointview1];

    }
    
    
    
}
-(void)newsystemmsg:(NSNotification *)sender{
    
    
    publicmsgmodel=(MsgModel *)sender.object;
    
    NSString *msgbodystr=[publicmsgmodel.contentdic objectForKey:@"msg-body"];
    UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"新消息" message:msgbodystr delegate:self cancelButtonTitle:@"忽略" otherButtonTitles:@"查看", nil];
    
    alertview.tag=2000000;
    [alertview show];
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag==2000000) {
        
        
        if (buttonIndex==1) {
            if ([publicmsgmodel.msgtype isEqualToString:@"NOTIF_TYPE_DOCTOR_AUDIT_PASS"]) {
                //通过认证
               
                  [[NSNotificationCenter defaultCenter]postNotificationName:@"newauthermsg" object:nil];
                self.selectedIndex=0;
            } else  if ([publicmsgmodel.msgtype isEqualToString:@"NOTIF_TYPE_DOCTOR_AUDIT_FAIL"]){
                //认失败证
                PubilcViewController *VC=[[PubilcViewController alloc]init];
                //VC.urslstr=[NSString stringWithFormat:@"http://192.168.1.117:8080/view/upload.html"];
                VC.urslstr=[NSString stringWithFormat:@"%@%@",k_webbaseurl,@"authentication.html"];
                // @"http://rm.chengyisheng.com.cn:8080/app_web/app_doctor_web/view/authentication.html";
                
                [self.navigationController pushViewController:VC animated:YES];
                
            }else  if ([publicmsgmodel.msgtype isEqualToString:@"NOTIF_TYPE_DOCTOR_OFFLINE_ORDER_SUCCEED"]){
                
                
                
                FaceOrderViewController *doctorteam1=[[FaceOrderViewController alloc]init];
                doctorteam1.statustype=1;
                
                [self.navigationController pushViewController:doctorteam1 animated:YES];
                
            }else  if ([publicmsgmodel.msgtype isEqualToString:@"NOTIF_TYPE_DOCTOR_IM_ORDER_SUCCEED"]){
              
                WMPageController *pageController = [self pageControllerStyleFlood];
                pageController.selectIndex=0;
                // pageController.navigationController.navigationBar.backgroundColor=[UIColor whiteColor];
                pageController.title = @"图文咨询预约";
                
                // self.tabBarController.navigationController.tabBarController.navigationController.navigationBar.hidden=NO;
                [self.navigationController pushViewController:pageController animated:YES];
                
            }else  if ([publicmsgmodel.msgtype isEqualToString:@"NOTIF_TYPE_DOCTOR_PHONE_ORDER_SUCCEED"]){
                
                [self callorder];
                
                
                
                
                
            }else  if ([publicmsgmodel.msgtype isEqualToString:@"NOTIF_TYPE_DOCTOR_MONTHLY_ORDER_SUCCEED"]){
                
                
                
                
                
                [self monthlyorder];
                
                
            }else  if ([publicmsgmodel.msgtype isEqualToString:@"NOTIF_TYPE_DOCTOR_SET_AVAILABLE_TIME_REMIND"]){
                
                [self schedul];
                
            }

        }else{
            
            [self laodmsg];
            
    
        }
        
    }
    
}
-(void)laodmsg{
   
    [[NSNotificationCenter defaultCenter]postNotificationName:@"newordermsg" object:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"newauthermsg" object:nil];
    [NotificationService getAllUnreadMessagesCountblock:^(id respdic) {
        
        NSDictionary *dic=(NSDictionary *)respdic;
        if (![[[dic objectForKey:@"count"] stringValue] isEqualToString:@"0"]) {
            self.msgcount=@"12";
            [[NSNotificationCenter defaultCenter]postNotificationName:@"haveSystemMsg" object:nil];
        }else{
          
            self.msgcount=@"0";
            [[NSNotificationCenter defaultCenter]postNotificationName:@"haveSystemMsg" object:nil];
            
        }
        


        
    }];
}
- (WMPageController *)pageControllerStyleFlood {
    //  NSArray *namearr=@[@"全部",@"未回复",@"已回复",@"已取消"];
    NSArray *viewControllers = @[[OrderIMPaidListViewController class], [OrderIMDoneListViewController class], [OrderIMCancleListViewController class]];
    NSArray *titles =@[@"未回复",@"已回复",@"已取消"];
    
    WMPageController *pageVC1 = [[WMPageController alloc] initWithViewControllerClasses:viewControllers andTheirTitles:titles];
    pageVC1.titleSizeSelected = 15;
    pageVC1.pageAnimatable = YES;
    [pageVC1 setSelectIndex:0];
    pageVC1.menuHeight=44.0;
    pageVC1.isneedhideItemBackground=YES;
    //pageVC.progressHeight=60.0;
    pageVC1.itemsWidths=@[@(ScreenWidth/3.0),@(ScreenWidth/3.0),@(ScreenWidth/3.0)];
    pageVC1.menuBGColor=[UIColor whiteColor];
    pageVC1.menuViewStyle = WMMenuViewStyleLine;
    pageVC1.titleColorSelected =KlightOrangeColor;
    pageVC1.titleColorNormal = KBlackColor;
    pageVC1.progressColor = KlightOrangeColor;
    pageVC1.progressHeight=3;
    // pageVC.itemsWidths = @[@(70),@(70),@(70)]; // 这里可以设置不同的宽度
    return pageVC1;
}
-(void)callorder{
    CallListViewController *doctorteam1=[[CallListViewController alloc]init];
    doctorteam1.isphone=YES;
    doctorteam1.isshow1st=YES;
    // [self.navigationController pushViewController:doctorteam1 animated:YES];
    
    
    CallListViewController *doctorteam=[[CallListViewController alloc]init];
    doctorteam.isphone=YES;
    doctorteam.isshow1st=NO;
    // [self.navigationController pushViewController:doctorteam animated:YES];
    
    CallListViewController *doctorteam2=[[CallListViewController alloc]init];
    doctorteam2.isphone=YES;
    doctorteam2.isshow1st=NO;
    doctorteam2.isshowCancle=YES;
    
    
    
    NSArray *viewControllers = @[doctorteam1, doctorteam,doctorteam2];
    NSArray *titles =@[@"待回电",@"已回电",@"已取消"];
    
    WMPageController *pageVC1 = [[WMPageController alloc] initWithViewControllerClasses:viewControllers andTheirTitles:titles];
    pageVC1.titleSizeSelected = 15;
    pageVC1.pageAnimatable = YES;
    pageVC1.isViewInstance=YES;
    [pageVC1 setSelectIndex:0];
    pageVC1.menuHeight=44.0;
    pageVC1.isneedhideItemBackground=YES;
    //pageVC.progressHeight=60.0;
    pageVC1.itemsWidths=@[@(ScreenWidth/3.0),@(ScreenWidth/3.0),@(ScreenWidth/3.0)];
    pageVC1.menuBGColor=[UIColor whiteColor];
    pageVC1.menuViewStyle = WMMenuViewStyleLine;
    pageVC1.titleColorSelected =KlightOrangeColor;
    pageVC1.titleColorNormal = KBlackColor;
    pageVC1.progressColor = KlightOrangeColor;
    pageVC1.progressHeight=3;
    
    pageVC1.title = @"电话咨询预约";
    
    // self.tabBarController.navigationController.tabBarController.navigationController.navigationBar.hidden=NO;
    [self.navigationController pushViewController:pageVC1 animated:YES];
    
}

-(void)monthlyorder{
    
    OrderIMListViewController *monthordervc=[[OrderIMListViewController alloc] init];
    monthordervc.showtype=1;
    OrderIMListViewController *monthordervc1=[[OrderIMListViewController alloc] init];
    monthordervc1.showtype=2;
    OrderIMListViewController *monthordervc2=[[OrderIMListViewController alloc] init];
    monthordervc2.showtype=0;
    
    
    
    
    NSArray *viewControllers = @[monthordervc, monthordervc1, monthordervc2];
    NSArray *titles =@[@"进行中",@"已完成",@"已取消"];
    
    WMPageController *pageVC1 = [[WMPageController alloc] initWithViewControllerClasses:viewControllers andTheirTitles:titles];
    pageVC1.titleSizeSelected = 15;
    pageVC1.pageAnimatable = YES;
    pageVC1.isViewInstance=YES;
    [pageVC1 setSelectIndex:0];
    pageVC1.menuHeight=44.0;
    pageVC1.isneedhideItemBackground=YES;
    //pageVC.progressHeight=60.0;
    pageVC1.itemsWidths=@[@(ScreenWidth/3.0),@(ScreenWidth/3.0),@(ScreenWidth/3.0)];
    pageVC1.menuBGColor=[UIColor whiteColor];
    pageVC1.menuViewStyle = WMMenuViewStyleLine;
    pageVC1.titleColorSelected =KlightOrangeColor;
    pageVC1.titleColorNormal = KBlackColor;
    pageVC1.progressColor = KlightOrangeColor;
    pageVC1.progressHeight=3;
    // pageVC.itemsWidths = @[@(70),@(70),@(70)]; // 这里可以设置不同的宽度
    // return pageVC;
    
    pageVC1.title = @"包月咨询预约";
    
    // self.tabBarController.navigationController.tabBarController.navigationController.navigationBar.hidden=NO;
    [self.navigationController pushViewController:pageVC1 animated:YES];

    
    
}
-(void)schedul{
    OutCallViewController *VC=[[OutCallViewController alloc]init];
    VC.delegate=self;
    NSString *tokenstr=KGetDefaultstr(@"token");
    NSLog(@"%@",tokenstr);
    NSString *encodetoken =[self encodeString:tokenstr];
    
    
    
    NSLog(@"%@",encodetoken);
    
    VC.urslstr=[NSString stringWithFormat:@"http://rm.chengyisheng.com.cn:8080/app/doctor/toVisitArrange.htm?token=%@",encodetoken];
    NSLog(@"%@",VC.urslstr);
    //生产机
    //   VC.urslstr=[NSString stringWithFormat:@"http://wxtest.chengyisheng.com.cn/app/doctor/toVisitArrange.htm?token=%@",encodetoken];
    
    [self.navigationController pushViewController:VC animated:YES];
    

}
-(NSString*)encodeString:(NSString*)unencodedString{
    
    // CharactersToBeEscaped = @":/?&=;+!@#$()~',*";
    // CharactersToLeaveUnescaped = @"[].";
    
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)unencodedString,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
}
@end
