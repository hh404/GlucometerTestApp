//
//  Message.m
//  GlucometerTestApp
//
//  Created by huangjianwu on 2017/4/27.
//  Copyright (c) 2017年 huangjianwu. All rights reserved.
//

#import "Message.h"

@interface Message ()

@end

// Constants
// NSString * const MessageDidSomethingNotification = @"MessageDidSomething";
// static NSString * const kSomeLocalConstant = @"SomeValue";

@implementation Message

#pragma mark -
#pragma mark Static methods

#pragma mark -
#pragma mark Default

- (instancetype)init {
    if ((self = [super init])) {
    }
    return self;
}

- (void)dealloc {
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"type:%@ jsonContent:%@",self.type,self.jsonContent];
}

#pragma mark -
#pragma mark Properties

- (NSString *)jsonContent
{
    NSAssert([_type length] != 0, @"必须先设置type");
    if(!_jsonContent)
    {
        NSURL *url = [[NSBundle mainBundle] URLForResource:_type withExtension:@"geojson"];
        NSString *str = [[NSBundle mainBundle] pathForResource:_type ofType:@"geojson"];
        _jsonContent = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    }
    return _jsonContent;
}

#pragma mark -
#pragma mark Public methods

#pragma mark - 
#pragma mark Private methods

#pragma mark - 
#pragma mark Delegate methods

#pragma mark - 
#pragma mark Event handlers

@end
