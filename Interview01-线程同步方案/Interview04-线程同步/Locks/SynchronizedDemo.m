//
//  SynchronizedDemo.m
//  Interview04-线程同步
//
//  Created by MJ Lee on 2018/6/12.
//  Copyright © 2018年 MJ Lee. All rights reserved.
//

#import "SynchronizedDemo.h"

@implementation SynchronizedDemo
/**
 @synchronized(self)  self 就是锁对象， 要保证对同一个对象加锁
 synchronized就是对mutex的封装
 
 @synchronized([self class]) { //objc_sync_enter  相当于加锁
 [super __drawMoney];
 } //objc_sync_exit 相当于解锁
 
 根据类对象找锁，因为是同一个对象，内存地址一样，从hash表取出来的对象是同一个
 
 
 
 */

- (void)__drawMoney
{
    @synchronized([self class]) {
        [super __drawMoney];
    }
}

- (void)__saveMoney
{
    @synchronized([self class]) { // objc_sync_enter
        [super __saveMoney];
    } // objc_sync_exit
}

- (void)__saleTicket
{
    static NSObject *lock;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lock = [[NSObject alloc] init];
    });
    
    @synchronized(lock) {
        [super __saleTicket];
    }
}

- (void)otherTest
{
    //递归加锁
    @synchronized([self class]) {
        NSLog(@"123");
        [self otherTest];
    }
}
@end

