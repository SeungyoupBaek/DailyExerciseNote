//
//  CountingViewController.m
//  DailyExerciseNote
//
//  Created by Youp on 2014. 1. 22..
//  Copyright (c) 2014년 admin. All rights reserved.
//

#import "CountingViewController.h"


@interface CountingViewController () <UIPickerViewDataSource, UIPickerViewDelegate>{
    NSArray *_exerciseList;
    UIPickerView *_picker;
    UIActionSheet *_sheet;
    float _height;
}

@end

@implementation CountingViewController

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _exerciseList.count;
}

- (void)handleDone:(id)sender{
    [_sheet dismissWithClickedButtonIndex:0 animated:YES];
    
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [_exerciseList objectAtIndex:row];
}

- (IBAction)showExerciseList:(id)sender {
    CGSize viewSize = self.view.bounds.size;
    
    if (nil == _sheet) {
        _sheet = [[UIActionSheet alloc] init];
        
        // 툴바와 Done 버튼
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, viewSize.width, 44)];
        UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(handleDone:)];
        
        NSArray *items = [NSArray arrayWithObject:done];
        [toolbar setItems:items];
        _picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, toolbar.frame.size.height, viewSize.width, _picker.frame.size.height)];
        _picker.dataSource = self;
        _picker.delegate = self;
        // 시트에 추가
        [_sheet addSubview:toolbar];
        [_sheet addSubview:_picker];
        
        // 시트 나타나기
        [_sheet showInView:self.view];
        
        // 액션시트크기와 위치계산용
        _height = toolbar.frame.size.height + _picker.frame.size.height;
        [_picker reloadAllComponents];
    }
    
    [_sheet showInView:self.view];
    _sheet.frame = CGRectMake(0, viewSize.height - _height, viewSize.width, _height);
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _exerciseList = @[@"Squat", @"BenchPress", @"PullUp", @"DeadLift", @"LegLaise"];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
