//
//  CountingViewController.m
//  DailyExerciseNote
//
//  Created by Youp on 2014. 1. 22..
//  Copyright (c) 2014년 admin. All rights reserved.
//

#import "CountingViewController.h"
#import "NoteViewController.h"
#import <sqlite3.h>


@interface CountingViewController () <UIPickerViewDataSource, UIPickerViewDelegate>{
    NSArray *_exerciseList;
    NSArray *_weightList;
    UIPickerView *_picker;
    UIActionSheet *_sheet;
    int _count;
    float _height;
    sqlite3 *db;
}
@property (weak, nonatomic) IBOutlet UILabel *exerciseLabel;
@property (weak, nonatomic) IBOutlet UIButton *exerciseButton;
@property (weak, nonatomic) IBOutlet UILabel *setLabel;

@end

@implementation CountingViewController

// 데이터베이스 오픈, 없으면 새로 만든다.
-(void)openDB{
    // 데이터베이스 파일경로 구하기
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* dbFilePath = [docPath stringByAppendingPathComponent:@"db.sqlite"];
    
    // 데이터 베이스 파일 체크
    NSFileManager* fm = [NSFileManager defaultManager];
    BOOL existFile = [fm fileExistsAtPath:dbFilePath];
    
    // 데이터 베이스 오픈
    int ret = sqlite3_open([dbFilePath UTF8String], &db);
    NSAssert1(SQLITE_OK==ret, @"Error on opening Database : %s", sqlite3_errmsg(db));
    NSLog(@"Success on Openning Database");
    
    // 새롭게 데이터베이스를 만들었으면 테이블을 생성한다.
    if (NO == existFile) {
        //테이블 생성
        const char* creatSQL = "CREATE TABLE IF NOT EXISTS exercise(date DATETIME, exerciseName CHAR, setCount INTEGER)";
        char* errMsg;
        ret = sqlite3_exec(db, creatSQL, NULL, NULL, &errMsg);
        if (ret != SQLITE_OK) {
            [fm removeItemAtPath:dbFilePath error:nil];
        }
        NSAssert1(SQLITE_OK==ret, @"Error on creating table : %s", errMsg);
        NSLog(@"creating table with ret : %d", ret);
    }
}

// 새로운 데이터를 데이터베이스에 저장한다.
-(void)addData:(NSDate *)date Name:(NSString *)exercise Count:(int)count{
    NSLog(@"adding data : %@, %@, %d", date, exercise, count);
    
    // sqlite3_exec로 실행하기
    NSString* sql = [NSString stringWithFormat:@"INSERT INTO exercise(DATE, EXERCISENAME, SETCOUNT) VALUES('%@', '%@', '%d')", date, exercise, count];
    NSLog(@"sql : %@", sql);
    
    char* errMsg;
    int ret = sqlite3_exec(db, [sql UTF8String], NULL, nil, &errMsg);
    
    if (SQLITE_OK != ret) {
        NSLog(@"Error on Insert New data : %s", errMsg);
    }
}

- (IBAction)countAction:(id)sender {
    _count++;
    NSString *countStr = [NSString stringWithFormat:@"%d", _count];
    self.setLabel.text = countStr;
}

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

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSString *selectStr = [_exerciseList objectAtIndex:row];
    self.exerciseButton.titleLabel.text = selectStr;
    self.exerciseLabel.text = selectStr;
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
    [self openDB];
    _exerciseList = @[@"Default", @"Squat", @"BenchPress", @"PullUp", @"DeadLift", @"LegLaise"];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NoteViewController *noteVC = segue.destinationViewController;
    [self addData:self.date Name:self.exerciseLabel.text Count:_count];
    noteVC.date = self.date;
    noteVC.setCount = _count;
    noteVC.exerciseName = self.exerciseLabel.text;
}
- (IBAction)goToNote:(id)sender {
        [self addData:self.date Name:self.exerciseLabel.text Count:_count];
}


@end
