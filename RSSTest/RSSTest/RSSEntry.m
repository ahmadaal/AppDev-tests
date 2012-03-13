//
//  RSSEntry.m
//  RSSTest
//
//  Created by Aaltan Ahmad on 3/13/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "RSSEntry.h"


@implementation RSSEntry

@synthesize blogTitle = _blogTitle;
@synthesize blogURL = _blogURL;
@synthesize articleTitle = _articleTitle;
@synthesize articleText = _articleText;
@synthesize articleURL = _articleURL;
@synthesize articleDate = _articleDate;

- (RSSEntry*)initWithBlogTitle:(NSString*)blogTitle blogURL:(NSString*)blogURL articleTitle:(NSString*)articleTitle articleText:(NSString*)articleText articleURL:(NSString*)articleURL articleDate:(NSDate*)articleDate {
    
    _blogTitle = [blogTitle copy];
    _blogURL = [blogURL copy];
    _articleTitle = [articleTitle copy];
    _articleText = [articleText copy];
    _articleURL = [articleURL copy];
    _articleDate = [articleDate copy];
    
    return self;
}

-(void)dealloc {
    [_blogTitle release];
    [_blogURL release];
    [_articleTitle release];
    [_articleDate release];
    [_articleText release];
    [_articleURL release];
    [super dealloc];
}
@end
