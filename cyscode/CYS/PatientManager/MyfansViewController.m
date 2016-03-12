//
//  MyfansViewController.m
//  CYS
//
//  Created by 谢阳晴 on 16/1/8.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import "MyfansViewController.h"
#import "itemdetailbutton.h"
#import "itemdetailbutton.h"

#import "ChineseString.h"


@interface MyfansViewController (){
    itemdetailbutton *oldbutton;
    UIView *masklineview;
    NSMutableArray * indexTitles;
    UIButton *morebutton;
   
    //@property (nonatomic, strong) BATableView *contactTableView;
   

}

 @property (nonatomic, strong) NSArray * dataSource;

@end

@implementation MyfansViewController

-(void)viewDidLoad{
   [super viewDidLoad];
    
   self.navigationController.navigationBar.hidden=NO;
   self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
   self.tableView.delegate=self;
   self.tableView.dataSource=self;
   [self.view addSubview:self.tableView];
    
    //区头索引字母的颜色
    
    
    self.tableView.sectionIndexColor = KLineColor;
    
    //索引的背景颜色
    
    
    self.tableView.sectionIndexBackgroundColor = [UIColor whiteColor];


//    itemdetailbutton *sentbutton=[itemdetailbutton buttonWithType:UIButtonTypeCustom];
//    sentbutton.frame=CGRectMake(0, 0, ScreenWidth/2.0, 60);
//    
//    
//  
//    [sentbutton setTitle:@"关注时间" forState:UIControlStateNormal];
//    
//    
//    sentbutton.tag=100;
//    
//    [sentbutton setTitleColor:KBlackColor forState:UIControlStateNormal];
//    [sentbutton setTitleColor:KlightOrangeColor forState:UIControlStateSelected];
//    
//    [sentbutton addTarget:self action:@selector(headaction:) forControlEvents:UIControlEventTouchUpInside];
//    sentbutton.backgroundColor=[UIColor whiteColor];
//    [self.view addSubview:sentbutton];
//    
//    sentbutton.selected=YES;
//    oldbutton=sentbutton;
//    
//    
//    
//    
//    
//    itemdetailbutton *sentbutton1=[itemdetailbutton buttonWithType:UIButtonTypeCustom];
//    sentbutton1.frame=CGRectMake(ScreenWidth/2.0, 0, ScreenWidth/2.0, 60);
// 
//    [sentbutton1 setTitle:@"姓名排序" forState:UIControlStateNormal];
//
//    //[sentbutton1 setTitle:@"添加" forState:UIControlStateNormal];
//    sentbutton1.tag=101;
//    
//    [sentbutton1 setTitleColor:KBlackColor forState:UIControlStateNormal];
//    [sentbutton1 setTitleColor:KlightOrangeColor forState:UIControlStateSelected];
//    
//    [sentbutton1 addTarget:self action:@selector(headaction:) forControlEvents:UIControlEventTouchUpInside];
//    sentbutton1.backgroundColor=[UIColor whiteColor];
//    [self.view addSubview:sentbutton1];
//    
//    
//    sentbutton.titleLabel.font=[UIFont boldSystemFontOfSize:18.0];
//    sentbutton1.titleLabel.font=[UIFont boldSystemFontOfSize:18.0];
//    
//    
//    UIView *lineview1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
//    lineview1.backgroundColor=KLineColor;
//    [self.view addSubview:lineview1];
//    
//    UIView *lineview=[[UIView alloc]initWithFrame:CGRectMake(0, 58.7, ScreenWidth, 1.3)];
//    lineview.backgroundColor=KlightOrangeColor;
//    [self.view addSubview:lineview];
//    
//    masklineview =[[UIView alloc]initWithFrame:CGRectMake(0, 58.7-5, ScreenWidth/2.0, 5.0)];
//    masklineview.backgroundColor=KlightOrangeColor;
//    [self.view addSubview:masklineview];
    
    
    
    
    JGProgressHUD *hud=[[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleDark];
    [hud showInView:self.view];
    [hud dismissAfterDelay:5];
    [PatientDataService getallPatientsblock:^(id respdic) {
        NSLog(@"%@",respdic);
        
        NSMutableArray *turenamearr=[[NSMutableArray alloc]init];
        NSArray *sourcearr=[[NSArray alloc]initWithArray:[respdic objectForKey:@"content"]];
        self.title=[NSString stringWithFormat:@"粉丝（%zd）",sourcearr.count];
        // NSMutableArray *tmparr=[[NSMutableArray alloc]init];
        
        NSMutableArray *sorttmpnamearr=[ChineseString SortArray:sourcearr];
        
        for (NSString *name in sorttmpnamearr) {
            for (NSDictionary *sortdic in sourcearr) {
                if ([name isEqualToString:[sortdic objectForKey:@"name"]]) {
                    [turenamearr addObject:sortdic];
                }
            }
        }
        
        
        NSMutableArray *indexarr=[[NSMutableArray alloc]init];
        
        for (NSString *name in sorttmpnamearr) {
            if (![indexarr containsObject:[self firstCharactor:name]]) {
                [indexarr addObject:[self firstCharactor:name]];
            }
        }
        
        
        
        NSMutableArray *turedataarr=[[NSMutableArray alloc]init];
        
        for (NSString *indexstr in indexarr) {
            NSMutableDictionary *turedatadic=[[NSMutableDictionary alloc]init];
            [turedatadic setObject:indexstr forKey:@"indexTitle"];
            //[indexarr addObject:[self firstCharactor:name]];
            NSMutableArray *tmparr=[[NSMutableArray alloc]init];
            for (NSDictionary *sortdic in turenamearr) {
                NSMutableDictionary *tmpdic1=[[NSMutableDictionary alloc]initWithDictionary:sortdic];
                if ([indexstr isEqualToString:[self firstCharactor:[sortdic objectForKey:@"name"]]]) {
                    [tmpdic1 setObject:@"unselect" forKey:@"selectstate"];
                    [tmparr addObject:tmpdic1];
                }
            }
            [turedatadic setObject:tmparr forKey:@"data"];
            [turedataarr addObject:turedatadic];
        }
        self.dataSource=turedataarr;
        [hud dismiss];
        
        
        
        indexTitles = [NSMutableArray array];
        for (NSDictionary * sectionDictionary in self.dataSource) {
            [indexTitles addObject:sectionDictionary[@"indexTitle"]];
        }
        //return indexTitles;
        
        //[self createTableView];
        [self.tableView reloadData];
//        NSLog(@"%@",indexarr);
//        NSLog(@"%@",turenamearr);
        
    }];

    
    //self.tableView.sectionIndexColor = KLineColor;
}
- (NSString *)firstCharactor:(NSString *)aString
{
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:aString];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *pinYin = [str capitalizedString];
    //获取并返回首字母
    return [pinYin substringToIndex:1];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     self.navigationController.navigationBar.hidden=NO;
}
-(void)headaction:(itemdetailbutton *)button{
    button.selected=YES;
    if (button.tag==oldbutton.tag) {
        
    } else {
        oldbutton.selected=NO;
        oldbutton=button;
    }
    if (button.tag==100) {
        
        
        
        
    } else {
        
        
    }
    [self.tableView reloadData];
    masklineview.frame=CGRectMake(button.frame.origin.x, 58.7-5, ScreenWidth/2.0, 5.0);
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 27.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(NSArray *)tableViewAtIndexes:(NSIndexSet *)indexes{
    return indexTitles;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.dataSource[section][@"indexTitle"];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr=(NSArray *)self.dataSource[section][@"data"];
    return arr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=nil;
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"usercell"];
    }
    
    NSDictionary *dic=self.dataSource[indexPath.section][@"data"][indexPath.row];
    
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
    [imagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@""]] placeholderImage:[UIImage imageNamed:kPlaceholderimage]];
    [cell addSubview:imagev];
    
    UILabel *label=[[UILabel alloc]init];
    
    
  
    label.frame=CGRectMake(60, 8, 160, 30);
        
 
    label.textColor=KBlackColor;
    label.font=[UIFont boldSystemFontOfSize:16.0];
    label.backgroundColor=[UIColor whiteColor];
    [cell addSubview:label];
    label.textAlignment=NSTextAlignmentLeft;
    //label.text=
    label.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
    
        UILabel *desclabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-190, 7, 180, 30)];
        
    
        desclabel.frame=CGRectMake(60, 30, 180, 30);
            
    
        
        desclabel.textColor=KLineColor;
        desclabel.font=[UIFont systemFontOfSize:13.0];
        desclabel.backgroundColor=[UIColor whiteColor];
        [cell addSubview:desclabel];
        desclabel.text=@"haha";
        
    
    itemdetailbutton *sentbutton=[itemdetailbutton buttonWithType:UIButtonTypeCustom];
    // sentbutton.frame=CGRectMake(ScreenWidth-90, 5, 80, 40-6);
    
    
   
    sentbutton.frame=CGRectMake(ScreenWidth-130, 15, 100, 30);
    [sentbutton setTitle:@"申请报到" forState:UIControlStateNormal];
  
    sentbutton.tag=indexPath.row+200000000;
    sentbutton.buttonlocation=indexPath.section;
    sentbutton.layer.masksToBounds = YES;
    sentbutton.layer.cornerRadius = 4.0;
    sentbutton.layer.borderWidth = 1.0;
    sentbutton.layer.borderColor = [KlightOrangeColor CGColor];
    
    [sentbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sentbutton.backgroundColor=KlightOrangeColor;
    [sentbutton addTarget:self action:@selector(sentmsgaction:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:sentbutton];
    
    
    return cell;
    

}
-(void)sentmsgaction:(itemdetailbutton *)button{
    [button setTitle:@"已申请报到" forState:UIControlStateNormal];
    [button setTitleColor:KGrayColor forState:UIControlStateNormal];
    button.backgroundColor=[UIColor clearColor];
    button.layer.borderColor = [[UIColor clearColor] CGColor];
    [PatientDataService invitePatientToDoctorPatientId:@"" doctor:@"" block:^(id respdic) {
        
        
        
    }];
}
@end
