//
//  FetchedResultsViewController.h
//  DoubleFetch
//
//  Created by Kaneuchi Tetsuya on 12/01/17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface FetchedResultsViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSPredicate *predicate;

- (id)initWithPredicate:(NSPredicate *)predicate;

@end
