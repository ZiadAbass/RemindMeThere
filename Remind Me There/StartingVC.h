//
//  StartingVC.h
//  Remind Me There
//
//  Created by Ziad Abass on 7/10/18.
//  Copyright © 2018 University Of Leeds. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "Popup.h"
@import GooglePlaces;
@import GoogleMaps;
@import GooglePlacePicker;

#import <CoreLocation/CoreLocation.h>
#import "ExistingRemindersViewController.h"
#import <UserNotifications/UserNotifications.h>

///////////////////////////
#import "Reminder+CoreDataClass.h"
#import "AppDelegate.h"
@class AppDelegate;
@import CoreData;
///////////////////////////

@interface StartingVC : UIViewController


@property GMSMapView *mapView;
@property GMSMarker *marker;
@property GMSCircle *circ;
@property CLLocationCoordinate2D circleCenter;


@property UIImageView *appImageView;

@property UIImagePickerController *pickerForTakePhoto;
@property UIImagePickerController *pickerForChooseExisting;
@property UIImage *chosenImage;


- (IBAction)btnAwi:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnOut;

- (IBAction)rSlider:(UISlider *)sender;
@property (weak, nonatomic) IBOutlet UISlider *sliderOut;

@property NSInteger radius;

@property (weak, nonatomic) IBOutlet UILabel *radiusLabel;

@property (weak, nonatomic) IBOutlet UILabel *radiusNum;


- (IBAction)segmentedC:(UISegmentedControl *)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedOut;


- (IBAction)xBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *xBtnOut;


@property (weak, nonatomic) IBOutlet UIImageView *myImage;

- (IBAction)takePhoto:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *takePhotoOut;

- (IBAction)chooseExisting:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *chooseExistingOut;


- (IBAction)contBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *contOut;


- (IBAction)cancelBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *cancelOut;


@property NSString *selectedPlace;
@property CLLocationCoordinate2D selectedLocation;
@property NSString *rLabel;


//////////////////////////////////////////////



@property (nonatomic) NSManagedObjectContext *context;

//creating an object for the appdelegate
@property (nonatomic) AppDelegate *delegate;

@property NSArray<Reminder*> *filteredReminder;


//////////////////////////////////////////////

@property (strong, nonatomic) CLLocationManager *locationManager;

@property CLCircularRegion *tempRegion;

@property bool notificationAccessGranted;



@end

