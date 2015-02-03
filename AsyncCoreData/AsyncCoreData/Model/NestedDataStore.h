//
//  DataStore.h
//  AsyncCoreData
//
//  Created by Zhangweina on 31/1/15.
//  Copyright (c) 2015 xiaofei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface NestedDataStore : NSObject

@property(readonly, strong, nonatomic)NSManagedObjectContext *temporaryContext;
@property(readonly, strong, nonatomic)NSManagedObjectModel *managedObjectModel;
@property(readonly, strong, nonatomic)NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (id)shareInstance;
- (void)saveContext;
- (NSURL *)documentsDirectory;

@end
