//
//  RootViewController.h
//  RSSTest
//
//  Created by Aaltan Ahmad on 3/13/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UITableViewController {

    NSMutableArray *_entries;
}
@property (retain, nonatomic) NSMutableArray *entries;

@end
