//
//  musicList.h
//  音乐播放器
//
//  Created by mac on 2017/4/3.
//  Copyright © 2017年 macTb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface musicList : NSObject
/**专辑名称*/
@property (nonatomic, copy)NSString *name;
/**专辑背景*/
@property (nonatomic, copy)NSString *coverImgUrl;
/**歌曲数量*/
@property (nonatomic, assign)NSUInteger trackCount;
/**订阅*/
@property (nonatomic, assign)NSUInteger subscribedCount;
/**订阅*/
@property (nonatomic, assign)NSUInteger cloudTrackCount;
/**订阅*/
@property (nonatomic, assign)NSUInteger shareCount;
/**订阅*/
@property (nonatomic, assign)NSUInteger commentCount;

@end
