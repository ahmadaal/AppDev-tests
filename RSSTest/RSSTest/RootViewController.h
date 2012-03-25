//
//  RootViewController.h
//  RSSTest
//
//  Created by Aaltan Ahmad on 3/13/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WebViewController;

@interface RootViewController : UITableViewController {

    NSMutableArray *_entries;
    NSOperationQueue *_opQueue;
    NSArray *_feeds;
    WebViewController *_web;
}



@property (retain, nonatomic) NSMutableArray *entries;
@property (retain) NSOperationQueue *opQueue;
@property (retain) NSArray *feeds;
@property (retain) WebViewController *web;

@end
