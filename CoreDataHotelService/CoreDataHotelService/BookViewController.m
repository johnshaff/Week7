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


@property(strong, nonatomic) UITextField *nameField;

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
    [self setupNameTextField];
    
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

-(void)setupNameTextField {
    self.nameField = [[UITextField alloc]init];
    self.nameField.placeholder = @"Please enter your name";
    
    [self.nameField setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.view addSubview:self.nameField];
    
    CGFloat myMargin = 20.0;
    CGFloat navAndStatusBarHeight = CGRectGetHeight(self.navigationController.navigationBar.frame) + 20.0;
    
    NSLayoutConstraint *top = [AutoLayout createGenericConstraintFrom:self.nameField toView:self.view withAttribute:NSLayoutAttributeTop];
    top.constant = navAndStatusBarHeight + myMargin;
    
    
    NSLayoutConstraint *leading = [AutoLayout createLeadingConstraintFrom:self.nameField toView:self.view];
    leading.constant = myMargin;
    
    NSLayoutConstraint *trailing = [AutoLayout createTrailingConstraintFrom:self.nameField toView:self.view];
    trailing.constant = -myMargin;
    
}

-(void)saveButtonSelected:(UIBarButtonItem *)sender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    
    Reservation *reservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:context];
    reservation.startDate = [NSDate date];
    reservation.endDate = self.endDate;
    reservation.room = self.room;
    
    self.room.reservations = [self.room.reservations setByAddingObject:reservation];
    
    reservation.guest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:context];
    reservation.guest.name = self.nameField.text;
    
    NSError *saveError;
    [context save:&saveError];
    
    if(saveError){
        NSLog(@"There was an wrror saving new reservation");

    } else {
        NSLog(@"Saved Reservation");
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
}


@end
