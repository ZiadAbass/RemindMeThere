//
//  StartingVC.m
//  Remind Me There
//
//  Created by Ziad Abass on 7/10/18.
//  Copyright © 2018 University Of Leeds. All rights reserved.
//

#import "StartingVC.h"
#import "StartingVC.h"
#import <GooglePlaces/GooglePlaces.h>

@interface StartingVC () <GMSAutocompleteViewControllerDelegate, PopupDelegate, CLLocationManagerDelegate, UIPopoverPresentationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation StartingVC



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //Setting backgound image:
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"AbstractBackground"]]];
    
    
    // clear existing map
    [self removeMap];
    
    /////////////////////////////////////////////
    
    CLLocationManager *location = [[CLLocationManager alloc] init];
    location.delegate = self;
    
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:location.location.coordinate.latitude
                                                            longitude:location.location.coordinate.longitude
                                                                 zoom:12];
    
    
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    //CGRect eshta = CGRectMake(0, 0, screenBound.size.width, 300);
    self.mapView = [GMSMapView mapWithFrame:screenBound camera:camera];
    //self.mapView = [GMSMapView mapWithFrame:eshta camera:camera];
    self.mapView.myLocationEnabled = YES;
    self.mapView.tag = 8;
    
    //[self.view insertSubview:mapView belowSubview:_txtPlaceSearch.superViewOfList];
    [self.view addSubview:self.mapView];
    [self.view sendSubviewToBack:self.mapView];
    
    
    /////////////////////////////////////////////
    
    
    // hide/show as appropriate
    self.sliderOut.hidden = YES;
    self.radiusNum.hidden = YES;
    self.contOut.hidden = YES;
    self.cancelOut.hidden = YES;
    self.xBtnOut.hidden = NO;
    self.xBtnOut.hidden = YES;
    self.takePhotoOut.hidden = YES;
    self.chooseExistingOut.hidden = YES;
    self.radiusLabel.hidden = YES;
    self.btnOut.hidden = NO;
    
    
    //navbar
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    //[self setNavBarImage];
    
    //default radius
    self.radius = 70;
    
    
    //show the user's location
    [self.mapView clear];
    self.mapView.myLocationEnabled = YES;
    self.mapView.settings.myLocationButton = true;
    
    
    self.btnOut.layer.cornerRadius = 10;
    self.btnOut.clipsToBounds = true;
    
    
    ///////////
    self.delegate = [[AppDelegate alloc] init];
    
    
    //getting a reference to the delegate & context
    self.delegate = ((AppDelegate *) [[UIApplication sharedApplication] delegate]);
    self.context = self.delegate.persistentContainer.viewContext;
    ///////////
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    
    
    //Setting picker objects and setting NewReminderViewController as the delegate for both pickers:
    self.pickerForTakePhoto = [[UIImagePickerController alloc] init];
    self.pickerForChooseExisting = [[UIImagePickerController alloc] init];
    
    
    //Setting this view controller as the delegate for the pickers:
    self.pickerForTakePhoto.delegate = self;
    self.pickerForChooseExisting.delegate = self;
    
    
    
    self.notificationAccessGranted = NO;
    
    UNUserNotificationCenter *notifCenter = [UNUserNotificationCenter currentNotificationCenter];
    UNAuthorizationOptions options = UNAuthorizationOptionAlert + UNAuthorizationOptionSound;
    [notifCenter requestAuthorizationWithOptions:options completionHandler:^(BOOL allowed, NSError * _Nullable error) {
        
        self.notificationAccessGranted = allowed;
    }];
    
    
    
    
}//viewDidLoad



// every time the VC is shown
- (void) viewWillAppear:(BOOL)animated
{
    self.segmentedOut.selectedSegmentIndex = 0;
}



/*
- (void) setNavBarImage
{
    
    UINavigationController *navBar;
    
    UIImage *image = [UIImage imageNamed:@"appimage1.png"];
    UIImageView *imageView;
    imageView.image = image;
    
    NSInteger bannerWidth = navBar.navigationBar.frame.size.width;
    NSInteger bannerHeight = navBar.navigationBar.frame.size.height;
    
    NSInteger bannerX = (bannerWidth/2) - (image.size.width/2);
    NSInteger bannerY = (bannerHeight/2) - (image.size.height/2);
    
    imageView.frame = CGRectMake(bannerX, bannerY, bannerWidth, bannerHeight);
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.navigationItem.titleView = imageView;
    


 
    
    //////
//    CGRect screenBound = [[UIScreen mainScreen] bounds];
//
//
//    self.appImageView.image = [UIImage imageNamed:@"appimage.png"];
//    self.appImageView = [[UIImageView alloc] initWithFrame:CGRectMake( (screenBound.size.width/2)-20 , 18, 30, 30)];
//    //[[UIApplication sharedApplication].keyWindow addSubview:self.appImageView];
//
//
//    self.navigationItem.titleView = self.appImageView;
    
    
}


*/



 

// Button to search for a new place
- (IBAction)btnAwi:(UIButton *)sender {
    
    NSLog(@"btnAwi runs");
    
    GMSAutocompleteViewController *acController = [[GMSAutocompleteViewController alloc] init];
    acController.delegate = self;
    
    [self presentViewController:acController animated:YES completion:nil];
    
    //self.appImageView.hidden = YES;
    //self.appImageView.image = nil;
    
}








// triggered when user selects a location
// Handle the user's selection.
- (void)viewController:(GMSAutocompleteViewController *)viewController
didAutocompleteWithPlace:(GMSPlace *)place {
    
    //dismiss the results table
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    // Do something with the selected place.
    NSLog(@"Place name %@", place.name);
    //    NSLog(@"Place address %@", place.formattedAddress);
    //    NSLog(@"Place attributions %@", place.attributions.string);
    NSLog(@"Place longitude: %f , latitude: %f", place.coordinate.longitude, place.coordinate.latitude);
    

    //CLLocationCoordinate2D selectedLocation;
    self.selectedLocation = place.coordinate;
    
    [self reduceMap];
    
    // remove existing markers
    [self.mapView clear];
    
    
    self.mapView.camera = [GMSCameraPosition cameraWithLatitude:place.coordinate.latitude longitude:place.coordinate.longitude zoom:17];
    
    // Creates a marker in the center of the map.
    self.marker = [[GMSMarker alloc] init];
    self.marker.position = CLLocationCoordinate2DMake(place.coordinate.latitude, place.coordinate.longitude);
    self.marker.title = [NSString stringWithFormat:@"%@",place.name];
    self.marker.map = self.mapView;
    
    
    
    // show the radius slider and label
    self.sliderOut.hidden = NO;
    self.radiusNum.hidden = NO;
    //self.viewSavedOut.hidden = YES;
    self.radiusNum.text = [NSString stringWithFormat:@"%li m",(long)self.radius];
    self.takePhotoOut.hidden = NO;
    self.chooseExistingOut.hidden = NO;
    self.radiusLabel.hidden = NO;
    self.btnOut.hidden = YES;
    
    
//    self.btnOut.titleLabel.text = @"    Change location";
//    self.btnOut.titleLabel.font = [UIFont fontWithName:@"Optima" size:25];
//    //self.btnOut.frame = CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    
    // draw the radius circle
    [self drawCircle:place.coordinate];
    
    
    // saving the name for later use
    self.selectedPlace = place.name;
    
    // show the continue button
    self.contOut.hidden = NO;
    self.cancelOut.hidden = NO;
}




// slider to set the radius
- (IBAction)rSlider:(UISlider *)sender
{
    self.radius = roundf(sender.value);
    self.radiusNum.text = [NSString stringWithFormat:@"%li m",(long)self.radius];
    
    // update radius circle
    [self drawCircle:self.marker.position];
    
}



//// draw radius circle: ///
- (void) drawCircle: (CLLocationCoordinate2D)center
{
    
    // remove existing circles
    self.circ.map = nil;
    
    // draw the new one
    //self.circleCenter = center;
    self.circ = [GMSCircle circleWithPosition:center
                                       radius:self.radius];
    self.circ.strokeColor = [UIColor blueColor];
    self.circ.map = self.mapView;
    
}



- (void)viewController:(GMSAutocompleteViewController *)viewController
didFailAutocompleteWithError:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
    // TODO: handle the error.
    NSLog(@"Error: %@", [error description]);
}



// User canceled the operation.
- (void)wasCancelled:(GMSAutocompleteViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Turn the network activity indicator on and off again.
- (void)didRequestAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)didUpdateAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}








- (IBAction)takePhoto:(id)sender {
    
    //Camera will open upon pressing this button
    
    [self.pickerForTakePhoto setSourceType:UIImagePickerControllerSourceTypeCamera];
    [self presentViewController:self.pickerForTakePhoto animated:YES completion:NULL];
    
}




- (IBAction)chooseExisting:(id)sender
{
    //User's photo library will open upon pressing this button
    
    [self.pickerForTakePhoto setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:self.pickerForTakePhoto animated:YES completion:NULL];
}



//Saving the selected image:
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    self.chosenImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    NSLog(@"Image chosen");
    
    //The imagePickerController is dismissed after selecting a photo:
    [self dismissViewControllerAnimated:YES completion:NULL];
    
}


//If the user cancels the process of choosing an image or capturing one, the imagePickerController is dismissed:
-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    NSLog(@"Cancelled image choosing");
    
}



- (IBAction)contBtn:(UIButton *)sender
{

    // only allow to continue if location chosen
    if (self.selectedPlace != nil)
    {
        
        
        Popup *popup = [[Popup alloc] initWithTitle:@"New Reminder"
                                           subTitle:[NSString stringWithFormat:@"Add what you'd like to be reminded of at %@",self.selectedPlace]
                              textFieldPlaceholders:@[@"Reminder Label"]
                                        cancelTitle:@"Cancel"
                                       successTitle:@"Remind Me"
                                        cancelBlock:^{
                                            //Custom code after cancel button was pressed
                                        } successBlock:^{
                                            //Custom code after success button was pressed
                                        }];
        
        [popup setBackgroundColor:[UIColor whiteColor]];
        [popup setBorderColor:[UIColor blueColor]];
        [popup setTitleColor:[UIColor darkGrayColor]];
        [popup setSubTitleColor:[UIColor darkGrayColor]];
        [popup setSuccessBtnColor:[UIColor lightGrayColor]];
        [popup setSuccessTitleColor:[UIColor darkGrayColor]];
        [popup setCancelBtnColor:[UIColor lightGrayColor]];
        [popup setCancelTitleColor:[UIColor darkGrayColor]];
        
        [popup setIncomingTransition:PopupIncomingTransitionTypeBounceFromCenter];
        [popup setOutgoingTransition:PopupOutgoingTransitionTypeBounceFromCenter];
        [popup setTapBackgroundToDismiss:YES];
        [popup setSwipeToDismiss:YES];
        [popup setRoundedCorners:YES];
        [popup setBackgroundBlurType:PopupBackGroundBlurTypeLight];
        [popup setDelegate:self];
        [popup showPopup];
        
        
        
        
        
        
        
    } else      // if no location chosen
    {
        
        // alert eno lazem ye5tar location
        [self alertTheUser:@"Please choose a location first!" :@""];
        
    }
        
    
    
    
}





- (IBAction)cancelBtn:(UIButton *)sender
{
    [self viewDidLoad];
}





// Method that creates and triggers an alert
- (void) alertTheUser:(NSString *)title: (NSString *)message
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    
    // Dah el zorar elly haykoon fel alert
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:(UIAlertActionStyleDefault) handler:nil];
    
    // adding the button to the alert
    [alert addAction:ok];
    
    // presenting the alert to the user
    [self presentViewController:alert animated:YES completion:nil];
}





#pragma mark Popup Delegate Methods


// retrieve text from popup textfield
- (void)dictionary:(NSMutableDictionary *)dictionary forpopup:(Popup *)popup stringsFromTextFields:(NSArray *)stringArray {
    
    self.rLabel = [stringArray objectAtIndex:0];
    
    
}


// popup button actions
- (void)popupPressButton:(Popup *)popup buttonType:(PopupButtonType)buttonType {
    
    if (buttonType == PopupButtonCancel) {
        //Do whatever when the user taps the "Cancel" button
        NSLog(@"Cancel button pressed");
    
        
    }
    
    else if (buttonType == PopupButtonSuccess) {
        //Do whatever when the user taps the "Remind Me" button
        
        
        
        ///////////////////////////////////////////////////////////////////////////////
        
        
        //        Two conditions to proceed with saving:
        //        1. less that 20 monitored regions
        //        2. A label between 1 and 25 chars ////
        
        
        
        
            
            
            if (self.locationManager.monitoredRegions.count < 20)
            {
                // proceed
                
                
                
                if ((self.rLabel.length > 25) | [self.rLabel  isEqual: @""])
                {
                    
                    //alert the user eno ybattal ra3'y aw ye2ool 7aga
                    [self alertTheUser:@"Label Issue" :@"Plesae insert a label that is less than 25 characters long"];
                    
                    
                    
                    
                } else
                {
                    // yalla beena
                    
                    
                    [self.locationManager requestAlwaysAuthorization];
                    
                    
                    
                    // Save
                    [self saveReminder];
                    
                }
                
                
                
                
            } else      // if 20 reminders saved
            {
                // enough reminders
                [self alertTheUser:@"Easy there!" :@"We know you're forgetful, but you can't have more than 20 reminders on at once"];
            }
            
            
            
        [self viewDidLoad];

        
        
        
        
        
        
     ///////////////////////////////////////////////////////////////////////////////
        
        
        
        
        
        
    }
    
}



- (void)saveReminder
{
    
    
    
    NSLog(@"Saving Reminder...");
    
    NSString *label = self.rLabel;
    NSLog(@"Reminder label is %@",self.rLabel);
    
    // Pulling PNG data from the chosen image:
    NSData *imageData = UIImagePNGRepresentation(self.chosenImage);
    
    //                NSString *text = self.reminderText.text;
    
    
    
    
    
    //creating a person in the context
    Reminder *reminder = [[Reminder alloc] initWithContext:self.context];
    
    reminder.label = [NSString stringWithFormat:@"%@",label];
    
    if (self.chosenImage != nil)
    {
        // add photo to entitiy
        reminder.photoData = imageData;
        
    }
    
    
    
    
    
    // save the added stuff to core data
    [self.delegate saveContext];
    
    
    
    
    
    // daroory in case user leaves slider as it is
    if (self.radius != 70)
    {
        self.tempRegion = [[CLCircularRegion alloc] initWithCenter:self.selectedLocation radius:self.radius identifier:label];
    } else
    {
        // is self.radius is 0 then the user has left the slider as it is (which is at 50m)
        self.tempRegion = [[CLCircularRegion alloc] initWithCenter:self.selectedLocation radius:70 identifier:label];
    }
    
    
    
    
    [self.locationManager startMonitoringForRegion:self.tempRegion];
    self.tempRegion.notifyOnEntry = YES;
    self.tempRegion.notifyOnExit = NO;
    
    

    
    NSLog(@"Monitored regions are: %@",self.locationManager.monitoredRegions);
    
    
    
    
} //saveReminder method








//Defining what happens when the user enters a saved region:
- (void)locationManager:(CLLocationManager *)manager
         didEnterRegion:(CLRegion *)region{
    
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    
    
    NSLog(@"Entered %@", region.identifier);
    
    
    NSString *currentIdentifier = region.identifier;
    
    
    //storing el currentIdentifier to userdefaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:currentIdentifier forKey:@"kCurrentLabel"];
    
    
    
    
    // creating request object
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reminder"];
    
    // create a predicate to the fetched data to filter it
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"label == %@",[defaults objectForKey:@"kCurrentLabel"]];
    
    
    //apply predicate to the results fetched
    request.predicate = predicate;
    
    // Returning an array containing the reminder corresponding to the user's region
    self.filteredReminder = [self.context executeFetchRequest:request error:nil];
    
    
    Reminder *reminder = self.filteredReminder[0];
    
    
    //[self saveImage:reminder.photoData withImageName:@"reminderImage"];
    
    
    
    
    //Triggering the notification:
    if (self.notificationAccessGranted) {
        
        //Creating a notification object:
        UNUserNotificationCenter *notifCenter = [UNUserNotificationCenter currentNotificationCenter];
        
        //Creating a notification content object and setting the properties:
        UNMutableNotificationContent *notifContent = [[UNMutableNotificationContent alloc] init];
        
        notifContent.title = [NSString stringWithFormat:@"%@",region.identifier];
        //notifContent.subtitle = [NSString stringWithFormat:@"%@",region.identifier];
        notifContent.body = @"Open app to view details";
        notifContent.sound = [UNNotificationSound defaultSound];
        notifContent.launchImageName = @"Text Icon1.png";
        
        
        //Requesting the notification:
        UNNotificationRequest *notifRequest = [UNNotificationRequest requestWithIdentifier:@"ArrivalNotification" content:notifContent trigger:nil];
        
        [notifCenter addNotificationRequest:notifRequest withCompletionHandler:nil];
        
        
        
        
        //Add a badge onto the 'ViewReminder' VC to indicate that a region has been entered
        [[super.tabBarController.viewControllers objectAtIndex:1] tabBarItem].badgeValue = @"1";
        
        
        //Stop looking for the region which the user enters:
        [self.locationManager stopMonitoringForRegion:region];
        
        
        
    }
    
    
    
    // display the reminder image if there is one
    if (reminder.photoData)
    {
        UIImage *currentImage = [UIImage imageWithData:reminder.photoData];
        [self.myImage setImage:currentImage];
        [self.view bringSubviewToFront:self.myImage];
        self.myImage.layer.cornerRadius = 12;
        self.myImage.clipsToBounds = YES;
        
        self.xBtnOut.hidden = NO;
        CGRect rect = self.myImage.frame;
        [self.xBtnOut setFrame:CGRectMake( rect.origin.x, rect.origin.y, 30, 30)];
        [self.view bringSubviewToFront:self.xBtnOut];
        
    }
    
    
    
    
    
    
    
    
    
    
    

    // create effect
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    // add effect to an effect view
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:blur];
    effectView.frame = self.view.frame;
    
    // add the effect view to the image view
    [self.mapView addSubview:effectView];
    
    [effectView removeFromSuperview];
    
    
    
    
    
    
    
    
    
//    if (currentImage.size.width > currentImage.size.height)     //landscape
//    {
//        self.myImage.frame = CGRectMake(25, 25, 300 , 200);
//
//    } else if ( currentImage.size.width < currentImage.size.height)
//    {
//        self.myImage.frame = CGRectMake(25, 25, 200 , 300);
//
//    } else
//    {
//        self.myImage.frame = CGRectMake(25, 25, 300 , 300);
//    }
    
    
    /////// DELETING THE FINISHED REMINDER //////////
    
    
    [self.context deleteObject:reminder];
    
    [self.delegate saveContext];
    
    
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    
    
    
} //didEnterRegion func







- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(nonnull NSError *)error {
    
    NSLog(@"Error");
    
}





- (void) reduceMap
{
    
    // clear existing map
    [self removeMap];


    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:30.015642
                                                            longitude:31.431731
                                                                 zoom:12];
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGRect eshta = CGRectMake(0, 0, screenBound.size.width, screenBound.size.height - 180);
    self.mapView = [GMSMapView mapWithFrame:eshta camera:camera];
    self.mapView.tag = 8;
    [self.view addSubview:self.mapView];
    [self.view sendSubviewToBack:self.mapView];
}



// to remove a subview with the tag '8'
- (void) removeMap
{
    for (UIView *subview in [self.view subviews]) {
        if (subview.tag == 8) {
            NSLog(@"eshtaa map removed with tag %li",(long)subview.tag);
            [subview removeFromSuperview];
        }
    }
}






- (IBAction)segmentedC:(UISegmentedControl *)sender
{
    
    if (sender.selectedSegmentIndex == 0 )
    {
        // anything?
    }
    
    if (sender.selectedSegmentIndex == 1 )
    {
        [self performSegueWithIdentifier: @"existingTable" sender: self];
    }
    
}






- (IBAction)xBtn:(id)sender
{
    [self.myImage setImage:nil];
    self.xBtnOut.hidden = YES;
    
    [self viewDidLoad];

}








@end

