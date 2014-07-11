//
//  AppDelegate.m
//  romods
//
//  Created by Kosuke Nagano on 2014/07/11.
//  Copyright (c) 2014年 Kousuke Nagano. All rights reserved.
//

#import "AppDelegate.h"
#import <CocoaHTTPServer/HTTPServer.h>

@interface AppDelegate ()
/**
 HTTPサーバーインスタンス
 */
@property (strong, nonatomic) HTTPServer *httpServer;

@end

@implementation AppDelegate
            

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // HTTPサーバーインスタンスを生成する
    self.httpServer = [HTTPServer new];
    
    // ポート未指定の場合ランダムで設定されるので、適当なポート番号を指定する
    self.httpServer.port = 50000;
    
    // ドキュメントルートに「htdocs」を指定する
    self.httpServer.documentRoot = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"htdocs"];

    // HTTPサーバーを起動する
    [self startServer];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // HTTPサーバーを停止する
    [self stopServer];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // HTTPサーバーを起動する
    [self startServer];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Private mehtods
/**
 HTTPサーバーを起動する
 */

- (void)startServer
{
    NSError *error;
    
    if (![self.httpServer start:&error]) {
        NSLog(@"Error starting HTTP Server: %@", error);
    }
}

/**
 HTTPサーバーを停止する
 */
- (void)stopServer
{
    [self.httpServer stop];
}

@end