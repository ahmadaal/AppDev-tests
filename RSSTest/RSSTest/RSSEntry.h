//
//  RSSEntry.h
//  RSSTest
//
//  Created by Aaltan Ahmad on 3/13/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RSSEntry : NSObject {
    
    NSString *_blogTitle;
    NSString *_blogURL;
    NSString *_articleTitle;
    NSString *_articleURL;
    NSDate *_date;

}

@property (copy) NSString *blogTitle;
@property (copy) NSString *blogURL;
@property (copy) NSString *articleTitle;
@property (copy) NSString *articleURL;
@property (copy) NSDate *articleDate;

- (RSSEntry*)initWithBlogTitle:(NSString*)bt 
                       blogURL:(NSString*)bu 
                  articleTitle:(NSString*)atit 
                    articleURL:(NSString*)au 
                   articleDate:(NSDate*)ad;

@end
