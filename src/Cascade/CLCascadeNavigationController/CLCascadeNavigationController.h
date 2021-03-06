//
//  CLCascadeNavigationController.h
//  Cascade
//
//  Created by Emil Wojtaszek on 11-05-06.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLCascadeView.h"

@class CLViewController;

@class CLSplitCascadeViewController;

@interface CLCascadeNavigationController : UIViewController <CLCascadeViewDataSource, CLCascadeViewDelegate> {
    // array of all view controllers
    // todo: in ios5 use childViewControllers
    NSMutableArray* _viewControllers;

    // view containing all views on stack
    CLCascadeView* _cascadeView;
}

@property (nonatomic, strong) CLSplitCascadeViewController* parentSplitViewController;

/*
 List of CLViewControllers on stock.
 */
@property (nonatomic, strong, readonly) NSMutableArray* viewControllers;

/*
 * Left inset of normal size pages from left boarder
 */
@property(nonatomic) CGFloat leftInset;

/*
 * Left inset of wider size page from left boarder. Default 220.0f
 */
@property(nonatomic) CGFloat widerLeftInset;

/*
 * Set and push root view controller
 */
- (void) setRootViewController:(CLViewController*)viewController animated:(BOOL)animated;

/*
 * Push new view controller from sender.
 * If sender is not last, then controller pop next controller and push new view from sender
 */
- (void) addViewController:(CLViewController*)viewController sender:(CLViewController*)sender animated:(BOOL)animated;

/*
 * Remove top view controller
 */
- (void) removeTopdViewControllerAnimated:(BOOL)animated;

/*
 * Set main view controller  
 */
- (void) setMainViewController:(UIViewController*)viewController animated:(BOOL)animated withFrameReset:(BOOL)frameReset;

/* 
 First in hierarchy CascadeViewController (opposite to lastCascadeViewController)
 */
- (UIViewController*) rootViewController;

/* 
 Last in hierarchy CascadeViewController (opposite to rootViewController)
 */
- (UIViewController*)  lastCascadeViewController;

/* 
 Return first visible view controller (load if needed)
 */
- (UIViewController*) firstVisibleViewController;


@end
