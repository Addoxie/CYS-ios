//
//  PatientManagerViewController.m
//  CYS
//
//  Created by 谢阳晴 on 15/12/17.
//  Copyright © 2015年 谢阳晴. All rights reserved.
//

#import "PatientManagerViewController.h"
#import "DVSwitch.h"
#import "ViewController.h"
#import "AddPatientViewController.h"
#import "RCDChatListViewController.h"

@interface PatientManagerViewController (){
    NavBarView *mybarview;
    BOOL havescroll;
}
@property(nonatomic,retain)DVSwitch *switcher;

@end

@implementation PatientManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITabBarController *tbv=[[UITabBarController alloc]init];
    
    
    
    
    // Do any additional setup after loading the view.
    
//    UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 44, ScreenWidth, ScreenHeight-44)];
//    scrollView.delegate=self;
//    scrollView.backgroundColor=KBackgroundColor;
//    scrollView.pagingEnabled=YES;
//    scrollView.contentSize=CGSizeMake(ScreenWidth*2, ScreenHeight-49-44-20);
//    [self.view addSubview:scrollView];
    
    
//    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-49)];
//    view1.backgroundColor=KlightOrangeColor;
  
    
    
    UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-49)];
    view2.backgroundColor=KGreenColor;
    
    UIButton *addgroupbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    addgroupbutton.frame=CGRectMake(30, 150, ScreenWidth-60, 50);
    
    addgroupbutton.layer.masksToBounds = YES;
    addgroupbutton.layer.cornerRadius = 6.0;
    addgroupbutton.layer.borderWidth = 1.0;
    addgroupbutton.layer.borderColor = [KlightOrangeColor CGColor];
    [addgroupbutton setTitle:@"创建团队" forState:UIControlStateNormal];
    //nextbutton.userInteractionEnabled=NO;
    addgroupbutton.titleLabel.font=[UIFont systemFontOfSize:22.0];
    [addgroupbutton addTarget:self action:@selector(addgroupbuttontaction) forControlEvents:UIControlEventTouchUpInside];
    addgroupbutton.backgroundColor=KlightOrangeColor;
    [self.view addSubview:addgroupbutton];
    
    
    
//    UIButton *deletegroupbutton=[UIButton buttonWithType:UIButtonTypeCustom];
//    deletegroupbutton.frame=CGRectMake(30, 210, ScreenWidth-60, 50);
//    
//    deletegroupbutton.layer.masksToBounds = YES;
//    deletegroupbutton.layer.cornerRadius = 6.0;
//    deletegroupbutton.layer.borderWidth = 1.0;
//    deletegroupbutton.layer.borderColor = [KlightOrangeColor CGColor];
//    [deletegroupbutton setTitle:@"删除团队" forState:UIControlStateNormal];
//    //nextbutton.userInteractionEnabled=NO;
//    deletegroupbutton.titleLabel.font=[UIFont systemFontOfSize:22.0];
//    [deletegroupbutton addTarget:self action:@selector(deletegroupbuttonaction) forControlEvents:UIControlEventTouchUpInside];
//    deletegroupbutton.backgroundColor=KlightOrangeColor;
//    [self.view addSubview:deletegroupbutton];
    
  //  [scrollView addSubview:view2];

    
    
    
    self.view.backgroundColor=KBackgroundColor;
    
    
    
    
    
//    mybarview=[[NavBarView alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, 64)];
//    mybarview.delegate=self;
   self.title=@"患者管理";
//    mybarview.isRoot=YES;
//    [mybarview setnavcanclecolor:[UIColor orangeColor]];
//    // mybarview.alpha=0.7;
//    mybarview.backgroundColor=[UIColor whiteColor];
//    [self.view addSubview:mybarview];
    
//    UIStoryboard *storyboard =
//    [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    UITabBarController *roottabbarvc = [storyboard
//                                        instantiateViewControllerWithIdentifier:@"MainTabbarVC"];
//    
//    AddPatientViewController *vc=[[AddPatientViewController alloc]init];
//    RCDChatListViewController *vc1=[[RCDChatListViewController alloc]init];
//    
//    
//    
//    roottabbarvc.viewControllers=@[vc,vc1];
//    
//    
//    self.switcher = [[DVSwitch alloc] initWithStringsArray:@[@"我的患者", @"患者团队"]];
//    self.switcher.frame = CGRectMake(80, 26, self.view.frame.size.width -160, 35);
//    self.switcher.cornerRadius=35/2.0;
//    self.switcher.backgroundColor=KLineColor;
//    self.switcher.labelTextColorInsideSlider=KlightOrangeColor;
//    self.switcher.labelTextColorOutsideSlider=[UIColor grayColor];
//    [mybarview addSubview:self.switcher];
//    [self.switcher setPressedHandler:^(NSUInteger index) {
//        
//        if (havescroll==YES) {
//            havescroll=NO;
//            
//        }else{
//            [scrollView setContentOffset:CGPointMake(ScreenWidth*index, -20) animated:YES];
//            
//            scrollView.bouncesZoom = NO;
//        }
//       
//        
//        
//        NSLog(@"Did press position on first switch at index: %lu", (unsigned long)index);
//        
//    }];
//
//   
//    
//    UIButton *morebutton=[UIButton buttonWithType:UIButtonTypeCustom];
//    morebutton.frame=CGRectMake(ScreenWidth-51, 26, 45, 30);
//    
//    [morebutton setTitle:@"+" forState:UIControlStateNormal];
//    //[morebutton setImage:[UIImage imageNamed:@"more.png"] forState:UIControlStateNormal];
//    [morebutton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
//    [morebutton addTarget:self action:@selector(addBody) forControlEvents:UIControlEventTouchUpInside];
//    [mybarview addSubview:morebutton];

}
//-(void)deletegroupbuttonaction{
//   
//    [DocTeamDataService deleteDocTeamWithId:@"07ad7020-b178-405c-a287-c15f6c02a6a0" block:^(id dic) {
//        
//        [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//        [[PublicTools shareInstance]creareNotificationUIView:@"删除团队成功"];
//    }];
//}
-(void)addgroupbuttontaction{
    EditnameViewController *editnamevc=[[EditnameViewController alloc]init];
    //editnamevc.isrootvc=NO;
    editnamevc.delegate=self;
//    UIStoryboard *storyboard =
//    [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    UITabBarController *roottabbarvc = [storyboard
//                                        instantiateViewControllerWithIdentifier:@"MainTabbarVC"];
//    //                self.window.rootViewController = rootNavi;
//    //roottabbarvc.navigationController.navigationBar.hidden=NO;
//    self.tabBarController.navigationController.navigationBar.hidden=NO;
    if (self.isRoot) {
          [self.tabBarController.navigationController.tabBarController.navigationController pushViewController:editnamevc animated:YES];
    } else {
          [self.navigationController pushViewController:editnamevc animated:YES];
    }
  
}
-(void)addBody{
    
     AddPatientViewController *vc=[[AddPatientViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    havescroll=YES;
    NSInteger pageIndex = scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame);
    [self.switcher forceSelectedIndex:pageIndex animated:YES];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden=NO;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
   // self.navigationController.navigationBar.hidden=YES;
}
-(void)itemactionWithType:(NSInteger)typeindex{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
