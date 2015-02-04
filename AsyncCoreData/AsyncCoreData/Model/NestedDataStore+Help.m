//
//  NestedDataStore+Help.m
//  AsyncCoreData
//
//  Created by Zhangweina on 4/2/15.
//  Copyright (c) 2015 xiaofei. All rights reserved.
//

#import "NestedDataStore+Help.h"
#import "Student.h"
#import <objc/runtime.h>

@implementation NestedDataStore (Help)

static void *MyClassResultKey;

- (void)add:(NSDictionary *)dict
{
    Student *student = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:self.temporaryContext];
    [self fetch:dict to:student];
}

- (void)update:(NSDictionary *)dict with:(NSPredicate *)predicate result:(Result)block
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *results = [self.temporaryContext executeFetchRequest:request error:&error];
    
    block(results, error);
//    if ([results count] != 1) {
//        return NO;
//    }
//    
//    Student *student = results[0];
//    [self fetch:dict to:student];
//    return YES;
}

- (void)fetch:(NSDictionary *)dict to:(Student *)stu
{
    NSString *name = (NSString *)[dict objectForKey:@"name"];
    NSNumber *stu_id = (NSNumber *)[dict objectForKey:@"stu_id"];
    NSNumber *age = (NSNumber *)[dict objectForKey:@"age"];
    
    if (name != nil) {
        stu.name = name;
    }
    if (stu_id != nil) {
        stu.stu_id = stu_id;
    }
    if (age != nil) {
        stu.age = age;
    }
}

@end
