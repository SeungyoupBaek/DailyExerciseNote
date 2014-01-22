//
//  NoteViewController.m
//  DailyExerciseNote
//
//  Created by Youp on 2014. 1. 22..
//  Copyright (c) 2014년 admin. All rights reserved.
//

#import "NoteViewController.h"

@interface NoteViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *table;

@end

@implementation NoteViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dateArr = [[NSMutableArray alloc] init];
    self.exerciseArr = [[NSMutableArray alloc] init];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NOTE_CELL"];

    NSString *dateString = [NSDateFormatter localizedStringFromDate:self.date
                                                          dateStyle:NSDateFormatterShortStyle
                                                          timeStyle:NSDateFormatterFullStyle];
    NSLog(@"%@",dateString);
    UILabel *dateLabel = (UILabel *)[cell viewWithTag:1];
    UILabel *exerciseNameLabel = (UILabel *)[cell viewWithTag:2];
    UILabel *setCountLabel = (UILabel *)[cell viewWithTag:3];
    
    dateLabel.text = dateString;//[self.dateArr lastObject];
    exerciseNameLabel.text = self.exerciseName;//[self.exerciseArr lastObject];
    setCountLabel.text = [NSString stringWithFormat:@"%d", self.setCount];
    
    return cell;
}



@end
