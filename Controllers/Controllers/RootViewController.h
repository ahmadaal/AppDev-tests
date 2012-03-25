//
//  RootViewController.h
//  Controllers
//
//  Created by Aaltan Ahmad on 3/25/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewOneController.h"
#import "ColorModel.h"

@interface RootViewController : UIViewController {
    UIButton *button;
    ViewOneController *viewone;
    int colorVal;
    ColorModel *colorModel;

}
@property (nonatomic, retain) IBOutlet UIButton *button;
@property (nonatomic, retain) ViewOneController *viewone;
@property (nonatomic) int colorVal;
@property (nonatomic, retain) ColorModel *colorModel;

-(IBAction) onButtonClick:(id) sender;

-(void)changeColorWithInt:(int)colorVal;

@end
