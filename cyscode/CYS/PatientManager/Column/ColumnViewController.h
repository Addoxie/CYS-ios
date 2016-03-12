//
//  ColumnViewController.h
//  Column
//
//  Created by fujin on 15/11/18.
//  Copyright © 2015年 fujin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ColumnViewControllerdelegate <NSObject>

-(void)reloadtagsdata;

@end


@interface ColumnViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>
/**
 *  已选的数据
 */
@property (nonatomic, strong)NSMutableArray *selectedArray;
/**
 *  可选的数据
 */
@property (nonatomic, strong)NSMutableArray *optionalArray;



@property (nonatomic, retain)NSString *patientid;


@property (nonatomic, assign)id <ColumnViewControllerdelegate> delegate;

@end
