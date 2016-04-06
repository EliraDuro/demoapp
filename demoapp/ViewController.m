//
//  ViewController.m
//  demoapp
//
//  Created by nyuguest on 4/4/16.
//  Copyright © 2016 nyuguest. All rights reserved.
//

#import "ViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
//#import "GraphAPIReadViewController.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>

//#import "AlertControllerUtility.h"
//#import "PermissionUtility.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"@got here1");

    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    // Optional: Place the button in the center of your view.
    loginButton.center = self.view.center;
    [self.view addSubview:loginButton];
    loginButton.readPermissions = @[@"email", @"user_friends"];
     //NSLog(@"@got here1");
    if ([FBSDKAccessToken currentAccessToken]) {
        // NSLog(@"@got here");
        if ([[FBSDKAccessToken currentAccessToken] hasGranted:@"publish_actions"]) {
            // TODO: publish content.
           
        } else {
            
            FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
            [loginManager logInWithPublishPermissions:@[@"publish_actions"]
                                   fromViewController:self
                                              handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                                  //TODO: process error or result.
                                              }];
        }
    }

    

    
    
}

#pragma mark - Read Users

- (IBAction)readProfile:(id)sender
{
    // See https://developers.facebook.com/docs/graph-api/reference/user/ for details.
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                  initWithGraphPath:@"/me"
                                  parameters:@{ @"fields" : @"id, name" }
                                  HTTPMethod:@"GET"];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
        [self handleRequestCompletionWithResult:result error:error];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helper Method

- (void)handleRequestCompletionWithResult:(id)result error:(NSError *)error
{
    NSString *title = nil;
    NSString *message = nil;
    if (error) {
        title = @"Graph Request Fail";
        message = [NSString stringWithFormat:@"Graph API request failed with error:\n %@", error];
    } else {
        title = @"Graph Request Success";
        message = [NSString stringWithFormat:@"Graph API request success with result:\n %@", result];
    }
    //UIAlertController *alertController = [AlertControllerUtility alertControllerWithTitle:title message:message];
    //[self presentViewController:alertController animated:YES completion:nil];
}

@end
