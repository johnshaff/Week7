//
//  BookViewController.h
//  CoreDataHotelService
//
//  Created by John Shaff on 11/29/16.
//  Copyright © 2016 Adam Wallraff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Room+CoreDataClass.h"



@interface BookViewController : UIViewController

@property(strong, nonatomic) Room *room;
@property(strong, nonatomic) NSDate *endDate;
@property(strong, nonatomic) NSDate *startDate;



@end
