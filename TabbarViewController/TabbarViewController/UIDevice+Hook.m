

#import <objc/runtime.h>
#import "UIDevice+Hook.h"

@implementation UIDevice (Hook)

- (NSUUID *)hookedIdentifierForVendor {
    // 在这里实现您自己的逻辑，生成或返回您想要的唯一标识符
    return [[NSUUID alloc] initWithUUIDString:@"YourCustomUUIDString"];
}

// 在应用程序启动时进行Hook
__attribute__((constructor))
static void initialize(void) {
    Method originalMethod = class_getInstanceMethod([UIDevice class], @selector(identifierForVendor));
    Method swizzledMethod = class_getInstanceMethod([UIDevice class], @selector(hookedIdentifierForVendor));
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

@end
