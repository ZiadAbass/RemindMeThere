//
//  AppDelegate.m
//  Remind Me There
//
//  Created by Ziad Abass on 11/18/17.
//  Copyright © 2017 University Of Leeds. All rights reserved.
//

#import "AppDelegate.h"
#import "Reminder+CoreDataClass.h"


@interface AppDelegate ()


@property (nonatomic) NSManagedObjectContext *context;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    

    [GMSServices provideAPIKey:@"<Your-GoogleCloud-API-key>"];
    [GMSPlacesClient provideAPIKey:@"<Your-GoogleCloud-API-key>"];
    
    
    // This will call the persistentContainer getter.
    self.context = self.persistentContainer.viewContext;
    
    
    
    //CREATING
    //[self createData];
    
    //FETCHING
    //[self basicFetch];
    
    //FETCHING W/ SORTING
    //[self fetchWithSort];
    
    //FETCHING W/ FILTER
    //[self fetchWithFilter];
    
    //UPDATING
    //[self updatePersons];
    
    //DELETING
    //[self deleteReminder];
    
    
    return YES;
}




/*



////////////////////////////////////////////////////////////////

// CREATING DATA

- (void) createData
{
    
    Reminder *r1 = [[Reminder alloc] initWithContext:self.context];
    r1.label = @"Manyaka";
    r1.text = @"aady awel reminder";
    
 
    Reminder *r2 = [[Reminder alloc] initWithContext:self.context];
    r2.label = @"Ba3basa";
    r2.text = @"aady taany reminder";
 
    
    [self saveContext];
}



 
////////////////////////////////////////////////////////////////

// FETCHING DATA


- (void) basicFetch
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reminder"];
    
    // Returning an array of Person called persons:
    NSArray<Reminder*>*reminders = [self.context executeFetchRequest:request error:nil];
    
    //call at the NSLog method below to print the array
    [self printResultsFromArray:reminders];
    
}




////////////////////////////////////////////////////////////////

// FETCHING DATA WITH FILTER

// msh lazem return nsarray btw momken void eshta 3amalnaha array for sake of following method
- (NSArray <Reminder*>*) fetchWithFilter
{
    
    NSString *temp = @"Manyaka";
    
    // creating request object like before
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reminder"];
    
    // create a predicate to the fetched data to filter it
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"label == %@",temp];

    
    //apply predicate to the results fetched
    request.predicate = predicate;
    
    
    // Returning an array of Person called persons:
    NSArray<Reminder*>*reminders = [self.context executeFetchRequest:request error:nil];
    
    //call at the NSLog method below to print the array
    [self printResultsFromArray:reminders];
    
    return reminders;
    
    
}





////////////////////////////////////////////////////////////////

// DELETING

- (void) deleteReminder
{
    // calling the previous filtering method which will return array
    Reminder *temp = [self fetchWithFilter][0];
    
    [self.context deleteObject:temp];
    
    [self saveContext];
    
}



////////////////////////////////////////////////////////////////

// PRINTING RESULTS

- (void) printResultsFromArray:(NSArray <Reminder*>*) reminders
{
    for (Reminder *reminder in reminders)
    {
        NSLog(@"Reminder with label: %@ has the text: %@", reminder.label, reminder.text);
    }
}



*/





- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}





#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        // law el persistentContainer mish mawgood initialise it:
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"RemindMeThere"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    
//                     Typical reasons for an error here include:
//                     * The parent directory does not exist, cannot be created, or disallows writing.
//                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
//                     * The device is out of space.
//                     * The store could not be migrated to the current model version.
//                     Check the error message to determine what the actual problem was.
//
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}




#pragma mark - Core Data Saving support

- (void)saveContext {
    
    
    NSError *error = nil;
    if ([self.context hasChanges] && ![self.context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}



/*

#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"RemindMeThere"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    
//                     Typical reasons for an error here include:
//                     * The parent directory does not exist, cannot be created, or disallows writing.
//                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
//                     * The device is out of space.
//                     * The store could not be migrated to the current model version.
//                     Check the error message to determine what the actual problem was.
//
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}


*/

@end

