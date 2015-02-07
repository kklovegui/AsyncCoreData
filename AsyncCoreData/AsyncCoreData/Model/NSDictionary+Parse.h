//
//  NSDictionary+Parse.h
//  AsyncCoreData
//
//  Created by Zhangweina on 7/2/15.
//  Copyright (c) 2015 xiaofei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Parse)

- (BOOL) booleanForKey:(NSString *)key;
- (int) intForKey:(NSString *)key;
- (float) floatForKey:(NSString *)key;
- (double) doubleForKey:(NSString *)key;
- (NSString *) stringForKey:(NSString *)key;
- (NSDictionary *) dictionaryForKey:(NSString *)key;
- (NSArray *) arrayForKey:(NSString *)key;
- (NSNumber *) numberForKey:(NSString *)key;
@end
