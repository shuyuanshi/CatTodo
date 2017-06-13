//
//  FirstViewController.m
//  CatTodo
//
//  Created by Shuyuan Shi on 6/12/17.
//  Copyright © 2017 CatTodo. All rights reserved.
//

#import "FirstViewController.h"
#import "CCPCalendarManager.h"
#import "CCPCalendarModel.h"
#import "StoreManager.h"


#define PLACEMENT_ID @"287734805022076_287804248348465"

@interface FirstViewController ()
@property (nonatomic) UITextView *eventTextView;

@end

@implementation FirstViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, self.view.frame.size.width, 30)];
  label.text = @"Please input your To-do";
  label.textColor = [UIColor whiteColor];
  label.font = [UIFont boldSystemFontOfSize:13];
  [self.view addSubview:label];
  
  // Do any additional setup after loading the view, typically from a nib.
  __weak FirstViewController *weakSelf = self;
  [CCPCalendarManager show_signal_past:self complete:^(NSArray *stArr) {
    if (stArr.count > 0) {
      CCPCalendarModel *calendarModel = [stArr firstObject];
      NSMutableDictionary *todo = [[NSMutableDictionary alloc] init];
      [todo setObject:calendarModel.ccpDate forKey:@"date"];
      [todo setObject:weakSelf.eventTextView.text forKey:@"event"];
      [StoreManager addTodo:todo];
      NSLog(@"%@", [StoreManager getTodos]);

      if ([[UIApplication sharedApplication].delegate.window.rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)([UIApplication sharedApplication].delegate.window.rootViewController);
        UITabBarItem *item = (UITabBarItem *)[tabBarController.tabBar.items lastObject];
        NSUInteger todoCount = [StoreManager getTodos].count;
        if (todoCount)
          item.badgeValue = [NSString stringWithFormat:@"%lu", todoCount];
      }
    }
  }];

  FBAdView *adView = [[FBAdView alloc] initWithPlacementID:PLACEMENT_ID
                                                    adSize:kFBAdSizeHeight50Banner
                                        rootViewController:self];
  adView.frame = CGRectMake(0, self.view.frame.size.height - 49 - adView.bounds.size.height, adView.bounds.size.width, adView.bounds.size.height);
  adView.delegate = self;
  [adView loadAd];
  [self.view addSubview:adView];

  _eventTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 60, self.view.frame.size.width - 20, 80)];
  [_eventTextView setReturnKeyType:UIReturnKeyDone];
  _eventTextView.delegate = self;
  [self.view addSubview:_eventTextView];

  _eventTextView.backgroundColor = [UIColor whiteColor];
  _eventTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
  _eventTextView.layer.borderWidth = 2.f;
  _eventTextView.layer.cornerRadius = 3.f;

  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTextView:) name:@"received deferred deeplink" object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTextView:) name:@"received applink" object:nil];
}

- (void) viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  if ([[UIApplication sharedApplication].delegate.window.rootViewController isKindOfClass:[UITabBarController class]]) {
    UITabBarController *tabBarController = (UITabBarController *)([UIApplication sharedApplication].delegate.window.rootViewController);
    UITabBarItem *item = (UITabBarItem *)[tabBarController.tabBar.items lastObject];
    NSUInteger todoCount = [StoreManager getTodos].count;
    if (todoCount)
      item.badgeValue = [NSString stringWithFormat:@"%lu", todoCount];
  }
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {

  if([text isEqualToString:@"\n"]) {
    [textView resignFirstResponder];
    return NO;
  }

  return YES;
}

- (void)reloadTextView:(NSNotification*)notification
{
  if (notification) {
    NSDictionary* userInfo = notification.userInfo;
    _eventTextView.text = [userInfo objectForKey:@"url"];
  }
}
@end
