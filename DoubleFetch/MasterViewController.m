//
//  MasterViewController.m
//  DoubleFetch
//
//  Created by Kaneuchi Tetsuya on 12/01/17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MasterViewController.h"
#import "FetchedResultsViewController.h"

@interface NSArray (CellTitles)

+ (NSArray *)titles;

@end

@implementation MasterViewController

@synthesize managedObjectContext = __managedObjectContext;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"DoubleFetch";
    }
    return self;
}
							
- (void)dealloc
{
    [__managedObjectContext release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = [[NSArray titles] objectAtIndex:indexPath.row];
    return cell;
}

- (NSPredicate *)predicateForChecked
{
    NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
    [request setEntity:[NSEntityDescription entityForName:@"Item" inManagedObjectContext:self.managedObjectContext]];

    NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES] autorelease];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptors];
    [request setPredicate:[NSPredicate predicateWithFormat:@"checked = YES"]];
    [request setResultType:NSManagedObjectIDResultType];
    NSError *err = nil;
    NSArray *result = [self.managedObjectContext executeFetchRequest:request error:&err];
    return [NSPredicate predicateWithFormat:@"self in %@", result];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSPredicate *predicate = nil;
    switch (indexPath.row) {
    case 0:
        predicate = nil;
        break;
    case 1:
        predicate = [NSPredicate predicateWithFormat:@"checked = YES"];
        break;
    case 2:
        predicate = [self predicateForChecked];
        break;
    default:
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        return;
    }
    NSString *title = [[NSArray titles] objectAtIndex:indexPath.row];
    FetchedResultsViewController *viewController = [[[FetchedResultsViewController alloc] initWithPredicate:predicate] autorelease];
    viewController.managedObjectContext = self.managedObjectContext;
    viewController.title = title;
    [self.navigationController pushViewController:viewController animated:YES];
}

@end


@implementation NSArray (CellTitles)

+ (NSArray *)titles
{
    return [NSArray arrayWithObjects:@"All", @"Checked 1", @"Checked 2", nil];
}

@end
