//
//  BHFileTool.m
//  BHBooks
//
//  Created by sunbinhua on 2019/2/14.
//  Copyright © 2019 paidian. All rights reserved.
//

#import "BHFileTool.h"

@implementation BHFileTool

+ (NSString *)getDocumentPath {
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
}

+ (BOOL)createBooksRootDirectory {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL isDir = YES;
    if (![fileManager fileExistsAtPath:BHBooksPath isDirectory:&isDir]) {
        [fileManager createDirectoryAtPath:BHBooksPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    // 将项目中的书放入沙盒
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"龙王传说" ofType:@"txt"];
    NSString *toFilePath = [BHBooksPath stringByAppendingPathComponent:@"龙王传说.txt"];
    
    if (![fileManager fileExistsAtPath:toFilePath]) {
        [fileManager copyItemAtPath:filePath toPath:toFilePath error:nil];
    }
    
    return YES;
}

+ (NSString *)transcodingWithPath:(NSString *)path {
    
    NSURL *fileURL = [NSURL fileURLWithPath:path];
    NSStringEncoding *usedEncoding = nil;
    
    //使用utf-8解码
    NSString *body = [NSString stringWithContentsOfURL:fileURL usedEncoding:usedEncoding error:nil];
    if (body) {
        return body;
    }
    
    //使用GBK解码
    body = [NSString stringWithContentsOfURL:fileURL encoding:0x80000632 error:nil];
    if (body) {
        return body;
    }
    
    //使用GB18030解码
    body = [NSString stringWithContentsOfURL:fileURL encoding:0x80000631 error:nil];
    if (body) {
        return body;
    }
    
    return nil;
}

+ (NSMutableArray *)getRangeStr:(NSString *)text findText:(NSString *)findText
{
    NSMutableArray *arrayRanges = [NSMutableArray arrayWithCapacity:3];
    if (findText == nil && [findText isEqualToString:@""]) {
        return nil;
    }
    NSRange range = [text rangeOfString:findText options:NSRegularExpressionSearch];
    if (range.location != NSNotFound && range.length != 0) {
        [arrayRanges addObject:[NSValue valueWithRange:range]];
        
        NSRange range1 = {0, 0};
        NSInteger location = 0;
        NSInteger length = 0;
        for (int i = 0; ; i++) { // 等同于while循环。查找text中所有findText，并将range保存到arrayRange
            if (0 == i) {
                location = range.location + range.length;;
                length = text.length - range.location - range.length;
                range1 = NSMakeRange(location, length);
            }else{
                location = range1.location + range1.length;
                length = text.length - range1.location - range1.length;
                range1 = NSMakeRange(location, length);
            }
            
            range1 = [text rangeOfString:findText options:NSRegularExpressionSearch range:range1];
            if (range1.location == NSNotFound && range1.length == 0) {
                break;
            }else{
                [arrayRanges addObject:[NSValue valueWithRange:range1]];
            }
        }
        return arrayRanges;
    }
    return nil;
}


+ (NSMutableArray *)getChapterListWithText:(NSString *)text {
    
    NSMutableArray *marr = [BHFileTool getRangeStr:text findText:@"\r\n第.{1,}章.*\r\n"];
    NSMutableArray *strMarr = [NSMutableArray array];
    [strMarr addObject:@"开始"];
    for (NSValue *value in marr) {
        NSString *string = [text substringWithRange:value.rangeValue];
        string = [string stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        [strMarr addObject:string];
    }
    
    return strMarr;
}

+ (NSMutableArray *)getChapterTextArrWithString:(NSString *)text {
    
    NSMutableArray *marr = [BHFileTool getRangeStr:text findText:@"\r\n第.{1,}章.*\r\n"];
    NSMutableArray *strMarr = [NSMutableArray array];
    NSRange lastRange = NSMakeRange(0, 0);
    
    for (NSValue *value in marr) {
        NSString *str = [text substringWithRange:NSMakeRange(lastRange.location, value.rangeValue.location - lastRange.location)];
        lastRange = value.rangeValue;
        if ([str isEqualToString:@""]) {
            str = @"\r\n";
        }
        [strMarr addObject:str];
    }
    
    //最后一章
    NSString *str = [text substringFromIndex:lastRange.location];
    if ([str isEqualToString:@""]) {
        str = @"\r\n";
    }
    [strMarr addObject:str];
    
    return strMarr;
}


@end
