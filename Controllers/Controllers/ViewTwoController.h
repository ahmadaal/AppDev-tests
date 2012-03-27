//
//  ViewTwoController.h
//  Controllers
//
//  Created by Aaltan Ahmad on 3/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorModel.h"

@interface ViewTwoController : UITableViewController {
    ColorModel *colorModel;
    NSArray *possibleColors;
}

@property (nonatomic, retain) ColorModel *colorModel;
@property (nonatomic, retain) NSArray *possibleColors;

@end
