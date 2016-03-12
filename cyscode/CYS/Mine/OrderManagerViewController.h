//
//  OrderManagerViewController.h
//  CYS
//
//  Created by 谢阳晴 on 16/1/13.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "itemdetailbutton.h"

@interface OrderManagerViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,navbardelegate,UITextFieldDelegate>{
    
}

@property(nonatomic,retain)NSMutableArray *dataArr;
@property(nonatomic,retain)NSArray *indexdataArr;
@property(nonatomic,retain)UITableView *tableView;


@end
