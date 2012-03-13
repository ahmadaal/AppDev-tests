//
//  RootViewController.m
//  RSSTest
//
//  Created by Aaltan Ahmad on 3/13/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "RSSEntry.h"

@implementation RootViewController

@synthesize entries = _entries;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Aaltan RSS Test";
    _entries = [NSMutableArray array];
    [self addSomeRows];
    
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
    RSSEntry *thisEntry = [RSSEntry alloc];
    if (([indexPath row] <= [_entries count]))
    {
        *thisEntry = [_entries objectAtIndex:[indexPath row]];
    }
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
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
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
    [_entries dealloc];
    [super dealloc];
}

@end
