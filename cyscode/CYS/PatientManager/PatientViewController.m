//
//  PatientViewController.m
//  CYS
//
//  Created by 谢阳晴 on 15/12/22.
//  Copyright © 2015年 谢阳晴. All rights reserved.
//

#import "PatientViewController.h"
#import "DVSwitch.h"
#import "ViewController.h"
#import "AddPatientViewController.h"

#import "WMPageController.h"

@interface PatientViewController (){
  
}

@end

@implementation PatientViewController
-(void)viewDidLoad{
    [super viewDidLoad];
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
    
}
-(void)addgroupbuttontaction{
//    EditnameViewController *editnamevc=[[EditnameViewController alloc]init];
//    //editnamevc.isrootvc=NO;
//    editnamevc.delegate=self;
//    
//    [self.tabBarController.navigationController pushViewController:editnamevc animated:YES];
     WMPageController *pageController = [self p_defaultController];
//    NSArray *viewControllers = @[[UIViewController class], [UIViewController class], [UIViewController class], [UIViewController class]];
//    NSArray *titles = @[@"通知", @"赞与感谢", @"私信" ,@"haah"];
    pageController.navigationController.navigationBar.backgroundColor=[UIColor whiteColor];
    pageController = [self pageControllerStyleFlood];
    pageController.title = @"患者库";

    self.tabBarController.navigationController.navigationBar.hidden=NO;
    [self.tabBarController.navigationController pushViewController:pageController animated:YES];

}
-(void)viewWillAppear:(BOOL)animated{
   
    [super viewWillAppear:animated];
     self.tabBarController.navigationController.navigationBar.hidden=YES;
}
- (WMPageController *)pageControllerStyleFlood {
    NSArray *viewControllers = @[[UIViewController class], [UIViewController class], [UIViewController class]];
    NSArray *titles = @[@"通知", @"私信" ,@"haah"];
    
    WMPageController *pageVC = [[WMPageController alloc] initWithViewControllerClasses:viewControllers andTheirTitles:titles];
    pageVC.titleSizeSelected = 15;
    pageVC.pageAnimatable = YES;
    pageVC.menuViewStyle = WMMenuViewStyleFoold;
    pageVC.titleColorSelected = [UIColor whiteColor];
    pageVC.titleColorNormal = [UIColor colorWithRed:168.0/255.0 green:20.0/255.0 blue:4/255.0 alpha:1];
    pageVC.progressColor = [UIColor colorWithRed:168.0/255.0 green:20.0/255.0 blue:4/255.0 alpha:1];
    pageVC.itemsWidths = @[@(70),@(70),@(70)]; // 这里可以设置不同的宽度
    return pageVC;
}

- (WMPageController *)p_defaultController {
    NSArray *viewControllers = @[[UIViewController class], [UIViewController class], [UIViewController class]];
    NSArray *titles = @[@"通知", @"私信" ,@"haah"];
    WMPageController *pageVC = [[WMPageController alloc] initWithViewControllerClasses:viewControllers andTheirTitles:titles];
    pageVC.pageAnimatable = YES;
    pageVC.menuItemWidth = 85;
    pageVC.postNotification = YES;
    pageVC.bounces = YES;
    return pageVC;
}

@end
