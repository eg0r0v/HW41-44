//
//  DataManager.h
//  HW41-44
//
//  Created by Илья Егоров on 01.08.15.
//  Copyright (c) 2015 Илья Егоров. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>

@class Student, Teacher, Course;

@interface DataManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

+ (DataManager*) sharedManager;

-(Student*)addRandomStudent;
-(Teacher*)addRandomTeacher;
-(Course*)addCourseWithName:(NSString*)name;

-(void)generateEducationSphere;

@end
