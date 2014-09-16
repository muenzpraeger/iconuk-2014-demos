//
//  PersonTableViewController.m
//  iconuk2014
//
//  Created by René Winkelmeyer on 11.09.14.
//  Copyright (c) 2014 René Winkelmeyer. All rights reserved.
//

#import "PersonTableViewController.h"
#import "PersonDetailTableViewController.h"

@interface PersonTableViewController ()

@property (nonatomic, strong) NSMutableArray *arrPersons;

@end

@implementation PersonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Persons";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // We're here passing a new PersonDetailViewController to the target segue
    PersonDetailTableViewController *viewController = [segue destinationViewController];
    viewController.dictPerson = [[self.arrPersons objectAtIndex:self.tableView.indexPathForSelectedRow.row] mutableCopy];

}

-(void)viewWillAppear:(BOOL)animated {
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return 0 if the array is initialized, otherway return the real count.
    if (self.arrPersons) {
        return self.arrPersons.count;
    } else {
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Pick up the array element based on the current row index and configure the CellPerson cell with that.
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellPerson" forIndexPath:indexPath];
    
    NSDictionary *dictPerson = [self.arrPersons objectAtIndex:indexPath.row];
    
    NSString *fullName = [NSString stringWithFormat:@"%@ %@", [dictPerson objectForKey:@"firstName"], [dictPerson objectForKey:@"lastName"]];
    
    cell.textLabel.text = fullName;
    cell.detailTextLabel.text = [dictPerson objectForKey:@"mail"];
    
    return cell;
    
}

- (IBAction)loadDataFromServer:(id)sender {

    // Here we request the data from the server. It's important to assign the delegate so that we can callback the PersonTableViewController later on.
    Http *http = [[Http alloc] init];
    http.delegate = self;
    [http loadDataFromServer];
    
}


-(void)returnDataFromServer:(NSMutableArray *)people {
    // This is the delegate method from Http which will populate the person array and reload the table ui.
    self.arrPersons = people;
    [self.tableView reloadData];
    
}


@end
