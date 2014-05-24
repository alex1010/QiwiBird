//
//  CTViewController.m
//  Prototype1
//
//  Created by ]а on 24.05.14.
//  Copyright (c) 2014 QW-bird. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()

//@property (nonatomic) CGFloat x_QWdady;
//@property (nonatomic) CGFloat y_QWdady;
@property (nonatomic) IBOutlet UIView *QWdadyView;

@end

BOOL probability(double p) {
    srand48(time(0));
    double r = drand48();
    return r < p;
}


@implementation GameViewController
@synthesize QWdadyView;

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.x_QWdady = -10;
//    self.y_QWdady = -10;
    QWdadyView = [[UIView alloc] initWithFrame:CGRectMake(0, 5, 100, 100)];
    [self.view addSubview:QWdadyView ];

	// Do any additional setup after loading the view, typically from a nib.
    NSTimer *timerQWRun = [NSTimer scheduledTimerWithTimeInterval:8 target:self selector: @selector(runnerSelector:) userInfo: nil repeats:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) runQWSelector:(NSTimer *)timer {
    double xSpeed = .2;
    double ySpeed = 0;
    double x_new = QWdadyView.center.x+xSpeed;
    double y_new = QWdadyView.center.y+ySpeed;
    QWdadyView.center= (CGPoint) {x_new , y_new};
    NSLog(@"xNew,yNew = %f %f", x_new,y_new);
}

- (void) runningQiWi {
    NSInteger timeRun = 7;     //Falling time
    QWdadyView.backgroundColor = [UIColor blueColor];
//    [UIView animateWithDuration:timeRun animations:^void {
//        QWdadyView.center = (CGPoint){0 , -15};
//    }];
    NSTimer *timerRunnerQWdady = [NSTimer scheduledTimerWithTimeInterval:.01 target:self selector: @selector(runQWSelector:) userInfo: nil repeats:YES];
    NSTimer *timerBonusFall = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector: @selector(fallerSelector:) userInfo: nil repeats:YES];
    
}

- (void) runnerSelector:(NSTimer *)timer {
    if (probability(0.9)) {
        
        [self runningQiWi];
    }
    
}

- (void) fallDown {
    NSInteger timeFall = 5;     //Falling time
    CGFloat x_start = QWdadyView.center.x;
    CGFloat y_start = QWdadyView.center.y;
    NSLog(@"x,y = %f %f", x_start,y_start);
    UIView *fallView = [[UIView alloc] initWithFrame:CGRectMake(x_start, y_start, 20, 20)];
    fallView.backgroundColor = [UIColor redColor];
    [UIView animateWithDuration:timeFall animations:^void {
        fallView.center = (CGPoint){x_start , 500};
    }];
    [self.view addSubview:fallView ];
}

- (void) fallerSelector:(NSTimer *)timer  {
    if (probability(0.6)) {
        [self fallDown];
    }
}


@end
