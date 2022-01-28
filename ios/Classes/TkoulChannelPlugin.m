#import "TkoulChannelPlugin.h"
@interface TkoulChannelPlugin ()
@property(strong,nonatomic)NSMutableArray *arryClass;
@end
@implementation TkoulChannelPlugin
static dispatch_once_t onceToken;
static TkoulChannelPlugin *singleInstance =nil;
+ (TkoulChannelPlugin *)sharedInstance
{
    dispatch_once(&onceToken, ^{
        singleInstance = [[TkoulChannelPlugin alloc] init];
        singleInstance.arryClass = [[NSMutableArray alloc] init];
        
    });
    return singleInstance;
}
- (void)setDelegete:(__weak id<TkoulChannelPluginDelegete>)delegete{
    [self  registerClaseName:delegete.class];
}
- (void)registerClaseName:(Class)regClass{
    NSString  *stringClass =NSStringFromClass(regClass);
    if (![self.arryClass containsObject:stringClass]) {
        [self.arryClass addObject:stringClass];
    }
}
+ (void)tkRegisterWithRegistry:(NSObject<FlutterPluginRegistry>*)registry{
    NSLog(@"registry===%@",registry);
    [TkoulChannelPlugin registerWithRegistrar:[registry registrarForPlugin:@"TkoulChannelPlugin"]];
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"tkoul_channel_plugin"
                                     binaryMessenger:[registrar messenger]];
    TkoulChannelPlugin* instance = [TkoulChannelPlugin sharedInstance];;
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSString  *method = call.method;
    if (!method) {
        result(FlutterMethodNotImplemented);
        return;
    }
    NSArray   *arguments =  call.arguments;
    if (arguments.count!=0&&[self.arryClass containsObject:arguments[0]]) {
        Class  classDo =  NSClassFromString(arguments[0]);
        SEL sel = NSSelectorFromString(@"tkoulChannlePlugin:result:");
        if ([classDo respondsToSelector:sel]) {
              #pragma clang diagnostic push
              #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [classDo performSelector:sel withObject:arguments.count>=2?arguments[1]:@[] withObject:result];
              #pragma clang diagnostic pop
        }else{
            result(@{@"code":@"-1",@"msg":@"flutter唤起的类不存在或者类没有注册tkoulChannlePlugin:result: 方法"});
        }
    }else{
        result(@{@"code":@"-1",@"msg":@"入参错误"});
    }
    
    
    
//    if ([call.method containsString:@"get"]) {
//        result(@"sssss");
//    }else{
//        result(@[@"ww,,,"]);
//    }
    
    
}
@end
