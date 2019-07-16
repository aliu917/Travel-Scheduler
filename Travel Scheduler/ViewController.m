//
//  ViewController.m
//  Travel Scheduler
//
//  Created by aliu18 on 7/15/19.
//  Copyright © 2019 aliu18. All rights reserved.
//

#import "ViewController.h"
#import "APIManager.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //GI's test
    [[APIManager shared] getLocationAdressWithName:@"MPK" withCompletion:^(NSMutableDictionary *dict, NSError *error) {
        if (dict) {
            NSLog(@"😎😎😎 Successfully did it");
            NSLog(@"%@", dict);
            
        } else {
            NSLog(@"😫😫😫 Error: %@", error.localizedDescription);
        }
    }];

}

@end
