//
//  ZJDatabaseDetailViewModel.h
//  ZJKitTool
//
//  Created by qunlee on 2020/4/16.
//  Copyright © 2020 kapokcloud. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, QuestionType) {
    QuestionTypeTrue_False = 0,
    QuestionTypeChoice = 1,
    QuestionTypeGapFill = 2,
    QuestionTypeMultiGapFill = 3,
    QuestionTypeShortAnswer = 4
};

@interface ZJDatabaseDetailViewModel : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) CGFloat totalNum;
@property (nonatomic, assign) CGFloat limitTime;
@property (nonatomic, strong) NSArray *paperList;
@property (nonatomic, strong) NSArray *answerList;
@property (nonatomic, strong) NSArray *correctAnswerList;

- (void)setExamsWithCompletion:(void (^)(void))completion;
@end

NS_ASSUME_NONNULL_END
