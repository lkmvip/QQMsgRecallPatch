//#include <vector>
static BOOL trail = NO;

%group QQRecallPatch

//typedef union {
//    unsigned long long _field1;
//    unsigned long long _field2;
//    unsigned long long _field3;
//} XXUnion_znrfyA;
//
//typedef struct RecallItem {
//    bool _field1;
//    unsigned long long _field2;
//    XXUnion_znrfyA _field3;
//    unsigned _field4;
//    unsigned _field5;
//    unsigned _field6;
//    unsigned _field7;
//    unsigned _field8;
//    unsigned _field9;
//} RecallItem;
//
//typedef struct RecallModel {
//    /*function-pointer*/ void** _field1;
//    int _field2;
//    bool _field3;
//    std::vector<RecallItem *> _field4;
//} RecallModel;
//
//@interface RecallPairForOffline {
//    NSArray* _msgs;
//    RecallModel* _recallModel;
//    int orignalMsgType;
//}
//@property(assign, nonatomic) int orignalMsgType;
//@property(assign, nonatomic) RecallModel* recallModel;
//@property(retain, nonatomic) NSArray* msgs;
//-(void)dealloc;
//@end
//
//@interface RecallC2CBaseProcessor
//@property(readonly, assign) unsigned hash;
//-(void)updateAppBadNumInBackground;
//-(void)updateMsgListC2C:(id)c etype:(int)etype lastReadTime:(unsigned long long)time;
//-(void)updateMsgListOnlyContent:(id)content;
//-(void)updateMsgListByRecallNotify:(id)notify;
//-(id)convertRecallItemToMsg:(RecallItem *)msg recallModel:(RecallModel *)model msgType:(int)type;
//-(id)insertRecallMsg:(RecallModel*)msg item:(RecallItem*)item msgType:(int)type;
//-(void)updateMessageContentAndType:(id)type content:(id)content msgType:(int)type3;
//-(id)getRecallMessageContent:(RecallItem *)content;
//-(id)getLocalMessage:(RecallItem *)message;
//-(id)solveRecallNotify:(RecallModel *)notify isOnline:(BOOL)online;
//-(void)updateMsgListAfterRecallSucc:(id)succ;
//-(void)modifyModelAfterRecallSucc:(id)succ;
//-(int)getRecallModelType;
//-(int)getRecallMsgType:(RecallItem *)type;
//-(RecallModel*)generateRecallModelByMsg:(id)msg;
//@end
//
@interface QQMessageModel
@property (readonly) int msgType;
@property (assign, nonatomic) unsigned msgID;
@end

#pragma mark - better recall tips

%hook QQMessageRecallModule
- (void)handleRecallNotify:(id)notify isOnline:(BOOL)online {
    return;
}
%end

%hook RecallC2CBaseProcessor
//- (id)getLocalMessage:(id)item {
//    if (%orig(item) != nil) {
//        trail = YES;
//    }
//    return nil;
//}

//- (NSString *)getRecallMessageContent:(id)content {
//    if (trail) {
//        trail = NO;
//        return [[%orig(content) stringByReplacingOccurrencesOfString:@"撤回了" withString:@"尝试撤回"] stringByAppendingString:@" (已恢复)"];
//    } else {
//        return %orig(content);
//    }
//}

- (void)updateMessageContentAndType:(id)msg content:(id)content msgType:(int)type
{
    QQMessageModel *msg_model = (QQMessageModel *)msg;
    NSString *notify_str = (NSString *)content;
    %orig(msg, content, type);
    return;
}

//- (id)solveRecallNotify:(id)notify isOnline:(BOOL)online {
//    RecallModel *model = (RecallModel *)notify;
//    NSMutableArray *arr = [NSMutableArray array];
//    std::vector<RecallItem *>::iterator it;
//    int type = 0;
//    for (it = model->_field4.begin(); it != model->_field4.end(); it++)
//    {
//        RecallItem *i = *it;
//        unsigned long long uin = i->_field2;
//        QQMessageModel *msg;
//        msg = [self getLocalMessage:i];
//        if (msg != nil) {
//            type = [msg msgType];
//            if (type != 0x14c)
//            {
//                NSString *msg_content = [self getRecallMessageContent:i];
//                QQMessageModel *n = [self insertRecallMsg:model item:i msgType:0x14c];
//                [self updateMessageContentAndType:msg content:msg_content msgType:0x14c];
//            }
//        } else {
//            type = 0x14c;
//            msg = [self insertRecallMsg:model item:i msgType:type];
//        }
//        [arr addObject:msg];
//    }
//    RecallPairForOffline *pair = [%c(RecallPairForOffline) new];
//    [pair setRecallModel:model];
//    [pair setMsgs:arr];
//    [pair setOrignalMsgType:type];
//    return %orig(notify, NO);
//}
%end

//%hook RecallDiscussProcessor
//- (id)getLocalMessage:(id)item {
//    if (%orig(item) != nil) {
//        trail = YES;
//    }
//    return nil;
//}
//
//- (NSString *)getRecallMessageContent:(id)content
//                                 item:(id)item
//                                  msg:(id)msg
//                             isOnline:(BOOL)online
//{
//    if (trail) {
//        trail = NO;
//        return [[%orig(content, item, msg, online) stringByReplacingOccurrencesOfString:@"撤回了" withString:@"尝试撤回"] stringByAppendingString:@" (已恢复)"];
//    } else {
//        return %orig(content, item, msg, online);
//    }
//}
//%end
//
//%hook RecallGroupProcessor
//- (id)getLocalMessage:(id)item {
//    if (%orig(item) != nil) {
//        trail = YES;
//    }
//    return nil;
//}
//
//- (id)getRecallMessageContent:(id)content
//                         item:(id)item
//                          msg:(id)msg
//                     isOnline:(BOOL)online
//{
//    if (trail) {
//        trail = NO;
//        return [[%orig(content, item, msg, online) stringByReplacingOccurrencesOfString:@"撤回了" withString:@"尝试撤回"] stringByAppendingString:@" (已恢复)"];
//    } else {
//        return %orig(content, item, msg, online);
//    }
//}
//%end

%end

%ctor {
    %init(QQRecallPatch);
}
