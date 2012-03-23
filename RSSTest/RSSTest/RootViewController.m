//
//  RootViewController.m
//  RSSTest
//
//  Created by Aaltan Ahmad on 3/13/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "RSSEntry.h"
#import "ASIHTTPRequest.h"
#import "GDataXMLNode.h"
#import "GDataXMLExtra.h"
#import "WebViewController.h"

@implementation RootViewController

@synthesize entries = _entries;
@synthesize opQueue = _opQueue;
@synthesize feeds = _feeds;
@synthesize web = _web;


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
                [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:insertIdx inSection:0]]
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


/*
-(void)addSomeRows {
    RSSEntry *entry1 = [[[RSSEntry alloc] initWithBlogTitle:@"Blog 1" 
                                        blogURL:@"blog1.com" 
                                        articleTitle:@"Article 1" 
                                        articleText:@"Blah blah blah"
                                        articleURL:@"blog1.com/art1.html" 
                                              articleDate:[NSDate date]] autorelease];
    
    RSSEntry *entry2 = [[[RSSEntry alloc] initWithBlogTitle:@"Blog 2" 
                                                   blogURL:@"blog2.com" 
                                              articleTitle:@"Article 2" 
                                               articleText:@"Blah blah blah"
                                                articleURL:@"blog2.com/art2.html" 
                                               articleDate:[NSDate date]] autorelease];
    
    RSSEntry *entry3 = [[[RSSEntry alloc] initWithBlogTitle:@"Blog 3" 
                                                   blogURL:@"blog3.com" 
                                              articleTitle:@"Article 3" 
                                               articleText:@"Blah blah blah"
                                                articleURL:@"blog3.com/art3.html" 
                                               articleDate:[NSDate date]] autorelease];
    
    [_entries insertObject:entry1 atIndex:0];
    [_entries insertObject:entry2 atIndex:0];
    [_entries insertObject:entry3 atIndex:0]; 
    
}
*/

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Aaltan RSS Test";
    _entries = [[NSMutableArray array] retain];
    _opQueue = [[NSOperationQueue alloc] init];
    self.feeds = [NSArray arrayWithObjects:@"http://feeds.feedburner.com/RayWenderlich",
                  @"http://feeds.feedburner.com/vmwstudios",
                  @"http://idtypealittlefaster.blogspot.com/feeds/posts/default", 
                  @"http://www.71squared.com/feed/",
                  @"http://cocoawithlove.com/feeds/posts/default",
                  @"http://feeds2.feedburner.com/brandontreb",
                  @"http://feeds.feedburner.com/CoryWilesBlog",
                  @"http://geekanddad.wordpress.com/feed/",
                  @"http://iphonedevelopment.blogspot.com/feeds/posts/default",
                  @"http://karnakgames.com/wp/feed/",
                  @"http://kwigbo.com/rss",
                  @"http://shawnsbits.com/feed/",
                  @"http://pocketcyclone.com/feed/",
                  @"http://www.alexcurylo.com/blog/feed/",         
                  @"http://feeds.feedburner.com/maniacdev",
                  @"http://feeds.feedburner.com/macindie",
                  nil];    
    [self refresh];
} 
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   // NSLog(@"entries count : %@",[_entries count]);
    return [_entries count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }

    // Configure the cell.
    NSLog(@"row number %d",[indexPath row]);
    RSSEntry *thisEntry = [_entries objectAtIndex:[indexPath row]];
  
    
    NSLog(@"title : %@",thisEntry.articleTitle);
    
    NSDateFormatter *df = [[[NSDateFormatter alloc] init] autorelease];
    [df setTimeStyle:NSDateFormatterMediumStyle];
    [df setDateStyle:NSDateFormatterMediumStyle];
    NSString *date =[df stringFromDate:thisEntry.articleDate];
    
    cell.textLabel.text = thisEntry.articleTitle;
    cell.detailTextLabel.text = date;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
	*/
    
    if (_web == nil) {
        self.web = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:[NSBundle mainBundle]];
        self.web.title = @"XYZ";
    }
        RSSEntry *entry = [_entries objectAtIndex:indexPath.row];
        _web.entry = entry;
        [self.navigationController pushViewController:_web animated:YES];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    self.web = nil;
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [_entries release];
    [super viewDidUnload];

    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc
{
    [_entries dealloc];
    _entries = nil;
    [_opQueue dealloc];
    _opQueue = nil;
    [_feeds dealloc];
    _feeds = nil;
    _web = nil;
    [_web dealloc];
    [super dealloc];

}

@end
