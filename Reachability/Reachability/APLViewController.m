/*
 Copyright (C) 2015 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 Application delegate class.
 */

#import "APLViewController.h"
#import "Reachability.h"


@interface APLViewController ()

@property (nonatomic) Reachability *hostReachability;

@end

@implementation APLViewController

- (void)viewDidLoad{

  [super viewDidLoad];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
  
  NSString *remoteHostName = @"http://www.baidu.com";
  self.hostReachability = [Reachability reachabilityWithHostName:remoteHostName];
  [self.hostReachability startNotifier];
  [self updateInterfaceWithReachability:self.hostReachability];
}

- (void) reachabilityChanged:(NSNotification *)note{

  Reachability* curReach = [note object];
  [self updateInterfaceWithReachability:curReach];
}

- (void)updateInterfaceWithReachability:(Reachability *)reachability{

  if (reachability == self.hostReachability){
    [self configureTextField: reachability];
  }
}

- (void)configureTextField:(Reachability *)reachability{
  //NetworkStatus定义的枚举，
  NetworkStatus netStatus = [reachability currentReachabilityStatus];
  BOOL connectionRequired = [reachability connectionRequired];
  
  switch (netStatus){
    case NotReachable:
    {
      NSLog(@"网络不可用");
      connectionRequired = NO;
      break;
    }
    case ReachableViaWWAN:        {
      NSLog(@"连接WWAN");
      break;
    }
    case ReachableViaWiFi:        {
      NSLog(@"当前连接了WiFi");
      break;
    }
  }
  if (connectionRequired){
    //没有连接网络的操作；
  }
}

@end
