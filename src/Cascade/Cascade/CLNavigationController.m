//
//  CLNavigationController.m
//  TSystems
//
//  Created by Thomas Schedler on 06.10.11.
//  Copyright 2011 MASSIVE ART WebServices. All rights reserved.
//

#import "CLNavigationController.h"

#import "CLCascadeNavigationController.h"
#import "CLBorderShadowView.h"

@implementation CLNavigationController

@synthesize cascadeNavigationController = _cascadeNavigationController;
@synthesize viewSize = _viewSize;
@synthesize showRoundedCorners = _roundedCorners;

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id) init {
    self = [super init];
    if (self) {
        _viewSize = CLViewSizeWider;
        _roundedCorners = NO;
    }
    return self;
}

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    if ((self=[self initWithNibName:nil bundle:nil])) {
        self.viewControllers = [NSArray arrayWithObject:rootViewController];
        
        _viewSize = CLViewSizeWider;
        _roundedCorners = NO;
    }
    return self;
}

- (id) initWithSize:(CLViewSize)size {
    self = [super init];
    if (self) {
        _viewSize = size;
        _roundedCorners = NO;
    }
    return self;
}

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
    [super loadView];
    
    
    /*NSString *nib = self.nibName;
    
    if (nib) {
        NSBundle *bundle = self.nibBundle;
        if(!bundle) bundle = [NSBundle mainBundle];
        
        NSString *path = [bundle pathForResource:nib ofType:@"nib"];
        
        if(path) {
            self.view = [[bundle loadNibNamed:nib owner:self options:nil] objectAtIndex: 0];
            return;
        }
    }
    
    CLSegmentedView* view_ = [[CLSegmentedView alloc] initWithSize: _viewSize];
    self.view = view_;
    [view_ release];
    
    UIViewController *topViewController = self.topViewController;
    topViewController.view.frame = [view_.contentView frame];
    topViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [view_ setContentView: topViewController.view];
    
    [self.navigationBar setFrame: CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    [self.navigationBar setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [view_ setHeaderView:self.navigationBar];
    
    [view_ setAutoresizingMask:
     UIViewAutoresizingFlexibleLeftMargin | 
     UIViewAutoresizingFlexibleRightMargin | 
     UIViewAutoresizingFlexibleBottomMargin | 
     UIViewAutoresizingFlexibleTopMargin |
     UIViewAutoresizingFlexibleWidth | 
     UIViewAutoresizingFlexibleHeight];*/
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
    
    [self.view setClipsToBounds: NO];
    
    if (_shadowLeftWidth != width) {
        _shadowLeftWidth = width;
        [self.view setNeedsLayout];
        [self.view setNeedsDisplay];
    }
    
    if (shadowView != _shadowLeftView) {
        _shadowLeftView = shadowView;
        
        [self.view insertSubview:_shadowLeftView atIndex:1];
        
        [self.view setNeedsLayout];
        [self.view setNeedsDisplay];
    }
    
    CGRect shadowFrame = CGRectMake(0 - _shadowLeftWidth + _shadowLeftOffset, 0.0, _shadowLeftWidth, self.view.bounds.size.height);
    _shadowLeftView.frame = shadowFrame;
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

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    return [super popViewControllerAnimated:animated];
}

@end
