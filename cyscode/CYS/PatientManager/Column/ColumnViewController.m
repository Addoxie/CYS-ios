//
//  ColumnViewController.m
//  Column
//
//  Created by fujin on 15/11/18.
//  Copyright © 2015年 fujin. All rights reserved.
//

#import "ColumnViewController.h"
#import "CoclumnCollectionViewCell.h"
#import "ColumnReusableView.h"
#import "Header.h"
#define SPACE 10.0
static NSString *cellIdentifier = @"CoclumnCollectionViewCell";
static NSString *headOne = @"ColumnReusableViewOne";
static NSString *headTwo = @"ColumnReusableViewTwo";
@interface ColumnViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,DeleteDelegate>
/**
 *  collectionView
 */
@property (nonatomic, strong)UICollectionView *collectionView;
/**
 *  Whether sort
 */
@property (nonatomic, assign)BOOL isSort;
/**
 * Whether hidden the last
 */
@property (nonatomic, assign)BOOL lastIsHidden;
/**
 *  animation label（insert）
 */
@property (nonatomic, strong)UILabel *animationLabel;
/**
 *  attributes of all cells
 */
@property (nonatomic, strong)NSMutableArray *cellAttributesArray;

@end

@implementation ColumnViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        self.selectedArray = [[NSMutableArray alloc] init];
        self.optionalArray = [[NSMutableArray alloc] init];
        
        self.cellAttributesArray = [[NSMutableArray alloc] init];
        
        self.animationLabel = [[UILabel alloc] init];
        self.animationLabel.textAlignment = NSTextAlignmentCenter;
        self.animationLabel.font = [UIFont systemFontOfSize:15];
        self.animationLabel.numberOfLines = 1;
        self.animationLabel.adjustsFontSizeToFitWidth = YES;
        self.animationLabel.minimumScaleFactor = 0.1;
        self.animationLabel.textColor = RGBA(101, 101, 101, 1);
        self.animationLabel.layer.masksToBounds = YES;
        self.animationLabel.layer.borderColor = RGBA(211, 211, 211, 1).CGColor;
        self.animationLabel.layer.borderWidth = 0.45;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    UITextField *tagtf=[[UITextField alloc]initWithFrame:CGRectMake(5, 70, CGRectGetWidth(self.view.frame)-10, 40)];
    tagtf.delegate=self;
    tagtf.tintColor=[UIColor orangeColor];
    tagtf.placeholder=@"添加标签";
    tagtf.layer.cornerRadius=5.0;
    tagtf.backgroundColor=[UIColor yellowColor];
    tagtf.returnKeyType=UIReturnKeyDone;
    tagtf.textColor=[UIColor orangeColor];
    [self.view addSubview:tagtf];
 [self performSelector:@selector(initui) withObject:nil afterDelay:0.5];
    [self setLeftItem];
    
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
   
    
    
}
-(void)initui{
    self.title=@"haha";
    
    
    
    [self configCollection];

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
     [textField resignFirstResponder];
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
   // [textField resignFirstResponder];
    //数据整理
    if (![textField.text isEqualToString:@""]) {
        NSDictionary *dic=[[NSDictionary alloc]initWithObjectsAndKeys:textField.text,@"tag", nil];
        [self.selectedArray insertObject:dic atIndex:0];
        // [self.selectedArray removeObjectAtIndex:indexPath.row];
        //[self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
        
        [self.collectionView reloadData];
    }
 

}

-(void)setLeftItem{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
   // UIEdgeInsets inset   = UIEdgeInsetsMake(0, -15, 0, 0);
   // leftButton.contentEdgeInsets = inset;
    rightButton.frame = CGRectMake(-20, 0, 60, 40);
    // [leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [rightButton setTitle:@"保存" forState:UIControlStateNormal];
    [rightButton setTitleColor:KlightOrangeColor forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [rightButton addTarget:self action:@selector(saveall) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = backItem;
    
    
    
}
-(void)back:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)saveall{
  
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"是否更新相关标签？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
        if (buttonIndex==0) {
            
        }else if (buttonIndex==1) {
            //保存标签
            
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
    
}
#pragma mark ----------------- collectionInscance ---------------------
-(void)configCollection{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 106, SCREEN_SIZE.width, SCREEN_SIZE.height - 64-49) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.alwaysBounceVertical = YES;
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[CoclumnCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    [self.collectionView registerClass:[ColumnReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headOne];
    [self.collectionView registerClass:[ColumnReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headTwo];
    [self.collectionView reloadData];
}
#pragma mark ----------------- sort ---------------------
-(void)sortItem:(UIPanGestureRecognizer *)pan{
    CoclumnCollectionViewCell *cell = (CoclumnCollectionViewCell *)pan.view;
    NSIndexPath *cellIndexPath = [self.collectionView indexPathForCell:cell];
    
    //开始  获取所有cell的attributes
    if (pan.state == UIGestureRecognizerStateBegan) {
        [self.cellAttributesArray removeAllObjects];
        for (NSInteger i = 0 ; i < self.selectedArray.count; i++) {
            [self.cellAttributesArray addObject:[self.collectionView layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]]];
        }
    }
    
    CGPoint point = [pan translationInView:self.collectionView];
    cell.center = CGPointMake(cell.center.x + point.x, cell.center.y + point.y);
    [pan setTranslation:CGPointMake(0, 0) inView:self.collectionView];
    
    //进行是否排序操作
    BOOL ischange = NO;
    for (UICollectionViewLayoutAttributes *attributes in self.cellAttributesArray) {
        CGRect rect = CGRectMake(attributes.center.x - 6, attributes.center.y - 6, 12, 12);
        if (CGRectContainsPoint(rect, CGPointMake(pan.view.center.x, pan.view.center.y)) & (cellIndexPath != attributes.indexPath)) {
            
            //后面跟前面交换
            if (cellIndexPath.row > attributes.indexPath.row) {
                //交替操作0 1 2 3 变成（3<->2 3<->1 3<->0）
                for (NSInteger index = cellIndexPath.row; index > attributes.indexPath.row; index -- ) {
                    [self.selectedArray exchangeObjectAtIndex:index withObjectAtIndex:index - 1];
                }
            }
            //前面跟后面交换
            else{
                //交替操作0 1 2 3 变成（0<->1 0<->2 0<->3）
                for (NSInteger index = cellIndexPath.row; index < attributes.indexPath.row; index ++ ) {
                    [self.selectedArray exchangeObjectAtIndex:index withObjectAtIndex:index + 1];
                }
            }
            ischange = YES;
            [self.collectionView moveItemAtIndexPath:cellIndexPath toIndexPath:attributes.indexPath];
        }
        else{
            ischange = NO;
        }
    }
    
    //结束
    if (pan.state == UIGestureRecognizerStateEnded){
        if (ischange) {
            
        }
        else{
            cell.center = [self.collectionView layoutAttributesForItemAtIndexPath:cellIndexPath].center;
        }
    }
}

#pragma mark ----------------- delete ---------------------
-(void)deleteItemWithIndexPath:(NSIndexPath *)indexPath{
    //数据整理
    [self.optionalArray insertObject:[self.selectedArray objectAtIndex:indexPath.row] atIndex:0];
    [self.selectedArray removeObjectAtIndex:indexPath.row];
    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
    
    //删除之后更新collectionView上对应cell的indexPath
    for (NSInteger i = 0; i < self.selectedArray.count; i++) {
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
        CoclumnCollectionViewCell *cell = (CoclumnCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:newIndexPath];
        cell.indexPath = newIndexPath;
    }
    
}
#pragma mark ----------------- insert ---------------------
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        self.lastIsHidden = YES;
        
        CoclumnCollectionViewCell *endCell = (CoclumnCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
        endCell.contentLabel.hidden = YES;
        //已选择的数据
        [self.selectedArray addObject:[self.optionalArray objectAtIndex:indexPath.row]];
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
        
        //移动开始的attributes
        UICollectionViewLayoutAttributes *startAttributes = [self.collectionView layoutAttributesForItemAtIndexPath:indexPath];
        
        self.animationLabel.frame = CGRectMake(startAttributes.frame.origin.x, startAttributes.frame.origin.y, startAttributes.frame.size.width , startAttributes.frame.size.height);
        self.animationLabel.backgroundColor= RGBA(211, 211, 211, 1);
        self.animationLabel.layer.cornerRadius = CGRectGetHeight(self.animationLabel.bounds) * 0.2;
        NSDictionary *dic=[self.optionalArray objectAtIndex:indexPath.row];
        self.animationLabel.text = [dic objectForKey:@"tag"];
        self.animationLabel.textColor=KlightOrangeColor;
        [self.collectionView addSubview:self.animationLabel];
        NSIndexPath *toIndexPath = [NSIndexPath indexPathForRow:self.selectedArray.count-1 inSection:0];
        
        //移动终点的attributes
        UICollectionViewLayoutAttributes *endAttributes = [self.collectionView layoutAttributesForItemAtIndexPath:toIndexPath];
        
        typeof(self) __weak weakSelf = self;
        //移动动画
        [UIView animateWithDuration:0.2 animations:^{
            weakSelf.animationLabel.center = endAttributes.center;
            //展示最后一个cell的contentLabel
            CoclumnCollectionViewCell *endCell = (CoclumnCollectionViewCell *)[weakSelf.collectionView cellForItemAtIndexPath:toIndexPath];
            endCell.contentLabel.hidden = NO;
            
            weakSelf.lastIsHidden = NO;
            [weakSelf.animationLabel removeFromSuperview];
            //可选标签移除已选标签
            [weakSelf.optionalArray removeObjectAtIndex:indexPath.row];
            [weakSelf.collectionView deleteItemsAtIndexPaths:@[indexPath]];
        } completion:^(BOOL finished) {
           
        }];
        
    }
}

#pragma mark ----------------- item(样式) ---------------------
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if ( indexPath.section==0) {
        
          NSDictionary *datadic= self.selectedArray[indexPath.row];
        CGRect textsize=KStringSize([datadic objectForKey:@"tag"], MAXFLOAT, [UIFont systemFontOfSize:15.0]);
        // self.contentLabel.text =[datadic objectForKey:@"tag"];
        
        return CGSizeMake(textsize.size.width, 30);
        
    } else {
         NSDictionary *datadic= self.optionalArray[indexPath.row];
          CGRect textsize=KStringSize([datadic objectForKey:@"tag"], MAXFLOAT, [UIFont systemFontOfSize:15.0]);
         return CGSizeMake(textsize.size.width, 30);
      
        // self.contentLabel.text =[datadic objectForKey:@"tag"];
    }
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(SPACE, SPACE, SPACE, SPACE);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return SPACE;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return SPACE;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(SCREEN_SIZE.width, 40.0);
    }
    else{
        return CGSizeMake(SCREEN_SIZE.width, 30.0);
    }
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return  CGSizeMake(SCREEN_SIZE.width, 0.0);
}

#pragma mark ----------------- collectionView(datasouce) ---------------------

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (self.isSort) {
        return 1;
    }
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return self.selectedArray.count;
    }
    else{
        return self.optionalArray.count;
    }
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    ColumnReusableView *reusableView = nil;
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        if (indexPath.section == 0) {
            reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headOne forIndexPath:indexPath];
            reusableView.buttonHidden = NO;
            reusableView.clickButton.selected = self.isSort;
            reusableView.backgroundColor = [UIColor whiteColor];
            typeof(self) __weak weakSelf = self;
            [reusableView clickWithBlock:^(ButtonState state) {
                //排序删除
                if (state == StateSortDelete) {
                    weakSelf.isSort = YES;
                }
                //完成
                else{
                    weakSelf.isSort = NO;
                    if (weakSelf.cellAttributesArray.count) {
                        for (UICollectionViewLayoutAttributes *attributes in weakSelf.cellAttributesArray) {
                            CoclumnCollectionViewCell *cell = (CoclumnCollectionViewCell *)[weakSelf.collectionView cellForItemAtIndexPath:attributes.indexPath];
                            for (UIPanGestureRecognizer *pan in cell.gestureRecognizers) {
                                [cell removeGestureRecognizer:pan];
                            }
                        }
                    }
                }
                [weakSelf.collectionView reloadData];
            }];
            reusableView.titleLabel.text = @"已选标签";
            
        }else{
            reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headTwo forIndexPath:indexPath];
            reusableView.buttonHidden = YES;
            reusableView.backgroundColor = RGBA(240, 240, 240, 1);
            reusableView.titleLabel.text = @"点击选择更多标签";
        }
    }
    return (UICollectionReusableView *)reusableView;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
  //  static NSString * CellIdentifier = @"GradientCell";
    CoclumnCollectionViewCell * cell = (CoclumnCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
  
   // CoclumnCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
//    for (UIView *subv in cell.subviews) {
//        [subv removeFromSuperview];
//    }
    if (indexPath.section == 0) {
        [cell configCell:self.selectedArray withIndexPath:indexPath];
        //头条
        if (indexPath.row == 0) {
           cell.deleteButton.hidden = !self.isSort;
               cell.deleteDelegate = self;
        }else{
           cell.deleteDelegate = self;
           cell.deleteButton.hidden = !self.isSort;
            if (self.isSort) {
//                UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(sortItem:)];
//                [cell addGestureRecognizer:pan];
            }
            else{
                
            }
            //最后一位是否影藏(为了动画效果)
            if (indexPath.row == self.selectedArray.count - 1) {
                cell.contentLabel.hidden = self.lastIsHidden;
            }
        }
        
    }else{
        [cell configCell:self.optionalArray withIndexPath:indexPath];
        cell.deleteButton.hidden = YES;
    }
    return cell;
}
-(void)dealloc{
    NSLog(@"dealloc");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
