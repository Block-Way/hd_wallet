#import "FlutterHDKeyPlugin.h"
#import "HDKeyCore.h"

@implementation FlutterHDKeyPlugin
    FlutterEventSink _eventSink;

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                   methodChannelWithName:@"flutter_hdkey"
                                   binaryMessenger:[registrar messenger]];
    
    FlutterHDKeyPlugin* instance = [[FlutterHDKeyPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
    
    
    FlutterEventChannel* eventChannel = [FlutterEventChannel
                                        eventChannelWithName:@"flutter_hdkey_event"
                                        binaryMessenger:[registrar messenger]];
    
    [eventChannel setStreamHandler:instance];

    [HDKeyCore init];
}

- (FlutterError*)onListenWithArguments:(id)arguments eventSink:(FlutterEventSink)eventSink {
    _eventSink = eventSink;
    return nil;
}

- (FlutterError*)onCancelWithArguments:(id)arguments {
    _eventSink = nil;
    return nil;
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSArray *allFunc = @[@"testDeviceAttached", @"testDeviceDetached", @"clearTestData"];
    NSUInteger func = [allFunc indexOfObject:call.method];
    
    switch(func){
        case 0:
            [self testDeviceAttached:call result:result];
            break;
        case 1:
            [self testDeviceDetached:call result:result];
            break;
        case 2:
            [self clearTestData:call result:result];
            break;
        default:
            [HDKeyCore callFunc:call result:result];
            return;
    }
}

- (void)sendEvent:(NSObject*)data {
    if (_eventSink != nil) {
        _eventSink(data);
    } else {
        NSLog(@"eventSink is null");
    }
}

- (void)testDeviceAttached:(FlutterMethodCall*)call result:(FlutterResult)result {
    [self sendEvent:@"DeviceAttached"];
}

- (void)testDeviceDetached:(FlutterMethodCall*)call result:(FlutterResult)result {
    [self sendEvent:@"DeviceDetached"];
}

- (void)clearTestData:(FlutterMethodCall*)call result:(FlutterResult)result {
    @try
    {
        result(@(YES));
    }
    @catch(NSException *exception) {
        result([FlutterError errorWithCode:@"Error" message:exception.reason details:nil]);
        return;
    }
}

@end
