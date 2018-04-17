# HtmlWebView
iOS webView 加载 HTML，点击图片或链接相应操作

> 开发中，需要展示 HTML 类型的数据，HTML 相应包含图片或链接需要处理，多数选择的 UIWebView 或 WKWebView（关于两者的区别不明白，请自行百度），今天把一个三方类介绍给大家，那就是 [IMYWebView](https://link.jianshu.com/?t=https://github.com/li6185377/IMYWebView)，这个类兼容 WKWebView 和 UIWebView，实现了 UIWebView 到 WKWebView 的对接，即使你之前的项目是用的 UIWebView ，那也没关系，只要将 UIWebView 换成 IMYWebView 就可以了。


![HtmlWebView.gif](http://ohwf8vjl9.bkt.clouddn.com/0.gif)

图片或链接相应操作，具体详情请查看 Demo
````
//添加图片可点击js
- (void)webViewDidFinishLoad:(UIWebView *)webView{

//    //调整字号
//    NSString *str = @"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '95%'";
//    [webView stringByEvaluatingJavaScriptFromString:str];

//添加图片可点击js
static  NSString * const jsGetImages =
@"function getImages(){\
var objs = document.getElementsByTagName(\"img\");\
for(var i=0;i<objs.length;i++){\
objs[i].onclick=function(){\
document.location=\"myweb:imageClick:\"+this.src;\
};\
};\
return objs.length;\
};";

[webView stringByEvaluatingJavaScriptFromString:jsGetImages];//注入js方法

//注入自定义的js方法后别忘了调用 否则不会生效（不调用也一样生效了，，，不明白）
[webView stringByEvaluatingJavaScriptFromString:@"getImages()"];

/** 加载链接 图片*/
[self getImageData];
}


/**
加载 webview 图片
*/
- (void)getImageData{

//这里是js，主要目的实现对url的获取
static  NSString * const jsGetImages =
@"function getImages(){\
var objs = document.getElementsByTagName(\"img\");\
var imgScr = '';\
for(var i=0;i<objs.length;i++){\
imgScr = imgScr + objs[i].src + '+';\
};\
return imgScr;\
};";

[self.web stringByEvaluatingJavaScriptFromString:jsGetImages];//注入js方法

NSString *urlResurlt = [self.web stringByEvaluatingJavaScriptFromString:@"getImages()"];

mUrlArray = [NSMutableArray arrayWithArray:[urlResurlt componentsSeparatedByString:@"+"]];

[mUrlArray removeLastObject]; // 删除最后一个 +

_assets = [NSMutableArray array];

for (NSString *url in mUrlArray) {

ZLPhotoPickerBrowserPhoto *photo = [[ZLPhotoPickerBrowserPhoto alloc] init];
photo.photoURL = [NSURL URLWithString:url];
[_assets addObject:photo];
}
}

/**
图片浏览

@param aStr <#aStr description#>
*/
- (void)tapBrowser:(NSString *)aStr{

[self.assets enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

ZLPhotoPickerBrowserPhoto *photo = obj;

if([photo.photoURL.absoluteString isEqual:aStr]){
index = idx;
}
}];


// 图片游览器
ZLPhotoPickerBrowserViewController *pickerBrowser = [[ZLPhotoPickerBrowserViewController alloc] init];

pickerBrowser.status = UIViewAnimationAnimationStatusZoom;
pickerBrowser.photos = self.assets;
// 当前选中的值
pickerBrowser.currentIndex = index;
// 展示控制器
[pickerBrowser showPickerVc:self];

}

````
-----
###[参考 0](https://www.jianshu.com/p/149517ed8535)
###[参考 1](https://blog.csdn.net/fhsahfihf/article/details/51881887)
###[IMYVKWebView](https://github.com/li6185377/IMYWebView)

###[Github](https://github.com/QiuRongGUi/HtmlWebView)
