#import "XXRootViewController.h"
#import <dlfcn.h>
#import <objc/objc-runtime.h>
#import <AppSupport/CPDistributedMessagingCenter.h>


void (*rocketbootstrap_distributedmessagingcenter_apply)(CPDistributedMessagingCenter *messaging_center);

static void alert(NSString *format, ...) {
	va_list args;
    va_start(args, format);
    NSString *message = [[NSString alloc] initWithFormat:format arguments:args];  
    va_end(args);

	[[[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
}

static void loadRocketBootstrap()
{
    if (rocketbootstrap_distributedmessagingcenter_apply) return;
    const char * path = "/usr/lib/librocketbootstrap.dylib";
    void * handle = dlopen(path, RTLD_LAZY);
    if (handle) {
        rocketbootstrap_distributedmessagingcenter_apply = dlsym(handle, "rocketbootstrap_distributedmessagingcenter_apply");
        if (rocketbootstrap_distributedmessagingcenter_apply) {
			return;
        }
        dlclose(handle);
    }
	alert(@"RocketBootstrap is required!");
}


@implementation XXRootViewController {
	NSMutableArray *_objects;
}

- (void)loadView {
	[super loadView];

	self.view.backgroundColor = [UIColor whiteColor];

	self.title = @"Press the Plus button";
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addRightButtonTapped:)] autorelease];
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addLeftButtonTapped:)] autorelease];
}

- (void)addRightButtonTapped:(id)sender {
	loadRocketBootstrap();

	NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
    [userInfo setObject:@"aaaaa" forKey:@"arg001"];
    [userInfo setObject:@"bbbbb" forKey:@"arg002"];

    CPDistributedMessagingCenter *c = [objc_getClass("CPDistributedMessagingCenter") centerNamed:@"com.yourcompany.testmessageport.xxx"];
    rocketbootstrap_distributedmessagingcenter_apply(c);

    NSError *error;
    NSDictionary *result = [c sendMessageAndReceiveReplyName:@"xxx" userInfo:userInfo error:&error];
    if (result) {
        alert(@"send message successful, return: %@", result);
    } else {
        alert(@"send message failed, error: %@",  error.localizedDescription);
    }
}

- (void)addLeftButtonTapped:(id)sender {
    loadRocketBootstrap();

    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
    [userInfo setObject:@"aaaaa" forKey:@"arg001"];
    [userInfo setObject:@"bbbbb" forKey:@"arg002"];

    CPDistributedMessagingCenter *c = [objc_getClass("CPDistributedMessagingCenter") centerNamed:@"com.yourcompany.testmessageport.xxx"];
    rocketbootstrap_distributedmessagingcenter_apply(c);

    NSError *error;
    NSDictionary *result = [c sendMessageAndReceiveReplyName:@"pressHome" userInfo:userInfo error:&error];
    if (result) {
        alert(@"send message successful, return: %@", result);
    } else {
        alert(@"send message failed, error: %@",  error.localizedDescription);
    }
}

@end
