//
//  PriceUIViewController.m
//  CYS
//
//  Created by 谢阳晴 on 16/1/30.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import "PriceUIViewController.h"
#import "itemdetailbutton.h"

@interface PriceUIViewController (){
    UILabel *customitemlabel;
    itemdetailbutton *oldbutton;
    UILabel *freeitemlabel;
    itemdetailbutton *freesentbutton;
    
}

@end


@implementation PriceUIViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor=kimiColor(239, 239, 244, 1);
    if (self.ismonth) {
         self.title=@"包月咨询收费设置";
    } else {
        if (self.isIM) {
            self.title=@"图文咨询收费设置";
        }else{
            self.title=@"电话咨询收费设置";
        }
    }
  //  [self.navigationController.navigationBar setTranslucent:NO];
   
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
    
    NSLog(@"%@",[self.DataDic objectForKey:@"prices"]);
    self.dataArr=[[NSMutableArray alloc]initWithArray:[self.DataDic objectForKey:@"prices"]];
    
    freeitemlabel=[[UILabel alloc]initWithFrame:CGRectMake(40, 10, ScreenWidth-90, 34)];
    freeitemlabel.text=@" 不提供";

    freesentbutton=[itemdetailbutton buttonWithType:UIButtonTypeCustom];
    freesentbutton.frame=CGRectMake(10, 12, 30, 30);

    
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, desclabel.frame.origin.y+desclabel.frame.size.height+10, ScreenWidth, ScreenHeight-10-desclabel.frame.origin.y+desclabel.frame.size.height) style:UITableViewStyleGrouped];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
   
    [self.view addSubview:self.tableView];
    
    
    
    
    
    
    
    customitemlabel=[[UILabel alloc]initWithFrame:CGRectMake(45, 10, ScreenWidth-90, 34)];
//    if (self.currentpricestr) {
//        <#statements#>
//    }
    customitemlabel.text =@" 自由定价";
    
    self.tableView.sectionIndexColor = KLineColor;
    
    [self getdata];
    
    
    UIButton *morebutton=[UIButton buttonWithType:UIButtonTypeCustom];
    morebutton.frame=CGRectMake(ScreenWidth-51, 29, 45, 30);
    
    [morebutton setTitle:@"保存" forState:UIControlStateNormal];
    //[canclebutton setImage:[UIImage imageNamed:@"backArrow.png"] forState:UIControlStateNormal];
    //[morebutton setImage:[UIImage imageNamed:@"tmp"] forState:UIControlStateNormal];
    [morebutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [morebutton addTarget:self action:@selector(morebuttonaction) forControlEvents:UIControlEventTouchUpInside];
    //morebutton.hidden=YES;
    
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithCustomView:morebutton];
    
 //   self.navigationItem.rightBarButtonItem=item;
    
    
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 54.0;
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else if(section==1){
        NSLog(@"%@",self.dataArr);
        return self.dataArr.count+1;
        
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

//        UIImageView *imagev=[[UIImageView alloc]initWithFrame:CGRectMake(15, 14, 26,26)];
//        imagev.image=[UIImage imageNamed:@"tmp"];
//        [cell addSubview:imagev];
        
//        customitemlabel=[[UILabel alloc]initWithFrame:CGRectMake(15, 10, ScreenWidth-90, 34)];
//        customitemlabel.text=@" 自由定价";
        customitemlabel.textColor=KBlackColor;
        customitemlabel.font=[UIFont systemFontOfSize:16.0];
        // itemlabel.backgroundColor=KGreenColor;
        customitemlabel.textAlignment=NSTextAlignmentLeft;
        [cell addSubview:customitemlabel];
        
        
        
//        UIImageView *imagev1=[[UIImageView alloc]init];
//        //=[[UIImageView alloc]init];
//        imagev1.frame=CGRectMake(ScreenWidth-18, 54/2.0-8, 10, 16);
//        imagev1.image=[UIImage imageNamed:@"arrow"];
//        
//        imagev1.clipsToBounds=YES;
//        
//        imagev1.layer.masksToBounds=YES;
//        imagev1.layer.cornerRadius =4.0;
//        imagev1.layer.borderColor = [UIColor clearColor].CGColor;
//        imagev1.layer.rasterizationScale = [UIScreen mainScreen].scale;
//        
//        // imagev.image=[UIImage imageNamed:@"KAKA"];
//        //  NSLog(@"%@",[NSString stringWithFormat:@"%@",[datadic objectForKey:@"icon"]]);
//        
//        [cell addSubview:imagev1];

        
        
        
        
        
        
        
        
        
        
        
        //  NSLog(@"haha %@  %@",self.currentpricestr,[self.dataArr objectAtIndex:indexPath.row]);
      //  for (int i=0;i<self.dataArr.count;i++) {
//            NSString *defaultprice=[NSString stringWithFormat:@"%@",[self.dataArr objectAtIndex:i]];
        
        if (self.currentpricestr.length>0) {
            NSLog(@"%@",self.currentpricestr);
            NSLog(@"%@",self.dataArr);
            NSNumber *intcurrentpricestr=[[NSNumber alloc]initWithInt:[self.currentpricestr intValue]];
            if ([self.dataArr containsObject:intcurrentpricestr]) {
                NSLog(@"qw");
            }else if([self.currentpricestr isEqualToString:@"未开通"]){
                 NSLog(@"qw");
            }else{
                sentbutton.selected=YES;
                oldbutton=sentbutton;
                self.pricestr=self.currentpricestr;
                if (self.ismonth) {
                    if (self.isIM) {
                        customitemlabel.text=[NSString  stringWithFormat:@"%@%@",self.pricestr,@" 元/次(不限制图文咨询)"];
                    }else{
                        customitemlabel.text=[NSString  stringWithFormat:@"%@%@",self.pricestr,@" 元/次(不限制图文咨询)"];
                    }
                } else {
                    if (self.isIM) {
                        customitemlabel.text=[NSString  stringWithFormat:@"%@%@",self.pricestr,@" 元/次(25条咨询)"];
                    }else{
                        customitemlabel.text=[NSString  stringWithFormat:@"%@%@",self.pricestr,@" 元/次(25分钟咨询)"];
                    }
                }
            }

        }
             //     }
      
        
//        UILabel *masklabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-160, 10, 130, 34)];
//        masklabel.text=[NSString stringWithFormat:@"%@",@"未开通"];
//        masklabel.textColor=KLineColor;
//        masklabel.font=[UIFont systemFontOfSize:12.0];
//        // itemlabel.backgroundColor=KGreenColor;
//        masklabel.textAlignment=NSTextAlignmentRight;
//        [cell addSubview:masklabel];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

        
        
    }else if (indexPath.section==1){
        
        
        
        
        
//        UIImageView *imagev=[[UIImageView alloc]initWithFrame:CGRectMake(15, 14, 26,26)];
//        imagev.image=[UIImage imageNamed:@"tmp"];
//        [cell addSubview:imagev];
        

               if (indexPath.row==self.dataArr.count+1-1) {
                   
                   
                   
                   
                   freesentbutton.tag=indexPath.row;
                   freesentbutton.buttonlocation=indexPath.section;
                   freesentbutton.layer.masksToBounds = YES;
                   freesentbutton.layer.cornerRadius = 15.0;
                   freesentbutton.layer.borderWidth = 1.0;
                   freesentbutton.layer.borderColor = [[UIColor clearColor] CGColor];
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
                   
                   [freesentbutton setImage:[UIImage imageNamed:@"select_1"] forState:UIControlStateNormal];
                   [freesentbutton setImage:[UIImage imageNamed:@"select_2"] forState:UIControlStateSelected];
                   // [sentbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                   freesentbutton.backgroundColor=[UIColor whiteColor];
                   freesentbutton.section=indexPath.section;
                   [freesentbutton addTarget:self action:@selector(editaction:) forControlEvents:UIControlEventTouchUpInside];
                   [cell addSubview:freesentbutton];
                   

//                   if ([[NSString stringWithFormat:@"%@",self.currentpricestr] isEqualToString:@"未开通"]) {
//                       freesentbutton.selected=YES;
//                       oldbutton=freesentbutton;
//                   }
                   
                   
                   
                   
                   
                   
                   
            //freesentbutton.selected=YES;
           
            freeitemlabel.textColor=KBlackColor;
            freeitemlabel.font=[UIFont systemFontOfSize:16.0];
            // itemlabel.backgroundColor=KGreenColor;
            freeitemlabel.textAlignment=NSTextAlignmentLeft;
            [cell addSubview:freeitemlabel];
                   
                   
                   if ([[NSString stringWithFormat:@"%@",self.currentpricestr] isEqualToString:@"未开通"]) {
                       freesentbutton.selected=YES;
                       oldbutton=freesentbutton;
                   }
                   
          //            if (self.isaddshowall) {
//                sentbutton.hidden=YES;
//            }
//            
//
//            
//            
            

        }else{
            
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
            
      
           
            
            UILabel *itemlabel=[[UILabel alloc]initWithFrame:CGRectMake(45, 10, ScreenWidth-90, 34)];
            
            
            if (self.ismonth) {
                if (self.isIM) {
                    NSLog(@"haha %@  %@",self.currentpricestr,[self.dataArr objectAtIndex:indexPath.row]);
                    if ([[NSString stringWithFormat:@"%@",self.currentpricestr] isEqualToString: [NSString stringWithFormat:@"%@",[self.dataArr objectAtIndex:indexPath.row]]]) {
                        sentbutton.selected=YES;
                        oldbutton=sentbutton;
                    }

                    itemlabel.text=[NSString  stringWithFormat:@"%@%@",[self.dataArr objectAtIndex:indexPath.row],@" 元/次(不限制图文咨询)"];
                }else{
                    itemlabel.text=[NSString  stringWithFormat:@"%@%@",[self.dataArr objectAtIndex:indexPath.row],@" 元/次(不限制图文咨询)"];
                }
            } else {
               
                if (self.isIM) {
                     NSLog(@"haha %@  %@",self.currentpricestr,[self.dataArr objectAtIndex:indexPath.row]);
                    if ([[NSString stringWithFormat:@"%@",self.currentpricestr] isEqualToString: [NSString stringWithFormat:@"%@",[self.dataArr objectAtIndex:indexPath.row]]]) {
                        sentbutton.selected=YES;
                         oldbutton=sentbutton;
                    }
                    itemlabel.text=[NSString  stringWithFormat:@"%@%@",[self.dataArr objectAtIndex:indexPath.row],@" 元/次(25条咨询)"];
                }else{
                     NSLog(@"haha %@  %@",self.currentpricestr,[self.dataArr objectAtIndex:indexPath.row]);
                    if([[NSString stringWithFormat:@"%@",self.currentpricestr] isEqualToString: [NSString stringWithFormat:@"%@",[self.dataArr objectAtIndex:indexPath.row]]]) {
                        sentbutton.selected=YES;
                         oldbutton=sentbutton;
                    }
                    itemlabel.text=[NSString  stringWithFormat:@"%@%@",[self.dataArr objectAtIndex:indexPath.row],@" 元/次(25分钟咨询)"];
                }
            }
           
            
           
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

   
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0&&indexPath.row==0) {
        EnterPriceViewController *priceVC = [[EnterPriceViewController alloc]init];
        priceVC.delegate=self;
        priceVC.ismonth=self.ismonth;
        priceVC.isIM=self.isIM;
        priceVC.isglobe=self.isglobe;
        priceVC.maxPrice=[[self.DataDic objectForKey:@"max_price"] integerValue];
        [self.navigationController pushViewController:priceVC animated:YES];

    }
    
    
//    if (indexPath.section==1&&indexPath.row==5-1) {
//        
//        FreeDateViewController *priceVC = [[FreeDateViewController alloc]init];
//        priceVC.delegate=self;
//       
//        [self.navigationController pushViewController:priceVC animated:YES];
//        
//    }
    
    
    
}

-(void)sentFreedate:(NSString *)Freedate isoffer:(BOOL)isoffer{
    if (isoffer==YES) {
        freeitemlabel.text=[NSString stringWithFormat:@"%@ 免费",Freedate];
        
        [self.tableView reloadData];
        oldbutton.selected=NO;
        freesentbutton.selected=YES;
       // oldbutton.selected=NO;
    }
}
-(void)setCustomPrice:(NSString *)price{
    self.pricestr=price;
    self.currentpricestr=price;
    if (self.ismonth) {
        if (self.isIM) {
            customitemlabel.text=[NSString  stringWithFormat:@"%@%@",price,@" 元/次(不限制图文咨询)"];
        }else{
            customitemlabel.text=[NSString  stringWithFormat:@"%@%@",price,@" 元/次(不限制图文咨询)"];
        }
    } else {
        if (self.isIM) {
            customitemlabel.text=[NSString  stringWithFormat:@"%@%@",price,@" 元/次(25条咨询)"];
        }else{
            customitemlabel.text=[NSString  stringWithFormat:@"%@%@",price,@" 元/次(25分钟咨询)"];
        }
    }

    
    
}


-(void)editaction:(itemdetailbutton *)button{
   
    
    
    if (button.buttonlocation==0) {
        
        if ( [customitemlabel.text isEqualToString:@" 自由定价"]) {
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"请点击输入价格"];
            return;
        } else {
            button.selected=YES;
        }
        
    }else{
   
        button.selected=YES;
    }
    

    
    
    if (button==oldbutton) {
        
    } else {
        
        if (self.ismonth) {
            if (self.isIM) {
                if (button.buttonlocation==0) {
                    
                    if ( [customitemlabel.text isEqualToString:@" 自由定价"]) {
                        [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
                        [[PublicTools shareInstance]creareNotificationUIView:@"请点击输入价格"];
                    } else {
                        [OrderDataService setServicePriceWithServicetype:@"2" price:self.pricestr status:@"1" block:^(id respdic) {
                            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
                            [[PublicTools shareInstance]creareNotificationUIView:@"设置成功"];
                            [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadservice" object:nil];
                             [self.navigationController popViewControllerAnimated:YES];
                        }];
                    }
                    
                  
                    
                }else{
                    // itemlabel.text=[NSString  stringWithFormat:@"%@%@",[self.dataArr objectAtIndex:indexPath.row],@" 元/次(不限制图文咨询)"];
                    if (button.tag==self.dataArr.count) {
                        [OrderDataService setServicePriceWithServicetype:@"2" price:@"0" status:@"0" block:^(id respdic) {
                            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
                            [[PublicTools shareInstance]creareNotificationUIView:@"设置成功"];
                             [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadservice" object:nil];
                             [self.navigationController popViewControllerAnimated:YES];
                        }];
                        
                    }else{
                        [OrderDataService setServicePriceWithServicetype:@"2" price:[NSString  stringWithFormat:@"%@",[self.dataArr objectAtIndex:button.tag]] status:@"1" block:^(id respdic) {
                            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
                            [[PublicTools shareInstance]creareNotificationUIView:@"设置成功"];
                             [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadservice" object:nil];
                             [self.navigationController popViewControllerAnimated:YES];
                        }];
                    }
                }
            }else{
                //没有用的
                if (button.tag==self.dataArr.count-1) {
                    
                }else{
                    
                }
                // itemlabel.text=[NSString  stringWithFormat:@"%@%@",[self.dataArr objectAtIndex:indexPath.row],@" 元/次(不限制图文咨询)"];
            }
        } else {
            if (self.isIM) {
                if (button.buttonlocation==0) {
                    if ( [customitemlabel.text isEqualToString:@" 自由定价"]) {
                        [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
                        [[PublicTools shareInstance]creareNotificationUIView:@"请点击输入价格"];

                    } else {
                        [OrderDataService setServicePriceWithServicetype:@"0" price:self.pricestr status:@"1" block:^(id respdic) {
                            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
                            [[PublicTools shareInstance]creareNotificationUIView:@"设置成功"];
                             [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadservice" object:nil];
                             [self.navigationController popViewControllerAnimated:YES];
                        }];

                    }
                }else{
                    
                    if (button.tag==self.dataArr.count) {
                        [OrderDataService setServicePriceWithServicetype:@"0" price:@"0" status:@"0" block:^(id respdic) {
                            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
                            [[PublicTools shareInstance]creareNotificationUIView:@"设置成功"];
                             [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadservice" object:nil];
                             [self.navigationController popViewControllerAnimated:YES];
                        }];
                    }else{
                        [OrderDataService setServicePriceWithServicetype:@"0" price:[NSString  stringWithFormat:@"%@",[self.dataArr objectAtIndex:button.tag]] status:@"1" block:^(id respdic) {
                            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
                            [[PublicTools shareInstance]creareNotificationUIView:@"设置成功"];
                             [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadservice" object:nil];
                             [self.navigationController popViewControllerAnimated:YES];
                        }];
                        
                    }
                }
                // itemlabel.text=[NSString  stringWithFormat:@"%@%@",[self.dataArr objectAtIndex:indexPath.row],@" 元/次(25条咨询)"];
            }else{
                if (button.buttonlocation==0) {
                    if ( [customitemlabel.text isEqualToString:@" 自由定价"]) {
                        [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
                        [[PublicTools shareInstance]creareNotificationUIView:@"请点击输入价格"];

                    } else {
                        [OrderDataService setServicePriceWithServicetype:@"1" price:self.pricestr status:@"1" block:^(id respdic) {
                            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
                            [[PublicTools shareInstance]creareNotificationUIView:@"设置成功"];
                             [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadservice" object:nil];
                             [self.navigationController popViewControllerAnimated:YES];
                        }];
                    }
                   
                }else{
                    
                    if (button.tag==self.dataArr.count) {
                        [OrderDataService setServicePriceWithServicetype:@"1" price:@"0" status:@"0" block:^(id respdic) {
                            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
                            [[PublicTools shareInstance]creareNotificationUIView:@"设置成功"];
                             [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadservice" object:nil];
                             [self.navigationController popViewControllerAnimated:YES];
                        }];
                    }else{
                        [OrderDataService setServicePriceWithServicetype:@"1" price:[NSString  stringWithFormat:@"%@",[self.dataArr objectAtIndex:button.tag]] status:@"1" block:^(id respdic) {
                            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
                            [[PublicTools shareInstance]creareNotificationUIView:@"设置成功"];
                             [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadservice" object:nil];
                            [self.navigationController popViewControllerAnimated:YES];
                        }];
                        
                    }
                }
                
                // itemlabel.text=[NSString  stringWithFormat:@"%@%@",[self.dataArr objectAtIndex:indexPath.row],@" 元/次(25分钟咨询)"];
            }
        }
        

        
        
        
        
        
        
        oldbutton.selected=NO;
        oldbutton=button;
        
        
    }
    
}

@end
