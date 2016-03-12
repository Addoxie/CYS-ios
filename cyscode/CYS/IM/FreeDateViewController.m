//
//  FreeDateViewController.m
//  CYS
//
//  Created by 谢阳晴 on 16/2/2.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import "FreeDateViewController.h"
#import "itemdetailbutton.h"



@interface FreeDateViewController (){
    UILabel *customitemlabel;
    itemdetailbutton *oldbutton;
}

@end


@implementation FreeDateViewController
-(void)viewDidLoad{
    [super viewDidLoad];
      self.view.backgroundColor=kimiColor(239, 239, 244, 1);
  //  [self.navigationController.navigationBar setTranslucent:NO];
//    if (self.ismonth) {
//        self.title=@"包月咨询收费设置";
//    } else {
//        if (self.isIM) {
//            self.title=@"图文咨询收费设置";
//        }else{
//            self.title=@"电话咨询收费设置";
//        }
//    }
    
    
    self.title=@"免费咨询期设置";
//    UILabel *desclabel=[[UILabel alloc]init];
//    desclabel.frame=CGRectMake(15, 0, 180, 0);
//    
//    desclabel.textAlignment=NSTextAlignmentLeft;
//    desclabel.textColor=KBlackColor;
//    desclabel.font=[UIFont boldSystemFontOfSize:16.0];
//    desclabel.backgroundColor=[UIColor clearColor];
//    desclabel.numberOfLines=0;
//    
//    desclabel.text=@"设置免费咨询天数，到期后，需要付咨询费才可以向您咨询";
//    [desclabel sizeToFit];
//    
    
    
    self.view.backgroundColor=kimiColor(239, 239, 244, 1);
    
    
    UILabel *desclabel=[[UILabel alloc]init];
    desclabel.text=@"设置免费咨询天数\n到期后，需要付咨询费才可以向您咨询";
    desclabel.frame=CGRectMake(15, 10+64, ScreenWidth-30, 0);
    
    desclabel.textAlignment=NSTextAlignmentLeft;
    desclabel.textColor=kimiColor(153, 153, 153, 1);
    desclabel.font=[UIFont systemFontOfSize:16.0];
    desclabel.backgroundColor=[UIColor clearColor];
    desclabel.numberOfLines=0;
    
    [desclabel setLineBreakMode: UILineBreakModeCharacterWrap];
    
    
    [desclabel sizeToFit];
    
    [self.view addSubview:desclabel];
    

    
    
    
     self.dataArr=[[NSMutableArray alloc]initWithArray:[self.DataDic objectForKey:@"periods"]];
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, desclabel.frame.origin.y+desclabel.frame.size.height+10, ScreenWidth, ScreenHeight-desclabel.frame.origin.y+desclabel.frame.size.height+10) style:UITableViewStyleGrouped];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
   // self.tableView.tableHeaderView=desclabel;
    [self.view addSubview:self.tableView];
    
    
    
    
    
    
    
    customitemlabel=[[UILabel alloc]initWithFrame:CGRectMake(65, 10, ScreenWidth-90, 34)];
    customitemlabel.text=@" 自由定价";
    
    self.tableView.sectionIndexColor = KLineColor;
    
    [self getdata];
    
    
//    UIButton *morebutton=[UIButton buttonWithType:UIButtonTypeCustom];
//    morebutton.frame=CGRectMake(ScreenWidth-51, 26, 45, 30);
//    
//    [morebutton setTitle:@"保存" forState:UIControlStateNormal];
//    //[canclebutton setImage:[UIImage imageNamed:@"backArrow.png"] forState:UIControlStateNormal];
//    //[morebutton setImage:[UIImage imageNamed:@"tmp"] forState:UIControlStateNormal];
//    [morebutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [morebutton addTarget:self action:@selector(morebuttonaction) forControlEvents:UIControlEventTouchUpInside];
//    //morebutton.hidden=YES;
//    
//    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithCustomView:morebutton];
//    
//    self.navigationItem.rightBarButtonItem=item;
    
    
    //  self.tabBar.selectedImageTintColor=KlightOrangeColor
    
    
    
    
    
    
}
-(void)getdata{
    if (self.isIM) {
        
    }else{
        
    }
}

-(void)morebuttonaction{
    
    
    
    [self.navigationController popViewControllerAnimated:YES];
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 54.0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
       return self.dataArr.count;
    }else if(section==1){
        return 2;
        
    }else{
        return 2;
        
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=nil;
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"usercell"];
    }
    
//    if (indexPath.section==0) {
//        
//        
//        
//        itemdetailbutton *sentbutton=[itemdetailbutton buttonWithType:UIButtonTypeCustom];
//        sentbutton.frame=CGRectMake(10, 12, 30, 30);
//        sentbutton.tag=indexPath.row;
//        sentbutton.buttonlocation=indexPath.section;
//        sentbutton.layer.masksToBounds = YES;
//        sentbutton.layer.cornerRadius = 15.0;
//        sentbutton.layer.borderWidth = 1.0;
//        sentbutton.layer.borderColor = [KlightOrangeColor CGColor];
//        //            if ([datadic objectForKey:@"selectstate"]) {
//        //                if ([[datadic objectForKey:@"selectstate"]isEqualToString:@"unselect"]) {
//        //                    // [sentbutton setImage:[UIImage imageNamed:@"tmp"] forState:UIControlStateNormal];
//        //                    sentbutton.selected=NO;
//        //                    sentbutton.havePressed=NO;
//        //                }else{
//        //
//        //                    sentbutton.selected=YES;
//        //                    sentbutton.havePressed=YES;
//        //                }
//        //            }
//        
//        [sentbutton setImage:[UIImage imageNamed:@"tmp"] forState:UIControlStateNormal];
//        [sentbutton setImage:[UIImage imageNamed:@"HAHA"] forState:UIControlStateSelected];
//        // [sentbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        sentbutton.backgroundColor=[UIColor whiteColor];
//        sentbutton.section=indexPath.section;
//        [sentbutton addTarget:self action:@selector(editaction:) forControlEvents:UIControlEventTouchUpInside];
//        [cell addSubview:sentbutton];
//        
//        //        UIImageView *imagev=[[UIImageView alloc]initWithFrame:CGRectMake(15, 14, 26,26)];
//        //        imagev.image=[UIImage imageNamed:@"tmp"];
//        //        [cell addSubview:imagev];
//        
//        //        customitemlabel=[[UILabel alloc]initWithFrame:CGRectMake(15, 10, ScreenWidth-90, 34)];
//        //        customitemlabel.text=@" 自由定价";
//        customitemlabel.textColor=KBlackColor;
//        customitemlabel.font=[UIFont systemFontOfSize:16.0];
//        // itemlabel.backgroundColor=KGreenColor;
//        customitemlabel.textAlignment=NSTextAlignmentLeft;
//        [cell addSubview:customitemlabel];
//        
//        //        UILabel *masklabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-160, 10, 130, 34)];
//        //        masklabel.text=[NSString stringWithFormat:@"%@",@"未开通"];
//        //        masklabel.textColor=KLineColor;
//        //        masklabel.font=[UIFont systemFontOfSize:12.0];
//        //        // itemlabel.backgroundColor=KGreenColor;
//        //        masklabel.textAlignment=NSTextAlignmentRight;
//        //        [cell addSubview:masklabel];
//        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
//        
//        
//        
//    }else if (indexPath.section==1){
        //        UIImageView *imagev=[[UIImageView alloc]initWithFrame:CGRectMake(15, 14, 26,26)];
        //        imagev.image=[UIImage imageNamed:@"tmp"];
        //        [cell addSubview:imagev];
        
        
        itemdetailbutton *sentbutton=[itemdetailbutton buttonWithType:UIButtonTypeCustom];
        sentbutton.frame=CGRectMake(10, 12, 30, 30);
        sentbutton.tag=indexPath.row;
        sentbutton.buttonlocation=indexPath.section;
        sentbutton.layer.masksToBounds = YES;
        sentbutton.layer.cornerRadius = 15.0;
        sentbutton.layer.borderWidth = 1.0;
        sentbutton.layer.borderColor = [[UIColor clearColor] CGColor];
        //            if ([datadic objectForKey:@"selectstate"]) {
        //                if ([[datadic objectForKey:@"selectstate"]isEqualToString:@"unselect"]) {
        //                    // [sentbutton setImage:[UIImage imageNamed:@"tmp"] forState:UIControlStateNormal];
        //                    sentbutton.selected=NO;
        //                    sentbutton.havePressed=NO;
        //                }else{
        //
        //                    sentbutton.selected=YES;
        //                    sentbutton.havePressed=YES;
        //                }
        //            }
        
        [sentbutton setImage:[UIImage imageNamed:@"select_1"] forState:UIControlStateNormal];
        [sentbutton setImage:[UIImage imageNamed:@"select_2"] forState:UIControlStateSelected];
        // [sentbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sentbutton.backgroundColor=[UIColor whiteColor];
        sentbutton.section=indexPath.section;
        [sentbutton addTarget:self action:@selector(editaction:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:sentbutton];
        
        if (indexPath.row==self.dataArr.count-1) {
            if([self.freestr isEqualToString:@"永不"]){
            sentbutton.selected=YES;
                oldbutton=sentbutton;
            }
           
            
            UILabel *itemlabel=[[UILabel alloc]initWithFrame:CGRectMake(45, 10, ScreenWidth-90, 34)];
            itemlabel.text=@" 永不";
            itemlabel.textColor=KBlackColor;
            itemlabel.font=[UIFont systemFontOfSize:16.0];
            // itemlabel.backgroundColor=KGreenColor;
            itemlabel.textAlignment=NSTextAlignmentLeft;
            [cell addSubview:itemlabel];
            //            if (self.isaddshowall) {
            //                sentbutton.hidden=YES;
            //            }
            //
            //
            //
            //
            
            
        }else{
            UILabel *itemlabel=[[UILabel alloc]initWithFrame:CGRectMake(45, 10, ScreenWidth-90, 34)];
            if([[[self.dataArr objectAtIndex:indexPath.row] stringValue] isEqualToString:@"未开通"]){
                sentbutton.selected=YES;
                oldbutton=sentbutton;
            }else if([[[self.dataArr objectAtIndex:indexPath.row] stringValue] isEqualToString:self.freestr]){
                sentbutton.selected=YES;
                oldbutton=sentbutton;
            }
             itemlabel.text=[NSString  stringWithFormat:@"%@天",[self.dataArr objectAtIndex:indexPath.row]];
//            if (self.ismonth) {
//                if (self.isIM) {
//                    itemlabel.text=[NSString  stringWithFormat:@"%@",@" 10元/次(不限制图文咨询)"];
//                }else{
//                    itemlabel.text=[NSString  stringWithFormat:@"%@",@" 10元/次(不限制图文咨询)"];
//                }
//            } else {
//                if (self.isIM) {
//                    itemlabel.text=[NSString  stringWithFormat:@"%@",@" 10元/次(25条咨询)"];
//                }else{
//                    itemlabel.text=[NSString  stringWithFormat:@"%@",@" 10元/次(25分钟咨询)"];
//                }
//            }
//            
            
            
            itemlabel.textColor=KBlackColor;
            itemlabel.font=[UIFont systemFontOfSize:16.0];
            // itemlabel.backgroundColor=KGreenColor;
            itemlabel.textAlignment=NSTextAlignmentLeft;
            [cell addSubview:itemlabel];
        }
        
        //        UILabel *itemlabel=[[UILabel alloc]initWithFrame:CGRectMake(45, 10, ScreenWidth-90, 34)];
        //        itemlabel.text=@" 10元/次(25条咨询)";
        //        itemlabel.textColor=[UIColor blackColor];
        //        itemlabel.font=[UIFont systemFontOfSize:16.0];
        //        // itemlabel.backgroundColor=KGreenColor;
        //        itemlabel.textAlignment=NSTextAlignmentLeft;
        //        [cell addSubview:itemlabel];
        
        //        UILabel *masklabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-160, 10, 130, 34)];
        //        masklabel.text=[NSString stringWithFormat:@"%@",@"未开通"];
        //        masklabel.textColor=KLineColor;
        //        masklabel.font=[UIFont systemFontOfSize:12.0];
        //        // itemlabel.backgroundColor=KGreenColor;
        //        masklabel.textAlignment=NSTextAlignmentRight;
        //        [cell addSubview:masklabel];
        //        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
        
    //}
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section==0&&indexPath.row==0) {
//        EnterPriceViewController *priceVC = [[EnterPriceViewController alloc]init];
//        priceVC.delegate=self;
//        priceVC.ismonth=self.ismonth;
//        priceVC.isIM=self.isIM;
//        [self.navigationController pushViewController:priceVC animated:YES];
//        
//    }
    
    
    
}


-(void)setCustomPrice:(NSString *)price{
    customitemlabel.text=price;
}


-(void)editaction:(itemdetailbutton *)button{
    button.selected=YES;
    if (button==oldbutton) {
        
    } else {
        oldbutton.selected=NO;
        oldbutton=button;
        
        
        if (button.tag==self.dataArr.count-1) {
            [OrderDataService setFreeServicefreeperiod:[NSString stringWithFormat:@"%@",@"-1"] block:^(id respdic) {
                
                [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
                [[PublicTools shareInstance]creareNotificationUIView:@"设置成功"];
                 [self.navigationController popViewControllerAnimated:YES];
            }];
             self.freestr=@"永不";
            [self.delegate sentFreedate:@"永不" isoffer:NO];
        }else{
            
            
            
            [self.delegate sentFreedate:[NSString stringWithFormat:@"%@天",[self.dataArr objectAtIndex:button.tag]] isoffer:YES];
            self.freestr=[[self.dataArr objectAtIndex:button.tag] stringValue];
            [self.tableView reloadData];

            [OrderDataService setFreeServicefreeperiod:[NSString stringWithFormat:@"%@",[self.dataArr objectAtIndex:button.tag]] block:^(id respdic) {
                [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
                [[PublicTools shareInstance]creareNotificationUIView:@"设置成功"];
                 [self.navigationController popViewControllerAnimated:YES];
            }];
        }

        
        
        
        
        
        
        
        
    }
   //    [self.navigationController popViewControllerAnimated:YES];
    
    
    
    
}
@end
