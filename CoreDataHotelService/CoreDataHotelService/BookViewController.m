//
//  BookViewController.m
//  CoreDataHotelService
//
//  Created by John Shaff on 11/29/16.
//  Copyright © 2016 Adam Wallraff. All rights reserved.
//

#import "BookViewController.h"

#import "AppDelegate.h"

#import "Hotel+CoreDataClass.h"
#import "Reservation+CoreDataClass.h"
#import "Guest+CoreDataClass.h"

#import "AutoLayout.h"


@interface BookViewController ()


@property(strong, nonatomic) UITextField *firstName;
@property(strong, nonatomic) UITextField *lastName;
@property(strong, nonatomic) UITextField *email;


@end

@implementation BookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)loadView{
    [super loadView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self setupMessageLabel];
    [self setupTextFields];
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemSave
                                                                          target:self
                                                                          action:@selector(saveButtonSelected:)];

    [self.navigationItem setRightBarButtonItem:saveButton];
}

-(void)setupMessageLabel{
    UILabel *messageLabel = [[UILabel alloc]init];
    
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.numberOfLines = 0;
    
    [messageLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    CGFloat myMargin = 20.0;
    
    [self.view addSubview:messageLabel];
    NSLayoutConstraint *leading = [AutoLayout createLeadingConstraintFrom:messageLabel toView:self.view];
    leading.constant = myMargin;
    
    NSLayoutConstraint *trailing = [AutoLayout createTrailingConstraintFrom:messageLabel toView:self.view];
    trailing.constant = -myMargin;
    
    [AutoLayout createGenericConstraintFrom:messageLabel toView:self.view withAttribute:NSLayoutAttributeCenterY];
    
    messageLabel.text = [NSString stringWithFormat:@"Reservation At:%@\nRoom:%i\nFrom:Today - %@", self.room.hotel.name, self.room.number, self.endDate];
    
}

-(void)setupTextFields {
    self.firstName = [[UITextField alloc]init];
    self.firstName.placeholder = @"Please enter your first name";
    [self.firstName setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.firstName];
    
    self.lastName = [[UITextField alloc]init];
    self.lastName.placeholder = @"Please enter your last name";
    [self.lastName setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.lastName];
    
    self.email = [[UITextField alloc]init];
    self.email.placeholder = @"Please enter your email";
    [self.email setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.email];
    
    
    
    //CONSTRAINTS
    CGFloat myMargin = 20.0;
    CGFloat navAndStatusBarHeight = CGRectGetHeight(self.navigationController.navigationBar.frame) + 20.0;
    
    NSLayoutConstraint *top = [AutoLayout createGenericConstraintFrom:self.firstName toView:self.view withAttribute:NSLayoutAttributeTop];
    top.constant = navAndStatusBarHeight + myMargin;
    
    NSLayoutConstraint *leading = [AutoLayout createLeadingConstraintFrom:self.firstName toView:self.view];
    leading.constant = myMargin;
    
    NSLayoutConstraint *trailing = [AutoLayout createTrailingConstraintFrom:self.firstName toView:self.view];
    trailing.constant = -myMargin;
    
}

-(void)saveButtonSelected:(UIBarButtonItem *)sender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    
    Reservation *reservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:context];
    reservation.startDate = self.startDate;
    reservation.endDate = self.endDate;
    reservation.room = self.room;
    
    self.room.reservations = [self.room.reservations setByAddingObject:reservation];
    
    reservation.guest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:context];
    reservation.guest.firstName = self.firstName.text;
    reservation.guest.firstName = self.lastName.text;
    reservation.guest.email = self.email.text;


    
    
    NSError *saveError;
    [context save:&saveError];
    
    if(saveError){
        NSLog(@"There was an error saving new reservation");

    } else {
        NSLog(@"Saved Reservation");
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
}


@end
