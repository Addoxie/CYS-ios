//
//  HXViewController.h
//  HXTagsView
//
//  Created by 黄轩 on 16/1/14.
//  Copyright © 2016年 IT小子. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagsRenameViewController.h"

@protocol HXViewControllerdelegate <NSObject>

-(void)reloadtagsdata;

@end


@interface HXViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,TagsRenameViewControllerdelegate,UITextFieldDelegate>

@property(nonatomic,retain)UITableView *tableView;
/**
 *  已选的数据
 */
@property (nonatomic, strong)NSMutableArray *selectedArray;
/**
 *  可选的数据
 */
@property (nonatomic, strong)NSMutableArray *optionalArray;

@property (nonatomic, retain)NSString *patientid;


@property (nonatomic, assign)id <HXViewControllerdelegate> delegate;

@end

