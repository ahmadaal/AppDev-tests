//
//  ViewOneController.m
//  Controllers
//
//  Created by Aaltan Ahmad on 3/25/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewOneController.h"

@implementation ViewOneController

@synthesize slider, sliderval, label, button;
@synthesize rootview;
@synthesize colorModel;
@synthesize viewtwo;

- (IBAction)sliderChangedValue:(UISlider *)sender {
    self.sliderval = sender.value;
    /*UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"he" 
                                                    message:[NSString stringWithFormat:@"%d",sliderval]
                                                   delegate:self 
                                          cancelButtonTitle:@"cancel" 
                                          otherButtonTitles:nil, nil];
     [alert show];
     */
    self.label.text = [NSString stringWithFormat:@"%d",sliderval];
    NSLog(@"sliderVal/255.0: %F",((double)sliderval)/255.0);
    [self.colorModel setColorDbl:((double)sliderval)/255.0];

}

-(IBAction)buttonWasPressed:(id)sender {
    [self.navigationController pushViewController:viewtwo animated:YES];
}
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil model:(ColorModel *)model {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.colorModel = model;
    }
    return self;
}
*/

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    slider.value = [colorModel colorDbl]*255;
    [self.button setTitle:@"view 2" forState:UIControlStateNormal];
    viewtwo = [[ViewTwoController alloc] init];
    viewtwo.colorModel = colorModel;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)viewDidAppear:(BOOL)animated {
    slider.value = sliderval;
}

-(void)viewDidDisappear:(BOOL)animated {
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
