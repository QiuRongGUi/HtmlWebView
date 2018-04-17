//
//  OneViewController.m
//  HtmlWebView
//
//  Created by 邱荣贵 on 2018/4/17.
//  Copyright © 2018年 邱久. All rights reserved.
//

#import "OneViewController.h"

@interface OneViewController ()<UIWebViewDelegate>


@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.frame];
   webView.scrollView.bounces = NO;
   webView.delegate = self;
   [self.view addSubview:webView];
    
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_URLString]]];
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    
    self.navigationItem.title =  [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
