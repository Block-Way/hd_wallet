#import <Flutter/Flutter.h>
#import <Foundation/Foundation.h>

@interface HDKeyCore : NSObject

+ (void)callFunc:(FlutterMethodCall *)call result:(FlutterResult)result;

+ (void)init;

@end
