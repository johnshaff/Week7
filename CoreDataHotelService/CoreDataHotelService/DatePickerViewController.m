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
    self.endPicker = [[UIDatePicker alloc]init];
    
    self.endPicker.datePickerMode = UIDatePickerModeDate;
    
    [self.view addSubview:self.endPicker];

    
    [self.endPicker setTranslatesAutoresizingMaskIntoConstraints:NO];
    
 
    [AutoLayout createTrailingConstraintFrom:self.endPicker toView:self.view];
    [AutoLayout createLeadingConstraintFrom:self.endPicker toView:self.view];
    
   NSLayoutConstraint *topConstraint = [AutoLayout createGenericConstraintFrom:self.endPicker toView:self.view withAttribute:NSLayoutAttributeTop];
    
    topConstraint.constant = [self navBarAndStatusBarHeight];
    
}

-(void)doneButtonSelected:(UIBarButtonItem *)sender {
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
    availabilityVC.endDate = self.endPicker.date;
    
    [self.navigationController pushViewController:availabilityVC animated:YES];
}

-(CGFloat)navBarAndStatusBarHeight{
       return CGRectGetHeight(self.navigationController.navigationBar.frame) + 20.0;
}



@end
