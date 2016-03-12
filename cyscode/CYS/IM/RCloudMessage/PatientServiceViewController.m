//
//  PatientServiceViewController.m
//  CYS
//
//  Created by 谢阳晴 on 15/12/30.
//  Copyright © 2015年 谢阳晴. All rights reserved.
//

#import "PatientServiceViewController.h"
#import "PriceUIViewController.h"


@interface PatientServiceViewController (){
    NSIndexPath *selectpath;
    BOOL havescroll;
    JGProgressHUD *hud;
    NSMutableArray *serviceDataDetailarr;
    NSDictionary *detaildic;
    NSString *freedate;
    NSString *freedatestr;
}

@end

@implementation PatientServiceViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    
     self.view.backgroundColor=kimiColor(239, 239, 244, 1);
    
    
    UILabel *desclabel=[[UILabel alloc]init];
    desclabel.text=@"请根据您的情况\n如：您的职称、预期患者支付等设置收费";
    desclabel.frame=CGRectMake(15, 10+64, ScreenWidth-30, 0);
    
    desclabel.textAlignment=NSTextAlignmentLeft;
    desclabel.textColor=kimiColor(153, 153, 153, 1);
    desclabel.font=[UIFont systemFontOfSize:16.0];
    desclabel.backgroundColor=[UIColor clearColor];
    desclabel.numberOfLines=0;
    
    [desclabel setLineBreakMode: UILineBreakModeCharacterWrap];
    
    
    [desclabel sizeToFit];
    
    [self.view addSubview:desclabel];
    
    
    
    
   //  [self.navigationController.navigationBar setTranslucent:NO];
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 49, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
    
    if (self.isglobe) {
        self.tableView.frame=CGRectMake(0, desclabel.frame.origin.y+desclabel.frame.size.height+10, ScreenWidth, ScreenHeight);
    } else {
        self.tableView.frame =CGRectMake(0, desclabel.frame.origin.y+desclabel.frame.size.height+10, ScreenWidth, ScreenHeight);
    }
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadservice) name:@"reloadservice" object:nil];
    
    self.title=@"服务收费设置";
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
    self.tableView.scrollEnabled=NO;
    
    self.tableView.sectionIndexColor = KLineColor;
    
//    
//    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedRightButton:)];
//    
//    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
//    
//    [self.view addGestureRecognizer:swipeLeft];
//    
//    
//    
//    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedLeftButton:)];
//    
//    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
//    
//    [self.view addGestureRecognizer:swipeRight];
//    
    [self getServiceData];
}
-(void)reloadservice{
    [serviceDataDetailarr removeAllObjects];
    [self getServiceData];
}
-(void)getServiceData{
    hud=[[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleDark];
    [hud showInView:self.view];
    [hud dismissAfterDelay:7];
    
    
    [OrderDataService getAllServiceConfigsblock:^(id respdic) {
      
        _serviceDataDic=[[NSMutableDictionary alloc]initWithDictionary:respdic];
        
        
        
        [OrderDataService getServiceDetailWithServicetype:@"" block:^(id respdic0) {
              NSLog(@"%@",respdic0);
            [hud dismiss];
            detaildic=[[NSDictionary alloc]initWithDictionary:respdic0];
//            serviceDataDetailarr=[[NSMutableArray alloc]initWithArray:@[@"",@"",@""]];
//
//            for (int i=0; i<3; i++) {
//                NSDictionary *dic=[respdic0 objectForKey:[NSString stringWithFormat:@"%d",i]];
//                                if (i==0) {
//                    [serviceDataDetailarr replaceObjectAtIndex:0 withObject:dic];
//                }else if (i==2){
//                    [serviceDataDetailarr replaceObjectAtIndex:1 withObject:dic];
//                }else if (i==1){
//                    [serviceDataDetailarr replaceObjectAtIndex:2 withObject:dic];
//                    
//                }
//                
//                
//                
//            }
//            NSLog(@"%@",serviceDataDetailarr);
            [self.tableView reloadData];
            
        }];
        
        
    }];
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
     self.navigationController.navigationBar.hidden=NO;
  
}







- (IBAction) tappedRightButton:(id)sender

{
    havescroll=NO;
    UISwipeGestureRecognizer *swipeRight=(UISwipeGestureRecognizer *)sender;
    //    NSUInteger selectedIndex = [self.tabBarController selectedIndex];
    //
    //
    //
    //    NSArray *aryViewController = self.tabBarController.viewControllers;
    //
    //    if (selectedIndex < aryViewController.count - 1) {
    //
    //        UIView *fromView = [self.tabBarController.selectedViewController view];
    //
    //        UIView *toView = [[self.tabBarController.viewControllers objectAtIndex:selectedIndex + 1] view];
    //
    //        [UIView transitionFromView:fromView toView:toView duration:2.0f options:UIViewAnimationOptionTransitionCrossDissolve completion:^(BOOL finished) {
    //
    //            if (finished) {
    //
    //                [self.tabBarController setSelectedIndex:selectedIndex + 1];
    //
    //            }
    //
    //        }];
    //
    //    }
    NSUInteger currentIndex = self.tabBarController.selectedIndex;
    
    CATransition *transaction = [CATransition animation];
    transaction.type = kCATransitionPush;
    if (havescroll==NO) {
        if (swipeRight.direction == UISwipeGestureRecognizerDirectionLeft) {
            [transaction setSubtype:kCATransitionFromRight];
            
            self.tabBarController.selectedIndex = MAX(self.tabBarController.childViewControllers.count - 1, currentIndex + 1);
        } else {
            [transaction setSubtype:kCATransitionFromLeft];
            self.tabBarController.selectedIndex = MIN(0, currentIndex - 1);
        }
       havescroll=YES;
    }else{
   
    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeselectindex" object:nil];
    if (currentIndex == self.tabBarController.selectedIndex) {
        return;
    }
    transaction.duration = 0.25;
    transaction.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    [[self.tabBarController.view layer] addAnimation:transaction forKey:@"switchView"];
    
    
    
}



- (IBAction) tappedLeftButton:(id)sender
{
    
    
    
    havescroll=NO;
    UISwipeGestureRecognizer *swipeRight=(UISwipeGestureRecognizer *)sender;
    //    NSUInteger selectedIndex = [self.tabBarController selectedIndex];
    //
    //
    //
    //    NSArray *aryViewController = self.tabBarController.viewControllers;
    //
    //    if (selectedIndex < aryViewController.count - 1) {
    //
    //        UIView *fromView = [self.tabBarController.selectedViewController view];
    //
    //        UIView *toView = [[self.tabBarController.viewControllers objectAtIndex:selectedIndex + 1] view];
    //
    //        [UIView transitionFromView:fromView toView:toView duration:2.0f options:UIViewAnimationOptionTransitionCrossDissolve completion:^(BOOL finished) {
    //
    //            if (finished) {
    //
    //                [self.tabBarController setSelectedIndex:selectedIndex + 1];
    //
    //            }
    //
    //        }];
    //
    //    }
    NSUInteger currentIndex = self.tabBarController.selectedIndex;
    
    CATransition *transaction = [CATransition animation];
    transaction.type = kCATransitionPush;
   // if (havescroll==NO) {
        if (swipeRight.direction == UISwipeGestureRecognizerDirectionLeft) {
            [transaction setSubtype:kCATransitionFromRight];
            
            self.tabBarController.selectedIndex = MAX(self.tabBarController.childViewControllers.count - 1, currentIndex + 1);
            
            
        } else {
            [transaction setSubtype:kCATransitionFromLeft];
            if (currentIndex - 1==0) {
                self.tabBarController.selectedIndex = 0;

            }else{
                self.tabBarController.selectedIndex = currentIndex - 1;

           
            }
            
        
        }
       // havescroll=YES;
//    }else{
//        
//    }
     [[NSNotificationCenter defaultCenter]postNotificationName:@"changeselectindex" object:nil];
    if (currentIndex == self.tabBarController.selectedIndex) {
        return;
    }
    transaction.duration = 0.25;
    transaction.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    [[self.tabBarController.view layer] addAnimation:transaction forKey:@"switchView"];
    
    //{
    //
    //    NSUInteger selectedIndex = [self.tabBarController selectedIndex];
    //
    //
    //
    //    if (selectedIndex > 0) {
    //
    //        UIView *fromView = [self.tabBarController.selectedViewController view];
    //
    //        UIView *toView = [[self.tabBarController.viewControllers objectAtIndex:selectedIndex - 1] view];
    //
    //        [UIView transitionFromView:fromView toView:toView duration:2.0f options:UIViewAnimationOptionTransitionCrossDissolve completion:^(BOOL finished) {
    //
    //            if (finished) {
    //
    //                [self.tabBarController setSelectedIndex:selectedIndex - 1];
    //                
    //            }
    //            
    //        }];
    //        
    //    }
    //    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        return 25.0;
    }else{
        return 0.0;
        
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 54.0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        
        return 3;
    }else if(section==1){
        return 1;

    }else{
        return 2;

    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=nil;
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"usercell"];
    }
    if (indexPath.section==0) {
        NSDictionary *dic;
        
        if (detaildic!=nil) {
           // dic=[serviceDataDetailarr objectAtIndex:indexPath.row];
           
            if (indexPath.row==0) {
                //电话
                dic=[detaildic objectForKey:[NSString stringWithFormat:@"%d",1]];
                NSLog(@"%@",dic);
               
                 NSLog(@"%@",dic);

            }else if (indexPath.row==1){
                //图文
                // [serviceDataDetailarr replaceObjectAtIndex:0 withObject:dic];
                dic=[detaildic objectForKey:[NSString stringWithFormat:@"%d",0]];
                
                //   [serviceDataDetailarr replaceObjectAtIndex:2 withObject:dic];
                
                
            }else if (indexPath.row==2){
                                //包月
                          //  [serviceDataDetailarr replaceObjectAtIndex:1 withObject:dic];
                 dic=[detaildic objectForKey:[NSString stringWithFormat:@"%d",2]];
                 NSLog(@"%@",dic);
                            
            }
                
        
        }
      
        
        
        NSLog(@"%@",dic);
        NSLog(@"%@",dic);
        
        if (indexPath.row==0) {
            
            UIImageView *imagev=[[UIImageView alloc]initWithFrame:CGRectMake(15, 54/2.0-34/2.0, 34,34)];
            imagev.image=[UIImage imageNamed:@"phone_chat"];
            [cell addSubview:imagev];
            
            UILabel *itemlabel=[[UILabel alloc]initWithFrame:CGRectMake(55, 10, 90, 34)];
            itemlabel.text=@" 电话咨询";
            itemlabel.textColor=[UIColor blackColor];
            itemlabel.font=[UIFont systemFontOfSize:18.0];
            // itemlabel.backgroundColor=KGreenColor;
            itemlabel.textAlignment=NSTextAlignmentLeft;
            [cell addSubview:itemlabel];
            UILabel *masklabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-160, 10, 130, 34)];
            if (dic) {
                if ([[NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]]isEqualToString:@"1"]) {
                    masklabel.text=[NSString stringWithFormat:@"￥%@每次",[dic objectForKey:@"price"]];
                } else{
                    masklabel.text=@"未开通";
                }
            }
            masklabel.textColor=KtextGrayColor;
            masklabel.font=[UIFont systemFontOfSize:14.0];
            // itemlabel.backgroundColor=KGreenColor;
            masklabel.textAlignment=NSTextAlignmentRight;
            [cell addSubview:masklabel];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

            
            
           //
//            
//             UISwitch *userswitch=[[UISwitch alloc]initWithFrame:CGRectMake(ScreenWidth-70, 11, 80, 44-6*2)];
//            //self.myswitch.on;
//            userswitch.tag=1000;
//             userswitch.on=YES;
////            if ([[NSUserDefaults standardUserDefaults]objectForKey:@"isneedshow"]) {
////                if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"isneedshow"]isEqualToString:@"NO"]){
////                    showmessageswitch.on=NO;
////                }
////                if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"isneedshow"]isEqualToString:@"YES"]){
////                    showmessageswitch.on=YES;
////                }
////            }else{
////                showmessageswitch.on=YES;
////                
////            }
//            
//            
//            
//            [userswitch addTarget:self action:@selector(showmessageswitchAction:) forControlEvents:UIControlEventValueChanged];
//            //  showmessageswitch.onTintColor=[UIColor redColor];
//            [cell.contentView addSubview:userswitch];
            

        }else if(indexPath.row==1){
            
            UIImageView *imagev=[[UIImageView alloc]initWithFrame:CGRectMake(15, 54/2.0-34/2.0, 34,34)];
            imagev.image=[UIImage imageNamed:@"image_chat"];
            [cell addSubview:imagev];
            NSLog(@"%@",dic);
            if ([[dic objectForKey:@"properties"] objectForKey:@"free_period"]) {
                if ([[[dic objectForKey:@"properties"] objectForKey:@"free_period"] isEqualToString:@"-1"]) {
                    freedate=[NSString stringWithFormat:@"永不"];
                    freedatestr=[NSString stringWithFormat:@"永不"];
                }else{
                    freedate=[NSString stringWithFormat:@"%@天",[[dic objectForKey:@"properties"] objectForKey:@"free_period"]];
                    freedatestr=[NSString stringWithFormat:@"%@",[[dic objectForKey:@"properties"] objectForKey:@"free_period"]];
                }
                
            }else{
                freedate=@"不开通";
                freedatestr=@"不开通";
                
            }
            
            UILabel *itemlabel=[[UILabel alloc]initWithFrame:CGRectMake(55, 10, 90, 34)];
            itemlabel.text=@" 图文咨询";
            itemlabel.textColor=[UIColor blackColor];
            itemlabel.font=[UIFont systemFontOfSize:18.0];
            // itemlabel.backgroundColor=KGreenColor;
            itemlabel.textAlignment=NSTextAlignmentLeft;
            [cell addSubview:itemlabel];
            
            UILabel *masklabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-160, 10, 130, 34)];
            if (dic) {
                if ([[NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]]isEqualToString:@"1"]) {
                    masklabel.text=[NSString stringWithFormat:@"￥%@每次",[dic objectForKey:@"price"]];
                } else{
                    masklabel.text=@"未开通";
                }
                
            }
            
            
            
            masklabel.textColor=KtextGrayColor;
            masklabel.font=[UIFont systemFontOfSize:14.0];
            // itemlabel.backgroundColor=KGreenColor;
            masklabel.textAlignment=NSTextAlignmentRight;
            [cell addSubview:masklabel];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

            
            
            
            
            
            
          
//            UILabel *masklabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-70-140, 10, 130, 34)];
//            masklabel.text=[NSString stringWithFormat:@"50元/次 %@",@"已开通"];
//            masklabel.textColor=KLineColor;
//            masklabel.font=[UIFont systemFontOfSize:12.0];
//            // itemlabel.backgroundColor=KGreenColor;
//            masklabel.textAlignment=NSTextAlignmentRight;
//            [cell addSubview:masklabel];
//            UISwitch *userswitch=[[UISwitch alloc]initWithFrame:CGRectMake(ScreenWidth-70, 11, 80, 44-6*2)];
//            //self.myswitch.on;
//            userswitch.tag=1001;
//            userswitch.on=YES;
//            //            if ([[NSUserDefaults standardUserDefaults]objectForKey:@"isneedshow"]) {
//            //                if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"isneedshow"]isEqualToString:@"NO"]){
//            //                    showmessageswitch.on=NO;
//            //                }
//            //                if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"isneedshow"]isEqualToString:@"YES"]){
//            //                    showmessageswitch.on=YES;
//            //                }
//            //            }else{
//            //                showmessageswitch.on=YES;
//            //
//            //            }
//            
//            
//            
//            [userswitch addTarget:self action:@selector(showmessageswitchAction:) forControlEvents:UIControlEventValueChanged];
//            //  showmessageswitch.onTintColor=[UIColor redColor];
//            [cell.contentView addSubview:userswitch];

            
        }else{
            UIImageView *imagev=[[UIImageView alloc]initWithFrame:CGRectMake(15, 54/2.0-34/2.0, 34,34)];
            imagev.image=[UIImage imageNamed:@"month_chat"];
            [cell addSubview:imagev];
            
            UILabel *itemlabel=[[UILabel alloc]initWithFrame:CGRectMake(55, 10, 140, 34)];
            itemlabel.text=@" 包月图文咨询";
            itemlabel.textColor=[UIColor blackColor];
            itemlabel.font=[UIFont systemFontOfSize:18.0];
            // itemlabel.backgroundColor=KGreenColor;
            itemlabel.textAlignment=NSTextAlignmentLeft;
            [cell addSubview:itemlabel];
            
            UILabel *masklabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-160, 10, 130, 34)];
            if (dic) {
                if ([[NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]]isEqualToString:@"1"]) {
                    masklabel.text=[NSString stringWithFormat:@"￥%@每次",[dic objectForKey:@"price"]];
                } else{
                    masklabel.text=@"未开通";
                }
            }
            
            masklabel.textColor=KtextGrayColor;
            masklabel.font=[UIFont systemFontOfSize:14.0];
            // itemlabel.backgroundColor=KGreenColor;
            masklabel.textAlignment=NSTextAlignmentRight;
            [cell addSubview:masklabel];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            
//            UILabel *masklabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-70-140, 10, 130, 34)];
//            masklabel.text=[NSString stringWithFormat:@"50元/次 %@",@"已开通"];
//            masklabel.textColor=KLineColor;
//            masklabel.font=[UIFont systemFontOfSize:12.0];
//            // itemlabel.backgroundColor=KGreenColor;
//            masklabel.textAlignment=NSTextAlignmentRight;
//            [cell addSubview:masklabel];
//
//            UISwitch *userswitch=[[UISwitch alloc]initWithFrame:CGRectMake(ScreenWidth-70, 11, 80, 44-6*2)];
//            //self.myswitch.on;
//            userswitch.tag=1002;
//            userswitch.on=YES;
//            //            if ([[NSUserDefaults standardUserDefaults]objectForKey:@"isneedshow"]) {
//            //                if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"isneedshow"]isEqualToString:@"NO"]){
//            //                    showmessageswitch.on=NO;
//            //                }
//            //                if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"isneedshow"]isEqualToString:@"YES"]){
//            //                    showmessageswitch.on=YES;
//            //                }
//            //            }else{
//            //                showmessageswitch.on=YES;
//            //
//            //            }
//            
//            
//            
//            [userswitch addTarget:self action:@selector(showmessageswitchAction:) forControlEvents:UIControlEventValueChanged];
//            //  showmessageswitch.onTintColor=[UIColor redColor];
//            [cell.contentView addSubview:userswitch];

        }

        
    }else if(indexPath.section==1){
        
        if (indexPath.row==0) {
            UIImageView *imagev=[[UIImageView alloc]initWithFrame:CGRectMake(15, 54/2.0-34/2.0, 34,34)];
            imagev.image=[UIImage imageNamed:@"free"];
            [cell addSubview:imagev];
            
            UILabel *itemlabel=[[UILabel alloc]initWithFrame:CGRectMake(55, 10, 130, 34)];
            itemlabel.text=@" 免费咨询期";
            itemlabel.textColor=[UIColor blackColor];
            itemlabel.font=[UIFont systemFontOfSize:18.0];
            // itemlabel.backgroundColor=KGreenColor;
            itemlabel.textAlignment=NSTextAlignmentLeft;
            [cell addSubview:itemlabel];
            
            UILabel *masklabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-160, 10, 130, 34)];
            masklabel.text=freedate;
            masklabel.textColor=KtextGrayColor;
            masklabel.font=[UIFont systemFontOfSize:14.0];
            // itemlabel.backgroundColor=KGreenColor;
            masklabel.textAlignment=NSTextAlignmentRight;
            [cell addSubview:masklabel];

            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

        }else if(indexPath.row==1){
//            UIImageView *imagev=[[UIImageView alloc]initWithFrame:CGRectMake(15, 14, 26,26)];
//            imagev.image=[UIImage imageNamed:@"tmp"];
//            [cell addSubview:imagev];
//            
//            UILabel *itemlabel=[[UILabel alloc]initWithFrame:CGRectMake(45, 10, 130, 34)];
//            itemlabel.text=@" 服务收费设置";
//            itemlabel.textColor=[UIColor blackColor];
//            itemlabel.font=[UIFont systemFontOfSize:16.0];
//            // itemlabel.backgroundColor=KGreenColor;
//            itemlabel.textAlignment=NSTextAlignmentLeft;
//            [cell addSubview:itemlabel];
//
//            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }else{
            
        }
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }else{
        if (indexPath.row==0) {
//            UIImageView *imagev=[[UIImageView alloc]initWithFrame:CGRectMake(15, 14, 26,26)];
//            imagev.image=[UIImage imageNamed:@"tmp"];
//            [cell addSubview:imagev];
//            
//            UILabel *itemlabel=[[UILabel alloc]initWithFrame:CGRectMake(45, 10, 130, 34)];
//            itemlabel.text=@" 患者沟通设置";
//            itemlabel.textColor=[UIColor blackColor];
//            itemlabel.font=[UIFont systemFontOfSize:16.0];
//            // itemlabel.backgroundColor=KGreenColor;
//            itemlabel.textAlignment=NSTextAlignmentLeft;
//            [cell addSubview:itemlabel];
//            UILabel *masklabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-70-140, 10, 130, 34)];
//            masklabel.text=[NSString stringWithFormat:@"%@",@"是否免费沟通"];
//            masklabel.textColor=KLineColor;
//            masklabel.font=[UIFont systemFontOfSize:12.0];
//            // itemlabel.backgroundColor=KGreenColor;
//            masklabel.textAlignment=NSTextAlignmentRight;
//            [cell addSubview:masklabel];
//            UISwitch *userswitch=[[UISwitch alloc]initWithFrame:CGRectMake(ScreenWidth-70, 11, 80, 44-6*2)];
//            //self.myswitch.on;
//            userswitch.tag=1003;
//            userswitch.on=YES;
//            //            if ([[NSUserDefaults standardUserDefaults]objectForKey:@"isneedshow"]) {
//            //                if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"isneedshow"]isEqualToString:@"NO"]){
//            //                    showmessageswitch.on=NO;
//            //                }
//            //                if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"isneedshow"]isEqualToString:@"YES"]){
//            //                    showmessageswitch.on=YES;
//            //                }
//            //            }else{
//            //                showmessageswitch.on=YES;
//            //
//            //            }
//            
//            
//            
//            [userswitch addTarget:self action:@selector(showmessageswitchAction:) forControlEvents:UIControlEventValueChanged];
//            //  showmessageswitch.onTintColor=[UIColor redColor];
//            [cell.contentView addSubview:userswitch];
//
        }else if(indexPath.row==1){
            
//            UIImageView *imagev=[[UIImageView alloc]initWithFrame:CGRectMake(15, 14, 26,26)];
//            imagev.image=[UIImage imageNamed:@"tmp"];
//            [cell addSubview:imagev];
//            
//            UILabel *itemlabel=[[UILabel alloc]initWithFrame:CGRectMake(45, 10, 130, 34)];
//            itemlabel.text=@" 免费沟通期限";
//            itemlabel.textColor=[UIColor blackColor];
//            itemlabel.font=[UIFont systemFontOfSize:16.0];
//            // itemlabel.backgroundColor=KGreenColor;
//            itemlabel.textAlignment=NSTextAlignmentLeft;
//            [cell addSubview:itemlabel];

        }else{
            
        }
        
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
      selectpath=indexPath;
    
    
    NSDictionary *dic;
    NSLog(@"%@",detaildic);
     NSLog(@"%@",detaildic);
    if (indexPath.section==0) {
        //dic=[detaildic objectForKey:@"0"];
    
        if ([KGetDefaultstr(@"userstatus") isEqualToString:@"AUDIT_PASSED"]){
        
        if (selectpath.section==0) {
            
            if (selectpath.row==0) {
                
                
                dic=[detaildic objectForKey:@"1"];
                PriceUIViewController *priceVC = [[PriceUIViewController alloc]init];
                priceVC.ismonth=NO;
                priceVC.isIM=NO;
                priceVC.isglobe=self.isglobe;
                NSLog(@"%@",dic);
                if ([[[dic objectForKey:@"status"] stringValue]isEqualToString:@"0"]) {
                    priceVC.currentpricestr=@"未开通";
                }else{
                    priceVC.currentpricestr=[[dic objectForKey:@"price"] stringValue];
                    NSLog(@"%@",priceVC.currentpricestr);
                    NSLog(@"%@",priceVC.currentpricestr);
                    
                }
                
                priceVC.DataDic=[_serviceDataDic objectForKey:@"phone"];
                [self.navigationController pushViewController:priceVC animated:YES];
                

                
                
                
                
                
                
                
               
                
            } else if (selectpath.row==1) {
                
                dic=[detaildic objectForKey:@"0"];
                
                
                PriceUIViewController *priceVC = [[PriceUIViewController alloc]init];
                priceVC.ismonth=NO;
                
                priceVC.isIM=YES;
                priceVC.isglobe=self.isglobe;
                if ([[[dic objectForKey:@"status"] stringValue]isEqualToString:@"0"]) {
                    priceVC.currentpricestr=@"未开通";
                }else{
                    priceVC.currentpricestr=[[dic objectForKey:@"price"] stringValue];
                    
                }
                
                priceVC.DataDic=[_serviceDataDic objectForKey:@"im"];
                
                [self.navigationController pushViewController:priceVC animated:YES];
                
                
                
                
                
                
            }else{
                dic=[detaildic objectForKey:@"2"];
                PriceUIViewController *priceVC = [[PriceUIViewController alloc]init];
                priceVC.ismonth=YES;
                priceVC.isIM=YES;
                priceVC.isglobe=self.isglobe;
                if ([[[dic objectForKey:@"status"] stringValue]isEqualToString:@"0"]) {
                    priceVC.currentpricestr=@"未开通";
                }else{
                    priceVC.currentpricestr=[[dic objectForKey:@"price"] stringValue];
                    
                }
                
                priceVC.DataDic=[_serviceDataDic objectForKey:@"monthly_im"];
                [self.navigationController pushViewController:priceVC animated:YES];
                

                
            }
            
            
        }
        
        
        
    } else{
        UIAlertView *alertView =[[UIAlertView alloc] initWithTitle:nil
                                                           message:@"您好，开通收费服务需要认证身份，是否现在认证"
                                                          delegate:self
                                                 cancelButtonTitle:@"否"
                                                 otherButtonTitles:@"是", nil];
        [alertView show];

    }
    
  
    

    }else if(indexPath.section==1){
        
        if (indexPath.row==0) {
            
            
            
            FreeDateViewController *priceVC = [[FreeDateViewController alloc]init];
            priceVC.delegate=self;
            priceVC.isglobe=self.isglobe;
            priceVC.freestr=freedatestr;
            
            priceVC.DataDic=[_serviceDataDic objectForKey:@"free_period"];
            [self.navigationController pushViewController:priceVC animated:YES];
            
            
        }
    }
}
-(void)showmessageswitchAction:(UISwitch *)userSwitch{
   
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex==1) {
          NSDictionary *dic=[serviceDataDetailarr objectAtIndex:selectpath.row];
        if (selectpath.section==0) {
            
            if (selectpath.row==0) {
                PriceUIViewController *priceVC = [[PriceUIViewController alloc]init];
                priceVC.ismonth=NO;
                
                priceVC.isIM=YES;
                priceVC.isglobe=self.isglobe;
                priceVC.currentpricestr=[dic objectForKey:@"price"];
                priceVC.DataDic=[_serviceDataDic objectForKey:@"im"];
                
                [self.navigationController pushViewController:priceVC animated:YES];

            } else if (selectpath.row==1) {
                PriceUIViewController *priceVC = [[PriceUIViewController alloc]init];
                priceVC.ismonth=YES;
                priceVC.isIM=YES;
                 priceVC.isglobe=self.isglobe;
                priceVC.currentpricestr=[dic objectForKey:@"price"];
                 priceVC.DataDic=[_serviceDataDic objectForKey:@"monthly_im"];
                [self.navigationController pushViewController:priceVC animated:YES];

                
            }else{
                PriceUIViewController *priceVC = [[PriceUIViewController alloc]init];
                priceVC.ismonth=NO;
                priceVC.isIM=NO;
                priceVC.isglobe=self.isglobe;
                priceVC.currentpricestr=[dic objectForKey:@"price"];
                 priceVC.DataDic=[_serviceDataDic objectForKey:@"phone"];
                [self.navigationController pushViewController:priceVC animated:YES];

                
            }
            
            
        } else {
            
            FreeDateViewController *priceVC = [[FreeDateViewController alloc]init];
            priceVC.delegate=self;
            priceVC.isglobe=self.isglobe;
            priceVC.DataDic=[_serviceDataDic objectForKey:@"free_period"];
            [self.navigationController pushViewController:priceVC animated:YES];
            
        }
        
        
        
        
        
        
    }
}
-(void)sentFreedate:(NSString *)Freedate isoffer:(BOOL) isoffer{
    [serviceDataDetailarr removeAllObjects];
    [self getServiceData];
}
@end
