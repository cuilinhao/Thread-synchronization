//
//  SemaphoreDemo.m
//  Interview04-线程同步
//
//  Created by MJ Lee on 2018/6/12.
//  Copyright © 2018年 MJ Lee. All rights reserved.
//

#import "SemaphoreDemo.h"

@interface SemaphoreDemo()

/* 信号量 */
@property (strong, nonatomic) dispatch_semaphore_t semaphore;

@property (strong, nonatomic) dispatch_semaphore_t ticketSemaphore;

@property (strong, nonatomic) dispatch_semaphore_t moneySemaphore;

@end

@implementation SemaphoreDemo

- (instancetype)init
{
    if (self = [super init]) {
        //最大并发数量为5，同时有5个线程来做事情
        self.semaphore = dispatch_semaphore_create(5);
        self.ticketSemaphore = dispatch_semaphore_create(1);
        self.moneySemaphore = dispatch_semaphore_create(1);
    }
    return self;
}

- (void)__drawMoney
{
    //wait 信号量-1
    dispatch_semaphore_wait(self.moneySemaphore, DISPATCH_TIME_FOREVER);
    
    [super __drawMoney];
    //single 信号量+1
    dispatch_semaphore_signal(self.moneySemaphore);
}

- (void)__saveMoney
{
    dispatch_semaphore_wait(self.moneySemaphore, DISPATCH_TIME_FOREVER);
    
    [super __saveMoney];
    
    dispatch_semaphore_signal(self.moneySemaphore);
}

- (void)__saleTicket
{
    dispatch_semaphore_wait(self.ticketSemaphore, DISPATCH_TIME_FOREVER);

    [super __saleTicket];

    dispatch_semaphore_signal(self.ticketSemaphore);
}

- (void)otherTest
{
    for (int i = 0; i < 20; i++) {
        [[[NSThread alloc] initWithTarget:self selector:@selector(test) object:nil] start];
    }
}

// 线程10、7、6、9、8
//控制最大并发数量 使用dispatch_semaphore_wait 和dispatch_semaphore_signal 来控制

- (void)test
{
    // 如果信号量的值 > 0，就让信号量的值减1，然后继续往下执行代码
    // 如果信号量的值 <= 0，就会休眠等待，直到信号量的值变成>0，就让信号量的值减1，然后继续往下执行代码
    //----- 来一个线程，则信号量 -1 为4然后向下执行， 再来一个线程，则信号量-1 = 3然后然后向下执行，当第6个线程进来，则信号量<=0则会休眠等待，
    //  当信号量为0 则再进来线程就会等待，  wait 会让信号量-1，
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    
    sleep(2);
    NSLog(@"test - %@", [NSThread currentThread]);
    
    // signal让信号量的值+1
    //当之前的线程走到了signal，则会使信号量+1 = 1， 则等待的线程就会进来 -1 = 0
    //总的  一个线程进来，一个线程出去，一个线程进来，一个线程出去，就是用+1 和-1 来操作的
    dispatch_semaphore_signal(self.semaphore);
}

@end
