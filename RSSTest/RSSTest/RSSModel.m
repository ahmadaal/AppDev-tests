//
//  RSSModel.m
//  RSSTest
//
//  Created by Aaltan Ahmad on 3/27/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "RSSModel.h"
#import "RSSEntry.h"
#import "ASIHTTPRequest.h"
#import "GDataXMLNode.h"
#import "GDataXMLExtra.h"
#import "WebViewController.h"

@implementation RSSModel

@synthesize entries = _entries;
@synthesize opQueue = _opQueue;
@synthesize feeds = _feeds;
@synthesize web = _web;
@synthesize delegate = _delegate;

-(void)parseRSS:(GDataXMLElement *)rootElement entries:(NSMutableArray *)array {
    NSArray *channels = [rootElement elementsForName:@"channel"];
    for (GDataXMLElement *channel in channels) {
        NSString *blogTitle = [channel valueForChild:@"title"];
        NSArray *items = [channel elementsForName:@"item"];
        for (GDataXMLElement *item in items) {
            NSString *articleTitle = [item valueForChild:@"title"];
            NSString *articleURL = [item valueForChild:@"link"];
            //NSString *articleDate = [item valueForChild:@"pubDate"];
            NSDate *date = [NSDate date];
            RSSEntry *entry = [[[RSSEntry alloc] initWithBlogTitle:blogTitle
                                                           blogURL:@"no url"
                                                      articleTitle:articleTitle 
                                                        articleURL:articleURL   
                                                       articleDate:date] autorelease];
            [array addObject:entry];
            
        }
    }
}

-(void)parseAtom:(GDataXMLElement *)rootElement entries:(NSMutableArray *)entries {
    
    NSString *blogTitle = [rootElement valueForChild:@"title"];                    
    
    NSArray *items = [rootElement elementsForName:@"entry"];
    for (GDataXMLElement *item in items) {
        
        NSString *articleTitle = [item valueForChild:@"title"];
        NSString *articleUrl = nil;
        NSArray *links = [item elementsForName:@"link"];        
        for(GDataXMLElement *link in links) {
            NSString *rel = [[link attributeForName:@"rel"] stringValue];
            NSString *type = [[link attributeForName:@"type"] stringValue]; 
            if ([rel compare:@"alternate"] == NSOrderedSame && 
                [type compare:@"text/html"] == NSOrderedSame) {
                articleUrl = [[link attributeForName:@"href"] stringValue];
            }
        }
        
        NSString *articleDateString = [item valueForChild:@"updated"];        
        NSDate *articleDate = [NSDate date];
        
        RSSEntry *entry = [[[RSSEntry alloc] initWithBlogTitle:blogTitle 
                                                       blogURL:@"no url"
                                                  articleTitle:articleTitle 
                                                    articleURL:articleUrl 
                                                   articleDate:articleDate] autorelease];
        [entries addObject:entry];
        
    }      
    
}


-(void)parseFeeds:(GDataXMLElement *)rootElement entries:(NSMutableArray *)array {
    if ([rootElement.name compare:@"rss"] == NSOrderedSame)
        [self parseRSS:rootElement entries:array];
    if ([rootElement.name compare:@"atom"] == NSOrderedSame)
        [self parseAtom:rootElement entries:array];
    else NSLog(@"unrecongnized feed format: %@",rootElement.name);
}

-(void)refresh {
    for (NSString *feed in _feeds) {
        NSURL *url = [NSURL URLWithString:feed];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        [request setDelegate:self];
        [_opQueue addOperation:request];
    }
}

- (void)requestFinished:(ASIHTTPRequest *)request {
    
    RSSEntry *entry = [RSSEntry alloc];
    
    [entry initWithBlogTitle:request.url.absoluteString blogURL:request.url.absoluteString articleTitle:request.url.absoluteString articleURL:request.url.absoluteString articleDate:[[NSDate date] autorelease]];
    
    
    [_opQueue addOperationWithBlock:^{
        NSError *error;
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:[request responseData] options:0 error:&error];
        
        if(doc == nil) {
            NSLog(@"request failed: %@",request.url);   
        }
        else {
            NSMutableArray *entriesToAdd = [[NSMutableArray alloc] init];
            [self parseFeeds:doc.rootElement entries:entriesToAdd];
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                for (RSSEntry *entry in entriesToAdd) {
                    int insertIdx = 0;                    
                    [_entries insertObject:entry atIndex:insertIdx];
                    [self.delegate.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:insertIdx inSection:0]]
                                          withRowAnimation:UITableViewRowAnimationRight];
                }
            }];
        }
    }];
    
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    NSError *error = [request error];
    NSLog(@"Error: %@", error);
}



@end
