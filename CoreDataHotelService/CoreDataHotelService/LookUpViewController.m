//
//  LookUpViewController.m
//  CoreDataHotelService
//
//  Created by John Shaff on 11/30/16.
//  Copyright © 2016 Adam Wallraff. All rights reserved.
//

#import "LookUpViewController.h"

#import "AvailabilityViewController.h"
#import "AppDelegate.h"
#import "Reservation+CoreDataClass.h"
#import "Room+CoreDataClass.h"
#import "BookViewController.h"
#import "Hotel+CoreDataClass.h"
#import "Guest+CoreDataClass.h"

#import "AutoLayout.h"

@interface LookUpViewController () <UITableViewDelegate, UITableViewDataSource>


@property(strong, nonatomic) UITableView *tableView;
@property(strong, nonatomic) NSFetchedResultsController *reservations;
@property(strong, nonatomic) UISearchBar *searchBar;


@end

@implementation LookUpViewController

-(void)setupSearchBar {
    self.searchBar = [[UISearchBar alloc]init];
    self.searchBar.placeholder = @"Please enter guest email";
    
    [self.searchBar setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.searchBar];
    
    [AutoLayout createTrailingConstraintFrom:self.searchBar toView:self.view];
    [AutoLayout createLeadingConstraintFrom:self.searchBar toView:self.view];
    NSLayoutConstraint *searchBarTopConstraint = [AutoLayout createGenericConstraintFrom:self.searchBar toView:self.view withAttribute:NSLayoutAttributeTop];
    searchBarTopConstraint.constant = [self navBarAndStatusBarHeight];
}



-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSString *email = searchBar.text;
    _reservations =nil;
    
    [self reservations];
}

-(NSFetchedResultsController *)reservations {
    if(!_reservations){
        AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
        NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
        request.predicate = [NSPredicate predicateWithFormat:@"guest.email == %@", self.searchBar.text];
        
        request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"guest" ascending:YES]];
        
        NSError *roomRequestError;

        _reservations = [[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
        
        [_reservations performFetch:&roomRequestError];
        
        if(roomRequestError){
            NSLog(@"There was an issue with Reservation Fetch");
            return nil;
        }

    }
    return _reservations;
}

-(void)loadView{
    [super loadView];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self setupSearchBar];

    [self setupTableView];
    [self setTitle:@"Lookup"];

    
}


-(void)setupTableView{
    self.tableView = [[UITableView alloc]init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.tableView];
    
    //WE NEED TO REGISTER A CELL ON THIS TABLE VIEW... USE CUSTOM
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [AutoLayout createTrailingConstraintFrom:self.tableView toView:self.view];
    [AutoLayout createLeadingConstraintFrom:self.tableView toView:self.view];
    NSLayoutConstraint *tableViewTopConstraint = [AutoLayout createTopToBottomRelationFrom:self.tableView toView:self.searchBar];
    tableViewTopConstraint.constant = [self navBarAndStatusBarHeight];
}


- (void)viewDidLoad {
    [super viewDidLoad];

    
}

-(CGFloat)navBarAndStatusBarHeight{
    return CGRectGetHeight(self.navigationController.navigationBar.frame) + 20.0;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //BRINGING IN THE REGISTERED CELL
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    //IF A REGISTERED CELL DOESN'T EXIST, WE'RE CREATING ONE WITH A STYLE AND IDENTIFIER
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    //
    Reservation *reservation = [self.reservations objectAtIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"Reservation: %@, %@, %i, $%0.2f)", reservation.guest.firstName, reservation.startDate, reservation.room.number, reservation.room.rate.floatValue];
    
    return cell;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    //I DON'T UNDERSTAND SECTIONS
    NSArray *sections = [self.reservations sections];
    id<NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:section];
    return [sectionInfo numberOfObjects];
    
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.reservations.sections.count;
}



@end
