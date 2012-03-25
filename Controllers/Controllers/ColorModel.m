//
//  ColorModel.m
//  Controllers
//
//  Created by Aaltan Ahmad on 3/25/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ColorModel.h"


@implementation ColorModel

@synthesize colorInt, colorfromInt;

-(UIColor *)colorfromInt {
    CGFloat colorIntAsCGFloat = (CGFloat)colorInt;
    NSLog(@"colorIntAsCGFloat is %f",colorIntAsCGFloat);
    return [UIColor colorWithRed:colorInt                                   
                           green:colorInt
                            blue:colorInt
                           alpha:1.0];

}
/*
-(ColorModel *)initWithColorInt:(int)color {
    colorInt = color;
    return self;
}
*/
-(void)setColorInt:(double)color{
    NSLog(@"setColorInt with %F", color);
    colorInt = color;
}

@end
