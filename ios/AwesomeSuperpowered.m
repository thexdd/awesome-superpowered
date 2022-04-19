#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(AwesomeSuperpowered, NSObject)

RCT_EXTERN_METHOD(construct:(NSString *)recordingPath)

RCT_EXTERN_METHOD(multiply:(float)a withB:(float)b
                 withResolver:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(add:(float)a withB:(float)b
                 withResolver:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)

@end
