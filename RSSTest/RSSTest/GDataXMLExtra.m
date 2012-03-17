//
//  GDataXMLExtra.m
//  RSSTest
//
//  Created by Aaltan Ahmad on 3/17/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GDataXMLExtra.h"

@implementation GDataXMLElement(Extras)

- (GDataXMLElement *)elementForChild:(NSString *)childName {
    NSArray *children = [self elementsForName:childName];            
    if (children.count > 0) {
        GDataXMLElement *childElement = (GDataXMLElement *) [children objectAtIndex:0];
        return childElement;
    } else return nil;
}

- (NSString *)valueForChild:(NSString *)childName {    
    return [[self elementForChild:childName] stringValue];    
}

@end