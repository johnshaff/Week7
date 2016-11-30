//
//  AvailabilityViewController.m
//  CoreDataHotelService
//
//  Created by John Shaff on 11/29/16.
//  Copyright © 2016 Adam Wallraff. All rights reserved.
//

#import "AvailabilityViewController.h"
#import "AppDelegate.h"
#import "Reservation+CoreDataClass.h"
#import "Room+CoreDataClass.h"
#import "BookViewController.h"

#import "AutoLayout.h"

@interface AvailabilityViewController () <UITableViewDelegate, UITableViewDataSource>

@property(strong, nonatomic) UITableView *tableView;
@property(strong, nonatomic) NSArray *availableRooms;


@end

@implementation AvailabilityViewController

-(NSArray *)availableRooms {
    if(!_availableRooms){
        AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
        NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
        request.predicate = [NSPredicate predicateWithFormat:@"startDate <= %@ AND endDate >= %@", self.endDate, [NSDate date]];
        
        NSError *requestError;
        NSArray *results = [context executeFetchRequest:request error:&requestError];
        
        if(requestError){
            NSLog(@"There was an issue with Reservation Fetch");
            return nil;
        }
        
        NSMutableArray *unavailableRooms = [[NSMutableArray alloc]init];
        
        for (Reservation *reservation in results){
            [unavailableRooms addObject:reservation.room];
        }
        
        NSFetchRequest *roomRequest = [NSFetchRequest fetchRequestWithEntityName:@"Room"];
        roomRequest.predicate = [NSPredicate predicateWithFormat:@"NOT self IN %@", unavailableRooms];
        
        NSError *roomRequestError;
        _availableRooms = [context executeFetchRequest:roomRequest error:&roomRequestError];

        
        if(roomRequestError){
            NSLog(@"Error in requesting avail rooms");
        }
    }
    return _availableRooms;
}

-(void)loadView{
    [super loadView];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setupTableView];
    [self setTitle:@"Rooms"];
    
     
}


-(void)setupTableView{
    self.tableView = [[UITableView alloc]init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [AutoLayout activateFullViewConstraintsUsingVFLFor:self.tableView];
}


- (void)viewDidLoad {
    [super viewDidLoad];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    Room *room = self.availableRooms[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"Room: %i(%ibeds, $%0.2f)", room.number, room.beds, room.rate.floatValue];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.availableRooms.count;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Room *room = self.availableRooms[indexPath.row];
    
    BookViewController *bookViewController = [[BookViewController alloc]init];
    bookViewController.room = room;
    bookViewController.endDate = self.endDate;
    
    [self.navigationController pushViewController:bookViewController animated:YES];
    

}


@end
