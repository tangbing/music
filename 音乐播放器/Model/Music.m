//
//  Music.m
//  MusicDemo
//
//  Created by dear on 16/6/15.
//  Copyright © 2016年 张华. All rights reserved.
//

#import "Music.h"

@implementation Music
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString: @"id"]) {
        self.musicID = value;
    }
}
@end
