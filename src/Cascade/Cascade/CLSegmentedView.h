//
//  CLSegmentedView.h
//  Cascade
//
//  Created by Emil Wojtaszek on 11-04-24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "CLGlobal.h"

@interface CLSegmentedView : UIView {
    CLViewSize _viewSize;
    
    UIView* _headerView;
    UIView* _footerView;
    UIView* _contentView;
    UIView* _roundedCornersView;
    
    CGFloat _shadowLeftWidth;
    CGFloat _shadowLeftOffset;
    UIView* _shadowLeftView;
    
    CGFloat _shadowRightWidth;
    CGFloat _shadowRightOffset;
    UIView* _shadowRightView;
    
    BOOL _showRoundedCorners;
    UIRectCorner _rectCorner;
}

/*
 * Header view - located on the top of view
 */
@property (nonatomic, strong, readonly) IBOutlet UIView* header;

/*
 * Footer view - located on the bottom of view
 */
@property (nonatomic, strong, readonly) IBOutlet UIView* footer;

/*
 * Content view - located between header and footer view 
 */
@property (nonatomic, strong, readonly) IBOutlet UIView* content;

/*
 * The width of the shadow left
 */
@property (nonatomic, assign) CGFloat shadowLeftWidth;

/*
 * The offset of the shadow left in X-axis. Default 0.0
 */
@property (nonatomic, assign) CGFloat shadowLeftOffset;

/*
 * The width of the shadow right
 */
@property (nonatomic, assign) CGFloat shadowRightWidth;

/*
 * The offset of the shadow right in X-axis. Default 0.0
 */
@property (nonatomic, assign) CGFloat shadowRightOffset;

/*
 * Set YES if you want rounded corners. Default NO.
 */
@property (nonatomic, assign) BOOL showRoundedCorners;

/*
 * Type of rect corners. Default UIRectCornerAllCorners.
 */
@property (nonatomic, assign) UIRectCorner rectCorner;

/*
 * Size of view
 */
@property (nonatomic, assign) CLViewSize viewSize;

- (id) initWithSize:(CLViewSize)size;

/* 
 * To set content view.
 * This methoad add contentView to view and layout all views
 */
- (void) setContentView:(UIView*)contentView;

/* 
 * If you want set header view (above contentView).
 * This methoad add headerView to view and layout all views
 */
- (void) setHeaderView:(UIView*)headerView;

/* 
 * If you want set footer view (belove contentView)
 * This methoad add footerView to view and layout all views
 */
- (void) setFooterView:(UIView*)footerView;

/* 
 * This methoad add left outer shadow view with proper width
 */
- (void) addLeftBorderShadowView:(UIView *)view withWidth:(CGFloat)width;

/* 
 * This methoad remove left outer shadow
 */
- (void) removeLeftBorderShadowView;

/* 
 * This methoad add right outer shadow view with proper width
 */
- (void) addRightBorderShadowView:(UIView *)view withWidth:(CGFloat)width;

/* 
 * This methoad remove right outer shadow
 */
- (void) removeRightBorderShadowView;

@end
