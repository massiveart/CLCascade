//
//  CLSplitCascadeView.m
//  Cascade
//
//  Created by Emil Wojtaszek on 11-03-27.
//  Copyright 2011 CreativeLabs.pl. All rights reserved.
//

#import "CLSplitCascadeView.h"
#import "CLGlobal.h"

@interface CLSplitCascadeView (Private)
- (void) setupView;
- (void) addDivierView;
@end

@implementation CLSplitCascadeView

@synthesize splitCascadeViewController = _splitCascadeViewController;

@synthesize categoriesView = _categoriesView;
@synthesize cascadeView = _cascadeView;
@synthesize mainView = _mainView;
@synthesize backgroundView = _backgroundView;
@synthesize verticalDividerImage = _verticalDividerImage;


#pragma mark -
#pragma mark Private

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) setupView {
    [self setBackgroundColor: [UIColor clearColor]];
    [self setOpaque:NO];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) addDivierView {
    
    if ((!_backgroundView) || (!_verticalDividerImage)) return;
    
    if (_dividerView) {
        [_dividerView removeFromSuperview];
        _dividerView = nil;
    }
        
    _dividerView = [[UIView alloc] init];
    _dividerWidth = _verticalDividerImage.size.width;
    [_dividerView setBackgroundColor:[UIColor colorWithPatternImage: _verticalDividerImage]];
    
    [_dividerView.layer setOpaque:NO];
    [_dividerView setOpaque:NO];
    
    [_backgroundView addSubview: _dividerView];
    
    [_backgroundView.layer setOpaque:NO];
    [_backgroundView setOpaque:NO];
    
    [self setNeedsLayout];   
    
}


#pragma mark -
#pragma mark Init & dealloc

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)init {
    self = [super init];
    if (self) {
        // Initialization code
        [self setupView];
    }
    return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setupView];
    }
    return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setupView];
    }
    return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc
{
    _cascadeView = nil;
    _categoriesView = nil;
    _verticalDividerImage = nil;
    _dividerView = nil;

}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {

    CLCascadeNavigationController* cascadeNavigationController = _splitCascadeViewController.cascadeNavigationController;
    UIView* navigationView = [cascadeNavigationController view];

    if (CGRectContainsPoint(_categoriesView.frame, point)) {
        
        UIView* rootView = [[cascadeNavigationController firstVisibleViewController] view];
        CGRect rootViewRect = [rootView convertRect:rootView.bounds toView:self];

        if ((rootView) && (CGRectContainsPoint(rootViewRect, point))) {
            CGPoint newPoint = [self convertPoint:point toView:navigationView];
            return [navigationView hitTest:newPoint withEvent:event];
        } else {
            return [_categoriesView hitTest:point withEvent:event];
        }

    } else {
        CGPoint newPoint = [self convertPoint:point toView:navigationView];

        if (_mainView) {
            return [_mainView hitTest:newPoint withEvent:event];
        } else {
            return [navigationView hitTest:newPoint withEvent:event];
        }
    }
        
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) layoutSubviews {
    
    CGRect bounds = self.bounds;
    
    CGFloat width = (_categoriesView.bounds.size.width == 45.0) ?
                     _categoriesView.bounds.size.width : CATEGORIES_VIEW_WIDTH;
    
    CGRect categoriesFrame = CGRectMake(0.0, 0.0, width, bounds.size.height);
    _categoriesView.frame = categoriesFrame;
    
    CGRect cascadeNavigationFrame = bounds;
    _cascadeView.frame = cascadeNavigationFrame;

    CGRect backgroundViewFrame = CGRectMake(0.0, 0.0, bounds.size.width, bounds.size.height);
    _backgroundView.frame = backgroundViewFrame;

    CGRect dividerViewFrame = CGRectMake(0.0, 0.0, _dividerWidth, bounds.size.height);
    _dividerView.frame = dividerViewFrame;

}


#pragma mark -
#pragma mark Setter

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) setCategoriesView:(UIView*) aView {
    if (_categoriesView != aView) {
        _categoriesView = aView;
        
        [self addSubview: _categoriesView];
        [self bringSubviewToFront: _cascadeView];
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) setCascadeView:(UIView*) aView {
    if (_cascadeView != aView) {
        _cascadeView = aView;
                
        [self addSubview: _cascadeView];
        [self bringSubviewToFront: _cascadeView];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) setMainView:(UIView *) aView {
    if (_mainView != aView) {
        [self releaseMainView];
        
        _mainView = aView;
        
        [self addSubview: _mainView];        
        [self bringSubviewToFront: _mainView];
        [self bringSubviewToFront: _categoriesView];
    }
}

- (void) releaseMainView {
    if (_mainView) {
        [_mainView removeFromSuperview];
        _mainView = nil;
    }
    
    if (_cascadeView) {
        [self bringSubviewToFront: _cascadeView];        
    }
}

- (void) bringMainViewToFront {
    if (_mainView) {
        [self bringSubviewToFront:_mainView];
    }
}



///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) setBackgroundView:(UIView*) aView {
    if (_backgroundView != aView) {
        _backgroundView = aView;
        
        [_dividerView removeFromSuperview];
        _dividerView = nil;
        
        [self insertSubview:_backgroundView atIndex:0];

        [self addDivierView];
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) setVerticalDividerImage:(UIImage*) image {
    if (_verticalDividerImage != image) {
        _verticalDividerImage = image;
        
        [self addDivierView];
    }
}

@end
