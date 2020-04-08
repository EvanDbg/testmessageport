#import <AppSupport/CPDistributedMessagingCenter.h>
#import <rocketbootstrap/rocketbootstrap.h>
#import <objc/objc-runtime.h>
#import <UIKit/UIKit.h>

@interface SpringBoard : UIApplication
-(void)_simulateHomeButtonPress;
-(void)_simulateLockButtonPress;
@end

static void pressHome() {
    [((SpringBoard *)[%c(SpringBoard) sharedApplication]) _simulateHomeButtonPress];
}

%hook SpringBoard

- (void)applicationDidFinishLaunching:(id)application {
   %orig;
   CPDistributedMessagingCenter *c = [%c(CPDistributedMessagingCenter) centerNamed:@"com.yourcompany.testmessageport.xxx"];
   rocketbootstrap_distributedmessagingcenter_apply(c);
   [c runServerOnCurrentThread];
   [c registerForMessageName:@"xxx" target:self selector:@selector(handleMessage_testmessageport:userInfo:)];
   // [[[UIAlertView alloc] initWithTitle:nil message:@"registered distributed messaging center." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
   [c registerForMessageName:@"pressHome" target:self selector:@selector(handleMessage_pressHome:userInfo:)];
   
   CFNotificationCenterAddObserver(
            CFNotificationCenterGetDarwinNotifyCenter(),
            NULL,
            (CFNotificationCallback)pressHome,
            (CFStringRef)@"fun.yfyf/pressHome",
            NULL,
            CFNotificationSuspensionBehaviorCoalesce);
}

%new
- (NSDictionary *)handleMessage_testmessageport:(NSString *)name userInfo:(NSDictionary *)userInfo {
   NSString *message = [NSString stringWithFormat:@"handled message userInfo:%@", userInfo];
   [[[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
   
   NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
   [result setObject:@"success" forKey:@"status"];
   return result;
}

%new
- (NSDictionary *)handleMessage_pressHome:(NSString *)name userInfo:(NSDictionary *)userInfo {
   [((SpringBoard *)[%c(SpringBoard) sharedApplication]) _simulateHomeButtonPress];
   
   NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
   [result setObject:@"success" forKey:@"status"];
   return result;
}

%end
