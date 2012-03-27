//
//  RootViewController.h
//  RSSTest
//
//  Created by Aaltan Ahmad on 3/13/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RSSModel, WebViewController;

@interface RootViewController : UITableViewController {
    RSSModel *_rssmodel;
    WebViewController *_web;
}

@property (retain) RSSModel *rssmodel;
@property (retain) WebViewController *web;
@end
