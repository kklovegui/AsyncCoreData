//
//  NSDictionary+Parse.m
//  AsyncCoreData
//
//  Created by Zhangweina on 7/2/15.
//  Copyright (c) 2015 xiaofei. All rights reserved.
//

#import "NSDictionary+Parse.h"

@implementation NSDictionary (Parse)

-(BOOL) booleanForKey:(NSString*)key {
    BOOL i = NO;
    id object;
    if (key &&
        (object = [self objectForKey:key]) &&
        [object respondsToSelector:@selector(boolValue)]) {
        i = [object boolValue];
    }
    return i;
}

-(int) intForKey:(NSString*)key {
    int i=0;
    id object;
    if (key &&
        (object = [self objectForKey:key]) &&
        [object respondsToSelector:@selector(intValue)]) {
        i = [object intValue];
    }
    return i;
}

-(float) floatForKey:(NSString*)key {
    float i=0;
    id object;
    if (key &&
        (object = [self objectForKey:key]) &&
        [object respondsToSelector:@selector(floatValue)]) {
        i = [object floatValue];
    }
    return i;
}

-(double) doubleForKey:(NSString*)key {
    double i=0;
    id object;
    
    if (key &&
        (object = [self objectForKey:key]) &&
        [object respondsToSelector:@selector(doubleValue)]) {
        i = [object doubleValue];
    }
    return i;
}

-(NSString*) stringForKey:(NSString*)key {
    NSString* i=nil;
    id object;
    if (key &&
        (object = [self objectForKey:key]) &&
        [object isKindOfClass:[NSString class]]) {
        i = (NSString*) object;
    }
    return i;
}

-(NSDictionary*) dictionaryForKey:(NSString*)key {
    NSDictionary* i=nil;
    id object;
    if (key &&
        (object = [self objectForKey:key]) &&
        [object isKindOfClass:[NSDictionary class]]) {
        i = (NSDictionary*) object;
    }
    return i;
}

-(NSArray*) arrayForKey:(NSString*)key {
    NSArray* i=nil;
    id object;
    if (key &&
        (object = [self objectForKey:key]) &&
        [object isKindOfClass:[NSArray class]]) {
        i = (NSArray*) object;
    }
    return i;
}

-(NSNumber*) numberForKey:(NSString*)key {
    NSNumber* i=nil;
    id object;
    if (key &&
        (object = [self objectForKey:key]) &&
        [object isKindOfClass:[NSNumber class]]) {
        i = (NSNumber*) object;
    }
    return i;
}


@end
