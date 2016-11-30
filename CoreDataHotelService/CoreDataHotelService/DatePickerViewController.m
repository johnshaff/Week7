//
//  DatePickerViewController.m
//  CoreDataHotelService
//
//  Created by John Shaff on 11/29/16.
//  Copyright © 2016 Adam Wallraff. All rights reserved.
//

#import "DatePickerViewController.h"
#import "AutoLayout.h"
#import "AvailabilityViewController.h"



@interface DatePickerViewController ()

@property(strong, nonatomic) UIDatePicker *endPicker;
@property(strong, nonatomic) UIDatePicker *startPicker;


@end

@implementation DatePickerViewController

-(void)loadView {
    [super loadView];
    
    //This loads up the
    [self setupDatePicker];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonSelected:)];
    
    [self.navigationItem setRightBarButtonItem:doneButton];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
}



-(void)setupDatePicker{
    self.startPicker = [[UIDatePicker alloc]init];
    self.startPicker.datePickerMode = UIDatePickerModeDate;
    [self.view addSubview:self.startPicker];
    [self.startPicker setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    self.endPicker = [[UIDatePicker alloc]init];
    self.endPicker.datePickerMode = UIDatePickerModeDate;
    [self.view addSubview:self.endPicker];
    [self.endPicker setTranslatesAutoresizingMaskIntoConstraints:NO];
    
 
    //CONSTRAINTS
    [AutoLayout createTrailingConstraintFrom:self.startPicker toView:self.view];
    [AutoLayout createLeadingConstraintFrom:self.startPicker toView:self.view];
    NSLayoutConstraint *startTopConstraint = [AutoLayout createGenericConstraintFrom:self.startPicker toView:self.view withAttribute:NSLayoutAttributeTop];
    startTopConstraint.constant = [self navBarAndStatusBarHeight];
    
    
    [AutoLayout createTrailingConstraintFrom:self.endPicker toView:self.startPicker];
    [AutoLayout createLeadingConstraintFrom:self.endPicker toView:self.startPicker];
   NSLayoutConstraint *endTopConstraint = [AutoLayout createGenericConstraintFrom:self.endPicker toView:self.startPicker withAttribute:NSLayoutAttributeTop];
    endTopConstraint.constant = [self navBarAndStatusBarHeight];
    
}

-(void)doneButtonSelected:(UIBarButtonItem *)sender {
    NSDate *startDate = self.startPicker.date;
    NSDate *endDate = self.endPicker.date;

    
    if([[NSDate date] timeIntervalSinceReferenceDate] > [endDate timeIntervalSinceReferenceDate]){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Huh..." message:@"Please make sure end date is in the future" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            self.endPicker.date = [NSDate date];
            
        }];
        
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    
    AvailabilityViewController *availabilityVC = [[AvailabilityViewController alloc]init];
    availabilityVC.startDate = self.startPicker.date;
    availabilityVC.endDate = self.endPicker.date;
    
    [self.navigationController pushViewController:availabilityVC animated:YES];
}

-(CGFloat)navBarAndStatusBarHeight{
       return CGRectGetHeight(self.navigationController.navigationBar.frame) + 20.0;
}



@end
