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

@property (strong, nonatomic) NSMutableArray* dateArr;
@property (strong, nonatomic) NSMutableArray* exerciseArr;

@end
