//
//  ViewOneController.h
//  Controllers
//
//  Created by Aaltan Ahmad on 3/25/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorModel.h"




@interface ViewOneController : UIViewController {
    UISlider *slider;
    int sliderval;
    UILabel *label;
    UIViewController *rootview;
    ColorModel *colorModel;
}

@property (nonatomic, retain) IBOutlet UISlider *slider;
@property (nonatomic) int sliderval;
@property (nonatomic, retain) IBOutlet UILabel *label;
@property (nonatomic, retain) UIViewController *rootview;
@property (nonatomic, retain) ColorModel *colorModel;

-(IBAction)sliderChangedValue:(id) sender;

@end
