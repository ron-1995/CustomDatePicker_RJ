//
//  ViewController.m
//  CustomDatePickerDemo
//
//  Created by ronak on 11/23/17.
//  Copyright © 2017 com.zaptechsolutions. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    indexI = 0;
    _monthNames = [NSArray new];
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:[[NSLocale preferredLanguages] objectAtIndex:0]]];
    self.monthNames = [df monthSymbols];
    _lblNoUserFound.hidden = true;
    _viewFullScreen.hidden = true;
    _viewDatePicker.hidden = true;
    _view_MD_picker.hidden = true;
    _btnMonthOutlet.hidden = true;
    _btnDateMonthOutlet.hidden = true;
    isCalendarOpen = false;
    //Tap gesture
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [_viewFullScreen addGestureRecognizer:singleFingerTap];
   
    //Array Initialization
    arrDays = [NSMutableArray new];
    arrMonth = [NSMutableArray new];
    arrUserData = [NSMutableArray new];
    arrUserList = [NSMutableArray new];
    dictMonth = [NSDictionary new];
    dictMonth = [NSDictionary dictionaryWithObjectsAndKeys:
                 @"January", @"01", @"February", @"02", @"March", @"03", @"April", @"04", @"May", @"05", @"June", @"06", @"July", @"07", @"August", @"08", @"September", @"09", @"October", @"10", @"November", @"11", @"December", @"12", nil];
    arrDays = [NSMutableArray arrayWithObjects:@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31", nil];
       //Collection view custom class called
    columncount=2;
    miniInteriorSpacing=10;
    
    
    
    //UIDatePicker
    dateFormatBirthdate = [NSDateFormatter new];
    //_datePickerView.backgroundColor = [UIColor colorWithRed:179/255.0 green:174/255.0 blue:212/255.0 alpha:0.95];
    _datePickerView.backgroundColor = [UIColor clearColor];
    [_datePickerView setMaximumDate:[NSDate date]];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //  _pickerView.backgroundColor = [UIColor colorWithRed:39/255.0 green:50/255.0 blue:132/255.0 alpha:0.9];
    arrMonth =[[NSMutableArray alloc]initWithObjects:@"January",@"February",@"March",@"April",@"May",@"June",@"July",@"August",@"September",@"October",@"November",@"December",nil];
    //Date Picker Code
    NSDateComponents *comps = [NSDateComponents new];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:
                            NSCalendarIdentifierGregorian];
    NSDate *currentDate = [NSDate date];
    [comps setYear:-100];
    NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
    [_datePickerView setMinimumDate:minDate];
    NSLocale *frLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    _datePickerView.locale = frLocale;
    
    
    NSString *strBdate = [NSString stringWithFormat:@"%@",[arrUserData valueForKey:@"birthday"]];
    strBirthDate = strBdate;
    StrCalType = @"0";

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    NSDate *dateBDay = [dateFormat dateFromString:strBdate];
    [_datePickerView setDate:dateBDay];
    [_datePickerView setMaximumDate:[NSDate date]];
    // [_datePickerView addDoneOnKeyboardWithTarget:self action:@selector(doneAction:)];
    
    //- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
    [self pickerView:_pickerViewMonth didSelectRow:0 inComponent:0];
    [self pickerView:_pickerView_MD didSelectRow:0 inComponent:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Tap Gesture handler
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer{
    _viewFullScreen.hidden = true;
    _viewDatePicker.hidden = true;
    _view_MD_picker.hidden = true;
}
#pragma mark - UIPicker View Delegate Methods
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView.tag == 1) {
        return arrMonth.count;
    }else{
        NSUInteger number = 0;
        if (component == 1) {
            number = 12;
        } else {
            
            //  NSDateComponents *comps = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
            // [arr objectAtIndex:[pickerView selectedRowInComponent:0]]
            NSUInteger month = indexI+1 ;
            NSUInteger actualYear = 2016;
            NSDateComponents *selectMothComps = [[NSDateComponents alloc] init];
            selectMothComps.year = actualYear;
            selectMothComps.month = month;
            selectMothComps.day = 1;
            NSDateComponents *nextMothComps = [[NSDateComponents alloc] init];
            nextMothComps.year = actualYear;
            nextMothComps.month = month+1;
            nextMothComps.day = 1;
            NSDate *thisMonthDate = [[NSCalendar currentCalendar] dateFromComponents:selectMothComps];
            NSDate *nextMonthDate = [[NSCalendar currentCalendar] dateFromComponents:nextMothComps];
            NSDateComponents *differnce = [[NSCalendar currentCalendar]  components:NSDayCalendarUnit
                                                                           fromDate:thisMonthDate
                                                                             toDate:nextMonthDate
                                                                            options:0];
            
            number = [differnce day];
        }
        return number;
    }
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (pickerView.tag == 1) {
        return 1;
    }
    else{
        return 2;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (pickerView.tag == 1){
        strMonth = [NSString stringWithFormat:@"%@",[arrMonth objectAtIndex:[pickerView selectedRowInComponent:0]]];
       
       
    }
    else{
        indexI = [pickerView selectedRowInComponent:1];
        if (component == 1) {
            [pickerView reloadComponent:0];
        }
        else{
        }
        NSString *strDay = [NSString stringWithFormat:@"%@",[arrDays objectAtIndex:[pickerView selectedRowInComponent:0]]];
        NSString *strMonth1 = [NSString stringWithFormat:@"%@",[arrMonth objectAtIndex:[pickerView selectedRowInComponent:1]]];
        NSString *strMonth2 =  [NSString stringWithFormat:@"%@",[[dictMonth allKeysForObject:strMonth1] objectAtIndex:0]];
        strDay_Month = [NSString stringWithFormat:@"%@/%@",strDay,strMonth2];
        
           }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (pickerView.tag == 1) {
        return [arrMonth objectAtIndex:row];
    }
    else{
        NSString *result;
        if (component == 0) {
            result = [NSString stringWithFormat:@"%ld", row+1];
        } else {
            result = [self.monthNames objectAtIndex:row];
        }
        return result;
    }
}
#pragma mark - UIButton Actions
- (IBAction)btnDonePickerView:(id)sender {
    _viewFullScreen.hidden = true;
    _viewDatePicker.hidden = true;
}
- (IBAction)datePickerAction:(id)sender {
    
    //datePickerBirthdate = (UIDatePicker*)self.txtFieldBirthdate.inputView;
    //NSDateFormatter *dateFormat = [[NSDateFormatter new];
    NSDate *eventDate = _datePickerView.date;
    [dateFormatBirthdate setDateFormat:@"dd/MM/yyyy"];
    NSMutableAttributedString * dateString = [[NSMutableAttributedString alloc] initWithString:[dateFormatBirthdate stringFromDate:eventDate]];
    strBirthDate = dateString.string;
}
- (IBAction)btnCalenderAction:(id)sender {
    if (isCalendarOpen == false) {
        isCalendarOpen = true;
        _btnMonthOutlet.hidden = false;
        _btnDateMonthOutlet.hidden = false;
      
    }
    else{
        isCalendarOpen = false;
        _btnMonthOutlet.hidden = true;
        _btnDateMonthOutlet.hidden = true;
    }
}
- (IBAction)btnMonthAction:(id)sender{
    _viewFullScreen.hidden = false;
    _viewDatePicker.hidden = false;
    isCalendarOpen = false;
    _btnMonthOutlet.hidden = true;
    _btnDateMonthOutlet.hidden = true;
}

- (IBAction)btnDateMonthAction:(id)sender{
    _viewFullScreen.hidden = false;
    _view_MD_picker.hidden = false;
    isCalendarOpen = false;
    _btnMonthOutlet.hidden = true;
    _btnDateMonthOutlet.hidden = true;
}
- (IBAction)btnOKAction:(id)sender {
  _lblSelectedDate.text = strMonth;
    strBirthDate = [NSString stringWithFormat:@"01/%@/0000",[[dictMonth allKeysForObject:strMonth] objectAtIndex:0]];
  
    StrCalType = @"0";
   
    _viewFullScreen.hidden = true;
    _viewDatePicker.hidden = true;
}

- (IBAction)btnCancelAction:(id)sender {
    _viewFullScreen.hidden = true;
    _viewDatePicker.hidden = true;
}
- (IBAction)btnCancel_MD_Action:(id)sender{
    _viewFullScreen.hidden = true;
    _view_MD_picker.hidden = true;
}
- (IBAction)btnOK_MD_Action:(id)sender{
   _lblSelectedDate.text = strDay_Month;
    strBirthDate = [NSString stringWithFormat:@"%@/0000",strDay_Month];
   
    StrCalType = @"1";
   
    _viewFullScreen.hidden = true;
    _view_MD_picker.hidden = true;
}
@end
