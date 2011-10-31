//
//  CLBorderShadowView.m
//  Cascade
//
//  Created by Emil Wojtaszek on 23.08.2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CLBorderShadowView.h"

@implementation CLBorderShadowView

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)init {
    self = [super init];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        
        CGFloat colors[8] = DEFAULT_COLORS;
        [self setColors:colors];
        
    }
    return self;
}

- (void)setColors:(CGFloat[8]) colors {
    for (int i = 0; i < 8; i++) {
        _colors[i] = colors[i];
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) drawRect:(CGRect)rect {
    
    CGColorSpaceRef baseSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(baseSpace, _colors, NULL, 2);
    CGColorSpaceRelease(baseSpace), baseSpace = NULL;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGPoint startPoint = CGPointMake(0, CGRectGetMidY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMaxX(rect), CGRectGetMidY(rect));
    
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGGradientRelease(gradient), gradient = NULL;
    
    
}

@end
