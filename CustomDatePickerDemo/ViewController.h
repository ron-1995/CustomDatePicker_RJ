//
//  ViewController.h
//  CustomDatePickerDemo
//
//  Created by ronak on 11/23/17.
//  Copyright © 2017 com.zaptechsolutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIPickerViewDelegate>

{
    
    NSInteger columncount,miniInteriorSpacing,indexCounter,indexI;
    NSMutableArray *arrDays,*arrMonth,*arrUserData,*arrUserList;
    NSString *strLat,*strLong,*strMonth,*strBirthDate,*strDay_Month,*StrCalType;
    
    NSDateFormatter *dateFormatBirthdate;
    NSDictionary *dictMonth;
    UILabel *lblNoData;
    BOOL isCalendarOpen;
}
- (IBAction)showMenu;
@property (weak, nonatomic) IBOutlet UICollectionView *CollectionViewOut;

@property (weak, nonatomic) IBOutlet UIPickerView *pickerViewMonth;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView_MD;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerViewDay;


@property (weak, nonatomic) IBOutlet UIView *viewFullScreen;
- (IBAction)btnCalenderAction:(id)sender;


- (IBAction)btnDonePickerView:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnDoneOutlet;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerView;

- (IBAction)datePickerAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *view_MD_picker;

@property (weak, nonatomic) IBOutlet UIView *viewDatePicker;



@property (weak, nonatomic) IBOutlet UILabel *lblSelectedDate;


@property (strong) NSArray *monthNames;
@property (strong, nonatomic) IBOutlet UIView *ViewMainScreen;
@property (weak, nonatomic) IBOutlet UILabel *lblNoUserFound;


#pragma mark - Filter Option Outlets & Actions
@property (weak, nonatomic) IBOutlet UIButton *btnMonthOutlet;
@property (weak, nonatomic) IBOutlet UIButton *btnDateMonthOutlet;
- (IBAction)btnMonthAction:(id)sender;
- (IBAction)btnDateMonthAction:(id)sender;
- (IBAction)btnOKAction:(id)sender;
- (IBAction)btnCancelAction:(id)sender;
- (IBAction)btnOK_MD_Action:(id)sender;
- (IBAction)btnCancel_MD_Action:(id)sender;


@end

