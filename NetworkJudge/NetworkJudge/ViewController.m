//
//  ViewController.m
//  NetworkJudge
//
//  Created by chenyufeng on 15/12/9.
//  Copyright © 2015年 chenyufengweb. All rights reserved.
//

#import "ViewController.h"
#import "Reachability.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  [self testConnection];

}

-(void)testConnection{
  NSString *result;
  if ([self checkNetworkConnection]) {
    result = @"连接网络成功！";
  }else {
    result = @"连接网络失败！";
  }
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:result
                                                 delegate:self
                                        cancelButtonTitle:@"确定" otherButtonTitles:nil];
  [alert show];
  
}

-(BOOL)checkNetworkConnection
{
  struct sockaddr_in zeroAddress;
  bzero(&zeroAddress, sizeof(zeroAddress));
  zeroAddress.sin_len = sizeof(zeroAddress);
  zeroAddress.sin_family = AF_INET;
  
  SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
  SCNetworkReachabilityFlags flags;
  
  BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
  CFRelease(defaultRouteReachability);
  
  if (!didRetrieveFlags) {
    printf("Error. Count not recover network reachability flags\n");
    return NO;
  }
  
  BOOL isReachable = flags & kSCNetworkFlagsReachable;
  BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
  return (isReachable && !needsConnection) ? YES : NO;
}

@end


