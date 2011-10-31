//
//  CLNavigationController.h
//  TSystems
//
//  Created by Thomas Schedler on 06.10.11.
//  Copyright 2011 MASSIVE ART WebServices. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "CLSegmentedView.h"
#import "UIView+CLView.h"
#import "CLViewControllerDelegate.h"
#import "CLGlobal.h"

@class CLCascadeNavigationController;

@interface CLNavigationController : UINavigationController  <CLViewControllerDelegate> {
    CLCascadeNavigationController* _cascadeNavigationController;
    
    CLViewSize _viewSize;
    BOOL _roundedCorners;
    
    CGFloat _shadowLeftWidth;
    CGFloat _shadowLeftOffset;
    UIView* _shadowLeftView;
    
    CGFloat _shadowRightWidth;
    CGFloat _shadowRightOffset;
    UIView* _shadowRightView;
}

- (id) initWithSize:(CLViewSize)size;
- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil size:(CLViewSize)size;

@property (nonatomic, strong) IBOutlet CLCascadeNavigationController* cascadeNavigationController;
@property (nonatomic, assign) CLViewSize viewSize;
@property (nonatomic, assign) BOOL showRoundedCorners;

// Outer left shadow methods
- (void) addLeftBorderShadowWithWidth:(CGFloat)width andOffset:(CGFloat)offset;
- (void) removeLeftBorderShadow;

/*
 Override this methods to return view which represent left border shadow.
 It could be UIImageView with gradient image or simle UIView, where you can overrider drawRect: method
 to draw gradient in Core Animation.
 */
- (UIView *) leftBorderShadowView;

// Outer right shadow methods
- (void) addRightBorderShadowWithWidth:(CGFloat)width andOffset:(CGFloat)offset;
- (void) removeRightBorderShadow;

/*
 Override this methods to return view which represent left border shadow.
 It could be UIImageView with gradient image or simle UIView, where you can overrider drawRect: method
 to draw gradient in Core Animation.
 */
- (UIView *) rightBorderShadowView;


@end
