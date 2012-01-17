//
//  Item.h
//  DoubleFetch
//
//  Created by Kaneuchi Tetsuya on 12/01/18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Item : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic) BOOL checked;

@end
