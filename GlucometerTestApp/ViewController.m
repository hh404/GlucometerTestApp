//
//  ViewController.m
//  GlucometerTestApp
//
//  Created by huangjianwu on 2017/4/25.
//  Copyright © 2017年 huangjianwu. All rights reserved.
//

#import "ViewController.h"
#import "TSCentralViewController.h"
#import "TSPeripheralViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor orangeColor];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *but1 = [UIButton buttonWithType:UIButtonTypeCustom];
    but1.frame = CGRectMake(30, 85, 80, 30);
    but1.backgroundColor = [UIColor blueColor];
    [but1 setTitle:@"中心设备" forState:UIControlStateNormal];
    [self.view addSubview:but1];
    UIButton *but2 = [UIButton buttonWithType:UIButtonTypeCustom];
    but2.frame = CGRectMake(210, 85, 80, 30);
    but2.backgroundColor = [UIColor blueColor];
    [but2 setTitle:@"外设" forState:UIControlStateNormal];
    [self.view addSubview:but2];
    [but1 addTarget:self action:@selector(changeToCentralController) forControlEvents:UIControlEventTouchUpInside];
    [but2 addTarget:self action:@selector(changeToPeripheralController) forControlEvents:UIControlEventTouchUpInside];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)changeToCentralController
{
    TSCentralViewController *cc = [[TSCentralViewController alloc] init];
    [self.navigationController pushViewController:cc animated:YES];
}

- (void)changeToPeripheralController
{
    TSPeripheralViewController *pc = [[TSPeripheralViewController alloc] init];
    [self.navigationController pushViewController:pc animated:YES];
}

@end
