//
//  RSSModel.h
//  RSSTest
//
//  Created by Aaltan Ahmad on 3/27/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WebViewController;
@class GDataXMLElement;
@class ASIHTTPRequest;
@class UITableViewController;

@interface RSSModel : NSObject {
    NSMutableArray *_entries;
    NSOperationQueue *_opQueue;
    NSArray *_feeds;
    WebViewController *_web;
    UITableViewController *_delegate;
}

@property (retain, nonatomic) NSMutableArray *entries;
@property (retain) NSOperationQueue *opQueue;
@property (retain) NSArray *feeds;
@property (retain) WebViewController *web;
@property (retain) UITableViewController *delegate;

-(void)parseFeeds:(GDataXMLElement *)rootElement entries:(NSMutableArray *)array;
-(void)refresh;
-(void)requestFinished:(ASIHTTPRequest *)request;
-(void)requestFailed:(ASIHTTPRequest *)request;

@end
