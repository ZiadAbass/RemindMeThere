//
//  FirstViewController.m
//  Remind Me There
//
//  Created by Ziad Abass on 11/18/17.
//  Copyright © 2017 University Of Leeds. All rights reserved.
//

#import "ExistingRemindersViewController.h"

@interface ExistingRemindersViewController ()

@end

@implementation ExistingRemindersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    //Setting backgound image:
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"AbstractBackground"]]];
    
    
    
    self.locationManager = [[CLLocationManager alloc] init];
    
    //getting a reference to the delegate & context
    self.delegate = ((AppDelegate *) [[UIApplication sharedApplication] delegate]);
    self.context = self.delegate.persistentContainer.viewContext;
    
    //performing a basic data fetch
    [self fetchAllReminders];
    
    
}




-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.existingReminderLabels = [defaults objectForKey:@"kReminderLabelArray"];
    self.existingReminderPhotos = [defaults objectForKey:@"kReminderPhotoArray"];
    
    [self.existingRemindersTable reloadData];

    
    self.doneBtnOut.hidden = true;
    
}





//mohem to refresh data in table
-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self fetchAllReminders];
    [self.existingRemindersTable reloadData];
    
}





//populating the reminders array...
- (void)fetchAllReminders
{
    
    // awalan fetch request
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reminder"];
    
    // Populating out initially empty array persons:
    self.reminders = [self.context executeFetchRequest:request error:nil];
    
}






#pragma mark - TableView Data Source Methods


  //Setting the number of rows in the table:
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.reminders.count;
    
}




  //Filling up the table's cells:
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReminderCell" forIndexPath:indexPath];
    

    
    //data
    Reminder *reminder = self.reminders[indexPath.row];
    cell.textLabel.text = nil;
    cell.detailTextLabel.text = reminder.label;
    
    
    cell.backgroundColor = [UIColor lightGrayColor];
    
    return cell;
    
    
}



// defining what happens when the user selects a cell to be deleted
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        
        //// 1. DELETING THE SELECTED REMINDER FROM THE TABLE AND CORE DATA ///////
        
        // obtaining the cell's content because it is the reminder's label
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        NSString *label = cell.detailTextLabel.text;
        
        NSLog(@"The deleted cell reads:%@",label);
        
        // Deleting the selected reminder from the database
        
        // creating request object
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reminder"];
        
        // create a predicate to the fetched data to filter it
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"label == %@",label];
        
        //apply predicate to the results fetched
        request.predicate = predicate;
        
        NSArray<Reminder*> *reminder = [self.context executeFetchRequest:request error:nil];
        
        // Returning an array containing the reminder corresponding to the user's region
        [self.context deleteObject:reminder[0]];
        
        [self.delegate saveContext];
        
        [self fetchAllReminders];
        
        [self.existingRemindersTable deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        
        
        
        
        ///// 2. STOP MONITORING FOR THE DELETED REMINDER'S LOCATION //////
        
        
        // since locationManager.monitoredRegions is readonly:
        self.monitoredRegions = self.locationManager.monitoredRegions;

        
        //applying a predicate to filter through only the reminder with the corresponding label to be deleted:
        NSPredicate *predicateM = [NSPredicate predicateWithFormat:@"identifier == %@",label];
        self.filteredSet = [self.monitoredRegions filteredSetUsingPredicate:predicateM];

        

        NSLog(@"Monitored regions before: %@",self.locationManager.monitoredRegions);
        
        CLCircularRegion *regionD;
        
        // stop monitoring the relevent region
        for (regionD in self.filteredSet)
        {
            [self.locationManager stopMonitoringForRegion:regionD];
        }
        
        NSLog(@"Monitored regions after: %@",self.locationManager.monitoredRegions);

    }
}




// start editing when edit button pressed
- (IBAction)editBtn:(id)sender
{
    [self.existingRemindersTable setEditing:YES animated:YES];
    self.doneBtnOut.hidden = false;
    self.editBtnOut.hidden = true;
}



- (IBAction)doneBtn:(id)sender
{
    self.editBtnOut.hidden = false;
    self.doneBtnOut.hidden = true;
    [self.existingRemindersTable setEditing:NO animated:YES];
}




#pragma mark - TableView Delegate Methods

// defining what tyoe of editing is required
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}




@end












