//
//  Course.h
//  HW41-44
//
//  Created by Илья Егоров on 02.08.15.
//  Copyright (c) 2015 Илья Егоров. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Student, Teacher;

@interface Course : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *lecturers;
@property (nonatomic, retain) NSSet *students;
@end

@interface Course (CoreDataGeneratedAccessors)

- (void)addLecturersObject:(Teacher *)value;
- (void)removeLecturersObject:(Teacher *)value;
- (void)addLecturers:(NSSet *)values;
- (void)removeLecturers:(NSSet *)values;

- (void)addStudentsObject:(Student *)value;
- (void)removeStudentsObject:(Student *)value;
- (void)addStudents:(NSSet *)values;
- (void)removeStudents:(NSSet *)values;

@end
