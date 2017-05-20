//
//  Notes.m
//  MBPlayerProject
//
//  Created by yindongbo on 2017/5/15.
//  Copyright © 2017年 Dombo. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - IJKMediaPlayback
#pragma mark 通知
// IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification; // 播放状态的改变 代替 MPMoviePlayerContentPreloadDidFinishNotification

// IJKMPMoviePlayerScalingModeDidChangeNotification; // 缩放比例的改变

// IJKMPMoviePlayerPlaybackDidFinishNotification;
// IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey; // NSNumber (IJKMPMovieFinishReason)
// 当电影播放结束或用户退出播放时调用。

// IJKMPMoviePlayerPlaybackStateDidChangeNotification; // 用户改变播放状态改变时调用
// IJKMPMoviePlayerLoadStateDidChangeNotification; // 当网络加载状态发生变化时。
// IJKMPMoviePlayerIsAirPlayVideoActiveDidChangeNotification; // 当视频通过 AirPlay 开始播放视频或结束时调用

// Movie Property Notifications
// 属性相关的同时声明
// IJKMPMovieNaturalSizeAvailableNotification; // 在执行 prepareToPlay 时开始异步确定影片属性，当相关属性变为有效可用时调用该通知
// IJKMPMoviePlayerVideoDecoderOpenNotification; // 视频 编译器打开通知
// IJKMPMoviePlayerFirstVideoFrameRenderedNotification; // 视频 视频第一帧时通知
// IJKMPMoviePlayerFirstAudioFrameRenderedNotification; // 视频 音频第一段时通知

#pragma mark 枚举
//typedef NS_OPTIONS(NSUInteger, IJKMPMovieLoadState) {
//    IJKMPMovieLoadStateUnknown        = 0, // 未知状态
//    IJKMPMovieLoadStatePlayable       = 1 << 0, //
//    IJKMPMovieLoadStatePlaythroughOK  = 1 << 1, // 当shouldAutoPlay 为Yes时，将开始在这种状态
//    IJKMPMovieLoadStateStalled        = 1 << 2, // 播放后，自动设定为该方法
//};

//typedef NS_ENUM(NSInteger, IJKMPMoviePlaybackState) {
//    IJKMPMoviePlaybackStateStopped, // 播放停止
//    IJKMPMoviePlaybackStatePlaying, // 开始播放
//    IJKMPMoviePlaybackStatePaused,  // 暂停播放
//    IJKMPMoviePlaybackStateInterrupted, // 播放间断
//    IJKMPMoviePlaybackStateSeekingForward, // 播放快进
//    IJKMPMoviePlaybackStateSeekingBackward // 播放后退
//};

//typedef NS_ENUM(NSInteger, IJKMPMovieScalingMode) {
//    IJKMPMovieScalingModeNone,       // 没有缩放比例
//    IJKMPMovieScalingModeAspectFit,  //尺寸比例不变填满屏幕为止
//    IJKMPMovieScalingModeAspectFill, // 尺寸比例不变填满屏幕，可能造成内容缺少
//    IJKMPMovieScalingModeFill        // 尺寸比例变形也会填满屏幕
//};


//    int reason =[[[notification userInfo] valueForKey:IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey] intValue];
//用于IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey通知中，判断reason为一枚举
//typedef NS_ENUM(NSInteger, IJKMPMovieFinishReason) {
//    IJKMPMovieFinishReasonPlaybackEnded, // 完成原因：播放结束
//    IJKMPMovieFinishReasonPlaybackError, // 完成原因：播放出现错误
//    IJKMPMovieFinishReasonUserExited // 完成原因：出现用户行为退出
//};


// Thumbnails （缩略图）
//获取在指定播放时间的视频缩略图，第一个参数是获取缩略图的时间点数组；第二个参数代表时间点精度，枚举类型
//typedef NS_ENUM(NSInteger, IJKMPMovieTimeOption) {
//    IJKMPMovieTimeOptionNearestKeyFrame, // 时间点附近
//    IJKMPMovieTimeOptionExact //准确时间
//};

#pragma mark Attribute
//@property(nonatomic, readonly)  UIView *view; // 用于显示视频播放的view，调用次view
//@property(nonatomic)            NSTimeInterval currentPlaybackTime; // 当前播放的时间点
//@property(nonatomic, readonly)  NSTimeInterval duration; // 总时长
//@property(nonatomic, readonly)  NSTimeInterval playableDuration; // 可播放时长
//@property(nonatomic, readonly)  NSInteger bufferingProgress; // 缓冲进度
//
//@property(nonatomic, readonly)  BOOL isPreparedToPlay; // 准备播放
//@property(nonatomic, readonly)  IJKMPMoviePlaybackState playbackState; // 播放终止状态枚举
//@property(nonatomic, readonly)  IJKMPMovieLoadState loadState; // 加载状态枚举
//
//@property(nonatomic, readonly) int64_t numberOfBytesTransferred; // 传输字节数
//
//@property(nonatomic, readonly) CGSize naturalSize; // 视频原始显示View size，
//@property(nonatomic) IJKMPMovieScalingMode scalingMode; // 视频尺寸模式
//@property(nonatomic) BOOL shouldAutoplay; // 需要自动播放
//
//@property (nonatomic) BOOL allowsMediaAirPlay; // 支持AirPlay 媒体
//@property (nonatomic) BOOL isDanmakuMediaAirPlay; // 支持弹幕AirPlay媒体
//@property (nonatomic, readonly) BOOL airPlayMediaActive; AirPlay 是否活跃
//
//@property (nonatomic) float playbackRate;  // 返回音频/视频的当前播放速度 0-1
//
//- (UIImage *)thumbnailImageAtCurrentTime; //获取当前时间的封面帧图片


#pragma mark - IJKMediaUrlOpenDelegate && IJKMediaUrlOpenData
//typedef NS_ENUM(NSInteger, IJKMediaUrlOpenType) {
//    IJKMediaUrlOpenEvent_ConcatResolveSegment = 0x10000,
//    IJKMediaUrlOpenEvent_TcpOpen = 0x10001,
//    IJKMediaUrlOpenEvent_HttpOpen = 0x10002,
//    IJKMediaUrlOpenEvent_LiveOpen = 0x10004,
//};

//- (id)initWithUrl:(NSString *)url
//openType:(IJKMediaUrlOpenType)openType
//segmentIndex:(int)segmentIndex
//retryCounter:(int)retryCounter;
//
//@property(nonatomic, readonly) IJKMediaUrlOpenType openType;
//@property(nonatomic, readonly) int segmentIndex;
//@property(nonatomic, readonly) int retryCounter; // 重试次数
//
//@property(nonatomic, retain) NSString *url;
//@property(nonatomic) int error; // 错误提示，发生错误该属性为负
//@property(nonatomic, getter=isHandled)    BOOL handled;     // 如果url发生改变，该数值变为Yes
//@property(nonatomic, getter=isUrlChanged) BOOL urlChanged;  // 通过改变url设置为YES

#pragma mark - IJKMediaModule
//@property(atomic, getter=isAppIdleTimerDisabled)            BOOL appIdleTimerDisabled; // 如果不希望在运行程序时锁屏 ，设置为YES
//@property(atomic, getter=isMediaModuleIdleTimerDisabled)    BOOL mediaModuleIdleTimerDisabled;

#pragma mark - IJKFFOptions
//typedef enum IJKFFOptionCategory {
//    kIJKFFOptionCategoryFormat = 1,
//    kIJKFFOptionCategoryCodec  = 2,
//    kIJKFFOptionCategorySws    = 3,
//    kIJKFFOptionCategoryPlayer = 4,
//} IJKFFOptionCategory;


// 解码器选项 skip_loop_filter & skip_frame
//typedef enum IJKAVDiscard {
//    /* We leave some space between them for extensions (drop some
//     * keyframes for intra-only or drop just some bidir frames). */
//    IJK_AVDISCARD_NONE    =-16, ///< discard nothing
//    IJK_AVDISCARD_DEFAULT =  0, ///< 如果包大小为0，责抛弃无效的包
//    IJK_AVDISCARD_NONREF  =  8, ///< 抛弃非参考帧（I帧）
//    IJK_AVDISCARD_BIDIR   = 16, ///< 抛弃B帧
//    IJK_AVDISCARD_NONKEY  = 32, ///< 抛弃除关键帧以外的，比如B，P帧
//    IJK_AVDISCARD_ALL     = 48, ///< 抛弃所有的帧
//} IJKAVDiscard;


//+(IJKFFOptions *)optionsByDefault;  //初始化用

//-(void)applyTo:(struct IjkMediaPlayer *)mediaPlayer;

//- (void)setOptionValue:(NSString *)value forKey:(NSString *)key ofCategory:(IJKFFOptionCategory)category;

//- (void)setOptionIntValue:(int64_t)value forKey:(NSString *)key ofCategory:(IJKFFOptionCategory)category;


//-(void)setFormatOptionValue:       (NSString *)value forKey:(NSString *)key;
//-(void)setCodecOptionValue:        (NSString *)value forKey:(NSString *)key;
//-(void)setSwsOptionValue:          (NSString *)value forKey:(NSString *)key;
//-(void)setPlayerOptionValue:       (NSString *)value forKey:(NSString *)key;

//-(void)setFormatOptionIntValue:    (int64_t)value forKey:(NSString *)key;
//-(void)setCodecOptionIntValue:     (int64_t)value forKey:(NSString *)key;
//-(void)setSwsOptionIntValue:       (int64_t)value forKey:(NSString *)key;
//-(void)setPlayerOptionIntValue:    (int64_t)value forKey:(NSString *)key; // value:1 forKey:@"videotoolbox"；开启硬件解码

//@property(nonatomic) BOOL useRenderQueue; // 使用渲染队列
//@property(nonatomic) BOOL showHudView; // 显示加载指示器视图

// MARK: Example
// IJKFFOptions *options = [IJKFFOptions optionsByDefault];
// [options setOptionIntValue:IJK_AVDISCARD_DEFAULT forKey:@”skip_frame”  ofCategory:kIJKFFOptionCategoryCodec];

// [options setOptionIntValue:IJK_AVDISCARD_DEFAULT forKey:@”skip_loop_filter” ofCategory:kIJKFFOptionCategoryCodec];

// [options setOptionIntValue:1 forKey:@”videotoolbox” ofCategory:kIJKFFOptionCategoryPlayer]; // 开启硬件解码

// [options setOptionIntValue:60 forKey:@”max-fps” ofCategory:kIJKFFOptionCategoryPlayer]; // 播放最大帧数

// ======= Attribute =================
// start-on-prepared （开始准备）、overlay-format、max-fps（最大fps）、framedrop（跳帧开关）、videotoolbox-max-frame-width（指定最大宽度）、videotoolbox（播放工具盒子）、video-pictq-size  、ijkinject-opaque、
// user-agent 、auto_convert（自动转屏开关）、timeout(超时时间)、reconnect （重连次数）、safe 、skip_frame、skip_loop_filter
// ==================================
// [options setPlayerOptionIntValue:29.97 forKey:@"r"]; // 帧速率（fps）可以改，确认非标准桢率会导致音画不同步，所以只能设定为15或者29.97）

// [options setPlayerOptionIntValue:512 forKey:@"vol"]; // 设置音量大小，256为标准音量。（要设置成两倍音量时则输入512，依此类推

// [options setPlayerOptionIntValue:30 forKey:@"max-fps"]; // 最大fps

// [options setPlayerOptionIntValue:0 forKey:@"framedrop"]; // 跳帧开关

// [options setPlayerOptionIntValue:960 forKey:@"videotoolbox-max-frame-width"]; // 指定最大宽度

// [options setFormatOptionIntValue:0 forKey:@"auto_convert"]; // 自动转屏开关

// [options setFormatOptionIntValue:1 forKey:@"reconnect"]; // 重连次数

// [options setFormatOptionIntValue:30 * 1000 * 1000 forKey:@"timeout"]; // 超时时间，timeout参数只对http设置有效，若果你用rtmp设置timeout，ijkplayer内部会忽略timeout参数。rtmp的timeout参数含义和http的不一样。

//_player = [[IJKFFMoviePlayerController alloc] initWithContentURL:self.url withOptions:options];


#pragma mark - IJKFFMoviePlayerController
//  LogLevel 日志等级
//typedef enum IJKLogLevel {
//    k_IJK_LOG_UNKNOWN = 0, //未知
//    k_IJK_LOG_DEFAULT = 1, //默认
//    
//    k_IJK_LOG_VERBOSE = 2, //详细
//    k_IJK_LOG_DEBUG   = 3, //调试
//    k_IJK_LOG_INFO    = 4, //详情信息
//    k_IJK_LOG_WARN    = 5, //警告
//    k_IJK_LOG_ERROR   = 6, //错误
//    k_IJK_LOG_FATAL   = 7, //致命
//    k_IJK_LOG_SILENT  = 8, //
//} IJKLogLevel;


//- (id)initWithContentURL:(NSURL *)aUrl
//withOptions:(IJKFFOptions *)options;
//
//- (id)initWithContentURLString:(NSString *)aUrlString
//withOptions:(IJKFFOptions *)options;
//
//- (void)prepareToPlay; // 播放准备
//- (void)play; // 播放
//- (void)pause; // 暂停
//- (void)stop; // 停止播放
//- (BOOL)isPlaying; // 是否正在播放中
//
//- (void)setPauseInBackground:(BOOL)pause; // 后台暂停
//- (BOOL)isVideoToolboxOpen; // 视频工具栏是否开启（一般不用这个，太丑）
//
//+ (void)setLogReport:(BOOL)preferLogReport; // 日志报告输出
//+ (void)setLogLevel:(IJKLogLevel)logLevel; // 日志报告等级
//+ (BOOL)checkIfFFmpegVersionMatch:(BOOL)showAlert; // 检查版本是否匹配
//+ (BOOL)checkIfPlayerVersionMatch:(BOOL)showAlert // 检查版本是否匹配
//                            major:(unsigned int)major
//                            minor:(unsigned int)minor
//                            micro:(unsigned int)micro;
//
//@property(nonatomic, readonly) CGFloat fpsInMeta; // fps 率
//@property(nonatomic, readonly) CGFloat fpsAtOutput; // fps输出值
//
//- (void)setOptionValue:(NSString *)value forKey:(NSString *)key ofCategory:(IJKFFOptionCategory)category;
//- (void)setOptionIntValue:(int64_t)value forKey:(NSString *)key ofCategory:(IJKFFOptionCategory)category;

//
//- (void)setFormatOptionValue:       (NSString *)value forKey:(NSString *)key;
//- (void)setCodecOptionValue:        (NSString *)value forKey:(NSString *)key;
//- (void)setSwsOptionValue:          (NSString *)value forKey:(NSString *)key;
//- (void)setPlayerOptionValue:       (NSString *)value forKey:(NSString *)key;
//
//- (void)setFormatOptionIntValue:    (int64_t)value forKey:(NSString *)key;
//- (void)setCodecOptionIntValue:     (int64_t)value forKey:(NSString *)key;
//- (void)setSwsOptionIntValue:       (int64_t)value forKey:(NSString *)key;
//- (void)setPlayerOptionIntValue:    (int64_t)value forKey:(NSString *)key;
//
//@property (nonatomic, retain) id<IJKMediaUrlOpenDelegate> segmentOpenDelegate;
//@property (nonatomic, retain) id<IJKMediaUrlOpenDelegate> tcpOpenDelegate;
//@property (nonatomic, retain) id<IJKMediaUrlOpenDelegate> httpOpenDelegate;
//@property (nonatomic, retain) id<IJKMediaUrlOpenDelegate> liveOpenDelegate;

#pragma mark - Literature
/**
 选择了MPMoviePlayerViewController在线播放视频，实现上其实很简单.关于视频缓冲的大小的获取
 http://blog.csdn.net/jiayou8809/article/details/8438799
 */
