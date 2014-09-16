//
//  PersonDetailTableViewController.m
//  iconuk2014
//
//  Created by René Winkelmeyer on 11.09.14.
//  Copyright (c) 2014 René Winkelmeyer. All rights reserved.
//

#import "PersonDetailTableViewController.h"

@interface PersonDetailTableViewController ()
@property (weak, nonatomic) IBOutlet UITextField *fieldFirstNAme;
@property (weak, nonatomic) IBOutlet UITextField *fieldLastName;
@property (weak, nonatomic) IBOutlet UITextField *fieldEMail;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *buttonMode;
@property (nonatomic) BOOL isEditable;

@end

@implementation PersonDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated {
    
    // Setting the values for the text fields.
    self.title = [self.dictPerson objectForKey:@"firstName"];
    self.fieldFirstNAme.text = [self.dictPerson objectForKey:@"firstName"];
    self.fieldLastName.text = [self.dictPerson objectForKey:@"lastName"];
    self.fieldEMail.text = [self.dictPerson objectForKey:@"mail"];
    self.buttonMode.title = @"Edit";
    self.isEditable = NO;
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section==0) {
        return 3;
    } else {
        return 1;
    }
    
}

- (IBAction)changeMode:(id)sender {
    
    // This IBAction is used to switch between edit/non edit mode.
    
    [self.fieldFirstNAme setEnabled:!self.isEditable];
    [self.fieldLastName setEnabled:!self.isEditable];
    [self.fieldEMail setEnabled:!self.isEditable];
    
    if (!self.isEditable) {
        self.buttonMode.title = @"Save";
        self.isEditable = YES;
    } else {
        self.buttonMode.title = @"Edit";
        self.isEditable = NO;
        [self sendChangedData];
    }
    
}


-(void)sendChangedData {
    
    // We update the existing NSMutableDictionary and post that values back to the server.
    [self.dictPerson setObject:@"firstName" forKey:self.fieldFirstNAme.text];
    [self.dictPerson setObject:@"lastName" forKey:self.fieldLastName.text];
    [self.dictPerson setObject:@"mail" forKey:self.fieldEMail.text];
   
    Http *http = [[Http alloc] init];
    http.delegate = self; // We don't use the delegate right now, but it's a good habit to set it anyway.
    [http updateUser:self.dictPerson];
    
}



@end
