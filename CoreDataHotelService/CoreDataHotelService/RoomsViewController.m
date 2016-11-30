//
//  RoomsViewController.m
//  CoreDataHotelService
//
//  Created by John Shaff on 11/28/16.
//  Copyright © 2016 Adam Wallraff. All rights reserved.
//

#import "RoomsViewController.h"
#import "AutoLayout.h"

#import "AppDelegate.h"
#import "Room+CoreDataProperties.h"






@interface RoomsViewController () <UITableViewDataSource, UITableViewDelegate>

@property(strong, nonatomic)NSArray *dataSource;
@property(strong, nonatomic) UITableView *tableView;


@end

@implementation RoomsViewController

-(void)loadView{
    [super loadView];
    
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
    
    [self setTitle:@"Rooms"];



}


-(NSArray *)dataSource{
    
    if(!_dataSource){
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        NSManagedObjectContext *context = delegate.persistentContainer.viewContext;
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Room"];
        
        
        NSError *fetchError;
        _dataSource = [context executeFetchRequest:request error:&fetchError];
        
        if(fetchError){
            NSLog(@"Error Fetching Rooms from Core Data");
        }
    }
    
    return _dataSource;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    Room *room = self.dataSource[indexPath.row];
    
    cell.textLabel.text = [@(room.number) stringValue];
//    cell.textLabel.text = [NSString stringWithFormat:@"%hd", room.number];
    
    return cell;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}



@end
