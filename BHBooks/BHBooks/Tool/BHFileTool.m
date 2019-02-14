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
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"龙皇武神" ofType:@"txt"];
    NSString *toFilePath = [BHBooksPath stringByAppendingPathComponent:@"龙皇武神.txt"];
    
    if (![fileManager fileExistsAtPath:toFilePath]) {
        [fileManager copyItemAtPath:filePath toPath:toFilePath error:nil];
    }
    
    return YES;
}


@end
