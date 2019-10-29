//
//  main.m
//  Remind Me There
//
//  Created by Ziad Abass on 11/18/17.
//  Copyright © 2017 University Of Leeds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}



/*
 
 REFERENCES
 
 https://www.youtube.com/watch?v=T7COfFjhXo8
 Taking and uploading photos methods in NewReminderViewController.
 
 For map search help: https://www.thorntech.com/2016/01/how-to-search-for-location-using-apples-mapkit/
    & https://github.com/ThornTechPublic/MapKitTutorialObjC
    No code was taken directly from that code.
 
 https://www.youtube.com/watch?v=73duDCjOTFw
 Local notification calling in NewReminderViewController (Within didEnterRegion method).
 
 
 */



/*
 
 TATWEER EL TATBEEK
 
 1. Save shit to device rather than userDefaults                ESHTA
 2. Option to delete reminders                                  ESHTA
 3. Remove reminders from list after viewing the reminder       ESHTA
 4. 7assen manzar el review when there's no photo chosen
 5. 'OK' when you chose location badal <Back
 6. MVC protocol
 7. Nazzam eldenya code-wise, shorter and more methods badal less and longer
 8. Explore option using UNMutableNotificationContent -> launchImageName
 9. Word limit for label 3ashan makan fel table cell            ESHTA
 10. User decides radius w/ slider + label                      ESHTA
 11. Limit 20 reminders                                         ESHTA
 12. app tez3al iF user left label blank                        ESHTA
 13. only 2 tabs, existing and view. Existing has + button for newRemVC     ESHTA
 14. clear the saved location from userDefaults whenever NRVC is opened
 15. User can save some locations to choose from (eg home)
 16. Google maps
 
 

 
 
 */
