//
//  NestedDataStore+Help.m
//  AsyncCoreData
//
//  Created by Zhangweina on 4/2/15.
//  Copyright (c) 2015 xiaofei. All rights reserved.
//

#import "NestedDataStore+Help.h"
#import "Student.h"
#import "NSDictionary+Parse.h"
#import <objc/runtime.h>

@implementation NestedDataStore (Help)

- (void)add:(NSDictionary *)dict
{
    Student *student = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:self.temporaryContext];
    [self fetch:dict to:student];
    [self saveContext];
}

- (void)update:(NSDictionary *)dict with:(NSPredicate *)predicate result:(CallBackBlock)block
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *results = [self.temporaryContext executeFetchRequest:request error:&error];
    
    if (error == nil)  {
        block(results, nil);
        return;
    }
    block(nil, error);
}

- (void)fetch:(NSDictionary *)dict to:(Student *)stu
{
    NSString *name = [dict stringForKey:@"name"];
    NSNumber *stu_id = (NSNumber *)[dict numberForKey:@"stu_id"];
    NSNumber *age = (NSNumber *)[dict numberForKey:@"age"];
    
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
