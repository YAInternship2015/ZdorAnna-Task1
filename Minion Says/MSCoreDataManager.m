//
//  MSManeger.m
//  Minion Says
//
//  Created by anna on 9/21/15.
//  Copyright (c) 2015 anna. All rights reserved.
//

#import "MSCoreDataManager.h"
#import "MSContent.h"
static NSString *kItWasFilledCoreDataDB = @"itWasFilledCoreDataDB";
static NSString *const URLByAppendingPathComponentForStoreURL = @"MSContentModel.sqlite";


@interface MSCoreDataManager ()

@property (assign, nonatomic) BOOL itWasFilledCoreDataDB;

@end


@implementation MSCoreDataManager

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

+ (MSCoreDataManager *)sharedManager {
    static MSCoreDataManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[MSCoreDataManager alloc] init];
    });
    
    return manager;
}

- (void)fillCoreDataDBWithInitialModels {
    
    NSManagedObjectModel *managedObjectModel = [self managedObjectModel];
    NSDictionary *attributesDictionary = [[[managedObjectModel entitiesByName] objectForKey:@"MSContent"] attributesByName];
    NSArray *arrayWithContentOfPlist = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Content"
                                                                                                      ofType:@"plist"]];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.itWasFilledCoreDataDB = YES;
    [defaults setBool:self.itWasFilledCoreDataDB forKey:kItWasFilledCoreDataDB];
    [defaults synchronize];

    for (NSDictionary *keyedValueDictionary in arrayWithContentOfPlist) {
        NSManagedObject *managedObject = [NSEntityDescription insertNewObjectForEntityForName:@"MSContent"
                                                                  inManagedObjectContext:[self managedObjectContext]];
        
        
        for (NSString *attribute in attributesDictionary) {
            id value = [keyedValueDictionary objectForKey:attribute] ;
            if (value == nil) {
                continue ;
            }
            NSAttributeType attributeType = [[attributesDictionary objectForKey:attribute] attributeType];
            
            if ((attributeType == NSStringAttributeType) &&
                ([value isKindOfClass:[NSNumber class]])) {
                
                value = [value stringValue];
                
            } else if (((attributeType == NSInteger16AttributeType) ||
                        (attributeType == NSInteger32AttributeType) ||
                        (attributeType == NSInteger64AttributeType) ||
                        (attributeType == NSBooleanAttributeType)) &&
                       [value isKindOfClass:[NSString class]]) {
                
                value = [NSNumber numberWithInteger:[value integerValue]];
                
            } else if ((attributeType == NSFloatAttributeType) &&
                       ([value isKindOfClass:[NSString class]])) {
                
                value = [NSNumber numberWithDouble:[value doubleValue]];
            }
            [managedObject setValue:value forKey:attribute];
        }
    }
    NSError *error = nil;
    if (![[self managedObjectContext] save:&error]) {
        NSLog(@"%@, %@", error, [error userInfo]);
    }
}


- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"MSContentModel" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:URLByAppendingPathComponentForStoreURL];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"MSContentDomain" code:9999 userInfo:dict];
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    if (![defaults boolForKey:kItWasFilledCoreDataDB]) {
        [self fillCoreDataDBWithInitialModels];
    }
    
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
