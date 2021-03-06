//
//  DataStore.m
//  AsyncCoreData
//
//  Created by Zhangweina on 31/1/15.
//  Copyright (c) 2015 xiaofei. All rights reserved.
//

#import "NestedDataStore.h"
#import <objc/runtime.h>

static void *temporaryContextKey;

@implementation NestedDataStore{
    NSManagedObjectContext *mainManagedObjectContext;
    NSManagedObjectContext *bgManagedObjectContext;
}

@synthesize temporaryContext = _temporaryContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

+ (id)shareInstance
{
    static NestedDataStore *nestedDataStore;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        nestedDataStore = [[NestedDataStore alloc] init];
    });
    return nestedDataStore;
}

- (NSURL *)documentsDirectory{
    NSLog(@"%@", [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]);
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"AsyncCoreData" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    
    NSURL *storeURL = [[self documentsDirectory] URLByAppendingPathComponent:@"AsyncCoreData.sqlite"];
    NSError *error = nil;
    NSString *errorReason = @"here was an error creating or loading the application's saved data.";
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = errorReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)mainManagedObjectContext
{
    if (mainManagedObjectContext != nil) {
        return mainManagedObjectContext;
    }
    
    mainManagedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [mainManagedObjectContext setParentContext:self.bgManagedObjectContext];
    
    return mainManagedObjectContext;
}

- (NSManagedObjectContext *)bgManagedObjectContext
{
    if (bgManagedObjectContext != nil) {
        return bgManagedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator == nil) {
        abort();
    }
    bgManagedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    [bgManagedObjectContext setPersistentStoreCoordinator:coordinator];
    
    return bgManagedObjectContext;
}

- (NSManagedObjectContext *)temporaryContext
{
    if (_temporaryContext != nil) {
        return _temporaryContext;
    }
    
    _temporaryContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    _temporaryContext.parentContext = [self mainManagedObjectContext];
    
    return _temporaryContext;
}

- (void)saveContext
{
    NSManagedObjectContext *managedObjectContext = self.mainManagedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
