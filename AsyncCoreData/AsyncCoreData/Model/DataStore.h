//
//  DataStore.h
//  AsyncCoreData
//
//  Created by Zhangweina on 31/1/15.
//  Copyright (c) 2015 xiaofei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface DataStore : NSObject

@property(readonly, strong, nonatomic)NSManagedObjectContext *managedObjectContext;
@property(readonly, strong, nonatomic)NSManagedObjectModel *managedObjectModel;
@property(readonly, strong, nonatomic)NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (id)shareInstance;
- (void)saveContext;

@end
