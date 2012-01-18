//
//  MasterViewController.h
//  DoubleFetch
//
//  Created by Kaneuchi Tetsuya on 12/01/17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "FetchedResultsViewController.h"

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
