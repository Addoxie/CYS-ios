//
//  HXViewController.m
//  HXTagsView
//
//  Created by 黄轩 on 16/1/14.
//  Copyright © 2016年 IT小子. All rights reserved.
//

#import "HXViewController.h"

#import "CutomUIButton.h"

@interface HXViewController (){
    UIScrollView *scrollview;
  
    UITextField *tagtextfield;
    
    UIButton *morebutton;
}

@end

@implementation HXViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        self.selectedArray = [[NSMutableArray alloc] init];
        self.optionalArray = [[NSMutableArray alloc] init];
        }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    tagtextfield=[[UITextField alloc] init];
    tagtextfield.delegate=self;
    
    self.view.backgroundColor=KBackgroundColor;
//    NSDictionary *dic=[[NSDictionary alloc]initWithObjectsAndKeys:@"橙医生",@"tag", nil];
//    _selectedArray =[[NSMutableArray alloc]initWithArray:@[dic]];
//    
//    _optionalArray =[[NSMutableArray alloc]initWithArray:@[dic]];
    
    

    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 10, ScreenWidth, ScreenHeight-20) style:UITableViewStyleGrouped] ;
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.separatorColor=[UIColor clearColor];
    self.tableView.backgroundColor=KBackgroundColor;
     //     optionaltagsView = [[HXTagsView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 0)];
//     selectedtagsView = [[HXTagsView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 0)];

    [self.view addSubview:self.tableView];
    
    self.title = @"标签";
    
    
    
    morebutton=[UIButton buttonWithType:UIButtonTypeCustom];
    morebutton.frame=CGRectMake(ScreenWidth-51, 29, 45, 30);
    
    [morebutton setTitle:@"保存" forState:UIControlStateNormal];
    //[canclebutton setImage:[UIImage imageNamed:@"backArrow.png"] forState:UIControlStateNormal];
    //[morebutton setImage:[UIImage imageNamed:@"tmp"] forState:UIControlStateNormal];
    [morebutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [morebutton addTarget:self action:@selector(morebuttonaction) forControlEvents:UIControlEventTouchUpInside];
    morebutton.hidden=YES;
   
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:morebutton];

    
    JGProgressHUD *hud=[[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleDark];
    [hud showInView:self.view];
    [hud dismissAfterDelay:5];
    [PatientDataService getPatientTagsWithPatientId:self.patientid block:^(id resparr) {
        NSArray *selectedArray=(NSArray *)resparr;
        
        
        
        //        NSArray *selectedArray = @[@"头条",@"热点"];
        //
        
        
        
        
        [PatientDataService getAlltagsblock:^(id resparr1) {
            [hud dismiss];
            NSMutableArray *optionalArray =[[NSMutableArray alloc]initWithArray:resparr1];
            for (NSDictionary * dic in selectedArray) {
                if ([optionalArray containsObject:dic]) {
                    [optionalArray removeObject:dic];
                }
            }
            
            
            
            
            
            [self.selectedArray addObjectsFromArray:selectedArray];
            [self.optionalArray addObjectsFromArray:optionalArray];
            // UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:vc];
            [self.tableView reloadData];
        }];
        
        
        //        NSArray *optionalArray = @[@"画报",@"跑步",@"值得买",@"酒香",@"LOL",@"社会"];
        
        
        
        
        
        
    }];

   
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
      return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        
        NSInteger ylocation=10;
        CutomUIButton *lastbtn=[CutomUIButton buttonWithType:UIButtonTypeCustom];
        for (NSInteger i=0;i<_selectedArray.count+1;i++) {
            
            
            
            if (i==_selectedArray.count) {
                
                
                
                if (lastbtn.frame.origin.x+lastbtn.frame.size.width+10+120+20<ScreenWidth) {
                    tagtextfield=[[UITextField alloc] init];
                    tagtextfield.delegate=self;
                    tagtextfield.backgroundColor=[UIColor whiteColor];
                    
                    tagtextfield.frame=CGRectMake(lastbtn.frame.origin.x+lastbtn.frame.size.width+10, ylocation+10, 120, 35);
                    tagtextfield.layer.cornerRadius=35/2.0;
                    tagtextfield.layer.borderWidth=1.0;
                    tagtextfield.returnKeyType=UIReturnKeyDone;
                    tagtextfield.leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 35)];
                    KtfAddpaddingView(tagtextfield);
                    tagtextfield.tintColor=KlightOrangeColor;
                    tagtextfield.layer.borderColor=KLineColor.CGColor;
                    //        [tagtextfield setTitle:@"添加标签" forState:UIControlStateNormal];
                    tagtextfield.placeholder=@"请输入标签";
                    // tagtextfield.section=indexPath.row;
                    
                    // [addtagbtn addTarget:self action:@selector(addtagbtnaction) forControlEvents:UIControlEventTouchUpInside];
                    
                    
                   // [cell addSubview:tagtextfield];
                    
                } else {
                    
                    
                    ylocation=ylocation+45;
                    
                    
                    tagtextfield=[[UITextField alloc] init];
                    tagtextfield.delegate=self;
                    tagtextfield.backgroundColor=[UIColor whiteColor];
                    
                    tagtextfield.frame=CGRectMake(10, ylocation+10, 120, 35);
                    tagtextfield.layer.cornerRadius=35/2.0;
                    tagtextfield.layer.borderWidth=1.0;
                    tagtextfield.returnKeyType=UIReturnKeyDone;
                    tagtextfield.leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 35)];
                    KtfAddpaddingView(tagtextfield);
                    tagtextfield.tintColor=KlightOrangeColor;
                    tagtextfield.layer.borderColor=KLineColor.CGColor;
                    //        [tagtextfield setTitle:@"添加标签" forState:UIControlStateNormal];
                    tagtextfield.placeholder=@"请输入标签";
                    
                   // [cell addSubview:tagtextfield];
                }
                
                
                
                
                
                
                
                
                
                
                
                
            }else{
                
                
                
                
                NSString *btntitle = [[_selectedArray objectAtIndex:i] objectForKey:@"tag"];
                CGRect btnsize=KStringwSize(btntitle, 20, [UIFont systemFontOfSize:15]);
                if (lastbtn.frame.origin.x+lastbtn.frame.size.width+10+btnsize.size.width+20<ScreenWidth) {
                    CutomUIButton *btn=[CutomUIButton buttonWithType:UIButtonTypeCustom];
                    btn.backgroundColor=[UIColor clearColor];
                    btn.frame=CGRectMake(lastbtn.frame.origin.x+lastbtn.frame.size.width+10, ylocation+10, btnsize.size.width+20, 35);
                    btn.tag=i+1000000;
                    btn.layer.cornerRadius=35/2.0;
                    [btn setTitle:btntitle forState:UIControlStateNormal];
                    [btn setTitleColor:KlightOrangeColor forState:UIControlStateNormal];
                    btn.titleLabel.font=[UIFont systemFontOfSize:15];
                    btn.section=indexPath.row;
                    btn.layer.borderWidth=1.0;
                    btn.layer.borderColor=KLineColor.CGColor;
                    [btn addTarget:self action:@selector(btnaction:) forControlEvents:UIControlEventTouchUpInside];
                    lastbtn=btn;
                    
                  //  [cell addSubview:btn];
                } else {
                    ylocation=ylocation+45;
                    
                    CutomUIButton *btn=[CutomUIButton buttonWithType:UIButtonTypeCustom];
                    btn.frame=CGRectMake(10, ylocation+10, btnsize.size.width+20, 35);
                    [btn setTitle:btntitle forState:UIControlStateNormal];
                    btn.backgroundColor=[UIColor clearColor];
                    btn.tag=i+1000000;
                    btn.layer.cornerRadius=35/2.0;
                    btn.titleLabel.font=[UIFont systemFontOfSize:15];
                    [btn setTitleColor:KlightOrangeColor forState:UIControlStateNormal];
                    btn.section=indexPath.row;
                    btn.layer.borderWidth=1.0;
                    btn.layer.borderColor=KLineColor.CGColor;
                    [btn addTarget:self action:@selector(btnaction:) forControlEvents:UIControlEventTouchUpInside];
                    lastbtn=btn;
                   // [cell addSubview:btn];
                    
                    
                }
                
            }
            
        }
        
        
        
        return ylocation+50+10;
    } else {
        
        
        NSInteger ylocation=10;
        UIButton *lastbtn=[UIButton buttonWithType:UIButtonTypeCustom];
        for (NSInteger i=0;i<_optionalArray.count;i++) {
            NSString *btntitle = [[_optionalArray objectAtIndex:i] objectForKey:@"tag"];
            CGRect btnsize=KStringwSize(btntitle, 35, [UIFont systemFontOfSize:15]);
            if (lastbtn.frame.origin.x+lastbtn.frame.size.width+10+btnsize.size.width+20<ScreenWidth) {
                UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
                btn.backgroundColor=KlightOrangeColor;
                btn.frame=CGRectMake(lastbtn.frame.origin.x+lastbtn.frame.size.width+10, ylocation+10, btnsize.size.width+20, 35);
                btn.tag=i+2000000;
                btn.layer.cornerRadius=35/2.0;
                btn.layer.borderColor=KLightLineColor.CGColor;
                [btn setTitle:btntitle forState:UIControlStateNormal];
                lastbtn=btn;
             //   [cell addSubview:btn];
            } else {
                ylocation=ylocation+45;
                
                UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame=CGRectMake(10, ylocation+10, btnsize.size.width+20, 35);
                [btn setTitle:btntitle forState:UIControlStateNormal];
                btn.backgroundColor=KlightOrangeColor;
                btn.layer.cornerRadius=35/2.0;
                btn.layer.borderColor=KLightLineColor.CGColor;
                btn.tag=i+2000000;
                lastbtn=btn;
              //  [cell addSubview:btn];
                
                
            }
            
            
            
        }

        
       return ylocation+50;
     
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=nil;
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"myviewcell"];
    }
    if (indexPath.row==0) {
        UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 20)];
        titleLable.text = @"已选标签";
        titleLable.textColor=KBlackColor;
        titleLable.font=[UIFont systemFontOfSize:13];
        [cell addSubview:titleLable];
        
        NSInteger ylocation=10;
        CutomUIButton *lastbtn=[CutomUIButton buttonWithType:UIButtonTypeCustom];
        for (NSInteger i=0;i<_selectedArray.count+1;i++) {
            
            
            
            if (i==_selectedArray.count) {
                
                
                
                if (lastbtn.frame.origin.x+lastbtn.frame.size.width+10+120+20<ScreenWidth) {
//                    tagtextfield=[[UITextField alloc] init];
//                    tagtextfield.delegate=self;
                    tagtextfield.backgroundColor=[UIColor whiteColor];
                    
                    tagtextfield.frame=CGRectMake(lastbtn.frame.origin.x+lastbtn.frame.size.width+10, ylocation+10, 120, 35);
                    tagtextfield.layer.cornerRadius=35/2.0;
                   // tagtextfield.layer.borderWidth=1.0;
                    tagtextfield.returnKeyType=UIReturnKeyDone;
                    tagtextfield.leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 35)];
                    KtfAddpaddingView(tagtextfield);
                    tagtextfield.tintColor=KlightOrangeColor;
                   // tagtextfield.layer.borderColor=KLineColor.CGColor;
                    //        [tagtextfield setTitle:@"添加标签" forState:UIControlStateNormal];
                    tagtextfield.placeholder=@"请输入标签";
                    // tagtextfield.section=indexPath.row;
                    
                    // [addtagbtn addTarget:self action:@selector(addtagbtnaction) forControlEvents:UIControlEventTouchUpInside];
                    
                    
                    [cell addSubview:tagtextfield];

                  } else {
                      
                      
                      ylocation=ylocation+45;
                      
                      
                     
                      tagtextfield.backgroundColor=[UIColor whiteColor];
                      
                      tagtextfield.frame=CGRectMake(10, ylocation+10, 120, 35);
                      tagtextfield.layer.cornerRadius=35/2.0;
                      //tagtextfield.layer.borderWidth=1.0;
                      tagtextfield.returnKeyType=UIReturnKeyDone;
                      tagtextfield.leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 35)];
                      KtfAddpaddingView(tagtextfield);
                      tagtextfield.tintColor=KlightOrangeColor;
                    //  tagtextfield.layer.borderColor=KLineColor.CGColor;
                      //        [tagtextfield setTitle:@"添加标签" forState:UIControlStateNormal];
                      tagtextfield.placeholder=@"请输入标签";

                    [cell addSubview:tagtextfield];
                }

                
               
                
                
                
                
                
                
                
                
                
            }else{
                
                
                
                
                NSString *btntitle = [[_selectedArray objectAtIndex:i] objectForKey:@"tag"];
                CGRect btnsize=KStringwSize(btntitle, 20, [UIFont systemFontOfSize:15]);
                if (lastbtn.frame.origin.x+lastbtn.frame.size.width+10+btnsize.size.width+20<ScreenWidth) {
                    CutomUIButton *btn=[CutomUIButton buttonWithType:UIButtonTypeCustom];
                    btn.backgroundColor=[UIColor clearColor];
                    btn.frame=CGRectMake(lastbtn.frame.origin.x+lastbtn.frame.size.width+10, ylocation+10, btnsize.size.width+20, 35);
                    btn.tag=i+1000000;
                    btn.layer.cornerRadius=35/2.0;
                    [btn setTitle:btntitle forState:UIControlStateNormal];
                    [btn setTitleColor:KlightOrangeColor forState:UIControlStateNormal];
                    btn.layer.masksToBounds = YES;
                    btn.titleLabel.font=[UIFont systemFontOfSize:15];
                    btn.section=indexPath.row;
                    btn.layer.borderWidth=1.0;
                    btn.layer.borderColor=KLineColor.CGColor;
                 //   [btn addTarget:self action:@selector(btnaction:) forControlEvents:UIControlEventTouchUpInside];
                    lastbtn=btn;
                    
                    [cell addSubview:btn];
                } else {
                    ylocation=ylocation+45;
                    
                    CutomUIButton *btn=[CutomUIButton buttonWithType:UIButtonTypeCustom];
                    btn.frame=CGRectMake(10, ylocation+10, btnsize.size.width+20, 35);
                    [btn setTitle:btntitle forState:UIControlStateNormal];
                    btn.backgroundColor=[UIColor clearColor];
                    btn.tag=i+1000000;
                     btn.layer.masksToBounds = YES;
                    btn.layer.cornerRadius=35/2.0;
                    btn.titleLabel.font=[UIFont systemFontOfSize:15];
                    [btn setTitleColor:KlightOrangeColor forState:UIControlStateNormal];
                    btn.section=indexPath.row;
                    btn.layer.borderWidth=1.0;
                    btn.layer.borderColor=KLineColor.CGColor;
                  //  [btn addTarget:self action:@selector(btnaction:) forControlEvents:UIControlEventTouchUpInside];
                    lastbtn=btn;
                    [cell addSubview:btn];
                    
                    
                }

            }
            
        }
        

    }else{
        cell.backgroundColor=KBackgroundColor;
        UILabel *titleLable1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 20)];
        titleLable1.text = @"可选标签";
        titleLable1.textColor=KBlackColor;
        
        titleLable1.font=[UIFont systemFontOfSize:13];
        [cell addSubview:titleLable1];
        
        
        NSInteger ylocation=10;
        CutomUIButton *lastbtn=[CutomUIButton buttonWithType:UIButtonTypeCustom];
        for (NSInteger i=0;i<_optionalArray.count;i++) {
            NSString *btntitle = [[_optionalArray objectAtIndex:i] objectForKey:@"tag"];
            CGRect btnsize=KStringwSize(btntitle, 20, [UIFont systemFontOfSize:15]);
            if (lastbtn.frame.origin.x+lastbtn.frame.size.width+10+btnsize.size.width+20<ScreenWidth) {
                CutomUIButton *btn=[CutomUIButton buttonWithType:UIButtonTypeCustom];
               // btn.backgroundColor=KlightOrangeColor;
                btn.frame=CGRectMake(lastbtn.frame.origin.x+lastbtn.frame.size.width+10, ylocation+10, btnsize.size.width+20, 35);
                btn.tag=i+2000000;
                btn.backgroundColor=[UIColor whiteColor];
                btn.layer.cornerRadius=35/2.0;
                [btn setTitle:btntitle forState:UIControlStateNormal];
                  btn.section=indexPath.row;
                 btn.titleLabel.font=[UIFont systemFontOfSize:15];
                [btn setTitleColor:KBlackColor forState:UIControlStateNormal];
                btn.layer.borderWidth=1.0;
                 btn.layer.masksToBounds = YES;
                btn.layer.borderColor=KLineColor.CGColor;
               // btn.layer.borderColor=KlightOrangeColor.CGColor;
                 [btn addTarget:self action:@selector(btnaction:) forControlEvents:UIControlEventTouchUpInside];
                lastbtn=btn;
                [cell addSubview:btn];
            } else {
                ylocation=ylocation+45;
                
                CutomUIButton *btn=[CutomUIButton buttonWithType:UIButtonTypeCustom];
                btn.frame=CGRectMake(10, ylocation+10, btnsize.size.width+20, 35);
                [btn setTitle:btntitle forState:UIControlStateNormal];
                btn.backgroundColor=[UIColor whiteColor];
                btn.layer.cornerRadius=35/2.0;
                btn.tag=i+2000000;
                 btn.titleLabel.font=[UIFont systemFontOfSize:15];
                btn.layer.borderColor=KLightLineColor.CGColor;
                [btn setTitleColor:KBlackColor forState:UIControlStateNormal];
                btn.layer.borderWidth=1.0;
                 btn.layer.masksToBounds = YES;
                btn.layer.borderColor=KLineColor.CGColor;

                  btn.section=indexPath.row;
                [btn addTarget:self action:@selector(btnaction:) forControlEvents:UIControlEventTouchUpInside];
                lastbtn=btn;
                [cell addSubview:btn];
                
                
            }
            
            
            
        }

   
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    NSLog(@"text::%@",textField.text);
    if (textField.text.length>0) {
        JGProgressHUD *hud=[[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleDark];
        [hud showInView:self.view];
        [hud dismissAfterDelay:5];
        [PatientDataService addTagWithTagstr:textField.text block:^(id respdic) {
            [hud dismiss];
            
            
            NSDictionary *tmpdic=(NSDictionary *)respdic;
            [self.selectedArray addObject:tmpdic];
            [self.tableView reloadData];
             textField.text=@"";
            
        
        }];
       
        
    }else{
        [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
        [[PublicTools shareInstance]creareNotificationUIView:@"标签不能为空"];
   
    }

    
    
    
    return YES;
}
//- (CGSize)buttonAutoCalculateRectWith:(NSString*)text FontSize:(CGFloat)fontSize MaxSize:(CGSize)maxSize
//
//
//
//{
//    
//    
//    
//    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc]init];
//    
//    
//    
//    paragraphStyle.lineBreakMode=NSLineBreakByWordWrapping;
//    
//    
//    
//    NSDictionary* attributes =@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],NSParagraphStyleAttributeName:paragraphStyle.copy};
//    
//    
//    
//    
//    
//  CGSize labelSize = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
////     CGSize labelSize =[text boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:font} context:nil];
//    
//    
//   // [paragraphStyle release];
//    
//    
//    
//    labelSize.height=ceil(labelSize.height);
//    
//    
//    
//    labelSize.width=ceil(labelSize.width);
//    
//    
//    
//    return labelSize;
//    
//    
//    
//}


-(void)addtagbtnaction{
   // NSDictionary *tmpdic=self.contents[commentmodel.section][commentmodel.row][0];
    TagsRenameViewController *vc = [[TagsRenameViewController alloc] init];
    vc.delegate=self;
    vc.isadd=YES;
//    vc.tagid=[[tmpdic objectForKey:@"tag"] objectForKey:@"id"];
//    vc.tagstr=[[tmpdic objectForKey:@"tag"] objectForKey:@"tag"];
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    morebutton.hidden=YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
     morebutton.hidden=NO;
}
-(void)addwithdic:(NSDictionary *)tagdic{
    }
-(void)btnaction:(CutomUIButton *)button{
    morebutton.hidden=NO;
    if (button.section==0) {
        [self.optionalArray addObject:[self.selectedArray objectAtIndex:button.tag-1000000]];
       // [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
         [self.selectedArray removeObjectAtIndex:button.tag-1000000];

    } else {
        [self.selectedArray addObject:[self.optionalArray objectAtIndex:button.tag-2000000]];
         [self.optionalArray removeObjectAtIndex:button.tag-2000000];
        //[self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];

        
    }
    [self.tableView reloadData];
}
-(void)morebuttonaction{
   
           JGProgressHUD *hud=[[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleDark];
        [hud showInView:self.view];
        [hud dismissAfterDelay:5];
        
        NSMutableArray *tmparr=[[NSMutableArray alloc]init];
        for (NSDictionary *dic in self.selectedArray) {
            [tmparr addObject:[dic objectForKey:@"tag"]];
        }
       
        
        [PatientDataService PatientAddTagsWithTags:tmparr PatientId:self.patientid block:^(id respdic) {
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"标签已更新"];
            [self.delegate reloadtagsdata];
            
            [self.navigationController popViewControllerAnimated:YES];
        }];

        
        
   

    
    
    
    
    
}


@end
