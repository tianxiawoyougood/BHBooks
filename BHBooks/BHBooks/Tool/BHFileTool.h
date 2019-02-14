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

/** 创建书籍的目录 */
+ (BOOL)createBooksRootDirectory;

/** 解析文件：utf-8, GKB, GBK18030 */
+ (NSString *)transcodingWithPath:(NSString *)path ;

/** 在字符串中查找字符串所有位置 */
+ (NSMutableArray *)getRangeStr:(NSString *)text findText:(NSString *)findText;

/** 获取章节目录 */
+ (NSMutableArray *)getChapterListWithText:(NSString *)text;

/** 获取所有章节内容 */
+ (NSMutableArray *)getChapterTextArrWithString:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
