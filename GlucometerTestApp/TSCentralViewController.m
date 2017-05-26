//
//  TSCentralViewController.m
//  GlucometerTestApp
//
//  Created by huangjianwu on 2017/4/26.
//  Copyright (c) 2017年 huangjianwu. All rights reserved.
//

#import "TSCentralViewController.h"
#import "Masonry.h"
#import "TSCentralManager.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface TSCentralViewController ()<UITableViewDelegate,UITableViewDataSource,TSCentralManagerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *peripherals;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UITextView *textView;
@end

// Constants
// static NSString * const kSomeLocalConstant = @"SomeValue";

@implementation TSCentralViewController

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
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@(64+44));
        make.size.width.equalTo(@(CGRectGetWidth(self.view.bounds)/2.0));
        make.bottom.equalTo(self.view.mas_bottom);
    }];

    [TSCentralManager shareManager].didAdd = ^(NSArray *peripherals)
    {
        _peripherals = peripherals;
        [self.tableView reloadData];
    };
    
    _textField = [[UITextField alloc] init];
    _textField.layer.borderWidth = 1;
    _textField.layer.borderColor = [UIColor blackColor].CGColor;
    [self.view addSubview:_textField];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@5);
        make.top.equalTo(@64);
        make.right.equalTo(self.view.mas_right).offset(-5);
        make.height.equalTo(@44);
    }];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_textView];
    
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tableView.mas_right);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.tableView.mas_top);
        make.bottom.equalTo(self.tableView.mas_bottom);
    }];
    
    [TSCentralManager shareManager].logBlock = ^(NSString *str)
    {
        _textView.text = str;
    };
    [TSCentralManager shareManager].delegate = self;
    
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
    [[TSCentralManager shareManager] cleanLog];
    _textView.text = @"";
}

- (void)_dismissKeyboard
{
    [_textField resignFirstResponder];
}

- (void)_send
{
    NSData *data = [_textField.text dataUsingEncoding:NSUTF8StringEncoding];
    [[TSCentralManager shareManager] writeValue:data];
}

#pragma mark - 
#pragma mark Delegate methods




#pragma mark - 
#pragma mark Handlers

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [self.peripherals count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"Cell"];
    CBPeripheral *per = [self.peripherals objectAtIndex:indexPath.row];
    cell.textLabel.text = per.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CBPeripheral *per = [self.peripherals objectAtIndex:indexPath.row];
    [[TSCentralManager shareManager] connectPeripheral:per];
}

#pragma mark - TSCentralManagerDelegate

- (void)didReceiveData:(NSData*)data complate:(BOOL)complate;
{
    if(complate)
    {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"didReceiveData:%@",dic);
    }
}

@end
