//
//  BHBook.h
//  BHBooks
//
//  Created by sunbinhua on 2019/2/12.
//  Copyright © 2019 paidian. All rights reserved.
//

#import "BHBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BHBook : BHBaseModel

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *fileType;//文件后缀
@property (nonatomic, copy) NSString *imageURL;
@property (nonatomic, copy) NSString *filePath;
@property (nonatomic, copy) NSString *date;


@end

NS_ASSUME_NONNULL_END
