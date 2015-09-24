//
//  MSManeger.m
//  Minion Says
//
//  Created by anna on 9/21/15.
//  Copyright (c) 2015 anna. All rights reserved.
//

#import "MSManeger.h"

static NSString *kArrayWithContentOfPlist = @"arrayWithContentOfPlist";

@interface MSManeger ()

@property (strong, nonatomic) NSArray *arrayWithContentOfPlist;

@end


@implementation MSManeger

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

+ (MSManeger *)sharedManager {
#warning static MSManeger *manager = nil;
    static MSManeger* manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[MSManeger alloc] init];
    });
    
    return manager;
}

#warning неудачное имя метода, лучше fillCoreDataDBWithInitialModels
- (void)resavingDataFromPlistToCoreData {
    
    NSManagedObjectModel *managedObjectModel = [self managedObjectModel];
    NSDictionary *attributesDictionary = [[[managedObjectModel entitiesByName] objectForKey:@"MSContent"] attributesByName];
    self.arrayWithContentOfPlist = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Content"
                                                                                                      ofType : @"plist"]];
#warning вокруг "=" должны быть пробелы
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
#warning зечем в NSUserDefaults хранить массив? Достаточно положить туда булевый флажок
    [defaults setObject:self.arrayWithContentOfPlist forKey:kArrayWithContentOfPlist];
    [defaults synchronize];

    for (NSDictionary *keyedValueDictionary in self.arrayWithContentOfPlist) {
        NSManagedObject *managedObject = [NSEntityDescription insertNewObjectForEntityForName:@"MSContent"
                                                                  inManagedObjectContext:[self managedObjectContext]];
#warning Лютый кусок кода. Можно было просто привести managedObject к типу MSContent и заполнить как обычно
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
#warning смысл в этом error, если он затем не обрабатывается
    NSError * error;
    [[self managedObjectContext] save:&error];
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
#warning @"MSContentModel.sqlite" - в константы
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"MSContentModel.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
#warning @"YOUR_ERROR_DOMAIN" :)
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
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
#warning вокруг "=" должны быть пробелы
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];

    if (![defaults objectForKey:kArrayWithContentOfPlist]) {
        [self resavingDataFromPlistToCoreData];
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
