//
//  RCDPrivateViewController.m
//  RCloudMessage
//
//  Created by Liv on 15/4/21.
//  Copyright (c) 2015年 RongCloud. All rights reserved.
//

#import "RCDPrivateSettingViewController.h"

@interface RCDPrivateSettingViewController ()

@end

@implementation RCDPrivateSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView=[UIView new];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 6, 87, 23);
    UIImageView *backImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back"]];
    backImg.frame = CGRectMake(-10, 1, 11, 20);
    [backBtn addSubview:backImg];
    UILabel *backText = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 85, 22)];
    backText.text = @"返回";//NSLocalizedStringFromTable(@"Back", @"RongCloudKit", nil);
    backText.font = [UIFont boldSystemFontOfSize:17];
    [backText setBackgroundColor:[UIColor clearColor]];
    [backText setTextColor:KlightOrangeColor];
    [backBtn addSubview:backText];
    [backBtn addTarget:self action:@selector(leftBarButtonItemPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    [self.navigationItem setLeftBarButtonItem:leftButton];

    // Do any additional setup after loading the view.
}
-(void)leftBarButtonItemPressed:(UIButton *)buttom{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.defaultCells[indexPath.row];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //覆盖父类实现，什么也不做
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
