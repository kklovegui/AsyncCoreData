//
//  DataCoreTests.m
//  AsyncCoreData
//
//  Created by Zhangweina on 1/2/15.
//  Copyright (c) 2015 xiaofei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "DataStore.h"
#import "Student.h"

@interface DataCoreTests : XCTestCase{
    DataStore *dataStore;
}

@end

@implementation DataCoreTests

- (void)setUp {
    [super setUp];
    dataStore = [DataStore shareInstance];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testInsert
{
    NSManagedObjectContext * context = [dataStore managedObjectContext];
    NSManagedObject        * student  = nil;
    
    [dataStore documentsDirectory];
    
    student = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext: context];
    [student setValue:@1 forKey: @"stu_id"];
    NSLog (@"The Author's email is: %@", [student valueForKey:@"stu_id"]);
    
}

- (void)testUpdate
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSManagedObjectContext * context = [dataStore managedObjectContext];
    [request setEntity:[NSEntityDescription entityForName:@"Student" inManagedObjectContext:context]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"stu_id == %@", @1];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    NSLog(@"%@", results);
}

- (void)testFetchData
{
    NSManagedObjectContext * context = [dataStore managedObjectContext];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    NSError *error = nil;
    
    NSArray *results = [context executeFetchRequest:request error:&error];
    XCTAssertNil(error);
    
    Student *stu = results[0];
    NSLog(@"%@", stu.stu_id);
    NSLog(@"%@", results);

}

@end
