//
//  ViewController.m
//  CoreDataHotelService
//
//  Created by Adam Wallraff on 11/28/16.
//  Copyright © 2016 Adam Wallraff. All rights reserved.
//

#import "AutoLayout.h"
#import "DatePickerViewController.h"


#import "ViewController.h"
#import "HotelsViewController.h"
#import "RoomsViewController.h"



#import "Hotel+CoreDataClass.h"
#import "Room+CoreDataClass.h"


@interface ViewController ()

@end

@implementation ViewController


-(void)loadView{
    [super loadView];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationItem setTitle:@"Hotel Manager"];
    
    [self setupCustomLayout];
}

-(void)setupCustomLayout{
    
    CGFloat navigationBarHeight = CGRectGetHeight(self.navigationController.navigationBar.frame);
    
    CGFloat buttonHeigth = (self.view.frame.size.height - navigationBarHeight) / 3;
    
    UIButton *browseButton = [self createButtonWithTitle:@"Browse" andBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:0.76 alpha:1.0]];
    UIButton *bookButton = [self createButtonWithTitle:@"Book" andBackgroundColor:[UIColor colorWithRed:1.0 green:0.91 blue:0.76 alpha:1.0]];
    UIButton *lookupButton = [self createButtonWithTitle:@"Lookup" andBackgroundColor:[UIColor colorWithRed:0.85 green:1.0 blue:0.76 alpha:1.0]];
    
    [AutoLayout createLeadingConstraintFrom:browseButton toView:self.view];
    [AutoLayout createTrailingConstraintFrom:browseButton toView:self.view];

    NSLayoutConstraint *browseButtonTopConstraint = [AutoLayout createGenericConstraintFrom:browseButton toView:self.view withAttribute:NSLayoutAttributeTop];
    browseButtonTopConstraint.constant = navigationBarHeight;
    
    [AutoLayout createLeadingConstraintFrom:bookButton toView:self.view];
    [AutoLayout createTrailingConstraintFrom:bookButton toView:self.view];
    
    NSLayoutConstraint *bookButtonCenterY = [AutoLayout createGenericConstraintFrom:bookButton toView:self.view withAttribute:NSLayoutAttributeCenterY];
    
    bookButtonCenterY.constant = navigationBarHeight * 0.66;//Center Y Offset
    
    [AutoLayout createLeadingConstraintFrom:lookupButton toView:self.view];
    [AutoLayout createTrailingConstraintFrom:lookupButton toView:self.view];
    
    [AutoLayout createGenericConstraintFrom:lookupButton toView:self.view withAttribute:NSLayoutAttributeBottom];
    
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint
                                            constraintWithItem:browseButton
                                            attribute:NSLayoutAttributeHeight
                                            relatedBy:NSLayoutRelationEqual
                                            toItem:nil
                                            attribute:NSLayoutRelationEqual
                                            multiplier:1.0 constant:buttonHeigth];
    
    
    heightConstraint.active = YES;
    [browseButton addConstraint:heightConstraint];
    
    [AutoLayout createEqualHeightConstraintFrom:browseButton toView:bookButton];
    [AutoLayout createEqualHeightConstraintFrom:lookupButton toView:bookButton];
    
    
    [browseButton addTarget:self action:@selector(browseButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    [bookButton addTarget:self action:@selector(bookButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
}


-(void)browseButtonSelected:(UIButton *)sender{
    
    HotelsViewController *hotelsVC = [[HotelsViewController alloc]init];
    
    [self.navigationController pushViewController:hotelsVC animated:YES];
    
}

-(void) bookButtonSelected:(UIButton *)sender{
    
    DatePickerViewController *datePickerVC = [[DatePickerViewController alloc]init];
    
    [self.navigationController pushViewController:datePickerVC animated:YES];
}



-(UIButton *)createButtonWithTitle:(NSString *)title andBackgroundColor:(UIColor *)color{
    UIButton *button = [[UIButton alloc]init];
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundColor:color];
    
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [button setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.view addSubview:button];
    
    return button;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
