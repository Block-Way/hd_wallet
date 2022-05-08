#import "HDKeyCore.h"

@implementation HDKeyCore
    NSUserDefaults *preferences;

+ (void)callFunc:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSArray *allFunc = @[@"hasHDKey", @"connectHDKey", @"getInfo", @"validatePin", @"setPin", @"changePin"];
    NSUInteger func = [allFunc indexOfObject:call.method];
    
    switch(func){
        case 0:
            [self hasHDKey:call result:result];
            break;
        case 1:
            [self connectHDKey:call result:result];
            break;
        case 2:
            [self getInfo:call result:result];
            break;
        case 3:
            [self validatePin:call result:result];
            break;
        case 4:
            [self setPin:call result:result];
            break;
        case 5:
            [self changePin:call result:result];
            break;
        default:
            return;
    }
}

+ (void)init {
    preferences = [NSUserDefaults standardUserDefaults];
}

+ (void)hasHDKey:(FlutterMethodCall*)call result:(FlutterResult)result {
//    NSError* __autoreleasing error;
    @try
    {
        result(@(YES));
    }
    @catch(NSException *exception) {
        result([FlutterError errorWithCode:@"Error" message:exception.reason details:nil]);
        return;
    }
}

+ (void)connectHDKey:(FlutterMethodCall*)call result:(FlutterResult)result {
//    NSError* __autoreleasing error;
    @try
    {
        result(@(YES));
    }
    @catch(NSException *exception) {
        result([FlutterError errorWithCode:@"Error" message:exception.reason details:nil]);
        return;
    }
}

+ (void)getInfo:(FlutterMethodCall*)call result:(FlutterResult)result {
//    NSError* __autoreleasing error;
    @try
    {
        NSObject * _Nullable hasPin = [preferences objectForKey:@"pin"];
        NSMutableDictionary *keys = [NSMutableDictionary dictionaryWithCapacity:2];
        keys[@"isInitialized"] = @(YES);
        keys[@"solt"] = @"000";
        result(keys);
    }
    @catch(NSException *exception) {
        result([FlutterError errorWithCode:@"Error" message:exception.reason details:nil]);
        return;
    }
}

+ (void)validatePin:(FlutterMethodCall*)call result:(FlutterResult)result {
//    NSError* __autoreleasing error;
//    NSString* pin = call.arguments[@"pin"];
    @try
    {
        result(@(YES));
    }
    @catch(NSException *exception) {
        result([FlutterError errorWithCode:@"Error" message:exception.reason details:nil]);
        return;
    }
}

+ (void)setPin:(FlutterMethodCall*)call result:(FlutterResult)result {
//    NSError* __autoreleasing error;
    NSString* pin = call.arguments[@"pin"];
    @try
    {
        [preferences setValue:pin forKey:@"pin"];
        result(@(YES));
    }
    @catch(NSException *exception) {
        result([FlutterError errorWithCode:@"Error" message:exception.reason details:nil]);
        return;
    }
}

+ (void)changePin:(FlutterMethodCall*)call result:(FlutterResult)result {
//    NSError* __autoreleasing error;
//    NSString* oldPin = call.arguments[@"oldPin"];
//    NSString* newPin = call.arguments[@"newPin"];
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
