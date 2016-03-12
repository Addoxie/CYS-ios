//
//  InviteMessageListViewController.m
//  CYS
//
//  Created by 谢阳晴 on 16/2/1.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import "InviteMessageListViewController.h"


@interface InviteMessageListViewController ()

@end

@implementation InviteMessageListViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.title=@"受邀信息";
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.separatorColor=[UIColor clearColor];
    
    [DocTeamDataService getAllInvitationsblock:^(id responsearr2) {
        NSMutableArray *invitationarr=(NSMutableArray *)responsearr2;
       
        _invitationarr=invitationarr;
        [self.tableView reloadData];
        
}];
    [self.view addSubview:self.tableView];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _invitationarr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * cellName = @"UITableViewCell";
    
    
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    
    for (UIView *subv in cell.subviews) {
        [subv removeFromSuperview];
    }
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    NSDictionary *dic=(NSDictionary *)[self.invitationarr objectAtIndex:indexPath.row];
    
    NSLog(@"%@",dic);
    UIImageView *imagev;
    //=[[UIImageView alloc]init];
    
    
    imagev =[[UIImageView alloc]initWithFrame:CGRectMake(10, 32-25, 50, 50)];
    //   imagev.frame=CGRectMake(10, 8, 44, 44);
    
    
    
    imagev.clipsToBounds=YES;
    
    imagev.layer.masksToBounds=YES;
    imagev.layer.cornerRadius =22.0;
    imagev.layer.borderColor = [UIColor clearColor].CGColor;
    imagev.layer.rasterizationScale = [UIScreen mainScreen].scale;
    [imagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@""]] placeholderImage:[UIImage imageNamed:kPlaceholderimage]];
    [cell addSubview:imagev];
    
    
    
    UILabel *label=[[UILabel alloc]init];
    label.frame=CGRectMake(65, 32-25, 120, 25);
    label.textColor=KBlackColor;
    label.textAlignment=NSTextAlignmentLeft;
    label.font=[UIFont systemFontOfSize:18.0];
    // label.backgroundColor=[UIColor whiteColor];
    [cell addSubview:label];
    label.text=[[[dic objectForKey:@"team"] objectForKey:@"owner"] objectForKey:@"name"]?[NSString stringWithFormat:@"%@",[[[dic objectForKey:@"team"] objectForKey:@"owner"] objectForKey:@"name"]]:@"";
    
    
    
    UILabel *desclabel=[[UILabel alloc]init];
    
    desclabel.frame=CGRectMake(65, 32-25+25, 180,25);
    desclabel.textColor=KtextGrayColor;
    desclabel.font=[UIFont systemFontOfSize:15.0];
    desclabel.textAlignment=NSTextAlignmentLeft;
    // desclabel.backgroundColor=[UIColor whiteColor];
    [cell addSubview:desclabel];
    desclabel.text=[NSString stringWithFormat:@"邀请您加入%@团队",[[dic objectForKey:@"team"] objectForKey:@"name"]];
    
    UIButton *invitebutton=[[UIManager shareInstance]getbuttonWithtitle:@"" theFrame:CGRectMake(ScreenWidth-65, 64/2.0-25/2.0, 45, 25) theButtonImage:nil];
    NSLog(@"%@",[dic objectForKey:@"status"]);
    
    [invitebutton setTitle:@"加入" forState:UIControlStateNormal];
    
    invitebutton.layer.cornerRadius=4.0;
    
    invitebutton.tag=indexPath.row;
    invitebutton.backgroundColor=KlightOrangeColor;
    [invitebutton addTarget:self action:@selector(inviteactioin:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell addSubview:invitebutton];
    
    
    
    if (indexPath.row!=_invitationarr.count-1) {
        
        UIView *linev=[[UIView alloc]initWithFrame:CGRectMake(65, 63.3, ScreenWidth-65, 0.7)];
        linev.backgroundColor=KLineColor;
        [cell addSubview:linev];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
    

}
-(void)inviteactioin:(UIButton *)button{
    NSDictionary *dic=(NSDictionary *)[self.invitationarr objectAtIndex:button.tag];
    [DocTeamDataService docconfirminginvitationWithteamId:[dic objectForKey:@"team_id"] block:^(id respdic) {
       // [button setTitle:@"已加入" forState:UIControlStateNormal];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"reloaddocteam" object:nil];
        button.backgroundColor=[UIColor whiteColor];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        button.userInteractionEnabled=NO;
        [self regetdata];
        
    }];

}

-(void)regetdata{
    
    [DocTeamDataService getAllInvitationsblock:^(id responsearr2) {
        NSMutableArray *invitationarr=(NSMutableArray *)responsearr2;
            
        _invitationarr=invitationarr;
        [self.tableView reloadData];
        
                
                
    }];
            
    
    
}


@end
