//
//  ViewController.m
//  SH_AES加密
//
//  Created by HarrySun on 2017/2/23.
//  Copyright © 2017年 Mobby. All rights reserved.
//

#import "ViewController.h"
#import "NSString+AES256.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *userName = @"userName:Coder_Sun";
    NSLog(@"加密前的字符串：%@",userName);
    
    
    NSString *string = [userName aes256_encrypt:@"Coder"];
    NSLog(@"加密后的字符串：%@",string);
    NSLog(@"%lu",(unsigned long)string.length); // 打印加密后的字符串的位数
    
    
    NSString *string1 = [string aes256_decrypt:@"Coder"];
    NSLog(@"解密后的字符串：%@",string1);
    

    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
