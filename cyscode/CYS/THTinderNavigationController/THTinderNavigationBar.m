//
//  THTinderNavigationBar.m
//  THTinderNavigationControllerExample
//
//  Created by Tanguy Hélesbeux on 11/10/2014.
//  Copyright (c) 2014 Tanguy Hélesbeux. All rights reserved.
//

#import "THTinderNavigationBar.h"

#define kXHiPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

#define kXHLabelBaseTag 1000

#define MARGIN_LEFT 145
#define WIDTH self.bounds.size.width
#define IMAGESIZE 30
#define STEP 130
#define SPEED 2.45
#define Y_POSITION 28

@interface THTinderNavigationBar ()

@end

@implementation THTinderNavigationBar

#pragma mark - DataSource

- (void)reloadData {
    if (!self.itemViews.count) {
        return;
    }
    
    [self.itemViews enumerateObjectsUsingBlock:^(UIView<THTinderNavigationBarItem> *itemView, NSUInteger idx, BOOL *stop) {
        CGRect itemViewFrame = CGRectMake(MARGIN_LEFT + (idx * (kXHiPad ? 240 : STEP)), Y_POSITION, IMAGESIZE, IMAGESIZE);
        itemView.hidden = NO;
        itemView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        itemView.frame = itemViewFrame;
        if (self.currentPage == idx) {
            [itemView updateViewWithRatio:1.0];
        } else {
            [itemView updateViewWithRatio:0.0];
        }
    }];
}

- (void)tapGestureHandle:(UITapGestureRecognizer *)tapGesture
{
    NSInteger pageIndex = [self.itemViews indexOfObject:tapGesture.view];
    [self.navigationController setCurrentPage:pageIndex animated:YES];
}

#pragma mark - Propertys

- (void)setContentOffset:(CGPoint)contentOffset {
    _contentOffset = contentOffset;
    
    CGFloat xOffset = contentOffset.x;
    
    CGFloat normalWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    
    [self.itemViews enumerateObjectsUsingBlock:^(UIView<THTinderNavigationBarItem> *itemView, NSUInteger idx, BOOL *stop) {
        CGRect itemViewFrame = itemView.frame;
        itemViewFrame.origin.x = MARGIN_LEFT + (idx * (kXHiPad ? 240 : STEP)) - xOffset / SPEED;
        itemView.frame = itemViewFrame;
        
        CGFloat ratio;
        if(xOffset < normalWidth * idx) {
            ratio = (xOffset - normalWidth * (idx - 1)) / normalWidth;
        }else{
            ratio = 1 - ((xOffset - normalWidth * idx) / normalWidth);
        }
        [itemView updateViewWithRatio:ratio];
    }];
}

- (void)setItemViews:(NSArray *)itemViews
{
    if (itemViews) {
        
        [self.itemViews enumerateObjectsUsingBlock:^(UIView<THTinderNavigationBarItem> *itemView, NSUInteger idx, BOOL *stop) {
            [itemView removeFromSuperview];
        }];
        
        [itemViews enumerateObjectsUsingBlock:^(UIView<THTinderNavigationBarItem> *itemView, NSUInteger idx, BOOL *stop) {
            itemView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureHandle:)];
            [itemView addGestureRecognizer:tapGesture];
            [self addSubview:itemView];
        }];
    }
    
    _itemViews = itemViews;
}

#pragma mark - Life Cycle

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return self;
}

- (void)dealloc {
    self.itemViews = nil;
}

@end


// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
