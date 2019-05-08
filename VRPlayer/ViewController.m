//
//  ViewController.m
//  VRPlayer
//
//  Created by Metagem on 2019/5/7.
//  Copyright © 2019 SevenNine. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.title = NSLocalizedString(@"VRPlayer", nil);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.    
}


@end
