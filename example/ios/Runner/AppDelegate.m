#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
#import "TkoulChannelPlugin.h"

@interface AppDelegate()<TkoulChannelPluginDelegete>
{
    TkoulChannelPlugin *plugs;
}
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
//    [TkoulChannelPluginSingle sharedInstance];
//  

//    [TkoulChannelPlugin  registerWithRegistrar:self];
//    [[TkoulChannelPlugin sharedInstance] registerClaseName:self.class];
    [[TkoulChannelPlugin sharedInstance] setDelegete:self];
    [TkoulChannelPlugin tkRegisterWithRegistry:self];
    
    
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        plugs = [[TkoulChannelPlugin alloc]init];
//        [plugs setDelegete:self];
//    });
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}



static int a =0;
+ (void)tkoulChannlePlugin:(NSObject *)arguments result:(void (^)(NSDictionary *))result {
    if ([[arguments valueForKey:@"type"] isEqualToString:@"show"]) {
        NSLog(@"展示参数==%@",arguments);
        if (result) {
            result(@{@"code":@"0",@"message":@"hello"});
        }
    }if ([[arguments valueForKey:@"type"] isEqualToString:@"flutterBtnClick"]) {
        NSLog(@"点击交互==%@",arguments);
        if (result) {
            result(@{@"code":@"0",@"message":[NSString stringWithFormat:@"beautiful%d",a]});
            a++;
        }
    }else{
        if (result) {
            result(@{@"code":@"1",@"message":@"hello"});
        }
    }
  
}


@end
