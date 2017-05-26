//
//  TSCentralManager.h
//  GlucometerTestApp
//
//  Created by huangjianwu on 2017/4/26.
//  Copyright (c) 2017年 huangjianwu. All rights reserved.
//

@import Foundation;
#import <CoreBluetooth/CoreBluetooth.h>

typedef void(^logChanged)(NSString *log);

typedef void(^peripheralsDidAdd)(NSArray *peripherals);


@protocol TSCentralManagerDelegate <NSObject>

- (void)didReceiveData:(NSData*)data complate:(BOOL)complate;

@end

@interface TSCentralManager : NSObject

@property (nonatomic, copy) logChanged logBlock;

@property (nonatomic, strong) peripheralsDidAdd didAdd;

@property (nonatomic, weak) id<TSCentralManagerDelegate> delegate;

+ (instancetype)shareManager;

-(void)writeValue:(NSData *)data;

- (void)connectPeripheral:(CBPeripheral*)peripheral;

- (void)cleanLog;

@end
