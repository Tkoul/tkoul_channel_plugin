#import <Flutter/Flutter.h>


@protocol TkoulChannelPluginDelegete <NSObject>

+ (void)tkoulChannlePlugin:(NSObject*)arguments result:(void(^)(NSDictionary *callBackDic))result;

@end

@interface TkoulChannelPlugin : NSObject<FlutterPlugin>

@property(weak,nonatomic)id <TkoulChannelPluginDelegete> delegete;

+ (TkoulChannelPlugin *)sharedInstance;

- (void)registerClaseName:(Class)regClass;

+ (void)tkRegisterWithRegistry:(NSObject<FlutterPluginRegistry>*)registry;

@end
