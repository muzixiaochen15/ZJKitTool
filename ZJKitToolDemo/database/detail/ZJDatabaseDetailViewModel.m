//
//  ZJDatabaseDetailViewModel.m
//  ZJKitTool
//
//  Created by qunlee on 2020/4/16.
//  Copyright © 2020 kapokcloud. All rights reserved.
//

#import "ZJDatabaseDetailViewModel.h"
#import "ZJDBDetailItem.h"

@implementation ZJDatabaseDetailViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

- (CGFloat)getTitleHeightWithAttr:(NSAttributedString *)attr
                    withTextWidth:(CGFloat)textWidth{
    CGFloat marginTop, marginBottom, marginLeft, marginRight;
    marginTop = 5;
    marginBottom = 5;
    marginLeft = 20;
    marginRight = 20;
    CGSize attSize = [attr boundingRectWithSize:CGSizeMake(textWidth - marginLeft - marginRight, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil].size;
    return attSize.height + marginBottom + marginTop;
}

- (NSAttributedString *)getTitleHeightWithType:(QuestionType)type
                             withQuestionTitle:(NSString *)title
                                     withScore:(NSInteger)score
                                     withIndex:(NSInteger)index{
    NSString *typeStr = @"";
    switch (type) {
        case QuestionTypeChoice:{
            typeStr = @" 选择题 ";
        }
            break;
        case QuestionTypeGapFill:
        case QuestionTypeMultiGapFill:{
            typeStr = @" 填空题 ";
        }
            break;
        case QuestionTypeTrue_False:{
            typeStr = @" 判断题 ";
        }
            break;
        case QuestionTypeShortAnswer:{
            typeStr = @" 简答题 ";
        }
            break;
        default:
            break;
    }
    
    NSString *scoreStr = [NSString stringWithFormat:@" %ld分 ", score];
    NSString *str = [NSString stringWithFormat:@"%ld. %@ %@ %@",  (long)index, typeStr, title?title:@"", scoreStr];
    NSRange typeRange = [str rangeOfString:typeStr];
    NSRange titleRange = [str rangeOfString:title?title:@""];
    NSRange scoreRange = [str rangeOfString:scoreStr];

    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:str];
    YYTextBorder *border = [YYTextBorder borderWithFillColor:kHexRGB(0xbcd3f5) cornerRadius:2.0];
    [attr yy_setBackgroundColor:kHexRGB(0xd6eef5) range:typeRange];
    [attr yy_setStrokeColor:kHexRGB(0xd6eef5) range:typeRange];
    [attr yy_setColor:kHexRGB(0x3d87fa) range:typeRange];
    [attr yy_setTextBorder:border range:typeRange];

    [attr yy_setBackgroundColor:kHexRGB(0xd6eef5) range:scoreRange];
    [attr yy_setColor:kHexRGB(0x3d87fa) range:scoreRange];
    [attr yy_setTextBorder:border range:scoreRange];

    [attr yy_setColor:kBlackColor range:titleRange];
    [attr yy_setFont:kBoldFontWithSize(15) range:NSMakeRange(0, str.length)];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    style.paragraphSpacing = 5;
    style.lineSpacing = 5;
    [attr yy_setParagraphStyle:style range:NSMakeRange(0, str.length)];
    return attr;
}

static const CGFloat edge = 20;

- (void)setExamsWithCompletion:(void (^)(void))completion{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"scrum敏捷基础考试" ofType:@"json"];
    NSString *jsonStr = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSDictionary *examsDic = [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    _name = examsDic[@"name"];
    _totalNum = examsDic[@"totalNum"]?[examsDic[@"totalNum"] floatValue]: 100;
    _limitTime = examsDic[@"limitTime"]?[examsDic[@"limitTime"] floatValue]: 60;

    NSMutableArray *paperArray = [[NSMutableArray alloc]init];
    NSMutableArray *answerArray = [[NSMutableArray alloc]init];
    NSMutableArray *correctAnswerArray = [[NSMutableArray alloc]init];
    if (examsDic[@"paperList"]&&[examsDic[@"paperList"] isKindOfClass:[NSArray class]]) {
        for (NSDictionary *outDic in examsDic[@"paperList"]) {
            if (outDic[@"subjectList"]&&[outDic[@"subjectList"] isKindOfClass:[NSArray class]]) {
                NSArray *subjectList = outDic[@"subjectList"];
                for (int i = 0; i < subjectList.count; i++) {
                    NSDictionary *dic = subjectList[i];
                    ZJDBDetailItem *item = [[ZJDBDetailItem alloc]init];
                    item = (ZJDBDetailItem *)[self initPropertyWithClass:item fromDic:dic];
                    item.descr = dic[@"description"];
                    item.attr = [self getTitleHeightWithType:item.type withQuestionTitle:item.descr withScore:item.score withIndex:i + 1];
                    item.contentHeight = [self getTitleHeightWithAttr:item.attr withTextWidth:ScreenWidth - 2 * edge];
                    [paperArray addObject:item];
                }
            }
        }
    }
    
    if (examsDic[@"answerList"]&&[examsDic[@"answerList"] isKindOfClass:[NSArray class]]) {
        for (NSDictionary *dic in examsDic[@"answerList"]) {
            ZJDBDetailAnswerItem *item = [[ZJDBDetailAnswerItem alloc]init];
            item = (ZJDBDetailAnswerItem *)[self initPropertyWithClass:item fromDic:dic];
            [answerArray addObject:item];
        }
    }
    
    if (examsDic[@"correctAnswerList"]&&[examsDic[@"correctAnswerList"] isKindOfClass:[NSArray class]]) {
        for (NSDictionary *dic in examsDic[@"correctAnswerList"] ) {
            ZJDBDetailCorrectAnswerItem *item = [[ZJDBDetailCorrectAnswerItem alloc]init];
            item = (ZJDBDetailCorrectAnswerItem *)[self initPropertyWithClass:item fromDic:dic];
            [correctAnswerArray addObject:item];
        }
    }
    _paperList = paperArray;
    _answerList = answerArray;
    _correctAnswerList = correctAnswerArray;
    if (completion) {
        completion();
    }
}


//根据info属性名赋值
- (NSObject *)initPropertyWithClass:(NSObject *)infoObject fromDic:(NSDictionary *)jsonDic{
    if ([jsonDic isKindOfClass:[NSDictionary class]] && jsonDic.count > 0) {
        unsigned int outCount ;
        objc_property_t *properties = class_copyPropertyList([infoObject class], &outCount);
        for (int i = 0; i < outCount; i++) {
            objc_property_t property = properties[i];
            const char *propertyName = property_getName(property);
            NSString *propertyNameStr = [NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding];
            id valueObj = [jsonDic valueForKey:propertyNameStr];
            if (![valueObj isKindOfClass:[NSNull class]] && valueObj != nil) {
                if ([valueObj isKindOfClass:[NSObject class]]) {
                    [infoObject setValue:valueObj forKey:propertyNameStr];
                }
            }
        }
        free(properties);
        
        if (![NSStringFromClass(infoObject.superclass) isEqualToString:@"NSObject"]) {//表示有继承
            unsigned int superOutCount ;
            objc_property_t *superProperties = class_copyPropertyList(infoObject.superclass, &superOutCount);
            for (int i = 0; i < superOutCount; i++) {
                objc_property_t superProperty = superProperties[i];
                const char *superPropertyName = property_getName(superProperty);
                NSString *superPropertyNameStr = [NSString stringWithCString:superPropertyName encoding:NSUTF8StringEncoding];
                id valueObj = [jsonDic valueForKey:superPropertyNameStr];
                if (![valueObj isKindOfClass:[NSNull class]] && valueObj != nil) {
                    if ([valueObj isKindOfClass:[NSObject class]]) {
                        [infoObject setValue:valueObj forKey:superPropertyNameStr];
                    }
                }
            }
            free(superProperties);
        }
    }
    return infoObject;
}

@end
