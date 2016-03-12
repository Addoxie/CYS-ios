//
//  TagsGroupViewController.h
//  CYS
//
//  Created by 谢阳晴 on 16/1/13.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TagsGroupViewControllerdelegate <NSObject>

-(void)reloanewtagsdata;

@end

@interface TagsGroupViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,navbardelegate>
@property(nonatomic,retain)UITableView *tableView;

@property(nonatomic,assign) id <TagsGroupViewControllerdelegate> delegate;

@end
