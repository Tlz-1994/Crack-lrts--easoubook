//
//  IPAPatchEntry.m
//  IPAPatch
//
//  Created by wutian on 2017/3/17.
//  Copyright © 2017年 Weibo. All rights reserved.
//

#import "IPAPatchEntry.h"
#import <UIKit/UIKit.h>
#import <Cycript/Cycript.h>
#import "Aspects.h"
#import <objc/runtime.h>

@implementation IPAPatchEntry

static id notificationHandler = nil;

+ (void)load
{
    // DO YOUR WORKS...
//    [self catchEverything];
    // For Example:
//    [self for_example_showAlert];
    
//    [self hiddenAdWithEs];
//    notificationHandler = [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
//                
//        CYListenServer(4567);
//    }];
}

/// 屏蔽懒人听书广告
+ (void)catchEverything {
    Class cls1 = NSClassFromString(@"BaiduMobAdDubao");
    [cls1 aspect_hookSelector:NSSelectorFromString(@"showAd") withOptions:AspectPositionInstead usingBlock:^(){
        
    }error:nil];
    Class cls2 = NSClassFromString(@"NSObject");
    [cls2 aspect_hookSelector:NSSelectorFromString(@"isVIPOrLimitTimeListenWholeBook:") withOptions:AspectPositionInstead usingBlock:^BOOL(){
        return YES;
    }error:nil];
    [cls2 aspect_hookSelector:NSSelectorFromString(@"setIsVIP") withOptions:AspectPositionInstead usingBlock:^BOOL(){
        return YES;
    }error:nil];
    [cls2 aspect_hookSelector:NSSelectorFromString(@"isVerifiedAnnouncer") withOptions:AspectPositionInstead usingBlock:^BOOL(){
        return YES;
    }error:nil];
    [cls2 aspect_hookSelector:NSSelectorFromString(@"isAnyFreeLimits:") withOptions:AspectPositionInstead usingBlock:^BOOL(){
        return YES;
    }error:nil];
    [cls2 aspect_hookSelector:NSSelectorFromString(@"isFreeLimits:") withOptions:AspectPositionInstead usingBlock:^BOOL(){
        return YES;
    }error:nil];
    [cls2 aspect_hookSelector:NSSelectorFromString(@"isMemberFreeLimits:") withOptions:AspectPositionInstead usingBlock:^BOOL(){
        return YES;
    }error:nil];
    [cls2 aspect_hookSelector:NSSelectorFromString(@"isLimitTimeListenWholeBook:") withOptions:AspectPositionInstead usingBlock:^BOOL(){
        return YES;
    }error:nil];
    [cls2 aspect_hookSelector:NSSelectorFromString(@"isVIPOrLimitTimeListenWholeBook:") withOptions:AspectPositionInstead usingBlock:^BOOL(){
        return YES;
    }error:nil];
    Class cls3 = NSClassFromString(@"LMListenBuyModel");
    [cls3 aspect_hookSelector:NSSelectorFromString(@"isBuyWholeBook") withOptions:AspectPositionInstead usingBlock:^BOOL(){
        return YES;
    }error:nil];
    Class cls4 = NSClassFromString(@"LMRPopPayViewModel");
    [cls4 aspect_hookSelector:NSSelectorFromString(@"isBuyCurrentChapter") withOptions:AspectPositionInstead usingBlock:^BOOL(){
        return YES;
    }error:nil];
    Class cls5 = NSClassFromString(@"RMStoreKeychainPersistence");
    [cls5 aspect_hookSelector:NSSelectorFromString(@"isPurchasedProductOfIdentifier:") withOptions:AspectPositionInstead usingBlock:^BOOL(){
        return YES;
    }error:nil];
    Class cls6 = NSClassFromString(@"RMStoreUserDefaultsPersistence");
    [cls6 aspect_hookSelector:NSSelectorFromString(@"isPurchasedProductOfIdentifier:") withOptions:AspectPositionInstead usingBlock:^BOOL(){
        return YES;
    }error:nil];
    Class cls7 = NSClassFromString(@"LMSectionlistCell");
    [cls7 aspect_hookSelector:NSSelectorFromString(@"data") withOptions:AspectPositionInstead usingBlock:^(id<AspectInfo> aspectInfo){
        NSLog(@"-------%@: -------%@", aspectInfo.instance, aspectInfo.arguments);
    }error:nil];
}

+ (void)hiddenAdWithEs {
    Class cls1 = NSClassFromString(@"BaiduMobAdDubao");
    [cls1 aspect_hookSelector:NSSelectorFromString(@"showAd") withOptions:AspectPositionInstead usingBlock:^(){
        
    }error:nil];
    Class cls2 = NSClassFromString(@"ESBookReadViewController");
    [cls2 aspect_hookSelector:NSSelectorFromString(@"showAdvertising") withOptions:AspectPositionInstead usingBlock:^(){
        
    }error:nil];
    Class cls3 = NSClassFromString(@"ESBookReadViewController");
    [cls3 aspect_hookSelector:NSSelectorFromString(@"showAdvertising") withOptions:AspectPositionInstead usingBlock:^(){
        
    }error:nil];
    Class cls4 = NSClassFromString(@"BaiduMobAdView");
    [cls4 aspect_hookSelector:NSSelectorFromString(@"start") withOptions:AspectPositionInstead usingBlock:^(){
        
    }error:nil];
    Class cls5 = NSClassFromString(@"ESAdDataTool");
    [cls5 aspect_hookSelector:NSSelectorFromString(@"loadingAdShow") withOptions:AspectPositionInstead usingBlock:^BOOL(){
        return NO;
    }error:nil];
    [cls5 aspect_hookSelector:NSSelectorFromString(@"searchVCAdShow") withOptions:AspectPositionInstead usingBlock:^BOOL(){
        return NO;
    }error:nil];
    [cls5 aspect_hookSelector:NSSelectorFromString(@"bookShelfAdShow") withOptions:AspectPositionInstead usingBlock:^BOOL(){
        return NO;
    }error:nil];
    [cls5 aspect_hookSelector:NSSelectorFromString(@"fstLoginShow") withOptions:AspectPositionInstead usingBlock:^BOOL(){
        return NO;
    }error:nil];
    [cls5 aspect_hookSelector:NSSelectorFromString(@"coverAdShow") withOptions:AspectPositionInstead usingBlock:^BOOL(){
        return NO;
    }error:nil];
    [cls5 aspect_hookSelector:NSSelectorFromString(@"coverAdShow") withOptions:AspectPositionInstead usingBlock:^BOOL(){
        return NO;
    }error:nil];
    
    Class cls6 = NSClassFromString(@"EASSwitchBannerView");
    [cls6 aspect_hookSelector:NSSelectorFromString(@"loadAdAndShow") withOptions:AspectPositionInstead usingBlock:^(){
        
    }error:nil];
    [cls6 aspect_hookSelector:NSSelectorFromString(@"initWithFrame:publsherId") withOptions:AspectPositionInstead usingBlock:^id(){
        return [UIView new];
    }error:nil];
    
    Class cls7 = NSClassFromString(@"ESBookReadViewController");
    [cls7 aspect_hookSelector:NSSelectorFromString(@"showAdvertising") withOptions:AspectPositionInstead usingBlock:^(){
        
    }error:nil];
    [cls7 aspect_hookSelector:NSSelectorFromString(@"getAdvertisingData") withOptions:AspectPositionInstead usingBlock:^(id<AspectInfo> aspectInfo){
        SEL remove = NSSelectorFromString(@"removeAdvertising");
        [aspectInfo.instance performSelector:remove];
        NSLog(@"%@", aspectInfo.instance);
    }error:nil];
    
    Class cls8 = NSClassFromString(@"ESBookConnateView");
    [cls8 aspect_hookSelector:NSSelectorFromString(@"initWithFrame:") withOptions:AspectPositionInstead usingBlock:^id(id<AspectInfo> aspectInfo){
        return [UIView new];
    }error:nil];
    
    Class cls9 = NSClassFromString(@"EasouSplashAdVC");
    [cls9 aspect_hookSelector:NSSelectorFromString(@"viewWillAppear:") withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo){
        SEL goHomeVC = NSSelectorFromString(@"goHomeVC");
        [aspectInfo.instance performSelector:goHomeVC];
    }error:nil];
}

+ (void)for_example_showAlert
{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"Hacked" message:@"Hacked with IPAPatch" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:NULL]];
        UIViewController * controller = [UIApplication sharedApplication].keyWindow.rootViewController;
        while (controller.presentedViewController) {
            controller = controller.presentedViewController;
        }
        [controller presentViewController:alertController animated:YES completion:NULL];
    });
}

@end
