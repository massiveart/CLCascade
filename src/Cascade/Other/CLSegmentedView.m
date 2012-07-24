//
//  CLSegmentedView.m
//  Cascade
//
//  Created by Emil Wojtaszek on 11-04-24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CLSegmentedView.h"

@interface CLSegmentedView (Private)
- (void) setupViews;
- (void) updateRoundedCorners;
@end

@implementation CLSegmentedView

@synthesize footer = _footerView;
@synthesize header = _headerView;
@synthesize content = _contentView;
@synthesize shadowLeftWidth = _shadowLeftWidth;
@synthesize shadowLeftOffset = _shadowLeftOffset;
@synthesize shadowRightWidth = _shadowRightWidth;
@synthesize shadowRightOffset = _shadowRightOffset;
@synthesize viewSize = _viewSize;
@synthesize showRoundedCorners = _showRoundedCorners;
@synthesize rectCorner = _rectCorner;

#pragma mark - Init & dealloc

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)init
{
    self = [super init];
    if (self) {

        _roundedCornersView = [[UIView alloc] init];
        [_roundedCornersView setBackgroundColor: [UIColor clearColor]];
        [self addSubview: _roundedCornersView];
        
        _viewSize = CLViewSizeNormal;
        _rectCorner = UIRectCornerAllCorners;
        _showRoundedCorners = NO;
    }
    return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id) initWithSize:(CLViewSize)size {
    self = [self init];
    if (self) {
        _viewSize = size;
    }
    return self;
}

#pragma mark -
#pragma mark Setters

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) setContentView:(UIView*)contentView {
    if (_contentView != contentView) {
        [_contentView removeFromSuperview];

        _contentView = contentView;

        if (_contentView) {
            [_contentView setAutoresizingMask:
             UIViewAutoresizingFlexibleLeftMargin | 
             UIViewAutoresizingFlexibleRightMargin | 
             UIViewAutoresizingFlexibleBottomMargin | 
             UIViewAutoresizingFlexibleTopMargin | 
             UIViewAutoresizingFlexibleWidth | 
             UIViewAutoresizingFlexibleHeight];
            
            [_roundedCornersView addSubview: _contentView];
            [self setNeedsLayout];
        }
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) setHeaderView:(UIView*)headerView {
    
    if (_headerView != headerView) {
        [_headerView removeFromSuperview];
        
        _headerView = headerView;

        if (_headerView) {
            [_headerView setAutoresizingMask:
             UIViewAutoresizingFlexibleLeftMargin | 
             UIViewAutoresizingFlexibleRightMargin | 
             UIViewAutoresizingFlexibleTopMargin];
            [_headerView setUserInteractionEnabled:YES];
            
            [_roundedCornersView addSubview: _headerView];
            [self setNeedsLayout];
        }
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) setFooterView:(UIView*)footerView {
    
    if (_footerView != footerView) {
        [_footerView removeFromSuperview];
        
        _footerView = footerView;
        if (_footerView) {
            [_footerView setAutoresizingMask:
             UIViewAutoresizingFlexibleLeftMargin | 
             UIViewAutoresizingFlexibleRightMargin | 
             UIViewAutoresizingFlexibleBottomMargin];
            [_footerView setUserInteractionEnabled:YES];
            
            [_roundedCornersView addSubview: _footerView];
            [self setNeedsLayout];
        }
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) addLeftBorderShadowView:(UIView *)view withWidth:(CGFloat)width {
    
    [self setClipsToBounds: NO];
    
    if (_shadowLeftWidth != width) {
        _shadowLeftWidth = width;
        [self setNeedsLayout];
        [self setNeedsDisplay];
    }
    
    if (view != _shadowLeftView) {
        _shadowLeftView = view;
        
        [self insertSubview:_shadowLeftView atIndex:0];
        
        [self setNeedsLayout];
        [self setNeedsDisplay];
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) removeLeftBorderShadowView {
    
    [self setClipsToBounds: YES];
    
    _shadowLeftView = nil;
    [self setNeedsLayout];
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) addRightBorderShadowView:(UIView *)view withWidth:(CGFloat)width {
    
    [self setClipsToBounds: NO];
    
    if (_shadowRightWidth != width) {
        _shadowRightWidth = width;
        [self setNeedsLayout];
        [self setNeedsDisplay];
    }
    
    if (view != _shadowRightView) {
        _shadowRightView = view;
        
        [self insertSubview:_shadowRightView atIndex:0];
        
        [self setNeedsLayout];
        [self setNeedsDisplay];
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) removeRightBorderShadowView {
    
    [self setClipsToBounds: YES];
    
    _shadowRightView = nil;
    [self setNeedsLayout];
    
}


#pragma mark -
#pragma mark Private

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) updateRoundedCorners {
    
    if (_showRoundedCorners) {
        CGRect toolbarBounds = self.bounds;
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect: toolbarBounds
                                                   byRoundingCorners:_rectCorner
                                                         cornerRadii:CGSizeMake(6.0f, 6.0f)];
        [maskLayer setPath:[path CGPath]];
        
        _roundedCornersView.layer.masksToBounds = YES;
        _roundedCornersView.layer.mask = maskLayer;
    } 
    else {
        _roundedCornersView.layer.masksToBounds = NO;
        [_roundedCornersView.layer setMask: nil];
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) layoutSubviews {

    CGRect rect = self.bounds;
    
    CGFloat viewWidth = rect.size.width;
    CGFloat viewHeight = rect.size.height;
    CGFloat headerHeight = 0.0;
    CGFloat footerHeight = 0.0;
    
    _roundedCornersView.frame = rect;
    
    if (_headerView) {
        headerHeight = _headerView.frame.size.height;
        
        CGRect newHeaderViewFrame = CGRectMake(0.0, 0.0, viewWidth, headerHeight);
        [_headerView setFrame: newHeaderViewFrame];
    }
    
    if (_footerView) {
        footerHeight = _footerView.frame.size.height;
        CGFloat footerY = viewHeight - footerHeight;
        
        CGRect newFooterViewFrame = CGRectMake(0.0, footerY, viewWidth, footerHeight);
        [_footerView setFrame: newFooterViewFrame];
    }
    
    [_contentView setFrame: CGRectMake(0.0, headerHeight, viewWidth, viewHeight - headerHeight - footerHeight)];

    if (_shadowLeftView) {
        CGRect shadowFrame = CGRectMake(0 - _shadowLeftWidth + _shadowLeftOffset, 0.0, _shadowLeftWidth, rect.size.height);
        _shadowLeftView.frame = shadowFrame;
    }
    
    if (_shadowRightView) {
        CGRect shadowFrame = CGRectMake(rect.size.width + _shadowRightOffset, 0.0, _shadowRightWidth, rect.size.height);
        _shadowRightView.frame = shadowFrame;
    }

    [self updateRoundedCorners];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc
{
    _roundedCornersView = nil;
    _shadowLeftView = nil;
    _shadowRightView = nil;
}

#pragma mark
#pragma mark Setters

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) setRectCorner:(UIRectCorner)corners {
    if (corners != _rectCorner) {
        _rectCorner = corners;
        [self setNeedsLayout];
    }
}


////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) setShowRoundedCorners:(BOOL)show {
    if (show != _showRoundedCorners) {
        _showRoundedCorners = show;
        [self setNeedsLayout];
    }
}


@end
