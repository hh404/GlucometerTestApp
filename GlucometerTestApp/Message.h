//
//  Message.h
//  GlucometerTestApp
//
//  Created by huangjianwu on 2017/4/27.
//  Copyright (c) 2017年 huangjianwu. All rights reserved.
//

@import Foundation;

@interface Message : NSObject

@property (nonatomic, strong) NSString *type;//接口名

@property (nonatomic, strong) NSString *displayName;//显示名

@property (nonatomic, strong) NSString *jsonContent;//json格式的字符串

@end
