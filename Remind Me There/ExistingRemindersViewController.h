//
//  FirstViewController.h
//  Remind Me There
//
//  Created by Ziad Abass on 11/18/17.
//  Copyright © 2017 University Of Leeds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

//////////////
#import "Reminder+CoreDataClass.h"
#import "AppDelegate.h"
@import CoreData;
//////////////


@interface ExistingRemindersViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate>


@property (weak, nonatomic) IBOutlet UITableView *existingRemindersTable;


@property NSMutableArray *existingReminderLabels;
@property NSMutableArray *existingReminderPhotos;


- (IBAction)editBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *editBtnOut;

- (IBAction)doneBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *doneBtnOut;


////////////////////////////////////

// Creating a person array from the data entitiy
@property NSArray<Reminder*>* reminders;


@property (nonatomic) NSManagedObjectContext *context;

//creating an object for the appdelegate
@property (weak, nonatomic) AppDelegate *delegate;


@property (strong, nonatomic) CLLocationManager *locationManager;


@property(nonatomic, copy) NSSet<__kindof CLRegion *> *monitoredRegions;
@property(nonatomic, copy) NSSet<__kindof CLRegion *> *filteredSet;
@property(nonatomic, copy) NSArray<__kindof CLRegion *> *filteredArray;


////////////////////////////////////


@end

