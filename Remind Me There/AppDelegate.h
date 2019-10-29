//
//  AppDelegate.h
//  Remind Me There
//
//  Created by Ziad Abass on 11/18/17.
//  Copyright © 2017 University Of Leeds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <GooglePlaces/GooglePlaces.h>
@import GoogleMaps;
@import GooglePlaces;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


//@property (nonatomic) NSManagedObjectContext *context;


@end

