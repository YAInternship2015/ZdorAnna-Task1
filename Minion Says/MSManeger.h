//
//  MSManeger.h
//  Minion Says
//
//  Created by anna on 9/21/15.
//  Copyright (c) 2015 anna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#warning не самое удачное имя, непонятно, чем класс занимается. И с опечаткой)) Лучше MSCoreDataManager
@interface MSManeger : NSObject

@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

+ (MSManeger*) sharedManager;

@end
