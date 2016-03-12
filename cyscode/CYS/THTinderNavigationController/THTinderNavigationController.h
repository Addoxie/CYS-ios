//
//  THTinderNavigationController.h
//  THTinderNavigationControllerExample
//
//  Created by Tanguy Hélesbeux on 11/10/2014.
//  Copyright (c) 2014 Tanguy Hélesbeux. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol THTinderNavigationControllerdelegate <NSObject>

-(void)THTinderShowCurrentPageIndex:(NSInteger)currentPageIndex;

@end




typedef void(^THDidChangedPageBlock)(NSInteger currentPage, NSString *title);

@interface THTinderNavigationController : UIViewController

@property (nonatomic, copy) THDidChangedPageBlock didChangedPageCompleted;

@property (nonatomic, strong) NSArray *viewControllers;
@property (nonatomic, strong) NSArray *navbarItemViews;
@property (nonatomic, strong) UIView *centerContainerView;
@property (nonatomic, strong) UIScrollView *paggingScrollView;



@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, strong) UIViewController *leftViewController;

@property (nonatomic, strong) UIViewController *rightViewController;



@property (nonatomic, assign) id <THTinderNavigationControllerdelegate> delegate;
- (instancetype)initWithLeftViewController:(UIViewController *)leftViewController;

- (instancetype)initWithRightViewController:(UIViewController *)rightViewController;

- (instancetype)initWithLeftViewController:(UIViewController *)leftViewController rightViewController:(UIViewController *)rightViewController;

- (NSInteger)getCurrentPageIndex;

- (void)setCurrentPage:(NSInteger)currentPage animated:(BOOL)animated;

- (void)reloadData;

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
