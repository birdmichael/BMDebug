//
//  BMViewController.m
//  BMDebug
//
//  Created by birdmichael on 11/26/2018.
//  Copyright (c) 2018 birdmichael. All rights reserved.
//

#import "BMViewController.h"
#import "BMDebug.h"

@interface BMViewController ()

@end

@implementation BMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[BMDebugManager sharedInstance] show];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
