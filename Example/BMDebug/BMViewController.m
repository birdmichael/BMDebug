//
//  BMViewController.m
//  BMDebug
//
//  Created by birdmichael on 11/26/2018.
//  Copyright (c) 2018 birdmichael. All rights reserved.
//

#import "BMViewController.h"
#import "BMConfig.h"
#import "BMDebug.h"

@interface BMViewController ()
@property (nonatomic, strong) BMConfig *config;

@end

@implementation BMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.config = [BMConfig new];
    self.config.url = @"123";
    
    [[BMDebugManager sharedInstance] show];
    [BMDebugManager sharedInstance].appConfig = self.config;
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)nsdadsadsada {
    NSLog(@"%@",self.config.url);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
