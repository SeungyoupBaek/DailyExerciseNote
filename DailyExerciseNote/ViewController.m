//
//  ViewController.m
//  DailyExerciseNote
//
//  Created by Youp on 2014. 1. 22..
//  Copyright (c) 2014년 admin. All rights reserved.
//
#import <CoreGraphics/CoreGraphics.h>
#import "ViewController.h"
#import "CKCalendarView.h"
#import "CountingViewController.h"

@interface ViewController ()<CKCalendarDelegate>


@end

@implementation ViewController


- (BOOL)calendar:(CKCalendarView *)calendar willSelectDate:(NSDate *)date {
    // don't let people select dates in previous/next month
    return [calendar dateIsInCurrentMonth:date];
}


- (void)calendar:(CKCalendarView *)calendar didSelectDate:(NSDate *)date {
    CountingViewController *countingVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CountingVC"];
    [self.navigationController pushViewController:countingVC animated:YES];
}


- (void)calendar:(CKCalendarView *)calendar didDeselectDate:(NSDate *)date {
    NSLog(@"User didn't like date %@", date);
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    CKCalendarView *calendar = [[CKCalendarView alloc] init];
    [self.view addSubview:calendar];
    calendar.delegate = self;
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
