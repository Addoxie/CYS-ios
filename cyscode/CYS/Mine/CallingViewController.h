//
//  CallingViewController.h
//  CYS
//
//  Created by 谢阳晴 on 16/1/11.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleProgressView.h"

@interface CallingViewController : UIViewController

@property (strong, nonatomic) IBOutlet CircleProgressView *circleProgressView;

@property (strong, nonatomic) IBOutlet UIButton *actionButton;
@end
