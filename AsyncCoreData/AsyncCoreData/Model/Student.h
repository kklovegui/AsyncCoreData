//
//  Student.h
//  AsyncCoreData
//
//  Created by Zhangweina on 1/2/15.
//  Copyright (c) 2015 xiaofei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Student : NSManagedObject

@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSString * major;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * stu_id;

+ (Student *)userWithUniqueId:(NSNumber *)uniqueID;

@end
