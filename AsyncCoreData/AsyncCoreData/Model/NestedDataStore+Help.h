//
//  NestedDataStore+Help.h
//  AsyncCoreData
//
//  Created by Zhangweina on 4/2/15.
//  Copyright (c) 2015 xiaofei. All rights reserved.
//

#import "NestedDataStore.h"

typedef void(^CallBackBlock)(NSArray* result, NSError *error);


@interface NestedDataStore (Help)

- (void)add:(NSDictionary *)dict;
- (void)update:(NSDictionary *)dict with:(NSPredicate *)predicate result:(CallBackBlock)block;



@end
