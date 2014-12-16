//
//  Calendar.h
//  AwesomeBD
//
//  Created by Jamie Currie on 21/11/2014.
//  Copyright (c) 2014 balloondog. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Calendar : NSObject {
    NSCalendar                  *calendar;
    NSDate                      *today;
    NSDateFormatter             *dayFormatter;
    NSDateFormatter             *longMonthFormatter;
    NSDateFormatter             *dayOfWeekFormatter;
    NSDateFormatter             *longYearFormatter;
    NSMutableArray              *calendarWeeks;
    int                         monthOffset;
    NSString                    *currentCalendarMonth;
    
}

@property (retain, nonatomic) NSCalendar *calendar;
@property (retain, nonatomic) NSDate *today;
@property (retain, nonatomic) NSDateFormatter *dayFormatter;
@property (retain, nonatomic) NSDateFormatter *longMonthFormatter;
@property (retain, nonatomic) NSDateFormatter *dayOfWeekFormatter;
@property (retain, nonatomic) NSDateFormatter *longYearFormatter;
@property (retain, nonatomic) NSMutableArray *calendarWeeks;
@property (assign, nonatomic) int monthOffset;
@property (retain, nonatomic) NSString *currentCalendarMonth;



+ (NSComparisonResult)compareDate:(NSString *)date1 againstDate:(NSString *)date2;
-(id)init;
-(void)generateCalendarArray:(NSDate *)newdate;
-(NSDate *)getBeginningOfMonth:(NSDate *)date;
-(NSDate *)getEndOfMonth:(NSDate *)date;
-(NSDate *)clampDate:(NSDate *)date toComponents:(NSUInteger)unitFlags;
-(NSString *)getMonthStringForNumber:(int)num;
-(int)getMonthNumberForString:(NSString *)month;
-(BOOL)dateOccursInFuture:(NSDate *)startDate;
-(NSDate *)getNSDateFromISO:(NSString *)startdate;
+(NSString *)formatTimeFromISO:(NSString *)startdate;
+(NSString *)getUKDateFromISO:(NSString *)startdate;

@end
