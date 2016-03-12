//
//  OrderIMPaidListViewController.m
//  CYS
//
//  Created by 谢阳晴 on 16/1/28.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import "OrderIMPaidListViewController.h"

#import "itemdetailbutton.h"
#import "CallingViewController.h"
#import "ConnectDetailViewController.h"



#define headheight 60


@interface OrderIMPaidListViewController (){
    
    NSMutableArray *tmparr;
    NSMutableArray *donearr;
    NSMutableArray *notyetarr;
    itemdetailbutton *oldbutton;
    
    UIView *masklineview;
}





@end


@implementation OrderIMPaidListViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    //self.isphone=NO;
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64.0-20.0) style:UITableViewStyleGrouped];
    self.tableView.delegate=self;
    
    self.tableView.dataSource=self;
    self.title=@"咨询";
    [self.view addSubview:self.tableView];
    //  “全部”“未回复”“已回复”“已取消”
    
    //    NSArray *namearr=@[@"全部",@"未回复",@"已回复",@"已取消"];
    //
    //        for (int i=0;i<namearr.count;i++) {
    //            NSString *btnname=[namearr objectAtIndex:i];
    //            itemdetailbutton *sentbutton=[itemdetailbutton buttonWithType:UIButtonTypeCustom];
    //            sentbutton.frame=CGRectMake(ScreenWidth/4.0*i, 64, ScreenWidth/4.0, headheight);
    //            [sentbutton setTitle:btnname forState:UIControlStateNormal];
    //            sentbutton.tag=100+i;
    //
    //            [sentbutton setTitleColor:KBlackColor forState:UIControlStateNormal];
    //            [sentbutton setTitleColor:KlightOrangeColor forState:UIControlStateSelected];
    //
    //            [sentbutton addTarget:self action:@selector(headaction:) forControlEvents:UIControlEventTouchUpInside];
    //            sentbutton.backgroundColor=[UIColor whiteColor];
    //            [self.view addSubview:sentbutton];
    //
    //
    //            if (i==0) {
    //                sentbutton.selected=YES;
    //
    //                oldbutton=sentbutton;
    //            }
    //
    //            sentbutton.titleLabel.font=[UIFont boldSystemFontOfSize:18.0];
    //        }
    //
    //
    //
    //    UIView *lineview=[[UIView alloc]initWithFrame:CGRectMake(0, headheight+headheight+4-1.3, ScreenWidth, 1.3)];
    //    lineview.backgroundColor=KlightOrangeColor;
    //    [self.view addSubview:lineview];
    //
    //    masklineview =[[UIView alloc]initWithFrame:CGRectMake(0, headheight+headheight+4-1.3-5, ScreenWidth/4.0, 5.0)];
    //    masklineview.backgroundColor=KlightOrangeColor;
    //    [self.view addSubview:masklineview];
    //
    //
    
    self.tableView.sectionIndexColor = KLineColor;
    
    [self getdata];
    
}
-(void)getdata{
    JGProgressHUD *hud=[[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleDark];
    [hud showInView:self.view];
    [hud dismissAfterDelay:5];
    
    [OrderDataService getOrderDetailListWithServicetype:0 Statu:self.stauts block:^(id resparr) {
        [hud dismiss];
        NSArray *arr=(NSArray *)resparr;
        self.dataArr=[[NSMutableArray alloc]initWithArray:arr];
        [self.tableView reloadData];
    }];
}
-(void)headaction:(itemdetailbutton *)button{
    //    button.selected=YES;
    //    if (button.tag==oldbutton.tag) {
    //
    //    } else {
    //        oldbutton.selected=NO;
    //        oldbutton=button;
    //    }
    //    if (button.tag==100) {
    //
    //
    //
    //
    //    } else if (button.tag==101){
    //
    //    }else if (button.tag==102){
    //
    //    }else if (button.tag==103){
    //
    //    }
    //    masklineview.frame=CGRectMake(button.frame.origin.x, headheight+headheight+4-1.3-5, ScreenWidth/4.0, 5.0);
    //
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64.0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=nil;
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"usercell"];
    }
    NSDictionary *dic=[self.dataArr objectAtIndex:indexPath.row];
    
    UIImageView *imagev;
    //=[[UIImageView alloc]init];
    
    
    imagev =[[UIImageView alloc]initWithFrame:CGRectMake(10, 8, 44, 44)];
    //   imagev.frame=CGRectMake(10, 8, 44, 44);
    
    
    
    
    imagev.clipsToBounds=YES;
    
    imagev.layer.masksToBounds=YES;
    imagev.layer.cornerRadius =22.0;
    imagev.layer.borderColor = [UIColor clearColor].CGColor;
    imagev.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    // imagev.image=[UIImage imageNamed:@"KAKA"];
    //  NSLog(@"%@",[NSString stringWithFormat:@"%@",[datadic objectForKey:@"icon"]]);
    [imagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"icon"]]] placeholderImage:[UIImage imageNamed:kPlaceholderimage]];
    [cell addSubview:imagev];
    
    UILabel *label=[[UILabel alloc]init];
    label.frame=CGRectMake(60, 8, 90, 30);
    label.textColor=KBlackColor;
    label.font=[UIFont systemFontOfSize:16.0];
    label.backgroundColor=[UIColor clearColor];
    [cell addSubview:label];
    
    //label.text=
    NSString *contentstring=[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@",[[dic objectForKey:@"patient"] objectForKey:@"name"]]];
    
    NSMutableAttributedString *astring=[[NSMutableAttributedString alloc]initWithString:contentstring];
    
    
    label.attributedText=astring;
    
    UILabel *desclabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-190, 7, 180, 30)];
    desclabel.frame=CGRectMake(60, 30, 180, 30);
    desclabel.textColor=KtextGrayColor;
    desclabel.font=[UIFont systemFontOfSize:13.0];
    desclabel.backgroundColor=[UIColor clearColor];
    [cell addSubview:desclabel];
    desclabel.text=[[NSString stringWithFormat:@"%@",[[dic objectForKey:@"auditable"] objectForKey:@"date_created"]] substringToIndex:10];
    
    
    UILabel *sexAgelabel=[[UILabel alloc]init];
    sexAgelabel.frame=CGRectMake(150, 8, 60, 30);
    sexAgelabel.textColor=KtextGrayColor;
    sexAgelabel.font=[UIFont systemFontOfSize:13.0];
    sexAgelabel.backgroundColor=[UIColor clearColor];
    
    NSString *sexstr=[[NSString alloc]init];
    if ([[[dic objectForKey:@"patient"] objectForKey:@"gender"] integerValue]==0) {
        sexstr=@"男";
    }else   if ([[[dic objectForKey:@"patient"] objectForKey:@"gender"] integerValue]==1){
        sexstr=@"女";
    }else{
        sexstr=@"";
    }
     NSString *agestr=[[NSString alloc]init];
    agestr=[[dic objectForKey:@"patient"] objectForKey:@"age"]?[[dic objectForKey:@"patient"] objectForKey:@"age"]:@"";
    
    
    sexAgelabel.text=[NSString stringWithFormat:@"%@  %@岁",sexstr,agestr];
    [cell addSubview:sexAgelabel];
    
    UILabel *paylabel=[[UILabel alloc]init];
    paylabel.frame=CGRectMake(ScreenWidth-116, 8, 80, 25);
    paylabel.textColor=KtextGrayColor;
    paylabel.layer.cornerRadius=5.0;
    paylabel.layer.borderWidth=1.5;
    paylabel.layer.borderColor=KGreenColor.CGColor;
    paylabel.font=[UIFont boldSystemFontOfSize:11.0];
    paylabel.backgroundColor=[UIColor clearColor];
    paylabel.textAlignment=NSTextAlignmentCenter;
    paylabel.textColor=KGreenColor;
    
    paylabel.text=[NSString stringWithFormat:@"已付%@元",[dic objectForKey:@"total_amount"]];
    [cell addSubview:paylabel];
    
    
    
    
    UILabel *orderlabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-190, 7, 180, 30)];
    
    
    orderlabel.frame=CGRectMake(ScreenWidth-166, 30, 130, 30);
    
    
    orderlabel.textColor=KtextGrayColor;
    orderlabel.font=[UIFont systemFontOfSize:13.0];
    orderlabel.backgroundColor=[UIColor clearColor];
    [cell addSubview:orderlabel];
    orderlabel.textAlignment=NSTextAlignmentRight;
    orderlabel.text=[NSString stringWithFormat:@"订单号：%@",[dic objectForKey:@"id"]];
    
    
    //    itemdetailbutton *sentbutton=[itemdetailbutton buttonWithType:UIButtonTypeCustom];
    //    // sentbutton.frame=CGRectMake(ScreenWidth-90, 5, 80, 40-6);
    //
    //
    //
    //    sentbutton.frame=CGRectMake(ScreenWidth-70, 15, 60, 30);
    //    [sentbutton setTitle:@"添加" forState:UIControlStateNormal];
    //
    //    sentbutton.tag=indexPath.row+200000000;
    //    sentbutton.buttonlocation=indexPath.section;
    //    sentbutton.layer.masksToBounds = YES;
    //    sentbutton.layer.cornerRadius = 4.0;
    //    sentbutton.layer.borderWidth = 1.0;
    //    sentbutton.layer.borderColor = [KlightOrangeColor CGColor];
    //
    //    [sentbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    sentbutton.backgroundColor=KlightOrangeColor;
    //    [sentbutton addTarget:self action:@selector(sentmsgaction:) forControlEvents:UIControlEventTouchUpInside];
    //    [cell addSubview:sentbutton];
    
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dic=[self.dataArr objectAtIndex:indexPath.row];
    NSLog(@"%@",dic);
    // if (self.isphone) {
    ConnectDetailViewController *VC=[[ConnectDetailViewController alloc]init];
    VC.delegate=self;
    VC.isphone=self.isphone;
    VC.patientdatadic=dic;
    //VC.urslstr=[NSString stringWithFormat:@"http://192.168.1.117:8080/view/imageText.html"];
 VC.urslstr=[NSString stringWithFormat:@"%@%@?order_id=%@",k_webbaseurl,@"imageText.html",[dic objectForKey:@"id"]];
    // @"http://rm.chengyisheng.com.cn:8080/app_web/app_doctor_web/view/authentication.html";
    
    [self.navigationController pushViewController:VC animated:YES];
    
    //    ConnectDetailViewController *callingvc=[[ConnectDetailViewController alloc]init];
    //    callingvc.isphone=self.isphone;
    //    callingvc.patientdatadic=dic;
    //    [self.navigationController pushViewController:callingvc animated:YES];
}
-(void)ConnectDetailMethodname:(NSString *)methodname stringval:(NSString *)stringval type:(NSInteger)type;{
    [self getdata];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=NO;
}
-(void)sentmsgaction:(itemdetailbutton *)button{
    //    [PatientDataService invitePatientToDoctorPatientId:@"" doctor:@"" block:^(id respdic) {
    //        
    //        
    //        
    //    }];
}




@end
