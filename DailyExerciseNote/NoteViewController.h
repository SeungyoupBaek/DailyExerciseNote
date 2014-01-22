//
//  NoteViewController.h
//  DailyExerciseNote
//
//  Created by Youp on 2014. 1. 22..
//  Copyright (c) 2014년 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoteViewController : UITableViewController

@property (strong, nonatomic) NSDate *date;
@property (nonatomic) int setCount;
@property (strong, nonatomic) NSString *exerciseName;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *exerciseNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *setCountLabel;

@end
