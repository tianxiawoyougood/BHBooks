//
//  BHFileTool.h
//  BHBooks
//
//  Created by sunbinhua on 2019/2/14.
//  Copyright © 2019 paidian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define BHBooksPath   [[BHFileTool getDocumentPath] stringByAppendingPathComponent:@"myBooks"]

@interface BHFileTool : NSObject

+ (NSString *)getDocumentPath;

+ (BOOL)createBooksRootDirectory;

@end

NS_ASSUME_NONNULL_END
