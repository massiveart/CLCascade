//
//  CLViewController.m
//  Cascade
//
//  Created by Emil Wojtaszek on 11-03-26.
//  Copyright 2011 CreativeLabs.pl. All rights reserved.
//

#import "CLViewController.h"
#import "CLCascadeNavigationController.h"
#import "CLBorderShadowView.h"

#import "CLSegmentedView.h"
#import "UIViewController+CLSegmentedView.h"
#import "CLViewControllerDelegate.h"
#import "CLGlobal.h"

#import "CLSegmentedView+Extension.h"

@implementation CLViewController

@synthesize cascadeNavigationController = _cascadeNavigationController;
@synthesize viewSize = _viewSize;
@synthesize showRoundedCorners = _roundedCorners;

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id) init {
    self = [super init];
    if (self) {
        _viewSize = CLViewSizeNormal;
        _roundedCorners = NO;
    }
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _viewSize = CLViewSizeNormal;
        _roundedCorners = NO;
    }
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id) initWithSize:(CLViewSize)size {
    self = [super init];
    if (self) {
        _viewSize = size;
        _roundedCorners = NO;
    }
    return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil size:(CLViewSize)size {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _viewSize = size;
        _roundedCorners = NO;
    }
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) loadView {
    NSString *nib = self.nibName;
    
    if (nib) {
        NSBundle *bundle = self.nibBundle;
        if(!bundle) bundle = [NSBundle mainBundle];
        
        NSString *path = [bundle pathForResource:nib ofType:@"nib"];
        
        if (path) {
            UIView* view_ = [[bundle loadNibNamed:nib owner:self options:nil] objectAtIndex:0];
            
            if ([view_ isKindOfClass:[CLSegmentedView class]]) {
                [(CLSegmentedView*)view_ setViewSize:self.viewSize];
            }
            self.view = view_; return;
        }
    }
    
    CLSegmentedView* view_ = [[CLSegmentedView alloc] initWithSize: _viewSize];
    self.view = view_;
    
    [view_ setAutoresizingMask:
     UIViewAutoresizingFlexibleLeftMargin | 
     UIViewAutoresizingFlexibleRightMargin | 
     UIViewAutoresizingFlexibleBottomMargin | 
     UIViewAutoresizingFlexibleTopMargin |
     UIViewAutoresizingFlexibleWidth | 
     UIViewAutoresizingFlexibleHeight];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.        
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}


#pragma mark -
#pragma mark Class methods

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIView *) leftBorderShadowView {
    return [[CLBorderShadowView alloc] init];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) addLeftBorderShadowWithWidth:(CGFloat)width andOffset:(CGFloat)offset {
    
    UIView* shadowView = [self leftBorderShadowView];
    [(CLSegmentedView*)self.view addLeftBorderShadowView:shadowView 
                                               withWidth:width];    
    
    [(CLSegmentedView*)self.view setShadowLeftOffset:offset];
    
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) removeLeftBorderShadow {
    
    [(CLSegmentedView*)self.view removeLeftBorderShadowView];    
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIView *) rightBorderShadowView {
    CGFloat colors[] = { 
        0.0, 0.0, 0.0, 0.2,
        255.0, 255.0, 255.0, 0.0
    };
    
    CLBorderShadowView* borderShadowView = [[CLBorderShadowView alloc] init];
    [borderShadowView setColors:colors];
    
    return borderShadowView;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) addRightBorderShadowWithWidth:(CGFloat)width andOffset:(CGFloat)offset {
    
    UIView* shadowView = [self rightBorderShadowView];
    [(CLSegmentedView*)self.view addRightBorderShadowView:shadowView 
                                                withWidth:width];    
    
    [(CLSegmentedView*)self.view setShadowRightOffset:offset];
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) removeRightBorderShadow {
    
    [(CLSegmentedView*)self.view removeRightBorderShadowView];    
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) pushDetailViewController:(CLViewController *)viewController animated:(BOOL)animated {
    NSAssert(_viewSize != CLViewSizeWider, @"Assert: You can't push a new view from a view which size is CLViewSizeWider.");
    [self.cascadeNavigationController addViewController:viewController sender:self animated:animated];
}

- (void) removeTopdViewControllerAnimated:(BOOL)animated {
	[self.cascadeNavigationController removeTopdViewControllerAnimated:animated];
}

#pragma mark CLViewControllerDelegate

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) pageDidAppear {
    /*
     * Called when page (view of this controller) will be unveiled by 
     * another page or will slide in CascadeView bounds
     */
    
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) pageDidDisappear {
    /*
     * Called when page (view of this controller) will be shadowed by 
     * another page or will slide out CascadeView bounds
     */
    
}

@end
