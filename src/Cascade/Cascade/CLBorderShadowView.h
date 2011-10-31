//
//  CLBorderShadowView.h
//  Cascade
//
//  Created by Emil Wojtaszek on 23.08.2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DEFAULT_COLORS { 255.0, 255.0, 255.0, 0.0, 0.0, 0.0, 0.0, 0.2 }


@interface CLBorderShadowView : UIView {
    CGFloat _colors[8];
}

-(void)setColors:(CGFloat[8]) colors;

@end
