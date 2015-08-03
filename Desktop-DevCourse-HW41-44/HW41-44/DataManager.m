//
//  DataManager.m
//  HW41-44
//
//  Created by Илья Егоров on 01.08.15.
//  Copyright (c) 2015 Илья Егоров. All rights reserved.
//

#import "DataManager.h"
#import "Teacher.h"
#import "Student.h"
#import "Course.h"

static NSString* firstNames[] = {
    @"Tran", @"Ramon", @"Brent", @"Bud", @"Denver",
    @"Norbert", @"Clyde", @"Hildegard", @"Vernell",  @"Rupert",
    @"Billie", @"Ty", @"Ben", @"Willard", @"Colton",
    @"Floyd", @"Pierre", @"Trang",
    @"Tamica", @"Crystle", @"Kandi", @"Caridad", @"Elise",
    @"Vanetta", @"Taylor", @"Pinkie",  @"Rosanna", @"Roma",
    @"Eufemia", @"Britteny",  @"Jacque", @"Telma", @"Mireille",
    @"Monte", @"Pam", @"Tracy", @"Tresa", @"Savanna",
    @"Whitney", @"Fredda", @"Katrice", @"Meghan", @"Tandra",
    @"Jenise",  @"Elenor", @"Sha", @"Lenore", @"Arvilla", @"Nellie", @"Jessie"
};

static NSString* lastNames[] = {
    
    @"Farrah", @"Laviolette", @"Heal", @"Sechrest", @"Roots",
    @"Homan", @"Starns", @"Oldham", @"Yocum", @"Mancia",
    @"Prill", @"Lush", @"Piedra", @"Castenada", @"Warnock",
    @"Vanderlinden", @"Simms", @"Gilroy", @"Brann", @"Bodden",
    @"Lenz", @"Gildersleeve", @"Wimbish", @"Bello", @"Beachy",
    @"Jurado", @"William", @"Beaupre", @"Dyal", @"Doiron",
    @"Plourde", @"Bator", @"Krause", @"Odriscoll", @"Corby",
    @"Waltman", @"Michaud", @"Kobayashi", @"Sherrick", @"Woolfolk",
    @"Holladay", @"Hornback", @"Moler", @"Bowles", @"Libbey",
    @"Spano", @"Folson", @"Arguelles", @"Burke", @"Rook"
};

static NSString* carModelNames[] = {
    @"Dodge", @"Toyota", @"BMW", @"Lada", @"Volga"
};

static int namesCount = 50;


@implementation DataManager

+(DataManager*) sharedManager {
    
    static DataManager* manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DataManager alloc] init];
        [manager generateEducationSphere];
    });
    
    return manager;
}

#pragma mark - AddObjects

-(Teacher*)addRandomTeacher {
    
    Teacher* teacher = [NSEntityDescription insertNewObjectForEntityForName:@"Teacher"
                                                     inManagedObjectContext:self.managedObjectContext];
    
    teacher.firstName = firstNames[arc4random_uniform(namesCount)];
    teacher.lastName = lastNames[arc4random_uniform(namesCount)];
    
    return teacher;
}

-(Student*) addRandomStudent {
    
    Student* student = [NSEntityDescription insertNewObjectForEntityForName:@"Student"
                                                     inManagedObjectContext:self.managedObjectContext];
    
    student.firstName = firstNames[arc4random_uniform(namesCount)];
    student.lastName = lastNames[arc4random_uniform(namesCount)];
    student.email = [[NSString stringWithFormat:@"%@-%@@gmail.com", student.firstName, student.lastName] lowercaseString];
    
    return student;
}

-(Course*) addCourseWithName:(NSString*)name {
    
    Course* course = [NSEntityDescription insertNewObjectForEntityForName:@"Course" inManagedObjectContext:self.managedObjectContext];
    
    course.name = name;
    
    return course;
}


#pragma mark - GetObjects

-(NSArray*)allObjects {
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* description = [NSEntityDescription entityForName:@"Object"
                                                   inManagedObjectContext:self.managedObjectContext];
    
    [request setEntity:description];
    
    NSError* error = nil;
    NSArray* resultArray = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
    
    return resultArray;
}


#pragma mark - Print

-(void)printArray:(NSArray*)array {
    
    for (id object in array) {
        
        if ([object isKindOfClass:[Teacher class]]) {
            
            Teacher* teacher = (Teacher*)object;
            NSLog(@"TEACHER: %@ %@, NUMBER OF COURSES: %d", teacher.firstName, teacher.lastName, [teacher.courses count]);
            
        } else if ([object isKindOfClass:[Student class]]) {
            
            Student* student = (Student*)object;
            NSLog(@"STUDENT: %@ %@, COURSES: %d",
                  student.firstName, student.lastName,
                  [student.courses count]);
            
        } else if ([object isKindOfClass:[Course class]]) {
            
            Course* course = (Course*)object;
            NSLog(@"COURSE: %@, %d students", course.name, [course.students count]);
        }
    }
    
    NSLog(@"COUNT: %d", [array count]);
}


-(void) printAllObjects {
    
    NSArray* allObjects = [self allObjects];
    
    [self printArray:allObjects];
    
}

#pragma mark - RemoveObjects

-(void) deleteAllObjects {
    
    for (id object in [self allObjects]) {
        [self.managedObjectContext deleteObject:object];
    }
    
    [self.managedObjectContext save:nil];
}

#pragma mark - Main

-(void)generateEducationSphere{
    
    [self deleteAllObjects];

    NSArray* courses = @[[self addCourseWithName:@"iOS"],
                         [self addCourseWithName:@"Android"],
                         [self addCourseWithName:@"PHP"],
                         [self addCourseWithName:@"JavaScript"],
                         [self addCourseWithName:@"HTML"]];
    
    for (int i = 0; i < 100; i++) {
        Student* student = [self addRandomStudent];
        
        NSInteger numberOfCourses = 1 + arc4random_uniform(5);
        
        while ([student.courses count] < numberOfCourses) {
            Course* course = [courses objectAtIndex:arc4random_uniform(5)];
            
            if (![student.courses containsObject:course]) {
                [student addCoursesObject:course];
            }
        }
    }
    
    for (int i = 0; i < 7; i++) {
        
        Teacher* teacher = [self addRandomTeacher];
        
        NSInteger numberOfCourses = 1 + arc4random_uniform(3);
        
        while ([teacher.courses count] < numberOfCourses) {
            Course* course = [courses objectAtIndex:arc4random_uniform(5)];
            
            if (![teacher.courses containsObject:course]) {
                [teacher addCoursesObject:course];
            }
        }
    }
    
    [self.managedObjectContext save:nil];
    [self printAllObjects];
}



#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.ilyaegorov._lesson41_CoreDataTest" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"HW41_44" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"HW41_44.sqlite"];
    NSError *error = nil;
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        
        [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
        
        [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                  configuration:nil
                                                            URL:storeURL
                                                        options:nil
                                                          error:&error];
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            [[[UIAlertView alloc] initWithTitle:@"Error"
                                        message:[error localizedDescription]
                                       delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil] show];
        }
    }
}

@end
