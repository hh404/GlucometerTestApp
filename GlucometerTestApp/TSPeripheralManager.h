//
//  TSPeripheralManager.h
//  GlucometerTestApp
//
//  Created by huangjianwu on 2017/4/26.
//  Copyright (c) 2017年 huangjianwu. All rights reserved.
//

@import Foundation;

typedef void(^logChanged)(NSString *log);

@interface TSPeripheralManager : NSObject

@property (nonatomic, copy) logChanged logBlock;

+ (instancetype)shareManager;

- (void)updateCharacteristicValue:(NSString*)value;

- (void)stopAdvertising;

@end
