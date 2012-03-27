//
//  RootViewController.m
//  RSSTest
//
//  Created by Aaltan Ahmad on 3/13/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "RSSEntry.h"
#import "WebViewController.h"
#import "RSSModel.h"

@implementation RootViewController

@synthesize rssmodel = _rssmodel;
@synthesize web = _web;

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

-(void)addButtonWasPressed:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Add button was pressed" 
                                                    message:@"You pressed a button" 
                                                   delegate:self
                                          cancelButtonTitle:@"Okay" 
                                          otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"+" style:UIBarButtonItemStylePlain target:self action:@selector(addButtonWasPressed:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    self.rssmodel = [[RSSModel alloc] init];
    
    self.title = @"Aaltan RSS Test";
    self.rssmodel.entries = [[NSMutableArray array] retain];
    self.rssmodel.opQueue = [[NSOperationQueue alloc] init];
    self.rssmodel.feeds = [NSArray arrayWithObjects:@"http://feeds.feedburner.com/RayWenderlich",
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
    [self.rssmodel refresh];
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
    return [self.rssmodel.entries count];
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
    RSSEntry *thisEntry = [self.rssmodel.entries objectAtIndex:[indexPath row]];
  
    
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
        RSSEntry *entry = [self.rssmodel.entries objectAtIndex:indexPath.row];
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
    [super viewDidUnload];

    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc
{
    _rssmodel = nil;
    [_rssmodel dealloc];
    _web = nil;
    [_web dealloc];
    [super dealloc];

}

@end
