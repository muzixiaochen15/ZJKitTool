//
//  ZJDBDetailItem.h
//  ZJKitTool
//
//  Created by qunlee on 2020/4/12.
//  Copyright © 2020 kapokcloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZJDatabaseDetailViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZJDBDetailOptionItem : NSObject

@property (nonatomic, strong) NSString *descr;
@property (nonatomic, strong) NSString *itemName;
@property (nonatomic, strong) NSString *subjectId;
@property (nonatomic, strong) NSString *attachment;
@property (nonatomic, strong) NSString *itemId;

@end

@interface ZJDBDetailPaperItem : NSObject

@end

@interface ZJDBDetailAnswerItem : NSObject
@property (nonatomic, strong) NSString *subjectId;
@property (nonatomic, strong) NSString *itemId;
@property (nonatomic, strong) NSString *answerSum;
@property (nonatomic, assign) BOOL isCorrect;
@property (nonatomic, strong) NSString *answer;
@property (nonatomic, assign) NSInteger score;

@end

@interface ZJDBDetailCorrectAnswerItem : NSObject
@property (nonatomic, strong) NSString *answer;
@property (nonatomic, strong) NSString *analysis;
@property (nonatomic, strong) NSString *subjectId;

@end


@interface ZJDBDetailItem : NSObject
@property (nonatomic, assign) QuestionType type;
@property (nonatomic, strong) NSString *paperId;
@property (nonatomic, strong) NSString *descr;
@property (nonatomic, assign) CGFloat score;
@property (nonatomic, strong) NSString *attachment;
@property (nonatomic, strong) NSString *subjectId;

@property (nonatomic, strong) NSArray *itemList;

@property (nonatomic, strong) NSAttributedString *attr;
@property (nonatomic, assign) CGFloat contentHeight;
@end

NS_ASSUME_NONNULL_END
