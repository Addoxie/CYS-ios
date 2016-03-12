//
//  PersonalSettingViewController.m
//  CYS
//
//  Created by 谢阳晴 on 16/2/1.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import "PersonalSettingViewController.h"
#import "SDImageCache.h"
#import "LogintocysViewController.h"

@interface PersonalSettingViewController (){
    NSMutableArray *imagearr;
    NSMutableArray *namearr;
     NSMutableArray *namearr1;
     NSMutableArray *namearr2;
    UILabel *phonelabel;
     UILabel *cachelabel;
}

@end


@implementation PersonalSettingViewController

-(void)viewDidLoad{
    [super viewDidLoad];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadindex:) name:@"reloadindex" object:nil];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updatephone:) name:@"updatephone" object:nil];
    phonelabel=[[UILabel alloc]init];
    phonelabel.text=[NSString stringWithFormat:@"%@",KGetDefaultstr(@"phonenum")];
    
     imagearr=[[NSMutableArray alloc]initWithArray:@[@"tmp",@"tmp",@"tmp",@"tmp",@"tmp",@"tmp"]];
     namearr=[[NSMutableArray alloc]initWithArray:@[@"修改密码",@"修改手机号"]];
     namearr1=[[NSMutableArray alloc]initWithArray:@[@"关于橙医生",@"功能介绍",@"服务协议",@"建议反馈",]];
     namearr2=[[NSMutableArray alloc]initWithArray:@[@"清理缓存"]];
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate=self;
    
    self.tableView.dataSource=self;
    self.title=@"设置";
   
    [self.view addSubview:self.tableView];
    
}
-(void)reloadindex:(NSNotification *)sender{
     phonelabel.text=[NSString stringWithFormat:@"%@",KGetDefaultstr(@"phonenum")];
    [self.tableView reloadData];
}
-(void)updatephone:(NSNotification *)sender{
    NSString *phonestr=(NSString *)sender.object;
    phonelabel.text=phonestr;
    [self.tableView reloadData];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    
    self.navigationController.navigationBar.hidden=NO;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden=YES;
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
   //
}
-(void)itemactionWithType:(NSInteger)typeindex{
    [self.navigationController popViewControllerAnimated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 50.0;
    } else {
        return 50.0;
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    if (section==0) {
        return 2;
    } else if (section==1) {
        return 3;
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
    UILabel *desclabel=[[UILabel alloc]init];
    desclabel.frame=CGRectMake(15, 0, 180, 50);
   
    desclabel.textAlignment=NSTextAlignmentLeft;
    desclabel.textColor=KBlackColor;
    desclabel.font=[UIFont boldSystemFontOfSize:16.0];
    desclabel.backgroundColor=[UIColor clearColor];
    [cell addSubview:desclabel];
    if (indexPath.section==0) {
         desclabel.text=[NSString stringWithFormat:@"%@",[namearr objectAtIndex:indexPath.row]];
        
        
        
        if (indexPath.row==1) {
            
            phonelabel.font=[UIFont systemFontOfSize:16.0];
            phonelabel.frame=CGRectMake(ScreenWidth-150, 0, 120, 50);
           
            phonelabel.textColor=KBlackColor;
            phonelabel.backgroundColor=[UIColor clearColor];
            [cell addSubview:phonelabel];

        }
        
        
        
        
        
    } else if (indexPath.section==1) {
         desclabel.text=[NSString stringWithFormat:@"%@",[namearr1 objectAtIndex:indexPath.row]];
    }else if (indexPath.section==2){
         desclabel.text=[NSString stringWithFormat:@"%@",[namearr2 objectAtIndex:indexPath.row]];
        
    }else if (indexPath.section==3){
        desclabel.frame=CGRectMake(0, 0, ScreenWidth, 50);
        
        desclabel.textAlignment=NSTextAlignmentCenter;

        desclabel.text=[NSString stringWithFormat:@"%@",@"退出登录"];
        
    }
    
    if (indexPath.section==2) {
        cachelabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-100, 10, 120, 30)];
        cachelabel.text=[NSString stringWithFormat:@"%.2f M",[[SDImageCache sharedImageCache] checkTmpSize]];
        cachelabel.textColor=kimiColor(76, 210, 100, 1);
        [cell addSubview:cachelabel];

    }
    if (indexPath.section!=3){
        
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

        
    }
    
    
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
        if (indexPath.row==0) {
            UpdatePasswordViewController *VC=[[UpdatePasswordViewController alloc]init];
            
            VC.isEnterOldPW=YES;
            
            [self.navigationController pushViewController:VC animated:YES];
        } else {
            UpdatePhoneViewController *VC=[[UpdatePhoneViewController alloc]init];
            
            VC.isGetCode=YES;
            
            [self.navigationController pushViewController:VC animated:YES];

            
        }
        
        
        
    } else if (indexPath.section==1) {
        
        
        if (indexPath.row==0) {
            SettingWebViewController *VC=[[SettingWebViewController alloc]init];
            VC.urslstr=[NSString stringWithFormat:@"%@%@",k_webbaseurl,@"aboutUs.html"];
            VC.title=@"关于橙医生";
            // @"http://rm.chengyisheng.com.cn:8080/app_web/app_doctor_web/view/authentication.html";
            
            [self.navigationController pushViewController:VC animated:YES];

        } else if (indexPath.row==1) {
            
            SettingWebViewController *VC=[[SettingWebViewController alloc]init];
            VC.urslstr=[NSString stringWithFormat:@"%@%@",k_webbaseurl,@"functionIntroduction.html"];
              VC.title=@"功能介绍";
            // @"http://rm.chengyisheng.com.cn:8080/app_web/app_doctor_web/view/authentication.html";
            
            [self.navigationController pushViewController:VC animated:YES];

        } else if (indexPath.row==2) {
            
            SettingWebViewController *VC=[[SettingWebViewController alloc]init];
            VC.urslstr=[NSString stringWithFormat:@"%@%@",k_webbaseurl,@"serviceAgreement.html"];
            VC.title=@"服务协议";
            // @"http://rm.chengyisheng.com.cn:8080/app_web/app_doctor_web/view/authentication.html";
            
            [self.navigationController pushViewController:VC animated:YES];

        } else if (indexPath.row==3) {
            SettingWebViewController *VC=[[SettingWebViewController alloc]init];
            VC.urslstr=[NSString stringWithFormat:@"%@%@",k_webbaseurl,@"authentication.html"];
            // @"http://rm.chengyisheng.com.cn:8080/app_web/app_doctor_web/view/authentication.html";
            
            [self.navigationController pushViewController:VC animated:YES];

            
        }
        

        
        
    }else if (indexPath.section==2){
        NSURLCache * cache = [NSURLCache sharedURLCache];
        [cache removeAllCachedResponses];
        [cache setDiskCapacity:0];
        [cache setMemoryCapacity:0];
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
        //        for(NSHTTPCookie *cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
        //
        //            if([[cookie domain] isEqualToString:someNSStringUrlDomain]) {
        //
        //                [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
        //            }
        //        }
        [[SDImageCache sharedImageCache] clearDisk];
        [[SDImageCache sharedImageCache] clearMemory];
        [[SDImageCache sharedImageCache] clearDisk];
        [[SDImageCache sharedImageCache] clearMemory];
        [[RCIMClient sharedRCIMClient]clearMessages:ConversationType_GROUP targetId:nil];
         [[RCIMClient sharedRCIMClient]clearMessages:ConversationType_PRIVATE targetId:nil];
        //[self.tableView reloadData];
        cachelabel.text=[NSString stringWithFormat:@"0.00 M"];
        [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
        [[PublicTools shareInstance]creareNotificationUIView:@"缓存已清理"];
        
        
    }else if (indexPath.section==3){
      
        
        JGProgressHUD *hud=[[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleDark];
        [hud showInView:self.view];

        [APPRegDataService logoutactionblock:^(id respdic) {
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"已注销"];
            
            [hud dismiss];
            
            LogintocysViewController *cysloginvc=[[LogintocysViewController alloc]init];
            cysloginvc.title=@"登录";
            UINavigationController*cysloginnav=[[UINavigationController alloc]initWithRootViewController:cysloginvc];
            [self presentViewController:cysloginnav animated:YES completion:nil];

        }];
        
        
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
        NSArray *tmparr=[[NSMutableArray alloc]initWithArray:[[RCIMClient sharedRCIMClient]getConversationList:@[@(ConversationType_PRIVATE)]]];
        
        for (RCConversation *cov in tmparr) {
            [[RCIMClient sharedRCIMClient]clearMessages:ConversationType_PRIVATE targetId:cov.targetId];
            [[RCIMClient sharedRCIMClient]removeConversation:ConversationType_PRIVATE targetId:cov.targetId];
        }
        
        NSArray *tmparr1=[[NSMutableArray alloc]initWithArray:[[RCIMClient sharedRCIMClient]getConversationList:@[@(ConversationType_GROUP)]]];
        
        for (RCConversation *cov in tmparr1) {
            [[RCIMClient sharedRCIMClient]clearMessages:ConversationType_GROUP targetId:cov.targetId];
            [[RCIMClient sharedRCIMClient]removeConversation:ConversationType_GROUP targetId:cov.targetId];
        }
        
        [[RCIM sharedRCIM]disconnect];
        [[UserDB shareInstance]deleteAll];
        [[UserDB shareInstance]deleteAllmsg];
        
        
        

        
    }
    
    
    
    
    
    
    
    
}

@end
