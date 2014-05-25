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
@property (nonatomic) CGFloat speedDir;
@property (nonatomic) IBOutlet UIImageView *QWdadyView;
@property (nonatomic) BOOL QWdadyViewOnScreen;
@property (nonatomic) BOOL QWdadyRunnigBool;
@property (nonatomic) CGFloat x_DadStart;
@property (nonatomic) CGFloat y_DadStart;
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

	// Do any additional setup after loading the view, typically from a nib.
    self.speedDir = 1;
    self.xSpeed = .3;
    self.ySpeed = 0;
    self.x_DadStart = -15;
    self.y_DadStart = 25;
    QWdadyView = [[UIImageView alloc] init];
    [self.view addSubview:QWdadyView ];
    UIImage *img = [UIImage imageNamed:@"3q_my.png"];
    CGRect siz = QWdadyView.frame;
    siz.size = img.size;
    QWdadyView.frame = siz;
    QWdadyView.image = img;
//    QWdadyView.center = (CGPoint) {5,22};
    QWdadyView.center = (CGPoint) {self.x_DadStart,self.y_DadStart};
//    QWdadyView.backgroundColor = [UIColor blueColor];

    NSTimer *timerQWRun = [NSTimer scheduledTimerWithTimeInterval:8 target:self selector: @selector(runnerSelector:) userInfo: nil repeats:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) QWdadRunner:(NSTimer *)timer {
    double x_old = QWdadyView.center.x;
    double y_old = QWdadyView.center.y;
    self.QWdadyViewOnScreen = (x_old<310) && (x_old>10);
    self.QWdadyRunnigBool = ((x_old<350) && self.speedDir >0) || ((x_old>-30) && self.speedDir<0);
    double xSpeed = self.xSpeed;
    double ySpeed = 0;
    if ( !self.QWdadyRunnigBool) { xSpeed = 0; }
    double x_new = x_old+self.speedDir*xSpeed;
    double y_new = y_old+ySpeed;
    QWdadyView.center= (CGPoint) {x_new , y_new};
    NSLog(@"xNew,yNew, dir = %f %f %f", x_new,y_new,self.speedDir);
}

- (void) QWdadTimers {
    NSTimer *timerRunnerQWdady = [NSTimer scheduledTimerWithTimeInterval:.01 target:self selector: @selector(QWdadRunner:) userInfo: nil repeats:YES];
    NSTimer *timerBonusFall = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector: @selector(fallerSelector:) userInfo: nil repeats:YES];
    
}

- (void) runnerSelector:(NSTimer *)timer {
    double x_old = self.QWdadyView.center.x;
    double y_old = self.QWdadyView.center.y;
    if (x_old>335){
        self.speedDir=-1;
    }
    if (x_old<-15){
        self.speedDir=1;
    }
    if (probability(0.9)) {
        [self QWdadTimers];
    }
}

- (void) bonusClick:(UIView *) View {
    NSLog(@"button taped");
    View.hidden = true;
}

- (void) fallDown {
    NSInteger timeFall = 5;     //Falling time
    CGFloat x_start = QWdadyView.center.x;
    CGFloat y_start = QWdadyView.center.y+self.speedDir*15;
    UIImageView *fallView = [[UIImageView alloc] initWithFrame:CGRectMake(x_start, y_start, 20, 20)];
    UIImage *img = [UIImage imageNamed:@"Apple.png"];
    CGRect siz = QWdadyView.frame;
    siz.size = img.size;
    fallView.frame = siz;
    fallView.image = img;
    fallView.center = (CGPoint) {x_start,y_start};
    UIButton* button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self action:@selector(bonusClick:) forControlEvents:UIControlEventTouchDown];
    button.center = (CGPoint){0,0};
    [fallView addSubview:button];
    [UIView animateWithDuration:timeFall delay:.01 options:UIViewAnimationOptionCurveEaseIn animations:^void {fallView.center = (CGPoint){x_start, 500};} completion:nil];
//    [UIView animateWithDuration:timeFall animations:^void {
//        fallView.center = (CGPoint){x_start , 500};
//    }];
    [self.view addSubview:fallView ];
}

- (void) fallerSelector:(NSTimer *)timer  {
    if ((probability(0.6)) && self.QWdadyViewOnScreen ) {
        [self fallDown];
    }
}


@end
