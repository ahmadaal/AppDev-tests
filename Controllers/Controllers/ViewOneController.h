//
//  ViewOneController.h
//  Controllers
//
//  Created by Aaltan Ahmad on 3/25/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorModel.h"
#import "ViewTwoController.h"




@interface ViewOneController : UIViewController {
    UISlider *slider;
    float sliderval;
    UILabel *label;
    UIViewController *rootview;
    ColorModel *colorModel;
    UIButton *button;
    ViewTwoController *viewtwo;
    
}

@property (nonatomic, retain) IBOutlet UISlider *slider;
@property (nonatomic) float sliderval;
@property (nonatomic, retain) IBOutlet UILabel *label;
@property (nonatomic, retain) IBOutlet UIButton *button;
@property (nonatomic, retain) UIViewController *rootview;
@property (nonatomic, retain) ColorModel *colorModel;
@property (nonatomic, retain) ViewTwoController *viewtwo;


-(IBAction)sliderChangedValue:(id) sender;
-(IBAction)buttonWasPressed:(id) sender;

@end
