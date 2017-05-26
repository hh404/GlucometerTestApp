//
//  TSPeripheralViewController.m
//  GlucometerTestApp
//
//  Created by huangjianwu on 2017/4/26.
//  Copyright (c) 2017年 huangjianwu. All rights reserved.
//

#import "TSPeripheralViewController.h"
#import "Masonry.h"
#import "TSPeripheralManager.h"
#import "Message.h"

@interface TSPeripheralViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITextView *logTextView;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *messageArray;
@end

// Constants
// static NSString * const kSomeLocalConstant = @"SomeValue";


@implementation TSPeripheralViewController

#pragma mark -
#pragma mark Static methods

#pragma mark -
#pragma mark Init and dealloc

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
    }
    return self;
}

- (void)dealloc {
}

#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark Public methods

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    _textView = [[UITextView alloc] init];
    _textView.layer.borderWidth = 1;
    _textView.layer.borderColor = [UIColor blackColor].CGColor;
    [self.view addSubview:_textView];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@5);
        make.top.equalTo(@64);
        make.right.equalTo(self.view.mas_right).offset(-5);
        make.height.equalTo(@144);
    }];
    UIButton *btnDismiss = [[UIButton alloc] initWithFrame:CGRectMake(160, 0, 60, 44)];
    [btnDismiss setTitle:@"隐藏键盘" forState:UIControlStateNormal];
    [btnDismiss setTintColor:[UIColor blueColor]];
    [btnDismiss.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [btnDismiss setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btnDismiss addTarget:self action:@selector(_dismissKeyboard) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithCustomView:btnDismiss];
    
    UIButton *btnClean = [[UIButton alloc] initWithFrame:CGRectMake(200, 0, 60, 44)];
    [btnClean setTitle:@"Clean" forState:UIControlStateNormal];
    [btnClean setTintColor:[UIColor blueColor]];
    [btnClean setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btnClean addTarget:self action:@selector(_cleanLog) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btnClean];
    
    UIButton *btnSend = [[UIButton alloc] initWithFrame:CGRectMake(270, 0, 60, 44)];
    [btnSend setTitle:@"Send" forState:UIControlStateNormal];
    [btnSend setTintColor:[UIColor blueColor]];
    [btnSend setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btnSend addTarget:self action:@selector(_send) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithCustomView:btnSend];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:item1,item2,rightItem, nil];
    [TSPeripheralManager shareManager].logBlock = ^(NSString *log)
    {
        _logTextView.text = log;
    };
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(_textView.mas_bottom);
        make.size.width.equalTo(@(CGRectGetWidth(self.view.bounds)/2.0));
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    
    _logTextView = [[UITextView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_logTextView];
    _logTextView.editable = NO;
    [_logTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tableView.mas_right);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.tableView.mas_top);
        make.bottom.equalTo(self.tableView.mas_bottom);
    }];
    [self _initData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[TSPeripheralManager shareManager] stopAdvertising];
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)viewDidLayoutSubviews
{
    
}


#pragma mark -
#pragma mark Private methods

- (void)_cleanLog
{
    _logTextView.text = @"";
}

- (void)_send
{
    [[TSPeripheralManager shareManager] updateCharacteristicValue:self.textView.text];
}

- (void)_dismissKeyboard
{
    [self.textView resignFirstResponder];
}

- (void)_initData
{
    _messageArray = [NSMutableArray array];
    
    Message *message0 = [[Message alloc] init];
    message0.displayName = @"测试";
    message0.type = @"Test";
    [self.messageArray addObject:message0];
    
    
    Message *message1 = [[Message alloc] init];
    message1.displayName = @"测试参数芯片";
    message1.type = @"test_parameter";
    [self.messageArray addObject:message1];
    
    Message *message2 = [[Message alloc] init];
    message2.displayName = @"质控参数芯片";
    message2.type = @"qc_parameter";
    [self.messageArray addObject:message2];
    
    Message *message3 = [[Message alloc] init];
    message3.displayName = @"校准参数芯片";
    message3.type = @"cl_parameter";
    [self.messageArray addObject:message3];
    
    Message *message4 = [[Message alloc] init];
    message4.displayName = @"插卡";
    message4.type = @"card_event";
    [self.messageArray addObject:message4];
    
    Message *message5 = [[Message alloc] init];
    message5.displayName = @"加热";
    message5.type = @"heat_complete";
    [self.messageArray addObject:message5];
    
    Message *message6 = [[Message alloc] init];
    message6.displayName = @"血液类型";
    message6.type = @"sample_result";
    [self.messageArray addObject:message6];
    
    Message *message7 = [[Message alloc] init];
    message7.displayName = @"病人测试结果1";
    message7.type = @"patient_test_result1";
    [self.messageArray addObject:message7];
    
    Message *message8 = [[Message alloc] init];
    message8.displayName = @"病人测试结果2";
    message8.type = @"patient_test_result2";
    [self.messageArray addObject:message8];
    
    Message *message9 = [[Message alloc] init];
    message9.displayName = @"病人测试结果3";
    message9.type = @"patient_test_result3";
    [self.messageArray addObject:message9];
    
    Message *message10 = [[Message alloc] init];
    message10.displayName = @"质控测试结果1";
    message10.type = @"qc_test_result1";
    [self.messageArray addObject:message10];
    
    Message *message11 = [[Message alloc] init];
    message11.displayName = @"质控测试结果2";
    message11.type = @"qc_test_result2";
    [self.messageArray addObject:message11];
    
    Message *message12 = [[Message alloc] init];
    message12.displayName = @"质控测试结果3";
    message12.type = @"qc_test_result3";
    [self.messageArray addObject:message12];
    
    Message *message13 = [[Message alloc] init];
    message13.displayName = @"校准测试结果";
    message13.type = @"cali_test_result";
    [self.messageArray addObject:message13];
    
    Message *message14 = [[Message alloc] init];
    message14.displayName = @"告警";
    message14.type = @"warn";
    [self.messageArray addObject:message14];
    
    Message *message15 = [[Message alloc] init];
    message15.displayName = @"事件";
    message15.type = @"event";
    [self.messageArray addObject:message15];
    
    Message *message16 = [[Message alloc] init];
    message16.displayName = @"电池电量";
    message16.type = @"battery_level";
    [self.messageArray addObject:message16];
}

#pragma mark - 
#pragma mark Delegate methods

#pragma mark - 
#pragma mark Handlers

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [self.messageArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"Cell"];
    Message *msg = [_messageArray objectAtIndex:indexPath.row];
    cell.textLabel.text = msg.displayName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Message *msg = [_messageArray objectAtIndex:indexPath.row];
    _textView.text = msg.jsonContent;

}


@end
