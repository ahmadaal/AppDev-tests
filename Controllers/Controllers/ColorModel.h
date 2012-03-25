//
//  ColorModel.h
//  Controllers
//
//  Created by Aaltan Ahmad on 3/25/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ColorModel : NSObject {
    double colorInt;
    UIColor *colorfromInt;
}

@property (nonatomic) double colorInt;
@property (nonatomic, retain) UIColor *colorfromInt;

@end
