//
//  CTViewController.m
//  Prototype1
//
//  Created by ]а on 24.05.14.
//  Copyright (c) 2014 QW-bird. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()


@end

BOOL probability(double p) {
    srand48(time(0));
    double r = drand48();
    NSLog(@"r,p = %l %l", r,p);
    return r < p;
}

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSTimer *timerQWRun = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector: @selector(fallerSelector:) userInfo: nil repeats:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) fallDown {
    NSInteger timeFall = 10;     //Falling time
    UIView *fallView = [[UIView alloc] initWithFrame:CGRectMake(5, 0, 100, 100)];
    fallView.backgroundColor = [UIColor redColor];
    [UIView animateWithDuration:timeFall animations:^void {
        fallView.center = (CGPoint){200 , 500};
    }];
    [self.view addSubview:fallView ];
}

- (void) fallerSelector:(NSTimer *)timer {
    if (probability(0.6)) {
        [self fallDown];
    }
}
@end
