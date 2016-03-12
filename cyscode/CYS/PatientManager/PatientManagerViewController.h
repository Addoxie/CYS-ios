//
//  PatientManagerViewController.h
//  CYS
//
//  Created by 谢阳晴 on 15/12/17.
//  Copyright © 2015年 谢阳晴. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditnameViewController.h"

#import "NavBarView.h"



@interface PatientManagerViewController : UIViewController<navbardelegate,UIScrollViewDelegate,EditnameViewControllerdelegate>{

}
@property(nonatomic,assign)BOOL isRoot;
@end
