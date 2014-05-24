//
//  CTViewController.m
//  Prototype1
//
//  Created by ]а on 24.05.14.
//  Copyright (c) 2014 QW-bird. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()

@property (nonatomic) CGFloat xSpeed;
@property (nonatomic) CGFloat ySpeed;
@property (nonatomic) IBOutlet UIView *QWdadyView;
@property (nonatomic) BOOL QWdadyViewOnScreen;
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
    self.xSpeed = .3;
    self.ySpeed = 0;
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
    double x_old = QWdadyView.center.x;
    double y_old = QWdadyView.center.y;
    self.QWdadyViewOnScreen = (x_old<350) && (x_old>0);
    double xSpeed = 0;
    double ySpeed = 0;
    if (self.QWdadyViewOnScreen) { xSpeed = self.xSpeed; }
    double x_new = x_old+xSpeed;
    double y_new = y_old+ySpeed;
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
    UIView *fallView = [[UIView alloc] initWithFrame:CGRectMake(x_start-80, y_start, 20, 20)];
    fallView.backgroundColor = [UIColor redColor];
    [UIView animateWithDuration:timeFall animations:^void {
        fallView.center = (CGPoint){x_start , 500};
    }];
    [self.view addSubview:fallView ];
}

- (void) fallerSelector:(NSTimer *)timer  {
    if ((probability(1.1)) && self.QWdadyViewOnScreen ) {
        [self fallDown];
    }
}


@end
