//
//  ViewController.m
//  ttyty
//
//  Created by 谢纪伟 on 16/10/3.
//  Copyright © 2016年 cn.com.rockmobile. All rights reserved.
/*
 rivacy - Microphone Usage Description //麦克风权限
 Privacy - Contacts Usage Description   //通讯录权限
 Privacy - Camera Usage Description     //摄像头权限
 Privacy - NSSiriUsageDescription       //Siri的权限
 Privacy - Bluetooth Peripheral Usage Description //蓝牙
 Privacy - Reminders Usage Description  //提醒事项
 Privacy - Motion Usage Description     //运动与健康
 Privacy - Media Libaray Usage Description //媒体资源库
 Privacy - Calendars Usage Description  //日历
 
 */
#import "YXEasing.h"

//引入文件

#import <ImageIO/ImageIO.h>

#import <MobileCoreServices/MobileCoreServices.h>
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  /*  UIImageView * imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 100, 200, 200)];
    
    [self.view addSubview:imageView1];
    
    imageView1.image =[UIImage imageNamed:@"1.jpg"];
    
    UIImageView * imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 300, 200, 200)];
    
    [self.view addSubview:imageView2];
    
    imageView2.image =[UIImage imageNamed:@"2.png"];
    
    //保存图片到本地相册
    UIImageWriteToSavedPhotosAlbum(imageView1.image, nil, nil, nil);
    
    [self pngToJpg];
    [self jpgTojpg];
    
    [self jpgToPng];
    
    
    [self deCompositionGif];
    //self.view.backgroundColor = [UIColor redColor];
    //[self snow];
    // Do any additional setup after loading the view, typically from a nib.
    
    //1.拿到gif数据
    
    
    //2.分帧
    
    
    //3.将单帧数据转化为图片
    
    */
    //4.保存
    UIImageView * imageView3 =[[UIImageView alloc]initWithFrame:CGRectMake(10, 100, 200, 200)];
    [self.view addSubview:imageView3];
  /*  NSMutableArray * arr = [[NSMutableArray alloc]init];
    
    for (int i = 1; i<9; i++) {
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"Documents%d",i]];
        
        [arr addObject:image];
    }
    //设置播放属性
    [imageView3 setAnimationImages:arr];
    [imageView3 setAnimationDuration:2];
    [imageView3 setAnimationRepeatCount:10];
    [imageView3 startAnimating];
    */
//    [self creatGif];
   // imageView3.image =[UIImage imageNamed:@"1.gif"];
    
    
    //设置原始画面
    UIView *showView               = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    showView.layer.masksToBounds   = YES;
    showView.layer.cornerRadius    = 50.f;
    showView.layer.backgroundColor = [UIColor redColor].CGColor;
    
    [self.view addSubview:showView];
    
    //创建关键帧动画
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animation];
    
    //设置动画属性
    keyFrameAnimation.keyPath              = @"position";
    keyFrameAnimation.duration             = 4.0f;
    
    　　　　//关键处, 在这里使用的缓动函数计算点路径
    keyFrameAnimation.values = [YXEasing calculateFrameFromPoint:showView.center
                                                         toPoint:CGPointMake(100, 300)
                                                            func:QuarticEaseInOut
                                                      frameCount:4.0f * 30];
    
    //设置动画结束位置
    showView.center = CGPointMake(50, 300);
    
    //添加动画到layer层
    [showView.layer addAnimation:keyFrameAnimation forKey:nil];
}


//jpg转化png
-(void)jpgToPng{
    UIImage * image = [UIImage imageNamed:@"1.jpg"];
    
    NSData * data = UIImagePNGRepresentation(image);
    
    UIImage * pngImage =[UIImage imageWithData:data];
    
    UIImageWriteToSavedPhotosAlbum(pngImage, nil, nil, nil);
    
}

//jpg转化jpg
-(void)jpgTojpg{
    UIImage * image = [UIImage imageNamed:@"1.jpg"];
    //后一个参数越小，则生成的图片越小，越模糊
    NSData * data = UIImageJPEGRepresentation(image, 0.5);
    
    UIImage * jpgImage =[UIImage imageWithData:data];
    
    UIImageWriteToSavedPhotosAlbum(jpgImage, nil, nil, nil);
    
}

//png转化png
-(void)pngToJpg{
    UIImage * image = [UIImage imageNamed:@"2.png"];
    
    NSData * data = UIImageJPEGRepresentation(image, 0.5);
    
    UIImage * jpgImage =[UIImage imageWithData:data];
    
    UIImageWriteToSavedPhotosAlbum(jpgImage, nil, nil, nil);
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//分解gif
-(void)deCompositionGif{
 //读取gif数据
    NSString * gifResource = [[NSBundle mainBundle]pathForResource:@"1.gif" ofType:nil];
    
    
    NSData * data = [NSData dataWithContentsOfFile:gifResource];
    
   CGImageSourceRef  source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    
   //获取gif帧数
    size_t count = CGImageSourceGetCount(source);
    NSLog(@"%ld",count);
    //定义数组，保存单帧图片
    
    NSMutableArray * ImageArr = [NSMutableArray array];
    
//遍历取出每一帧
    for (size_t i = 0; i<count; i++) {
       
        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(source, i, NULL);
        
        
        //将单帧数据转化为uiimag   scale 图片物理尺寸与屏幕的比例    orientation 图片的方向
        UIImage * image = [UIImage imageWithCGImage:imageRef scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
        //保存
        [ImageArr addObject:image];
        //释放
        CGImageRelease(imageRef);
    }
    CFRelease(source);
    //单帧图片保存
    int i  = 0 ;
    for (UIImage * image in ImageArr) {
        i++;
        NSData *  data = UIImagePNGRepresentation(image);
        
        NSArray * path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString * gifPath = path[0];
        
        NSString * pathNumber = [gifPath stringByAppendingString:[NSString stringWithFormat:@"%d.png",i]];
        NSLog(@"%@",pathNumber);
        [data writeToFile:pathNumber atomically:YES];
    }
    
}

//创建gif图片
-(void)creatGif{
    //获取gif数据
    NSMutableArray * image =[[NSMutableArray alloc]initWithObjects:[UIImage imageNamed:@"Documents1"],[UIImage imageNamed:@"Documents2"],[UIImage imageNamed:@"Documents3"],[UIImage imageNamed:@"Documents4"],[UIImage imageNamed:@"Documents5"],[UIImage imageNamed:@"Documents6"], nil];
//创建gif文件
    NSArray * document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString * documentStr = [document objectAtIndex:0];
    
    NSFileManager * manager = [NSFileManager defaultManager];
    NSString * testDic = [documentStr stringByAppendingString:@"/gif"];
    NSString * path = [testDic stringByAppendingString:@"test.gif"];
    [manager createDirectoryAtPath:testDic withIntermediateDirectories:YES attributes:nil error:nil];
//配置属性
    CGImageDestinationRef destion;
    //将path映射成 CFURLRef 对象
    CFURLRef url = CFURLCreateWithFileSystemPath(kCFAllocatorDefault, (CFStringRef)path, kCFURLPOSIXPathStyle, false);
   
    //url 路径 kUTTypeGIF目标类型
  destion  =    CGImageDestinationCreateWithURL(url, kUTTypeGIF, image.count, nil);
    
    NSDictionary * frameDic = [NSDictionary dictionaryWithObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:0.3], (NSString *)kCGImagePropertyGIFDelayTime,nil] forKey:(NSString *)kCGImagePropertyGIFDelayTime];
    
    NSMutableDictionary * gifParmDic = [NSMutableDictionary dictionaryWithCapacity:3];
    
    [gifParmDic setObject:[NSNumber numberWithBool:YES] forKey:(NSString *)kCGImagePropertyGIFHasGlobalColorMap];
    
    [gifParmDic setObject:(NSString *)kCGImagePropertyColorModelRGB forKey:(NSString *)kCGImagePropertyColorModel];
    [gifParmDic setObject:[NSNumber numberWithInt:8] forKey:(NSString *)kCGImagePropertyDepth];
    [gifParmDic setObject:[NSNumber numberWithInt:0] forKey:(NSString *)kCGImagePropertyGIFLoopCount];
    NSDictionary * gifProperty = [NSDictionary dictionaryWithObject:gifParmDic forKey:(NSString *)kCGImagePropertyGIFDictionary ];
    //单帧图片添加到gif
    for (UIImage * Dimage  in  image) {
        CGImageDestinationAddImage(destion,Dimage.CGImage, (__bridge CFDictionaryRef)frameDic);
           }
    CGImageDestinationSetProperties(destion, (__bridge CFDictionaryRef)gifProperty);
    CGImageDestinationFinalize(destion);
    CFRelease(destion);
}
@end
