//
//  PatientChatViewController.m
//  CYS
//
//  Created by 谢阳晴 on 15/12/30.
//  Copyright © 2015年 谢阳晴. All rights reserved.
//

#import "PatientChatViewController.h"
#import "RCDChatViewController.h"
#import "PatientServiceViewController.h"
#import "DVSwitch.h"
#import "TESTIViewController.h"
#import "itemdetailbutton.h"

@interface PatientChatViewController (){
    
    PatientProfileWEBViewController *vc;
    UIViewController *vc1;
    PatientServiceViewController *vc2;
    RCDChatViewController *_conversationVC;
    UIButton *morebutton;
    UIView *bgv;
    UIView *masklineview;
    itemdetailbutton *oldbutton;
    itemdetailbutton *sentbutton1;
    itemdetailbutton *sentbutton2;
//    RCConversationModel *_model;
   
}
@property(nonatomic,retain)DVSwitch *switcher;
@end


@implementation PatientChatViewController


-(id)initWithChatModel:(RCConversationModel *)model{
   
    self =[super init];
    if (self) {
        self.model=model;
        _conversationVC = [[RCDChatViewController alloc]init];
        _conversationVC.delegate=self;
       // _conversationVC.conversationMessageCollectionView.frame=CGRectMake(0, 64*2+49, ScreenWidth, ScreenHeight);
        _conversationVC.conversationType = _model.conversationType;
        NSLog(@"%zd",_model.conversationType);
        _conversationVC.title=@"患者沟通";
        _conversationVC.targetId = _model.targetId;
        _conversationVC.userName = _model.conversationTitle;
        _conversationVC.title = _model.conversationTitle;
        _conversationVC.conversation = _model;
        _conversationVC.unReadMessage = _model.unreadMessageCount;
        _conversationVC.enableNewComingMessageIcon=YES;//开启消息提醒
        _conversationVC.enableUnreadMessageIcon=YES;
        if (_model.conversationType == ConversationType_SYSTEM) {
            _conversationVC.userName = @"系统消息";
            _conversationVC.title = @"系统消息";
        }
        //  [[UINavigationBar appearance] setTintColor:KlightOrangeColor];
        
        
        vc=[[PatientProfileWEBViewController alloc]init];
       
       // vc.urslstr=[NSString stringWithFormat:@"%@%@",k_webbaseurl,@"personalInformation.html?patient_id=%@",self.patientd];

        vc.title=@"患者资料";
        vc.view.backgroundColor=KBackgroundColor;
        //    vc1=[[UIViewController alloc]init];
        //    vc1.title=@"1";
        //    vc1.view.backgroundColor=[UIColor yellowColor];
        
//        vc2=[[PatientServiceViewController alloc]init];
//        vc2.title=@"服务设置";
//        vc2.view.backgroundColor=[UIColor whiteColor];
        
        
        
        
        
        
        
        NSArray *viewControllers = @[vc,_conversationVC];
        self.viewControllers=viewControllers;
        self.selectedIndex=1;

        
        
       // self.tabBar.hidden=YES;
        bgv=[[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/2.0, 0, ScreenWidth, 52)];
        bgv.backgroundColor=[UIColor whiteColor];
      //  NSArray *namearr=@[@"患者资料",@"患者沟通",@"服务设置"];
         NSArray *namearr=@[@"患者资料",@"患者沟通"];
        
        for (int i=0; i<namearr.count; i++) {
            
            if (i==0) {
                sentbutton1=[itemdetailbutton buttonWithType:UIButtonTypeCustom];
                sentbutton1.frame=CGRectMake(ScreenWidth/2.0*i, 0, ScreenWidth/2.0, 52);
                [sentbutton1 setTitle:[namearr objectAtIndex:i] forState:UIControlStateNormal];
                sentbutton1.tag=100+i;
                
                [sentbutton1 setTitleColor:KBlackColor forState:UIControlStateNormal];
                [sentbutton1 setTitleColor:KlightOrangeColor forState:UIControlStateSelected];
                if (i==1) {
                    oldbutton=sentbutton1;
                    sentbutton1.selected=YES;
                }
                sentbutton1.titleLabel.font=[UIFont systemFontOfSize:18.0];
                [sentbutton1 addTarget:self action:@selector(headaction:) forControlEvents:UIControlEventTouchUpInside];
                sentbutton1.backgroundColor=[UIColor whiteColor];
                [bgv addSubview:sentbutton1];

            }else{
                sentbutton2=[itemdetailbutton buttonWithType:UIButtonTypeCustom];
                sentbutton2.frame=CGRectMake(ScreenWidth/2.0*i, 0, ScreenWidth/2.0, 52);
                [sentbutton2 setTitle:[namearr objectAtIndex:i] forState:UIControlStateNormal];
                sentbutton2.tag=100+i;
                
                [sentbutton2 setTitleColor:KBlackColor forState:UIControlStateNormal];
                [sentbutton2 setTitleColor:KlightOrangeColor forState:UIControlStateSelected];
                if (i==1) {
                    oldbutton=sentbutton2;
                    sentbutton2.selected=YES;
                }
                sentbutton2.titleLabel.font=[UIFont boldSystemFontOfSize:18.0];
                [sentbutton2 addTarget:self action:@selector(headaction:) forControlEvents:UIControlEventTouchUpInside];
                sentbutton2.backgroundColor=[UIColor whiteColor];
                [bgv addSubview:sentbutton2];

            }
          
        }
        
        
        
     
        
        
        
        UIView *lineview=[[UIView alloc]initWithFrame:CGRectMake(0, 52-1.3, ScreenWidth, 1.3)];
        lineview.backgroundColor=KlightOrangeColor;
        [bgv addSubview:lineview];
        
        masklineview =[[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/2.0, 52-5, ScreenWidth/2.0, 5.0)];
        masklineview.backgroundColor=KlightOrangeColor;
        [bgv addSubview:masklineview];

        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.25];
        CGRect oldframe=bgv.frame;
        oldframe.origin.x=oldframe.origin.x-ScreenWidth/2.0;
        bgv.frame=oldframe;
        //[_pview addSubview:aView];
        [UIView commitAnimations];
        
        
        [self.tabBar addSubview:bgv];
        
        
//        self.switcher = [[DVSwitch alloc] initWithStringsArray:@[@"个人资料",@"患者沟通" ,@"开通服务"]];
//        self.switcher.isneedimage=YES;
//        self.switcher.frame = CGRectMake(10, 9, self.view.frame.size.width -20, 35);
//        self.switcher.cornerRadius=35/2.0;
//        
//        self.switcher.backgroundColor=KLineColor;
//        self.switcher.font=[UIFont boldSystemFontOfSize:14];
//        self.switcher.labelTextColorInsideSlider=KlightOrangeColor;
//        self.switcher.labelTextColorOutsideSlider=KBackgroundColor;
//        [bgv addSubview:self.switcher];
//        
//        [self.switcher setPressedHandler:^(NSUInteger index) {
//            
//            self.selectedIndex=index;
//            
//        }];
//self.selectedIndex
       // [self addObserver:self forKeyPath:@"selectedIndex" options:NSKeyValueObservingOptionNew context:nil];
        [self.switcher forceSelectedIndex:1 animated:NO];
        
        
        self.tabBar.frame=CGRectMake(0, 64, ScreenWidth, 49);
        self.tabBar.tintColor=[UIColor whiteColor];
        self.tabBar.barTintColor=[UIColor whiteColor];
     //   self.title=@"haha";
        
        
        
        self.tabBar.selectedImageTintColor=KlightOrangeColor;
        

    }
    return self;

}
-(void)chatViewDealtdataMethodname:(NSString *)methodname stringval:(NSString *)stringval{
     [self headaction:sentbutton1];
}

-(void)headaction:(itemdetailbutton *)button{
    button.selected=YES;
    if (button.tag==oldbutton.tag) {
        
    } else {
        oldbutton.selected=NO;
        oldbutton=button;
        
        if (button.tag==100) {
            
           // [vc loadprofileurl:[NSString stringWithFormat:@"http://192.168.1.117:8080/view/patientHomePage.html?patient_id=%@",self.patientd]];
            
            
            if (self.isgroup) {
                [vc loadprofileurl:[NSString stringWithFormat:@"%@patientHomePage.html?patient_id=%@",k_webbaseurl,self.patientd]];
                vc.patientid=self.patientd;
                vc.targetid=self.model.targetId;
                vc.isgroup=self.isgroup;
            }else{
                [vc loadprofileurl:[NSString stringWithFormat:@"%@patientHomePage.html?patient_id=%@&is_for_individual=true",k_webbaseurl,self.patientd]];
                vc.patientid=self.patientd;
                vc.targetid=self.model.targetId;
                vc.isgroup=self.isgroup;
            }
            
            
        }
    }
    self.selectedIndex=button.tag-100;
     masklineview.frame=CGRectMake(button.frame.origin.x, 52-5, ScreenWidth/2.0, 5.0);
}
//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//    [self.switcher forceSelectedIndex:self.selectedIndex animated:YES];
////    if([keyPath isEqualToString:@"price"])
////    {
////        myLabel.text = [stockForKVO valueForKey:@"price"];
////    }
//}
//- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
//    
//    NSLog(@"haha");
//}
-(void)changeselectindex:(id)sender{
    [self.switcher forceSelectedIndex:self.selectedIndex animated:YES];
}
-(void)viewDidLoad{
    [super viewDidLoad];
    // [self.navigationController.navigationBar setTranslucent:YES];
   // [self.navigationController.navigationBar setTranslucent:NO];
    [vc loadprofileurl:[NSString stringWithFormat:@"http://192.168.1.117:8080/view/patientHomePage.html?patient_id=%@",self.patientd]];
  //   vc.urslstr=[NSString stringWithFormat:@"http://192.168.1.117:8080/view/patientHomePage.html?patient_id=%@",self.patientd];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeselectindex:) name:@"changeselectindex" object:nil];
    
//    self.pageViewController=[[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
//    
//    self.pageViewController.dataSource = self;
//    self.pageViewController.delegate=self;
//   
//    
//    
//    
//    
//    
    
    
  
 //    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
//    //self.pageViewController.transitionStyle=UIPageViewControllerTransitionStyleScroll;
//    self.pageViewController.view.frame = CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height);
//    [self addChildViewController:_pageViewController];
//    [self.view addSubview:_pageViewController.view];
//    [self.pageViewController didMoveToParentViewController:self];
    
    
    
    

  
}
-(void)setupmorebutton{
    morebutton=[UIButton buttonWithType:UIButtonTypeCustom];
    morebutton.frame=CGRectMake(ScreenWidth-75, 29, 70, 30);
    
    [morebutton setTitle:@"团队详情" forState:UIControlStateNormal];
    //[canclebutton setImage:[UIImage imageNamed:@"backArrow.png"] forState:UIControlStateNormal];
    // [morebutton setImage:[UIImage imageNamed:@"tmp"] forState:UIControlStateNormal];
    [morebutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    morebutton.titleLabel.font=[UIFont systemFontOfSize:17.0];
    [morebutton addTarget:self action:@selector(morebuttonaction) forControlEvents:UIControlEventTouchUpInside];
    //morebutton.hidden=YES;
    
    
    
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithCustomView:morebutton];
        
   self.navigationItem.rightBarButtonItem=item;
        
 
}


-(void)morebuttonaction{
    
    
    
    
    
   // if (indexPath.section==0) {
   
    NSDictionary *dic=[[NSDictionary alloc]initWithObjectsAndKeys:self.teamid,@"id", nil];
    
    NSLog(@"%@",self.teamdic);
  //  cov.targetId;
        GroupDetailViewController *groupvc=[[GroupDetailViewController alloc]init];
        groupvc.delegate=self;
        groupvc.datadic=dic;
        groupvc.title=[[self.teamdic objectForKey:@"team"] objectForKey:@"name"];
    
      //  groupvc.teamarr=self.teamarr;
        groupvc.ismanager=YES;
        groupvc.teamid=self.teamid;
        groupvc.teamdic=self.teamdic;
        [self.navigationController pushViewController:groupvc animated:YES];
        
        
        
  //  }
//    else if (indexPath.section==1) {
//        selectedindex=indexPath.row;
//        NSDictionary *dic=(NSDictionary *)[self.participatedTeamarr objectAtIndex:indexPath.row];
//        GroupDetailViewController *groupvc=[[GroupDetailViewController alloc]init];
//        groupvc.delegate=self;
//        groupvc.datadic=self.datadic;
//        groupvc.teamarr=self.teamarr;
//        groupvc.ismanager=self.ismanager;
//        [self.navigationController pushViewController:groupvc animated:YES];
//        
//        
//    }
   // self.navigationController.navigationBar.hidden=NO;

    
    
    
    
    
    
    
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //self.title=self.titlestr;
     //[[UIApplication sharedApplication].keyWindow addSubview:bgv];
    // 禁用 iOS7 返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick endEvent:@"consultation"];
//    [bgv removeFromSuperview];
//    [[UIApplication sharedApplication].keyWindow addSubview:bgv];
    self.navigationController.navigationBar.hidden=NO;
   // [self.navigationController.navigationBar setTranslucent:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
   // [bgv removeFromSuperview];
  //  [self.navigationController.navigationBar setTranslucent:NO];
    self.navigationController.navigationBar.hidden=NO;
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    
}
-(void)itemactionWithType:(NSInteger)typeindex{
  //  [bgv removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}


//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    
//    // 开启
//    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
//    }
//}
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    
    if (viewController==vc) {
        NSLog(@"0");
        return nil;
        
    }else if (viewController==_conversationVC){
        NSLog(@"1");
        return vc;
        
    }else{
        NSLog(@"2");
        return vc2;
    }

    
    
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    if (viewController==vc) {
        NSLog(@"0");
        return _conversationVC;
        
    }else if (viewController==_conversationVC){
        NSLog(@"1");
        return vc2;
        
    }else{
        NSLog(@"2");
        return nil;
    }
    
    
}




@end
