#line 1 "/Users/Zheng/Projects/QQMsgRecallPatch/QQMsgRecallPatch/QQMsgRecallPatch.xm"

static BOOL trail = NO;

#include <logos/logos.h>
#include <substrate.h>
@class RecallC2CBaseProcessor; @class RecallGroupProcessor; @class RecallDiscussProcessor; @class QQPlatform; 

static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$QQPlatform(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("QQPlatform"); } return _klass; }
#line 4 "/Users/Zheng/Projects/QQMsgRecallPatch/QQMsgRecallPatch/QQMsgRecallPatch.xm"
static NSString * (*_logos_orig$QQRecallPatch$RecallC2CBaseProcessor$getRecallMessageContent$)(RecallC2CBaseProcessor*, SEL, id); static NSString * _logos_method$QQRecallPatch$RecallC2CBaseProcessor$getRecallMessageContent$(RecallC2CBaseProcessor*, SEL, id); static void (*_logos_orig$QQRecallPatch$RecallC2CBaseProcessor$updateMessageContentAndType$content$msgType$)(RecallC2CBaseProcessor*, SEL, id, id, int); static void _logos_method$QQRecallPatch$RecallC2CBaseProcessor$updateMessageContentAndType$content$msgType$(RecallC2CBaseProcessor*, SEL, id, id, int); static id (*_logos_orig$QQRecallPatch$RecallDiscussProcessor$getLocalMessage$)(RecallDiscussProcessor*, SEL, id); static id _logos_method$QQRecallPatch$RecallDiscussProcessor$getLocalMessage$(RecallDiscussProcessor*, SEL, id); static NSString * (*_logos_orig$QQRecallPatch$RecallDiscussProcessor$getRecallMessageContent$item$msg$isOnline$)(RecallDiscussProcessor*, SEL, id, id, id, BOOL); static NSString * _logos_method$QQRecallPatch$RecallDiscussProcessor$getRecallMessageContent$item$msg$isOnline$(RecallDiscussProcessor*, SEL, id, id, id, BOOL); static id (*_logos_orig$QQRecallPatch$RecallGroupProcessor$getLocalMessage$)(RecallGroupProcessor*, SEL, id); static id _logos_method$QQRecallPatch$RecallGroupProcessor$getLocalMessage$(RecallGroupProcessor*, SEL, id); static id (*_logos_orig$QQRecallPatch$RecallGroupProcessor$getRecallMessageContent$item$msg$isOnline$)(RecallGroupProcessor*, SEL, id, id, id, BOOL); static id _logos_method$QQRecallPatch$RecallGroupProcessor$getRecallMessageContent$item$msg$isOnline$(RecallGroupProcessor*, SEL, id, id, id, BOOL); 
























































@interface QQMessageModel
@property (readonly) int msgType;
@property (nonatomic) unsigned msgID;
@end

#pragma mark - better recall tips

















static NSString * _logos_method$QQRecallPatch$RecallC2CBaseProcessor$getRecallMessageContent$(RecallC2CBaseProcessor* self, SEL _cmd, id content) {


        return [[_logos_orig$QQRecallPatch$RecallC2CBaseProcessor$getRecallMessageContent$(self, _cmd, content) stringByReplacingOccurrencesOfString:@"撤回了" withString:@"尝试撤回"] stringByAppendingString:@" (已恢复)"];



}


static void _logos_method$QQRecallPatch$RecallC2CBaseProcessor$updateMessageContentAndType$content$msgType$(RecallC2CBaseProcessor* self, SEL _cmd, id msg, id content, int type) {
    _logos_orig$QQRecallPatch$RecallC2CBaseProcessor$updateMessageContentAndType$content$msgType$(self, _cmd, msg, content, type);
    QQMessageModel *model = (QQMessageModel *)msg;
    model.msgID++;
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObject:model];
    [[[[_logos_static_class_lookup$QQPlatform() sharedPlatform] QQServiceCenter] C2CMultiTableDB] batchInsertReceivedMessages:arr];
    return;
}



































static id _logos_method$QQRecallPatch$RecallDiscussProcessor$getLocalMessage$(RecallDiscussProcessor* self, SEL _cmd, id item) {
    if (_logos_orig$QQRecallPatch$RecallDiscussProcessor$getLocalMessage$(self, _cmd, item) != nil) {
        trail = YES;
    }
    return nil;
}





static NSString * _logos_method$QQRecallPatch$RecallDiscussProcessor$getRecallMessageContent$item$msg$isOnline$(RecallDiscussProcessor* self, SEL _cmd, id content, id item, id msg, BOOL online) {
    if (trail) {
        trail = NO;
        return [[_logos_orig$QQRecallPatch$RecallDiscussProcessor$getRecallMessageContent$item$msg$isOnline$(self, _cmd, content, item, msg, online) stringByReplacingOccurrencesOfString:@"撤回了" withString:@"尝试撤回"] stringByAppendingString:@" (已恢复)"];
    } else {
        return _logos_orig$QQRecallPatch$RecallDiscussProcessor$getRecallMessageContent$item$msg$isOnline$(self, _cmd, content, item, msg, online);
    }
}



static id _logos_method$QQRecallPatch$RecallGroupProcessor$getLocalMessage$(RecallGroupProcessor* self, SEL _cmd, id item) {
    if (_logos_orig$QQRecallPatch$RecallGroupProcessor$getLocalMessage$(self, _cmd, item) != nil) {
        trail = YES;
    }
    return nil;
}





static id _logos_method$QQRecallPatch$RecallGroupProcessor$getRecallMessageContent$item$msg$isOnline$(RecallGroupProcessor* self, SEL _cmd, id content, id item, id msg, BOOL online) {
    if (trail) {
        trail = NO;
        return [[_logos_orig$QQRecallPatch$RecallGroupProcessor$getRecallMessageContent$item$msg$isOnline$(self, _cmd, content, item, msg, online) stringByReplacingOccurrencesOfString:@"撤回了" withString:@"尝试撤回"] stringByAppendingString:@" (已恢复)"];
    } else {
        return _logos_orig$QQRecallPatch$RecallGroupProcessor$getRecallMessageContent$item$msg$isOnline$(self, _cmd, content, item, msg, online);
    }
}




static __attribute__((constructor)) void _logosLocalCtor_c722081e() {
    {Class _logos_class$QQRecallPatch$RecallC2CBaseProcessor = objc_getClass("RecallC2CBaseProcessor"); MSHookMessageEx(_logos_class$QQRecallPatch$RecallC2CBaseProcessor, @selector(getRecallMessageContent:), (IMP)&_logos_method$QQRecallPatch$RecallC2CBaseProcessor$getRecallMessageContent$, (IMP*)&_logos_orig$QQRecallPatch$RecallC2CBaseProcessor$getRecallMessageContent$);MSHookMessageEx(_logos_class$QQRecallPatch$RecallC2CBaseProcessor, @selector(updateMessageContentAndType:content:msgType:), (IMP)&_logos_method$QQRecallPatch$RecallC2CBaseProcessor$updateMessageContentAndType$content$msgType$, (IMP*)&_logos_orig$QQRecallPatch$RecallC2CBaseProcessor$updateMessageContentAndType$content$msgType$);Class _logos_class$QQRecallPatch$RecallDiscussProcessor = objc_getClass("RecallDiscussProcessor"); MSHookMessageEx(_logos_class$QQRecallPatch$RecallDiscussProcessor, @selector(getLocalMessage:), (IMP)&_logos_method$QQRecallPatch$RecallDiscussProcessor$getLocalMessage$, (IMP*)&_logos_orig$QQRecallPatch$RecallDiscussProcessor$getLocalMessage$);MSHookMessageEx(_logos_class$QQRecallPatch$RecallDiscussProcessor, @selector(getRecallMessageContent:item:msg:isOnline:), (IMP)&_logos_method$QQRecallPatch$RecallDiscussProcessor$getRecallMessageContent$item$msg$isOnline$, (IMP*)&_logos_orig$QQRecallPatch$RecallDiscussProcessor$getRecallMessageContent$item$msg$isOnline$);Class _logos_class$QQRecallPatch$RecallGroupProcessor = objc_getClass("RecallGroupProcessor"); MSHookMessageEx(_logos_class$QQRecallPatch$RecallGroupProcessor, @selector(getLocalMessage:), (IMP)&_logos_method$QQRecallPatch$RecallGroupProcessor$getLocalMessage$, (IMP*)&_logos_orig$QQRecallPatch$RecallGroupProcessor$getLocalMessage$);MSHookMessageEx(_logos_class$QQRecallPatch$RecallGroupProcessor, @selector(getRecallMessageContent:item:msg:isOnline:), (IMP)&_logos_method$QQRecallPatch$RecallGroupProcessor$getRecallMessageContent$item$msg$isOnline$, (IMP*)&_logos_orig$QQRecallPatch$RecallGroupProcessor$getRecallMessageContent$item$msg$isOnline$);}
}
