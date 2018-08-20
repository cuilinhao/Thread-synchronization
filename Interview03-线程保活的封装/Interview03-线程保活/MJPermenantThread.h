//
//  MJPermenantThread.h
//  Interview03-线程保活
//
//  Created by MJ Lee on 2018/6/5.
//  Copyright © 2018年 MJ Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 封装一个可控制的线程的生命周期的类
 为了防止不在外面控制这个类，故不继承 NSThread，而是继承NSObject，所有的线程的
 生命周期都是我内部来写，这是一个设计思想
 
 */

typedef void (^MJPermenantThreadTask)(void);

@interface MJPermenantThread : NSObject

/**
 开启线程
 */
//- (void)run;

/**
 在当前子线程执行一个任务
 */
- (void)executeTask:(MJPermenantThreadTask)task;

/**
 结束线程
 */
- (void)stop;

@end
