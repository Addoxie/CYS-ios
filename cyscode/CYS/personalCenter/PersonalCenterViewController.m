//
//  PersonalCenterViewController.m
//  CYS
//
//  Created by 谢阳晴 on 16/2/1.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import "PersonalCenterViewController.h"
#import "PersonalSettingViewController.h"
#import "PubilcViewController.h"
#import "PersonalInfoViewController.h"
#import "InviteDoctorViewController.h"
#import "MainTabBarController.h"

#import "WalletViewController.h"
#import "AddDoctorViewController.h"


@interface PersonalCenterViewController (){
    NSMutableArray *imagearr;
    NSMutableArray *namearr;
    UIView *redpointview;
}

@end


@implementation PersonalCenterViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor=KBackgroundColor;
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadindex:) name:@"reloadindex" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(haveSystemMsg:) name:@"haveSystemMsg" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(newauthermsg:) name:@"newauthermsg" object:nil];
    
    imagearr=[[NSMutableArray alloc]initWithArray:@[@"authentication",@"wallet",@"service",@"invite_doc",@"news",@"setting"]];
    namearr=[[NSMutableArray alloc]initWithArray:@[@"身份认证",@"钱包",@"咨询服务设置",@"邀请医生加入诊所",@"消息",@"设置"]];
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-49) style:UITableViewStyleGrouped];
    self.tableView.delegate=self;
    self.tableView.separatorColor=[UIColor clearColor];
    self.tableView.dataSource=self;
    self.tableView.scrollEnabled=NO;
    self.title=@"个人中心";
    [self.view addSubview:self.tableView];
    
    
    
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
        
        if ([[dic objectForKey:@"status"]isEqualToString:@"AUDIT_PASSED"]) {
            [LoginDataService getSelfIMInfoblock:^(id respdic) {
                NSLog(@"%@",respdic);
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:[respdic objectForKey:@"im_id"] forKey:@"im-id"];
                [defaults setObject:[respdic objectForKey:@"im_reg_id"] forKey:@"im-token"];
                [defaults synchronize];
                //  [self login:[[NSUserDefaults standardUserDefaults]objectForKey:@"im-id"] password:@"123456"];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadindex" object:nil];
                
            }];
        }
       

        [self.tableView reloadData];
    }];

    
    
    

}
-(void)haveSystemMsg:(NSNotification *)sender{
    [self.tableView reloadData];
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden=NO;
//    self.tabBarController.navigationController.navigationBar.hidden=NO;
    [MobClick endEvent:@"doctor_center"];
    
   
}
-(void)newauthermsg:(NSNotification *)sender{
    [UserDataService getSelfInfoWithblock:^(id respdic) {
        NSDictionary *dic=[[NSDictionary alloc]initWithDictionary:respdic];
        
        NSLog(@"%@",dic);
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
        [self.tableView reloadData];
        if ([[dic objectForKey:@"status"]isEqualToString:@"AUDIT_PASSED"]) {
            [LoginDataService getSelfIMInfoblock:^(id respdic) {
                NSLog(@"%@",respdic);
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:[respdic objectForKey:@"im_id"] forKey:@"im-id"];
                [defaults setObject:[respdic objectForKey:@"im_reg_id"] forKey:@"im-token"];
                [defaults synchronize];
                //  [self login:[[NSUserDefaults standardUserDefaults]objectForKey:@"im-id"] password:@"123456"];
                //[[NSNotificationCenter defaultCenter]postNotificationName:@"reloadindex" object:nil];
                
            }];
        }
        
        
        [self.tableView reloadData];
    }];

}
-(void)reloadindex:(NSNotification *)sender{
    [UserDataService getSelfInfoWithblock:^(id respdic) {
        NSDictionary *dic=[[NSDictionary alloc]initWithDictionary:respdic];
        
        NSLog(@"%@",dic);
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
         [self.tableView reloadData];
        if ([[dic objectForKey:@"status"]isEqualToString:@"AUDIT_PASSED"]) {
            [LoginDataService getSelfIMInfoblock:^(id respdic) {
                NSLog(@"%@",respdic);
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:[respdic objectForKey:@"im_id"] forKey:@"im-id"];
                [defaults setObject:[respdic objectForKey:@"im_reg_id"] forKey:@"im-token"];
                [defaults synchronize];
                //  [self login:[[NSUserDefaults standardUserDefaults]objectForKey:@"im-id"] password:@"123456"];
                //[[NSNotificationCenter defaultCenter]postNotificationName:@"reloadindex" object:nil];
                
            }];
        }
        
        
        [self.tableView reloadData];
    }];
    

   // [self.tableView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    if (section==1) {
//        UILabel *label=[[UILabel alloc]init];
//        label.frame=CGRectMake(0, 16, ScreenWidth, 10);
//        label.textAlignment=NSTextAlignmentCenter;
//        label.font=[UIFont systemFontOfSize:14.0];
//        label.text=@"如果您有任何疑问，请拨打客服电话";
//        
//        UIButton *footerviewbtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
//        [footerviewbtn addSubview:label];
//        UIButton *telbutton=[UIButton buttonWithType:UIButtonTypeSystem];
//        telbutton.frame=CGRectMake(0, 33, ScreenWidth, 12);
//        [telbutton setTitle:@"400-061-8989" forState:UIControlStateNormal];
//        //        telbutton.text=[NSString stringWithFormat:@"%@",@"00008888888"];
//        //        telbutton.textAlignment=NSTextAlignmentCenter;
//        //        telbutton.textColor=[UIColor blueColor];
//     
//        [footerviewbtn addSubview:telbutton];
//        
//        [footerviewbtn addTarget:self action:@selector(telbuttonaction) forControlEvents:UIControlEventTouchUpInside];
//        
//        return footerviewbtn;
//    }else{
//        return nil;
//   
//    }
//   
//
//}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return kHeightgetFloat(136);
    } else {
        return kHeightgetFloat(88);
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    if (section==0) {
        return 1;
    } else if (section==1) {
        return 7;
    } else{
        return 1;
    }
   // return  self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=nil;
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"usercell"];
    }
    
    
    
 
    NSDictionary *dic;
      UIImageView *imagev=[[UIImageView alloc]init];
    
    if (indexPath.row!=6) {
        dic=[self.dataArr objectAtIndex:indexPath.row];
      
        //=[[UIImageView alloc]init];
        
        
        imagev.layer.cornerRadius =30.0;
        //   imagev.frame=CGRectMake(10, 8, 44, 44);
        if (indexPath.section==0) {
            imagev.frame=CGRectMake(kWidthgetFloat(24), kHeightgetFloat(136/2.0)/1.0-kHeightgetFloat(96)/2.0, kHeightgetFloat(96), kHeightgetFloat(96));
            
            [imagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",KGetDefaultstr(@"icon-url")]] placeholderImage:[UIImage imageNamed:kPlaceholderimage]];
            imagev.layer.borderWidth=0.6;
            imagev.layer.borderColor = KLineColor.CGColor;
            imagev.layer.cornerRadius=kWidthgetFloat(96)/2.0;
            
        } else if (indexPath.section==1) {
            imagev.frame=CGRectMake(kWidthgetFloat(24), kHeightgetFloat(88)/2.0-kHeightgetFloat(56)/2.0, kHeightgetFloat(56), kHeightgetFloat(56));
            [imagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"icon"]]] placeholderImage:[UIImage imageNamed:[imagearr objectAtIndex:indexPath.row]]];
            imagev.layer.cornerRadius =kWidthgetFloat(56)/2.0;
        } else{
            // [imagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"icon"]]] placeholderImage:[UIImage imageNamed:kPlaceholderimage]];
        }
        
        
        
        imagev.clipsToBounds=YES;
        
        imagev.layer.masksToBounds=YES;
        
        
        imagev.layer.rasterizationScale = [UIScreen mainScreen].scale;
        
        // imagev.image=[UIImage imageNamed:@"KAKA"];
        //  NSLog(@"%@",[NSString stringWithFormat:@"%@",[datadic objectForKey:@"icon"]]);
        
        [cell addSubview:imagev];
        
      

    }
   
    UILabel *label=[[UILabel alloc]init];
    label.font=[UIFont systemFontOfSize:18.0];
    
    if (indexPath.section==0) {
        
        
        NSString *namestr=KGetDefaultstr(@"nick-name");
        
        
        UIFont *strfont=[UIFont boldSystemFontOfSize:18.0];
        
        CGRect namestrsize=KStringwSize(namestr, 40, strfont);
//        newnamelabel.frame=CGRectMake(15, 0, namestrsize.size.width, 40);
//        
//        
//        authorlabel.frame=CGRectMake(newnamelabel.frame.origin.x+newnamelabel.frame.size.width, 10, 50, 20);
        

        
        
        label.frame=CGRectMake(kWidthgetFloat(144), imagev.center.y-28, namestrsize.size.width, 30);
       // label.backgroundColor=KRedColor;
        label.font=[UIFont boldSystemFontOfSize:18.0];
        label.text=KGetDefaultstr(@"nick-name");
       
        UILabel *titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(label.frame.origin.x+label.frame.size.width+5, imagev.center.y-26, 100,30)];
        titlelabel.text=[NSString stringWithFormat:@"%@",KGetDefaultstr(@"usertitle")];
        titlelabel.textColor=kimiColor(102, 102, 102, 1);
        titlelabel.numberOfLines=1;
        titlelabel.font=[UIFont systemFontOfSize:13.0];
        titlelabel.textAlignment=NSTextAlignmentLeft;
        //[titlelabel sizeToFit];
        titlelabel.userInteractionEnabled=NO;
        [cell addSubview:titlelabel];
        
        UIImageView *imagev1=[[UIImageView alloc]init];
        //=[[UIImageView alloc]init];
        imagev1.frame=CGRectMake(ScreenWidth-60, kHeightgetFloat(136)/2.0-12.5, 25, 25);
        imagev1.image=[UIImage imageNamed:@"qrcode"];
        //[imagev1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",KGetDefaultstr(@"icon-url")]] placeholderImage:[UIImage imageNamed:kPlaceholderimage]];
        
        imagev1.clipsToBounds=YES;
        
        imagev1.layer.masksToBounds=YES;
        //imagev1.layer.cornerRadius =4.0;
        imagev1.layer.borderColor = [UIColor clearColor].CGColor;
        imagev1.layer.rasterizationScale = [UIScreen mainScreen].scale;
        
        // imagev.image=[UIImage imageNamed:@"KAKA"];
        //  NSLog(@"%@",[NSString stringWithFormat:@"%@",[datadic objectForKey:@"icon"]]);
        
        [cell addSubview:imagev1];

        
        
        
        
         cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
        
        
    } else if (indexPath.section==1) {
        
        
        if (indexPath.row==4) {
            
            //label.frame=CGRectMake(60, 0, 190, 55);
            label.frame=CGRectMake(kWidthgetFloat(96), 0, 190, kHeightgetFloat(88));
            label.text=[namearr objectAtIndex:indexPath.row];
            [redpointview removeFromSuperview];
            MainTabBarController *tabbarVC=(MainTabBarController *)self.tabBarController;
            NSLog(@"%zd",[tabbarVC.msgcount integerValue]);
            
            redpointview=[[UIView alloc]initWithFrame:CGRectMake(ScreenWidth-50, kHeightgetFloat(88)/2.0-10/2.0, 10, 10)];
            redpointview.backgroundColor=[UIColor clearColor];
            redpointview.layer.cornerRadius=5.0;
            [cell addSubview:redpointview];

            if ([tabbarVC.msgcount intValue] !=0) {
                
                redpointview.backgroundColor=[UIColor redColor];
             
            }
            
          cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            
         //  [cell addSubview:[[UIManager shareInstance]getlineviewWithFrame:CGRectMake(15, kHeightgetFloat(88)-0.7, ScreenWidth-15, 0.7) withimage:nil withbgcolor:KLineColor]];
            

        }
        if(indexPath.row==6){
            
        UILabel *label=[[UILabel alloc]init];
        label.frame=CGRectMake(0, 16, ScreenWidth, 10);
        label.textAlignment=NSTextAlignmentCenter;
        label.font=[UIFont systemFontOfSize:14.0];
        label.text=@"如果您有任何疑问，请拨打客服电话";
        
        UIButton *footerviewbtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
        [footerviewbtn addSubview:label];
        UIButton *telbutton=[UIButton buttonWithType:UIButtonTypeSystem];
        telbutton.frame=CGRectMake(0, 33, ScreenWidth, 12);
        [telbutton setTitle:@"400-061-8989" forState:UIControlStateNormal];
        //        telbutton.text=[NSString stringWithFormat:@"%@",@"00008888888"];
        //        telbutton.textAlignment=NSTextAlignmentCenter;
        //        telbutton.textColor=[UIColor blueColor];
        
        [footerviewbtn addSubview:telbutton];
        [telbutton addTarget:self action:@selector(telbuttonaction) forControlEvents:UIControlEventTouchUpInside];
        [footerviewbtn addTarget:self action:@selector(telbuttonaction) forControlEvents:UIControlEventTouchUpInside];

        [cell addSubview:footerviewbtn];
            
        cell.backgroundColor=[UIColor clearColor];
            
        
        }else{
            label.frame=CGRectMake(kWidthgetFloat(96), 0, 190, kHeightgetFloat(88));
            label.text=[namearr objectAtIndex:indexPath.row];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            [cell addSubview:[[UIManager shareInstance]getlineviewWithFrame:CGRectMake(kWidthgetFloat(96), kHeightgetFloat(88)-0.5, ScreenWidth-kWidthgetFloat(96), 0.5) withimage:nil withbgcolor:KLineColor]];
        }
    
        
        
        
    } else{
        label.frame=CGRectMake(0, 16, ScreenWidth, 10);
        label.textAlignment=NSTextAlignmentCenter;
         label.font=[UIFont systemFontOfSize:14.0];
        label.text=@"如果您有任何疑问，请拨打客服电话";
    }
    label.textColor=KBlackColor;
    label.backgroundColor=[UIColor clearColor];
    [cell addSubview:label];
    
    //label.text=
//    NSString *contentstring=[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@",[[dic objectForKey:@"patient"] objectForKey:@"name"]]];
//    
//    NSMutableAttributedString *astring=[[NSMutableAttributedString alloc]initWithString:contentstring];
//    
//    
//    label.attributedText=astring;
    
    UILabel *desclabel=[[UILabel alloc]init ];
    
     [cell addSubview:desclabel];
    
    
    desclabel.textColor=KtextGrayColor;
    desclabel.font=[UIFont systemFontOfSize:14.0];
    desclabel.backgroundColor=[UIColor clearColor];

    if (indexPath.section==0) {
        
        desclabel.frame=CGRectMake(kWidthgetFloat(144), imagev.center.y, 180, 30);
        desclabel.text=[NSString stringWithFormat:@"橙子号：%@",KGetDefaultstr(@"usercheng_num")];
        desclabel.textAlignment=NSTextAlignmentLeft;
        desclabel.font=[UIFont systemFontOfSize:15.0];
        desclabel.textColor= KtextGrayColor;
    } else if (indexPath.section==1) {
//        desclabel.frame=CGRectMake(60, 30, 180, 30);
//        desclabel.text=[NSString stringWithFormat:@"橙子号%@",@"8888888"];
        if (indexPath.row==0) {
            desclabel.frame=CGRectMake(ScreenWidth-135, 0, 100, kHeightgetFloat(88));
            
            if ([KGetDefaultstr(@"userstatus") isEqualToString:@"AUDIT_PASSED"]) {
                desclabel.text=[NSString stringWithFormat:@"%@",@"已认证"];
            }else{
                desclabel.text=[NSString stringWithFormat:@"%@",@"未认证"];
            }
           
            desclabel.textAlignment=NSTextAlignmentRight;
        }
    } else{
        
    }
    
    
//    if (indexPath.section!=2) {
//        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
//    }
    
    //desclabel.text=[[NSString stringWithFormat:@"%@",[[dic objectForKey:@"auditable"] objectForKey:@"date_created"]] substringToIndex:10];
    return cell;
    
}
-(void)telbuttonaction{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"4000618989"];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0) {
        PersonalInfoViewController *VC=[[PersonalInfoViewController alloc]init];
       
      //  VC.urslstr=[NSString stringWithFormat:@"http://192.168.1.117:8080/view/personalInformation.html"];
        VC.urslstr=[NSString stringWithFormat:@"%@%@",k_webbaseurl,@"personalInformation.html"];
    //    WebBarCodeViewController *VC=[[WebBarCodeViewController alloc]init];
    
        
        [self.tabBarController.navigationController pushViewController:VC animated:YES];

    }else if (indexPath.section==1) {
        if (indexPath.row==2) {
            
            if ([KGetDefaultstr(@"userstatus") isEqualToString:@"AUDIT_PASSED"]) {
                PatientServiceViewController *VC=[[PatientServiceViewController alloc]init];
                VC.isglobe=YES;
                self.tabBarController.navigationController.navigationBar.hidden=NO;
                [self.tabBarController.navigationController pushViewController:VC animated:YES];
            }else{
                UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:nil message:@"您还没有通认证，请在身份认证申请认证" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertview show];
                //        ShowSpamContentViewController *doctorteam=[[ShowSpamContentViewController alloc]init];
                //        doctorteam.title=@"群发消息";
                //        //  doctorteam.isSpam=YES;
                //        self.tabBarController.navigationController.navigationBar.hidden=NO;
                //        [self.tabBarController.navigationController pushViewController:doctorteam animated:YES];
            }
            
            
        }else  if (indexPath.row==5) {
            PersonalSettingViewController *VC=[[PersonalSettingViewController alloc]init];
            
            
            [self.tabBarController.navigationController pushViewController:VC animated:YES];
            
            
        }else  if (indexPath.row==0){
            PubilcViewController *VC=[[PubilcViewController alloc]init];
            //VC.urslstr=[NSString stringWithFormat:@"http://192.168.1.117:8080/view/upload.html"];
            VC.urslstr=[NSString stringWithFormat:@"%@%@",k_webbaseurl,@"upload.html"];
           // @"http://rm.chengyisheng.com.cn:8080/app_web/app_doctor_web/view/authentication.html";
            
            [self.tabBarController.navigationController pushViewController:VC animated:YES];
            
        }else  if (indexPath.row==3){
            AddDoctorViewController *invitefriendsvc=[[AddDoctorViewController alloc]init];
            invitefriendsvc.isneedTimeLine=YES;
            invitefriendsvc.isfromPersonCenter=YES;
            // invitefriendsvc.title=@"Invite friends";
            //[self.navigationController pushViewController:invitefriendsvc animated:YES];
            [self.tabBarController.navigationController pushViewController:invitefriendsvc animated:YES];
          
        }else  if (indexPath.row==1){
            WalletViewController *VC=[[WalletViewController alloc]init];
           // VC.urslstr=[NSString stringWithFormat:@"http://192.168.1.117:8080/view/wallet.html"];
            VC.urslstr=[NSString stringWithFormat:@"%@%@",k_webbaseurl,@"wallet.html"];
            // @"http://rm.chengyisheng.com.cn:8080/app_web/app_doctor_web/view/authentication.html";
            
            [self.tabBarController.navigationController pushViewController:VC animated:YES];
            
        }else  if (indexPath.row==4){
//            WalletViewController *VC=[[WalletViewController alloc]init];
//            VC.urslstr=[NSString stringWithFormat:@"http://192.168.1.117:8080/view/wallet.html"];
//            // VC.urslstr=[NSString stringWithFormat:@"%@%@",k_webbaseurl,@"wallet.html"];
//            // @"http://rm.chengyisheng.com.cn:8080/app_web/app_doctor_web/view/authentication.html";
//            
//            [self.tabBarController.navigationController pushViewController:VC animated:YES];
//            MainTabBarController *tabbarVC=(MainTabBarController *)self.tabBarController;
//            tabbarVC.msgcount=@"12";
//            [self.tableView reloadData];
             [MobClick event:@"to_message"];
            MsgListWebViewController *VC=[[MsgListWebViewController alloc]init];
            VC.delegate=self;
           // VC.urslstr=[NSString stringWithFormat:@"http://192.168.1.117:8080/view/message.html"];
             VC.urslstr=[NSString stringWithFormat:@"%@%@",k_webbaseurl,@"message.html"];
            // @"http://rm.chengyisheng.com.cn:8080/app_web/app_doctor_web/view/authentication.html";
            
            [self.tabBarController.navigationController pushViewController:VC animated:YES];
            
            
            
            
        }
        
       //  MainTabBarController *tabbarVC=(MainTabBarController *)self.tabBarController;
      

        
        
    } else {
       
    }
}
-(void)MsgListWebMethodname:(NSString *)methodname stringval:(NSString *)stringval type:(NSInteger)type{
    NSLog(@"123");
    [[NSNotificationCenter defaultCenter]postNotificationName:@"haveSystemMsg" object:nil];
    [NotificationService getAllUnreadMessagesCountblock:^(id respdic) {
        NSDictionary *dic=(NSDictionary *)respdic;
        MainTabBarController *tabbarVC=(MainTabBarController *)self.tabBarController;
        
        if (![[[dic objectForKey:@"count"] stringValue] isEqualToString:@"0"]) {
            tabbarVC.msgcount=@"12";
            [[NSNotificationCenter defaultCenter]postNotificationName:@"haveSystemMsg" object:nil];
        }else{
            tabbarVC.msgcount=@"0";
            [[NSNotificationCenter defaultCenter]postNotificationName:@"haveSystemMsg" object:nil];
            
        }
        [self.tableView reloadData];
        
    }];
}
-(void)MsgWebdataMethodname:(NSString *)methodname stringval:(NSString *)stringval{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"haveSystemMsg" object:nil];
    [NotificationService getAllUnreadMessagesCountblock:^(id respdic) {
        NSDictionary *dic=(NSDictionary *)respdic;
        MainTabBarController *tabbarVC=(MainTabBarController *)self.tabBarController;

        if (![[[dic objectForKey:@"count"] stringValue] isEqualToString:@"0"]) {
            tabbarVC.msgcount=@"12";
            [[NSNotificationCenter defaultCenter]postNotificationName:@"haveSystemMsg" object:nil];
        }else{
            tabbarVC.msgcount=@"0";
            [[NSNotificationCenter defaultCenter]postNotificationName:@"haveSystemMsg" object:nil];
       
        }
        [self.tableView reloadData];
        
    }];
    
}

@end
