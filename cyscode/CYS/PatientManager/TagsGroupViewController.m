//
//  TagsGroupViewController.m
//  CYS
//
//  Created by 谢阳晴 on 16/1/13.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import "TagsGroupViewController.h"


@interface TagsGroupViewController ()
@property(nonatomic,retain)NSMutableArray *dataarr;

@end

@implementation TagsGroupViewController
    


-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor=KBackgroundColor;
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;

    // self.tableView.separatorColor=[UIColor clearColor];
    
    
    [self.view addSubview:self.tableView];

    
    
    
    JGProgressHUD *HUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
    [HUD showInView:self.view];
    [HUD dismissAfterDelay:3.0];
    
    [PatientDataService getPatientCountofDoctorTagsblock:^(id respdataarr) {
        [HUD dismiss];
        self.dataarr=[[NSMutableArray alloc]initWithArray:respdataarr];
        [self.tableView reloadData];
        [self.tableView setEditing:YES];
       

    }];
    
    [self setrightbutton];
}
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}
-(void)setrightbutton{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    // UIEdgeInsets inset   = UIEdgeInsetsMake(0, -15, 0, 0);
    // leftButton.contentEdgeInsets = inset;
    rightButton.frame = CGRectMake(-20, 0, 40, 40);
    // [leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [rightButton setTitle:@"保存" forState:UIControlStateNormal];
    [rightButton setTitleColor:KlightOrangeColor forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [rightButton addTarget:self action:@selector(saveall) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = backItem;
}
-(void)back:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)saveall{
    //保存标签
    NSMutableArray *orderarr=[[NSMutableArray alloc]init];
    for (NSDictionary *dic in self.dataarr) {
        [orderarr addObject:[[dic objectForKey:@"tag"] objectForKey:@"id"]];
    }
    
    JGProgressHUD *HUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
    [HUD showInView:self.view];
    [HUD dismissAfterDelay:3.0];
    [PatientDataService orderTagWithTags:orderarr block:^(id respdic) {
       
        [HUD dismiss];
        [self.delegate reloanewtagsdata];
        [self.navigationController popViewControllerAnimated:YES];
    }];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataarr.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=nil;
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"myviewcell"];
    }
    
    NSDictionary *dic=(NSDictionary *)[self.dataarr objectAtIndex:indexPath.row];
    cell.textLabel.text =[[dic objectForKey:@"tag"] objectForKey:@"tag"];
    
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor whiteColor];
    return cell;
}
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    //    需要的移动行
    NSInteger fromRow = [sourceIndexPath row];
    //    获取移动某处的位置
    NSInteger toRow = [destinationIndexPath row];
    //    从数组中读取需要移动行的数据
    id object = [self.dataarr objectAtIndex:fromRow];
    //    在数组中移动需要移动的行的数据
    [self.dataarr removeObjectAtIndex:fromRow];
    //    把需要移动的单元格数据在数组中，移动到想要移动的数据前面
    [self.dataarr insertObject:object atIndex:toRow];
    
    
}

@end
