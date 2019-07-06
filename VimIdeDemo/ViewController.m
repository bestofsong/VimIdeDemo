//
//  ViewController.m
//  VimIdeDemo
//
//  Created by ws2356 on 2019/7/6.
//  Copyright © 2019 ws2356. All rights reserved.
//

@import PromiseKit;
#import "ViewController.h"

NSString *API_STR = @"https://www.smartstudy.com/api/product/list?discountPrice=1&allPromotions=1&updateCache=1&scope=4&ids=2712,2730,2732";

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIView *sth = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:sth];
    sth.backgroundColor = [UIColor redColor];
    
    NSURL *url = [NSURL URLWithString:API_STR];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [[NSURLSession sharedSession] promiseDataTaskWithRequest:req]
        .then(^(id resp) {
            NSLog(@"Did load url: %@, resp: %@", API_STR, resp);
        })
        .catch(^(NSError *error) {
            NSLog(@"Failed to load url: %@, error: %@", API_STR, error);
        });
}
@end
