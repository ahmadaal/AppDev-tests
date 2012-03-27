//
//  ColorModel.m
//  Controllers
//
//  Created by Aaltan Ahmad on 3/25/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ColorModel.h"


@implementation ColorModel

@synthesize colorDbl, colorfromInt;

-(UIColor *)colorfromInt {
    CGFloat colorDblAsCGFloat = (CGFloat)colorDbl;
    NSLog(@"colorDblAsCGFloat is %f",colorDblAsCGFloat);
    return [UIColor colorWithRed:colorDbl                                   
                           green:colorDbl/2
                            blue:colorDbl/4
                           alpha:1.0];

}
/*
-(ColorModel *)initWithcolorDbl:(int)color {
    colorDbl = color;
    return self;
}
*/
-(void)setcolorDbl:(double)color{
    NSLog(@"setcolorDbl with %F", color);
    colorDbl = color;
}

@end
