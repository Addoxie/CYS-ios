//
//  OrderManagerViewController.m
//  CYS
//
//  Created by 谢阳晴 on 16/1/13.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import "OrderManagerViewController.h"
#import "CallListViewController.h"
#import "OrderIMListViewController.h"
#import "OrderIMPaidListViewController.h"

#import "OrderIMDoneListViewController.h"
#import "OrderIMCancleListViewController.h"

#import "FaceOrderViewController.h"


#import "WMPageController.h"

@implementation OrderManagerViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    // self.isphone=YES;
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate=self;
   
    self.tableView.dataSource=self;
     self.tableView.backgroundColor=KBackgroundColor;
    self.title=@"我的预约";
    [self.view addSubview:self.tableView];
    self.dataArr=[[NSMutableArray alloc]init];
    
    [OrderDataService getAllOrderCountblock:^(id resparr) {
        self.dataArr=[[NSMutableArray alloc]initWithArray:resparr];
        [self.tableView reloadData];
    }];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=NO;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
         return 50.0;
    } else {
         return 64.0;
    }
   
}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//   
//    UIView *bgv=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 60)];
//    bgv.backgroundColor=KBackgroundColor;
//    UIView *subbgv=[[UIView alloc]initWithFrame:CGRectMake(0, 30, ScreenWidth, 30)];
//    subbgv.backgroundColor=[UIColor whiteColor];
//    [bgv addSubview:subbgv];
//    UILabel *label=[[UILabel alloc]init];
//    label.frame=CGRectMake(10, 0, 90, 30);
//    label.textColor=KBlackColor;
//    label.textAlignment=NSTextAlignmentLeft;
//    label.font=[UIFont systemFontOfSize:16.0];
//    label.backgroundColor=[UIColor clearColor];
//    if (section==0) {
//        label.text=@"我的订单";
//    } else {
//        label.text=@"团队订单";
//
//    }
//
//    [subbgv addSubview:label];
//    
//    return bgv;
//}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if (section==0) {
//          return 3;
//    } else {
//          return 2;
//    }
    return 2;
  
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=nil;
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"usercell"];
    }
    
    
//    if (indexPath.section==0) {
//        
//    } else  if (indexPath.section==1) {
//        
//        
//        
//        
//    } else  if (indexPath.section==2) {
//        
//        
//        
//        
//    } else  if (indexPath.section==3) {
//        
//        
//        
//    }else{
//        
//    }
//    
//    
    
    
    
    
    
    
    
    
    UIImageView *imagev;
    //=[[UIImageView alloc]init];
    
    
    imagev =[[UIImageView alloc]initWithFrame:CGRectMake(10, 8, 34, 34)];
    //   imagev.frame=CGRectMake(10, 8, 44, 44);
    
    
    
    
    imagev.clipsToBounds=YES;
    
    imagev.layer.masksToBounds=YES;
    imagev.layer.cornerRadius =17.0;
    imagev.layer.borderColor = [UIColor clearColor].CGColor;
    imagev.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    // imagev.image=[UIImage imageNamed:@"KAKA"];
    //  NSLog(@"%@",[NSString stringWithFormat:@"%@",[datadic objectForKey:@"icon"]]);
   
    [cell addSubview:imagev];
    
    UILabel *label=[[UILabel alloc]init];
    label.frame=CGRectMake(60, 8, 200, 34);
    label.textColor=KBlackColor;
    label.textAlignment=NSTextAlignmentLeft;
    label.font=[UIFont systemFontOfSize:16.0];
    label.backgroundColor=[UIColor clearColor];
    [cell addSubview:label];
    
    
//    label.text=@"hahaha";
//    [imagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@""]] placeholderImage:[UIImage imageNamed:kPlaceholderimage]];
    
    
    
    
        if (indexPath.section==0) {
            if (indexPath.row==0) {
                label.text=@"见面咨询预约";
                imagev.image=[UIImage imageNamed:@"meet_chat"];
               // [imagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@""]] placeholderImage:[UIImage imageNamed:kPlaceholderimage]];
            } else {
                NSArray *namearr=@[@"待出诊",@"待确认",@"已完成"];
                 NSArray *imagearr=@[@"visit",@"confirm",@"closure"];
                for (int i=0; i<3; i++) {
                    
                    UIButton *btn1=[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/3.0*i, 0, ScreenWidth/3.0,64)];
                    // btn1.backgroundColor=[UIColor redColor];
                    [cell addSubview:btn1];
                    
                    UIImageView *imagev1=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(btn1.frame)/2-30/2, CGRectGetHeight(btn1.frame)/2-30/2-10, 30, 30)];
                    
                    imagev1.image=[UIImage imageNamed:[imagearr objectAtIndex:i]];
                    imagev1.layer.cornerRadius=5.0;
                    [btn1 addSubview:imagev1];
                    
                    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(btn1.frame)/2-100/2, imagev1.frame.origin.y+30+3, 100, 20)];
                    label1.text=[namearr objectAtIndex:i];
                    label1.textColor=KBlackColor;
                    label1.textAlignment=NSTextAlignmentCenter;
                    label1.font=[UIFont boldSystemFontOfSize:13.0];
                    [btn1 addSubview:label1];
                    
//                    if (i!=namearr.count-1) {
//                        UIView *linev=[[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/3.0-0.5, 0, 1, 64)];
//                        linev.backgroundColor=KLineColor;
//                        [btn1 addSubview:linev];
//                    }

                    
                    
                    btn1.tag=i;
                    [btn1 addTarget:self action:@selector(meetbtnaction:) forControlEvents:UIControlEventTouchUpInside];

                    for (NSDictionary *dic in self.dataArr) {
                        if ([[dic objectForKey:@"service_type"] integerValue]==4&&[[dic objectForKey:@"provider_type"] integerValue]==0) {
                            if ([[dic objectForKey:@"count"] integerValue]!=0) {
                                //  desclabel.text=[NSString stringWithFormat:@"%zd",[[dic objectForKey:@"count"] integerValue]];
                                
                                UIFont *font=[UIFont systemFontOfSize:13.0];
                                NSString *heightstr=[NSString stringWithFormat:@"%zd",[[dic objectForKey:@"count"] integerValue]];
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
                                unreadlabel.frame=CGRectMake(imagev1.frame.origin.x+28-width/2, imagev1.frame.origin.y-5, width, 20);
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
                                if ([[dic objectForKey:@"count"] integerValue]>0) {
                                    unreadlabel.hidden=NO;
                                }
                                
                                if (i==0) {
                                     [btn1 addSubview:unreadlabel];
                                }
                               
                                
                                
                                
                                
                                
                                
                                
                                
                                
                            }
                        }
                    }
                    
                    

                    
                    
                }
                
            }
           
            
//            UILabel *desclabel=[[UILabel alloc]init];
//            desclabel.frame=CGRectMake(ScreenWidth-90, 50/2.0-30/2.0, 80, 30);
//            desclabel.textColor=KLineColor;
//            desclabel.textAlignment=NSTextAlignmentLeft;
//            desclabel.font=[UIFont systemFontOfSize:15.0];
//            desclabel.backgroundColor=[UIColor clearColor];
//            [cell.contentView addSubview:desclabel];

            
            
            
        } else if (indexPath.section==1) {
            
            
            if (indexPath.row==0) {
                label.text=@"电话咨询预约";
                 imagev.image=[UIImage imageNamed:@"phone_chat"];
               // [imagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@""]] placeholderImage:[UIImage imageNamed:kPlaceholderimage]];
            } else {
                NSArray *namearr=@[@"待回电",@"已回电"];
                NSArray *imagearr=@[@"call_1",@"call_2"];
                for (int i=0; i<namearr.count; i++) {
                    
                    UIButton *btn1=[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/2.0*i, 0, ScreenWidth/2.0,64)];
                    // btn1.backgroundColor=[UIColor redColor];
                    [cell addSubview:btn1];
                    
                    UIImageView *imagev1=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(btn1.frame)/2-30/2, CGRectGetHeight(btn1.frame)/2-30/2-10, 30, 30)];
                    
                    
                    
                    if (i%2==0) {
                        imagev1.frame= CGRectMake(CGRectGetWidth(btn1.frame)/2-30/2+20, CGRectGetHeight(btn1.frame)/2-30/2-8, 30, 28);
                    }else{
                        imagev1.frame= CGRectMake(CGRectGetWidth(btn1.frame)/2-30/2-20, CGRectGetHeight(btn1.frame)/2-30/2-8, 30, 28);
                    }
                    
                    
                    
                    imagev1.image=[UIImage imageNamed:[imagearr objectAtIndex:i]];
                    imagev1.layer.cornerRadius=5.0;
                    [btn1 addSubview:imagev1];
                    
                    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(btn1.frame)/2-100/2, imagev1.frame.origin.y+30+3, 100, 20)];
                    
                    if (i%2==0) {
                        label1.frame= CGRectMake(CGRectGetWidth(btn1.frame)/2-100/2+20, imagev1.frame.origin.y+30+3, 100, 20);
                    }else{
                        label1.frame= CGRectMake(CGRectGetWidth(btn1.frame)/2-100/2-20, imagev1.frame.origin.y+30+3, 100, 20);
                    }

                    
                    
                    label1.text=[namearr objectAtIndex:i];
                    label1.textAlignment=NSTextAlignmentCenter;
                    label1.textColor=KBlackColor;
                    label1.font=[UIFont boldSystemFontOfSize:13.0];
                    [btn1 addSubview:label1];
                    
                    
                    
//                    if (i!=namearr.count-1) {
//                        UIView *linev=[[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/2.0-0.5, 0, 1, 64)];
//                        linev.backgroundColor=KLineColor;
//                        [btn1 addSubview:linev];
//                    }
                    
                    btn1.tag=i;
                    [btn1 addTarget:self action:@selector(callbtnaction:) forControlEvents:UIControlEventTouchUpInside];
                    
                    
                    if (i==0) {
                        
                   
                    for (NSDictionary *dic in self.dataArr) {
                        if ([[dic objectForKey:@"service_type"] integerValue]==1&&[[dic objectForKey:@"provider_type"] integerValue]==0) {
                            if ([[dic objectForKey:@"count"] integerValue]!=0) {
                                //  desclabel.text=[NSString stringWithFormat:@"%zd",[[dic objectForKey:@"count"] integerValue]];
                                
                                
                                
                                UIFont *font=[UIFont systemFontOfSize:13.0];
                                NSString *heightstr=[NSString stringWithFormat:@"%zd",[[dic objectForKey:@"count"] integerValue]];
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
                                unreadlabel.frame=CGRectMake(imagev1.frame.origin.x+28-width/2, imagev1.frame.origin.y-5, width, 20);
                               
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
                                if ([[dic objectForKey:@"count"] integerValue]>0) {
                                    unreadlabel.hidden=NO;
                                }
                                [cell.contentView addSubview:unreadlabel];
                                if (i==0) {
                                    [btn1 addSubview:unreadlabel];
                                }
                                
                                
                            }
                        }
                    }
                    }
                    
                    
                    
                    
                }
            }
            
            
            
            
            
            //            UILabel *desclabel=[[UILabel alloc]init];
            //            desclabel.frame=CGRectMake(ScreenWidth-90, 50/2.0-30/2.0, 80, 30);
            //            desclabel.textColor=KLineColor;
            //            desclabel.textAlignment=NSTextAlignmentLeft;
            //            desclabel.font=[UIFont systemFontOfSize:15.0];
            //            desclabel.backgroundColor=[UIColor clearColor];
            //            [cell.contentView addSubview:desclabel];
            
            
            
         
            
            
            
            
        }else if (indexPath.section==2) {
          
            
            if (indexPath.row==0) {
                label.text=@"图文咨询预约";
                 imagev.image=[UIImage imageNamed:@"image_chat"];
              //  [imagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@""]] placeholderImage:[UIImage imageNamed:kPlaceholderimage]];
            } else {
                NSArray *namearr=@[@"待回复",@"已回复"];
                NSArray *imagearr=@[@"reply_1",@"reply_2"];
                for (int i=0; i<namearr.count; i++) {
                    
                    UIButton *btn1=[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/2.0*i, 0, ScreenWidth/2.0,64)];
                    // btn1.backgroundColor=[UIColor redColor];
                    [cell addSubview:btn1];
                    
                    UIImageView *imagev1=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(btn1.frame)/2-30/2, CGRectGetHeight(btn1.frame)/2-30/2-10, 30, 30)];
                    if (i%2==0) {
                        imagev1.frame= CGRectMake(CGRectGetWidth(btn1.frame)/2-30/2+20, CGRectGetHeight(btn1.frame)/2-30/2-8, 30, 28);
                    }else{
                        imagev1.frame= CGRectMake(CGRectGetWidth(btn1.frame)/2-30/2-20, CGRectGetHeight(btn1.frame)/2-30/2-8, 30, 28);
                    }
                    imagev1.image=[UIImage imageNamed:[imagearr objectAtIndex:i]];
                    imagev1.layer.cornerRadius=5.0;
                    [btn1 addSubview:imagev1];
                    
                    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(btn1.frame)/2-100/2, imagev1.frame.origin.y+30+3, 100, 20)];
                    if (i%2==0) {
                        label1.frame= CGRectMake(CGRectGetWidth(btn1.frame)/2-100/2+20, imagev1.frame.origin.y+30+3, 100, 20);
                    }else{
                        label1.frame= CGRectMake(CGRectGetWidth(btn1.frame)/2-100/2-20, imagev1.frame.origin.y+30+3, 100, 20);
                    }
                    label1.text=[namearr objectAtIndex:i];
                    label1.textAlignment=NSTextAlignmentCenter;
                    label1.textColor=KBlackColor;
                    label1.font=[UIFont boldSystemFontOfSize:13.0];
                    [btn1 addSubview:label1];
//                    
//                    if (i!=namearr.count-1) {
//                        UIView *linev=[[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/2.0-0.5, 0, 1, 64)];
//                        linev.backgroundColor=KLineColor;
//                        [btn1 addSubview:linev];
//                    }
                    
                    btn1.tag=i;
                    [btn1 addTarget:self action:@selector(imbtnaction:) forControlEvents:UIControlEventTouchUpInside];
                    
                    for (NSDictionary *dic in self.dataArr) {
                        
                        
                        if ([[dic objectForKey:@"service_type"] integerValue]==0&&[[dic objectForKey:@"provider_type"] integerValue]==0) {
                            if ([[dic objectForKey:@"count"] integerValue]!=0) {
                                UIFont *font=[UIFont systemFontOfSize:13.0];
                                NSString *heightstr=[NSString stringWithFormat:@"%zd",[[dic objectForKey:@"count"] integerValue]];
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
                                unreadlabel.frame=CGRectMake(imagev1.frame.origin.x+28-width/2, imagev1.frame.origin.y-5, width, 20);
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
                                if ([[dic objectForKey:@"count"] integerValue]>0) {
                                    unreadlabel.hidden=NO;
                                }
                                if (i==0) {
                                    [btn1 addSubview:unreadlabel];
                                }
                                
                                
                            }
                        }
                    }
                    
                    
                    
                    
                    
                    
                }
            }
            
            
            
            
            
            //            UILabel *desclabel=[[UILabel alloc]init];
            //            desclabel.frame=CGRectMake(ScreenWidth-90, 50/2.0-30/2.0, 80, 30);
            //            desclabel.textColor=KLineColor;
            //            desclabel.textAlignment=NSTextAlignmentLeft;
            //            desclabel.font=[UIFont systemFontOfSize:15.0];
            //            desclabel.backgroundColor=[UIColor clearColor];
            //            [cell.contentView addSubview:desclabel];
           
            
            
            
            
            
        }else if (indexPath.section==3) {
            
            
            if (indexPath.row==0) {
                label.text=@"包月咨询预约";
                imagev.image=[UIImage imageNamed:@"month_chat"];
               // [imagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@""]] placeholderImage:[UIImage imageNamed:kPlaceholderimage]];
            } else {
                NSArray *namearr=@[@"进行中",@"已完成"];
                NSArray *imagearr=@[@"handle_2",@"handle_3"];
                for (int i=0; i<namearr.count; i++) {
                    
                    UIButton *btn1=[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/2.0*i, 0, ScreenWidth/2.0,64)];
                    // btn1.backgroundColor=[UIColor redColor];
                    [cell addSubview:btn1];
                    
                    UIImageView *imagev1=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(btn1.frame)/2-30/2, CGRectGetHeight(btn1.frame)/2-30/2-10, 30, 30)];
                    if (i%2==0) {
                        imagev1.frame= CGRectMake(CGRectGetWidth(btn1.frame)/2-30/2+20, CGRectGetHeight(btn1.frame)/2-30/2-10, 30, 30);
                    }else{
                        imagev1.frame= CGRectMake(CGRectGetWidth(btn1.frame)/2-30/2-20, CGRectGetHeight(btn1.frame)/2-30/2-10, 30, 30);
                    }
                    imagev1.image=[UIImage imageNamed:[imagearr objectAtIndex:i]];
                   // imagev1.layer.cornerRadius=5.0;
                    [btn1 addSubview:imagev1];
                    
                    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(btn1.frame)/2-100/2, imagev1.frame.origin.y+30+3, 100, 20)];
                    if (i%2==0) {
                        label1.frame= CGRectMake(CGRectGetWidth(btn1.frame)/2-100/2+20, imagev1.frame.origin.y+30+3, 100, 20);
                    }else{
                        label1.frame= CGRectMake(CGRectGetWidth(btn1.frame)/2-100/2-20, imagev1.frame.origin.y+30+3, 100, 20);
                    }
                    label1.text=[namearr objectAtIndex:i];
                    label1.textAlignment=NSTextAlignmentCenter;
                    label1.textColor=KBlackColor;
                    label1.font=[UIFont boldSystemFontOfSize:13.0];
                    [btn1 addSubview:label1];
                    
//                    if (i!=namearr.count-1) {
//                        UIView *linev=[[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/3.0-0.5, 0, 1, 64)];
//                        linev.backgroundColor=KLineColor;
//                        [btn1 addSubview:linev];
//                    }
                    btn1.tag=i;
                    [btn1 addTarget:self action:@selector(monthbtnaction:) forControlEvents:UIControlEventTouchUpInside];
                    
                    for (NSDictionary *dic in self.dataArr) {
                        if ([[dic objectForKey:@"service_type"] integerValue]==1&&[[dic objectForKey:@"provider_type"] integerValue]==2) {
                            
                            if ([[dic objectForKey:@"count"] integerValue]!=0) {
                                //  desclabel.text=[NSString stringWithFormat:@"%zd",[[dic objectForKey:@"count"] integerValue]];
                                
                                
                                
                                UIFont *font=[UIFont systemFontOfSize:13.0];
                                NSString *heightstr=[NSString stringWithFormat:@"%zd",[[dic objectForKey:@"count"] integerValue]];
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
                                unreadlabel.frame=CGRectMake(imagev1.frame.origin.x+28-width/2, imagev1.frame.origin.y-5, width, 20);
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
                                if ([[dic objectForKey:@"count"] integerValue]>0) {
                                    unreadlabel.hidden=NO;
                                }
                                [cell.contentView addSubview:unreadlabel];
                                if (i==0) {
                                    [btn1 addSubview:unreadlabel];
                                }
                                
                                
                            }
                        }
                    }
                    
                    
                    
                    
                }
            }
            
            
            
            
            
            //            UILabel *desclabel=[[UILabel alloc]init];
            //            desclabel.frame=CGRectMake(ScreenWidth-90, 50/2.0-30/2.0, 80, 30);
            //            desclabel.textColor=KLineColor;
            //            desclabel.textAlignment=NSTextAlignmentLeft;
            //            desclabel.font=[UIFont systemFontOfSize:15.0];
            //            desclabel.backgroundColor=[UIColor clearColor];
            //            [cell.contentView addSubview:desclabel];
            
            
            
            
            
        }

    

//    }else{
//        if (indexPath.row==0) {
//            label.text=@"图文咨询";
//            [imagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@""]] placeholderImage:[UIImage imageNamed:kPlaceholderimage]];
//        } else if (indexPath.row==1) {
//            label.text=@"电话咨询";
//            [imagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@""]] placeholderImage:[UIImage imageNamed:kPlaceholderimage]];
//        }
//    }
    
    if (indexPath.row==0) {
        // cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
   
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
//    
//    if (indexPath.section==0) {
//        if (indexPath.row==0) {
//            CallListViewController *doctorteam1=[[CallListViewController alloc]init];
//            doctorteam1.isphone=YES;
//            doctorteam1.isshow1st=YES;
//            // [self.navigationController pushViewController:doctorteam1 animated:YES];
//            
//            
//            CallListViewController *doctorteam=[[CallListViewController alloc]init];
//            doctorteam.isphone=YES;
//            doctorteam.isshow1st=NO;
//            // [self.navigationController pushViewController:doctorteam animated:YES];
//            
//            CallListViewController *doctorteam2=[[CallListViewController alloc]init];
//            doctorteam2.isphone=YES;
//            doctorteam2.isshow1st=NO;
//            doctorteam2.isshowCancle=YES;
//            
//            
//            
//            NSArray *viewControllers = @[doctorteam1, doctorteam,doctorteam2];
//            NSArray *titles =@[@"待出诊",@"待就诊",@"已完成"];
//            
//            WMPageController *pageVC = [[WMPageController alloc] initWithViewControllerClasses:viewControllers andTheirTitles:titles];
//            pageVC.titleSizeSelected = 15;
//            pageVC.pageAnimatable = YES;
//            pageVC.isViewInstance=YES;
//            [pageVC setSelectIndex:0];
//            pageVC.menuHeight=44.0;
//            pageVC.isneedhideItemBackground=YES;
//            //pageVC.progressHeight=60.0;
//            pageVC.itemsWidths=@[@(ScreenWidth/3.0),@(ScreenWidth/3.0),@(ScreenWidth/3.0)];
//            pageVC.menuBGColor=[UIColor whiteColor];
//            pageVC.menuViewStyle = WMMenuViewStyleLine;
//            pageVC.titleColorSelected =KlightOrangeColor;
//            pageVC.titleColorNormal = KBlackColor;
//            pageVC.progressColor = KlightOrangeColor;
//            pageVC.progressHeight=3;
//            
//            pageVC.title = @"见面咨询预约";
//            
//            // self.tabBarController.navigationController.tabBarController.navigationController.navigationBar.hidden=NO;
//            [self.navigationController pushViewController:pageVC animated:YES];
//            
//
//        } else if (indexPath.row==1) {
//            
//        }
//   
//    }else if (indexPath.section==1) {
//        if (indexPath.row==0) {
//            
//            CallListViewController *doctorteam1=[[CallListViewController alloc]init];
//            doctorteam1.isphone=YES;
//            doctorteam1.isshow1st=YES;
//           // [self.navigationController pushViewController:doctorteam1 animated:YES];
//            
//            
//            CallListViewController *doctorteam=[[CallListViewController alloc]init];
//            doctorteam.isphone=YES;
//            doctorteam.isshow1st=NO;
//           // [self.navigationController pushViewController:doctorteam animated:YES];
//
//            CallListViewController *doctorteam2=[[CallListViewController alloc]init];
//            doctorteam2.isphone=YES;
//            doctorteam2.isshow1st=NO;
//            doctorteam2.isshowCancle=YES;
//
//            
//            
//            NSArray *viewControllers = @[doctorteam1, doctorteam,doctorteam2];
//            NSArray *titles =@[@"待回电",@"已回电",@"已取消"];
//            
//            WMPageController *pageVC = [[WMPageController alloc] initWithViewControllerClasses:viewControllers andTheirTitles:titles];
//            pageVC.titleSizeSelected = 15;
//            pageVC.pageAnimatable = YES;
//            pageVC.isViewInstance=YES;
//            [pageVC setSelectIndex:0];
//            pageVC.menuHeight=44.0;
//            pageVC.isneedhideItemBackground=YES;
//            //pageVC.progressHeight=60.0;
//            pageVC.itemsWidths=@[@(ScreenWidth/3.0),@(ScreenWidth/3.0),@(ScreenWidth/3.0)];
//            pageVC.menuBGColor=[UIColor whiteColor];
//            pageVC.menuViewStyle = WMMenuViewStyleLine;
//            pageVC.titleColorSelected =KlightOrangeColor;
//            pageVC.titleColorNormal = KBlackColor;
//            pageVC.progressColor = KlightOrangeColor;
//            pageVC.progressHeight=3;
//            
//            pageVC.title = @"电话咨询预约";
//            
//            // self.tabBarController.navigationController.tabBarController.navigationController.navigationBar.hidden=NO;
//            [self.navigationController pushViewController:pageVC animated:YES];
//
//            
//
//            
//         } else if (indexPath.row==1) {
//           
//
//            
//        }
//        
//    }else if (indexPath.section==2) {
//        if (indexPath.row==0) {
//             [self mypatientaction];
//        } else if (indexPath.row==1) {
//            
//        }
//        
//    }else if (indexPath.section==3) {
//        if (indexPath.row==0) {
//            
//            OrderIMListViewController *monthordervc=[[OrderIMListViewController alloc] init];
//            OrderIMListViewController *monthordervc1=[[OrderIMListViewController alloc] init];
//            OrderIMListViewController *monthordervc2=[[OrderIMListViewController alloc] init];
//            
//            
//            
//            
//            
//            NSArray *viewControllers = @[monthordervc, monthordervc1, monthordervc2];
//            NSArray *titles =@[@"进行中",@"已完成",@"已取消"];
//            
//            WMPageController *pageVC = [[WMPageController alloc] initWithViewControllerClasses:viewControllers andTheirTitles:titles];
//            pageVC.titleSizeSelected = 15;
//            pageVC.pageAnimatable = YES;
//            pageVC.isViewInstance=YES;
//            [pageVC setSelectIndex:0];
//            pageVC.menuHeight=44.0;
//            pageVC.isneedhideItemBackground=YES;
//            //pageVC.progressHeight=60.0;
//            pageVC.itemsWidths=@[@(ScreenWidth/3.0),@(ScreenWidth/3.0),@(ScreenWidth/3.0)];
//            pageVC.menuBGColor=[UIColor whiteColor];
//            pageVC.menuViewStyle = WMMenuViewStyleLine;
//            pageVC.titleColorSelected =KlightOrangeColor;
//            pageVC.titleColorNormal = KBlackColor;
//            pageVC.progressColor = KlightOrangeColor;
//            pageVC.progressHeight=3;
//            // pageVC.itemsWidths = @[@(70),@(70),@(70)]; // 这里可以设置不同的宽度
//           // return pageVC;
//
//            pageVC.title = @"包月咨询预约";
//            
//            // self.tabBarController.navigationController.tabBarController.navigationController.navigationBar.hidden=NO;
//            [self.navigationController pushViewController:pageVC animated:YES];
//
//            
//            
//            
//            
//            
//            
//            
//        } else if (indexPath.row==1) {
//            
//            
//        }
//        
//    }
//    
//    
//    
//    
//    
//    
////    if (indexPath.section==0) {
////        if (indexPath.row==0) {
//////            CallListViewController *doctorteam=[[CallListViewController alloc]init];
//////            self.tabBarController.navigationController.navigationBar.hidden=NO;
//////            [self.tabBarController.navigationController pushViewController:doctorteam animated:YES];
////        } else if (indexPath.row==1) {
//////            OrderIMListViewController *doctorteam=[[OrderIMListViewController alloc]init];
//////            // doctorteam.isphone=NO;
//////           [s]
//////            [self.navigationController pushViewController:doctorteam animated:YES];
////           
////        }else if (indexPath.row==2) {
////                   }
////        
////    }else{
////        if (indexPath.row==0) {
////            CallListViewController *doctorteam=[[CallListViewController alloc]init];
////            doctorteam.isphone=NO;
////          
////            [self.navigationController pushViewController:doctorteam animated:YES];
////        } else if (indexPath.row==1) {
////            CallListViewController *doctorteam=[[CallListViewController alloc]init];
////             doctorteam.isphone=YES;
////           
////            [self.navigationController pushViewController:doctorteam animated:YES];
////        }
////    }
    
}

-(void)mypatientaction{
    //WMPageController *pageController = [self p_defaultController];
    //    NSArray *viewControllers = @[[UIViewController class], [UIViewController class], [UIViewController class], [UIViewController class]];
    //    NSArray *titles = @[@"通知", @"赞与感谢", @"私信" ,@"haah"];
    
    WMPageController *pageController = [self pageControllerStyleFlood];
   // pageController.navigationController.navigationBar.backgroundColor=[UIColor whiteColor];
    pageController.title = @"图文咨询预约";
    
   // self.tabBarController.navigationController.tabBarController.navigationController.navigationBar.hidden=NO;
    [self.navigationController pushViewController:pageController animated:YES];
    
    
    
}
- (WMPageController *)pageControllerStyleFlood {
   //  NSArray *namearr=@[@"全部",@"未回复",@"已回复",@"已取消"];
    OrderIMPaidListViewController *imvc1=[[OrderIMPaidListViewController alloc]init];
    imvc1.stauts=1;
    OrderIMPaidListViewController *imvc2=[[OrderIMPaidListViewController alloc]init];
    imvc2.stauts=2;

//    OrderIMPaidListViewController *imvc3=[[OrderIMPaidListViewController alloc]init];
//    imvc1.stauts=8;

    NSArray *viewControllers = @[imvc1, imvc2];
    NSArray *titles =@[@"待回复",@"已回复"];
    
    WMPageController *pageVC = [[WMPageController alloc] initWithViewControllerClasses:viewControllers andTheirTitles:titles];
    pageVC.titleSizeSelected = 15;
    pageVC.pageAnimatable = YES;
    [pageVC setSelectIndex:0];
    pageVC.menuHeight=44.0;
    pageVC.isViewInstance=YES;
    pageVC.isneedhideItemBackground=YES;
    //pageVC.progressHeight=60.0;
    pageVC.itemsWidths=@[@(ScreenWidth/2.0),@(ScreenWidth/2.0)];
    pageVC.menuBGColor=[UIColor whiteColor];
    pageVC.menuViewStyle = WMMenuViewStyleLine;
    pageVC.titleColorSelected =KlightOrangeColor;
    pageVC.titleColorNormal = KBlackColor;
    pageVC.progressColor = KlightOrangeColor;
     pageVC.progressHeight=3;
    // pageVC.itemsWidths = @[@(70),@(70),@(70)]; // 这里可以设置不同的宽度
    return pageVC;
}

-(void)callbtnaction:(UIButton *)button{
    if (button.tag==0) {
        
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
        
        
        
        NSArray *viewControllers = @[doctorteam1, doctorteam];
        NSArray *titles =@[@"待回电",@"已回电"];
        
        WMPageController *pageVC = [[WMPageController alloc] initWithViewControllerClasses:viewControllers andTheirTitles:titles];
        pageVC.titleSizeSelected = 15;
        pageVC.pageAnimatable = YES;
        pageVC.isViewInstance=YES;
        [pageVC setSelectIndex:0];
        pageVC.menuHeight=44.0;
        pageVC.isneedhideItemBackground=YES;
        //pageVC.progressHeight=60.0;
        pageVC.itemsWidths=@[@(ScreenWidth/2.0),@(ScreenWidth/2.0)];
        pageVC.menuBGColor=[UIColor whiteColor];
        pageVC.menuViewStyle = WMMenuViewStyleLine;
        pageVC.titleColorSelected =KlightOrangeColor;
        pageVC.titleColorNormal = KBlackColor;
        pageVC.progressColor = KlightOrangeColor;
        pageVC.progressHeight=3;
        
        pageVC.title = @"电话咨询预约";
        
        // self.tabBarController.navigationController.tabBarController.navigationController.navigationBar.hidden=NO;
        [self.navigationController pushViewController:pageVC animated:YES];
        

    } else if (button.tag==1) {
        
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
        
        
        
        NSArray *viewControllers = @[doctorteam1, doctorteam];
        NSArray *titles =@[@"待回电",@"已回电"];
        
        WMPageController *pageVC = [[WMPageController alloc] initWithViewControllerClasses:viewControllers andTheirTitles:titles];
        pageVC.titleSizeSelected = 15;
        pageVC.pageAnimatable = YES;
        pageVC.isViewInstance=YES;
        [pageVC setSelectIndex:1];
        pageVC.menuHeight=44.0;
        pageVC.isneedhideItemBackground=YES;
        //pageVC.progressHeight=60.0;
        pageVC.itemsWidths=@[@(ScreenWidth/2.0),@(ScreenWidth/2.0)];
        pageVC.menuBGColor=[UIColor whiteColor];
        pageVC.menuViewStyle = WMMenuViewStyleLine;
        pageVC.titleColorSelected =KlightOrangeColor;
        pageVC.titleColorNormal = KBlackColor;
        pageVC.progressColor = KlightOrangeColor;
        pageVC.progressHeight=3;
        
        pageVC.title = @"电话咨询预约";
        
        // self.tabBarController.navigationController.tabBarController.navigationController.navigationBar.hidden=NO;
        [self.navigationController pushViewController:pageVC animated:YES];
        
        
    }else if (button.tag==2) {
        
    }
}
-(void)imbtnaction:(UIButton *)button{
    if (button.tag==0) {
         //[self mypatientaction];
        WMPageController *pageController = [self pageControllerStyleFlood];
        pageController.selectIndex=0;
        // pageController.navigationController.navigationBar.backgroundColor=[UIColor whiteColor];
        pageController.title = @"图文咨询预约";
        
        // self.tabBarController.navigationController.tabBarController.navigationController.navigationBar.hidden=NO;
        [self.navigationController pushViewController:pageController animated:YES];
    } else if (button.tag==1) {
        // [self mypatientaction];
        WMPageController *pageController = [self pageControllerStyleFlood];
        pageController.selectIndex=1;
        // pageController.navigationController.navigationBar.backgroundColor=[UIColor whiteColor];
        pageController.title = @"图文咨询预约";
        
        // self.tabBarController.navigationController.tabBarController.navigationController.navigationBar.hidden=NO;
        [self.navigationController pushViewController:pageController animated:YES];
        
    }else if (button.tag==2) {
        
    }
}


-(void)monthbtnaction:(UIButton *)button{
    if (button.tag==0) {
        //[self mypatientaction];
        OrderIMListViewController *monthordervc=[[OrderIMListViewController alloc] init];
        monthordervc.showtype=1;
        OrderIMListViewController *monthordervc1=[[OrderIMListViewController alloc] init];
        monthordervc1.showtype=2;
        OrderIMListViewController *monthordervc2=[[OrderIMListViewController alloc] init];
        monthordervc2.showtype=0;
        
        
        
        
        NSArray *viewControllers = @[monthordervc, monthordervc1];
        NSArray *titles =@[@"进行中",@"已完成"];
        
        WMPageController *pageVC = [[WMPageController alloc] initWithViewControllerClasses:viewControllers andTheirTitles:titles];
        pageVC.titleSizeSelected = 15;
        pageVC.pageAnimatable = YES;
        pageVC.isViewInstance=YES;
        [pageVC setSelectIndex:0];
        pageVC.menuHeight=44.0;
        pageVC.isneedhideItemBackground=YES;
        //pageVC.progressHeight=60.0;
        pageVC.itemsWidths=@[@(ScreenWidth/2.0),@(ScreenWidth/2.0)];
        pageVC.menuBGColor=[UIColor whiteColor];
        pageVC.menuViewStyle = WMMenuViewStyleLine;
        pageVC.titleColorSelected =KlightOrangeColor;
        pageVC.titleColorNormal = KBlackColor;
        pageVC.progressColor = KlightOrangeColor;
        pageVC.progressHeight=3;
        // pageVC.itemsWidths = @[@(70),@(70),@(70)]; // 这里可以设置不同的宽度
        // return pageVC;
        
        pageVC.title = @"包月咨询预约";
        
        // self.tabBarController.navigationController.tabBarController.navigationController.navigationBar.hidden=NO;
        [self.navigationController pushViewController:pageVC animated:YES];

       
    } else if (button.tag==1) {
        OrderIMListViewController *monthordervc=[[OrderIMListViewController alloc] init];
        monthordervc.showtype=1;
        OrderIMListViewController *monthordervc1=[[OrderIMListViewController alloc] init];
        monthordervc1.showtype=2;
        OrderIMListViewController *monthordervc2=[[OrderIMListViewController alloc] init];
        monthordervc2.showtype=0;
        
        
        
        
        
        NSArray *viewControllers = @[monthordervc, monthordervc1];
        NSArray *titles =@[@"进行中",@"已完成"];
        
        WMPageController *pageVC = [[WMPageController alloc] initWithViewControllerClasses:viewControllers andTheirTitles:titles];
        pageVC.titleSizeSelected = 15;
        pageVC.pageAnimatable = YES;
        pageVC.isViewInstance=YES;
        [pageVC setSelectIndex:1];
        pageVC.menuHeight=44.0;
        pageVC.isneedhideItemBackground=YES;
        //pageVC.progressHeight=60.0;
        pageVC.itemsWidths=@[@(ScreenWidth/2.0),@(ScreenWidth/2.0)];
        pageVC.menuBGColor=[UIColor whiteColor];
        pageVC.menuViewStyle = WMMenuViewStyleLine;
        pageVC.titleColorSelected =KlightOrangeColor;
        pageVC.titleColorNormal = KBlackColor;
        pageVC.progressColor = KlightOrangeColor;
        pageVC.progressHeight=3;
        // pageVC.itemsWidths = @[@(70),@(70),@(70)]; // 这里可以设置不同的宽度
        // return pageVC;
        
        pageVC.title = @"包月咨询预约";
        
        // self.tabBarController.navigationController.tabBarController.navigationController.navigationBar.hidden=NO;
        [self.navigationController pushViewController:pageVC animated:YES];

        
    }else if (button.tag==2) {
//        OrderIMListViewController *monthordervc=[[OrderIMListViewController alloc] init];
//        monthordervc.showtype=1;
//        OrderIMListViewController *monthordervc1=[[OrderIMListViewController alloc] init];
//        monthordervc1.showtype=2;
//        OrderIMListViewController *monthordervc2=[[OrderIMListViewController alloc] init];
//        monthordervc2.showtype=0;
//        
//        
//        
//        
//        
//        NSArray *viewControllers = @[monthordervc, monthordervc1, monthordervc2];
//        NSArray *titles =@[@"待处理",@"处理中",@"已完成"];
//        
//        WMPageController *pageVC = [[WMPageController alloc] initWithViewControllerClasses:viewControllers andTheirTitles:titles];
//        pageVC.titleSizeSelected = 15;
//        pageVC.pageAnimatable = YES;
//        pageVC.isViewInstance=YES;
//        [pageVC setSelectIndex:2];
//        pageVC.menuHeight=44.0;
//        pageVC.isneedhideItemBackground=YES;
//        //pageVC.progressHeight=60.0;
//        pageVC.itemsWidths=@[@(ScreenWidth/3.0),@(ScreenWidth/3.0),@(ScreenWidth/3.0)];
//        pageVC.menuBGColor=[UIColor whiteColor];
//        pageVC.menuViewStyle = WMMenuViewStyleLine;
//        pageVC.titleColorSelected =KlightOrangeColor;
//        pageVC.titleColorNormal = KBlackColor;
//        pageVC.progressColor = KlightOrangeColor;
//        pageVC.progressHeight=3;
//        // pageVC.itemsWidths = @[@(70),@(70),@(70)]; // 这里可以设置不同的宽度
//        // return pageVC;
//        
//        pageVC.title = @"包月咨询预约";
//        
//        // self.tabBarController.navigationController.tabBarController.navigationController.navigationBar.hidden=NO;
//        [self.navigationController pushViewController:pageVC animated:YES];

        
    }
}
-(void)meetbtnaction:(UIButton *)button{
    
    
    if (button.tag==0) {
        
        FaceOrderViewController *doctorteam1=[[FaceOrderViewController alloc]init];
        doctorteam1.statustype=1;
        
        [self.navigationController pushViewController:doctorteam1 animated:YES];
        
// [self.navigationController pushViewController:doctorteam1 animated:YES];

//        
//        CallListViewController *doctorteam1=[[CallListViewController alloc]init];
//        doctorteam1.isphone=YES;
//        doctorteam1.isshow1st=YES;
//        // [self.navigationController pushViewController:doctorteam1 animated:YES];
//        
//        
//        CallListViewController *doctorteam=[[CallListViewController alloc]init];
//        doctorteam.isphone=YES;
//        doctorteam.isshow1st=NO;
//        // [self.navigationController pushViewController:doctorteam animated:YES];
//        
//        CallListViewController *doctorteam2=[[CallListViewController alloc]init];
//        doctorteam2.isphone=YES;
//        doctorteam2.isshow1st=NO;
//        doctorteam2.isshowCancle=YES;
//        
//        
//        
//        NSArray *viewControllers = @[doctorteam1, doctorteam,doctorteam2];
//        NSArray *titles =@[@"待出诊",@"待就诊",@"已完成"];
//        
//        WMPageController *pageVC = [[WMPageController alloc] initWithViewControllerClasses:viewControllers andTheirTitles:titles];
//        pageVC.titleSizeSelected = 15;
//        pageVC.pageAnimatable = YES;
//        pageVC.isViewInstance=YES;
//        [pageVC setSelectIndex:0];
//        pageVC.menuHeight=44.0;
//        pageVC.isneedhideItemBackground=YES;
//        //pageVC.progressHeight=60.0;
//        pageVC.itemsWidths=@[@(ScreenWidth/3.0),@(ScreenWidth/3.0),@(ScreenWidth/3.0)];
//        pageVC.menuBGColor=[UIColor whiteColor];
//        pageVC.menuViewStyle = WMMenuViewStyleLine;
//        pageVC.titleColorSelected =KlightOrangeColor;
//        pageVC.titleColorNormal = KBlackColor;
//        pageVC.progressColor = KlightOrangeColor;
//        pageVC.progressHeight=3;
//        
//        pageVC.title = @"见面咨询预约";
//        
        // self.tabBarController.navigationController.tabBarController.navigationController.navigationBar.hidden=NO;
       
    }else if (button.tag==1) {
        FaceOrderViewController *doctorteam1=[[FaceOrderViewController alloc]init];
        doctorteam1.statustype=2;
        
        [self.navigationController pushViewController:doctorteam1 animated:YES];

//        CallListViewController *doctorteam1=[[CallListViewController alloc]init];
//        doctorteam1.isphone=YES;
//        doctorteam1.isshow1st=YES;
//        // [self.navigationController pushViewController:doctorteam1 animated:YES];
//        
//        
//        CallListViewController *doctorteam=[[CallListViewController alloc]init];
//        doctorteam.isphone=YES;
//        doctorteam.isshow1st=NO;
//        // [self.navigationController pushViewController:doctorteam animated:YES];
//        
//        CallListViewController *doctorteam2=[[CallListViewController alloc]init];
//        doctorteam2.isphone=YES;
//        doctorteam2.isshow1st=NO;
//        doctorteam2.isshowCancle=YES;
//        
//        
//        
//        NSArray *viewControllers = @[doctorteam1, doctorteam,doctorteam2];
//        NSArray *titles =@[@"待出诊",@"待就诊",@"已完成"];
//        
//        WMPageController *pageVC = [[WMPageController alloc] initWithViewControllerClasses:viewControllers andTheirTitles:titles];
//        pageVC.titleSizeSelected = 15;
//        pageVC.pageAnimatable = YES;
//        pageVC.isViewInstance=YES;
//        [pageVC setSelectIndex:1];
//        pageVC.menuHeight=44.0;
//        pageVC.isneedhideItemBackground=YES;
//        //pageVC.progressHeight=60.0;
//        pageVC.itemsWidths=@[@(ScreenWidth/3.0),@(ScreenWidth/3.0),@(ScreenWidth/3.0)];
//        pageVC.menuBGColor=[UIColor whiteColor];
//        pageVC.menuViewStyle = WMMenuViewStyleLine;
//        pageVC.titleColorSelected =KlightOrangeColor;
//        pageVC.titleColorNormal = KBlackColor;
//        pageVC.progressColor = KlightOrangeColor;
//        pageVC.progressHeight=3;
//        
//        pageVC.title = @"见面咨询预约";
//        
//        // self.tabBarController.navigationController.tabBarController.navigationController.navigationBar.hidden=NO;
//        [self.navigationController pushViewController:pageVC animated:YES];
//        
    }else if (button.tag==2) {
        
        FaceOrderViewController *doctorteam1=[[FaceOrderViewController alloc]init];
        doctorteam1.statustype=3;
        
        [self.navigationController pushViewController:doctorteam1 animated:YES];

        
//        CallListViewController *doctorteam1=[[CallListViewController alloc]init];
//        doctorteam1.isphone=YES;
//        doctorteam1.isshow1st=YES;
//        // [self.navigationController pushViewController:doctorteam1 animated:YES];
//        
//        
//        CallListViewController *doctorteam=[[CallListViewController alloc]init];
//        doctorteam.isphone=YES;
//        doctorteam.isshow1st=NO;
//        // [self.navigationController pushViewController:doctorteam animated:YES];
//        
//        CallListViewController *doctorteam2=[[CallListViewController alloc]init];
//        doctorteam2.isphone=YES;
//        doctorteam2.isshow1st=NO;
//        doctorteam2.isshowCancle=YES;
//        
//        
//        
//        NSArray *viewControllers = @[doctorteam1, doctorteam,doctorteam2];
//        NSArray *titles =@[@"待出诊",@"待就诊",@"已完成"];
//        
//        WMPageController *pageVC = [[WMPageController alloc] initWithViewControllerClasses:viewControllers andTheirTitles:titles];
//        pageVC.titleSizeSelected = 15;
//        pageVC.pageAnimatable = YES;
//        pageVC.isViewInstance=YES;
//        [pageVC setSelectIndex:2];
//        pageVC.menuHeight=44.0;
//        pageVC.isneedhideItemBackground=YES;
//        //pageVC.progressHeight=60.0;
//        pageVC.itemsWidths=@[@(ScreenWidth/3.0),@(ScreenWidth/3.0),@(ScreenWidth/3.0)];
//        pageVC.menuBGColor=[UIColor whiteColor];
//        pageVC.menuViewStyle = WMMenuViewStyleLine;
//        pageVC.titleColorSelected =KlightOrangeColor;
//        pageVC.titleColorNormal = KBlackColor;
//        pageVC.progressColor = KlightOrangeColor;
//        pageVC.progressHeight=3;
//        
//        pageVC.title = @"见面咨询预约";
//        
//        // self.tabBarController.navigationController.tabBarController.navigationController.navigationBar.hidden=NO;
//        [self.navigationController pushViewController:pageVC animated:YES];
        
        
    }
}


@end
