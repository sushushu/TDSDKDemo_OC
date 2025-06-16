#import "ViewController.h"
#import <IAnalyticsSDK/IAnalyticsSDK-Swift.h>

@interface ViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) UITextView *logTextView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self setupSDK];
}

- (void)setupSDK {
    [[AnalyticsSDK shared] initializeWithApiKey:@"123456"
                                       clientId:@"woniu"
                                      aesSecret:@"YourPresharedSecretKey123456789012"
                                         apiUrl:@"http://dev01-w2a.tec-develop.cn/ted-w2a-track"
                                      debugMode:YES
                                    environment:@"DEVELOPMENT"
                       enableAdaptiveThrottling:YES
                         initialUploadThreshold:20
                          initialUploadInterval:60000];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor systemBackgroundColor];

    // 日志输出框
    self.logTextView = [[UITextView alloc] init];
    self.logTextView.editable = NO;
    self.logTextView.font = [UIFont systemFontOfSize:13];
    self.logTextView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    self.logTextView.textColor = [UIColor blackColor];
    self.logTextView.text = @"日志输出：\n";
    self.logTextView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.logTextView];

    // 滚动视图
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.scrollView];

    // StackView
    self.stackView = [[UIStackView alloc] init];
    self.stackView.axis = UILayoutConstraintAxisVertical;
    self.stackView.spacing = 8;
    self.stackView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollView addSubview:self.stackView];

    // 添加测试按钮
    [self addTestButtonWithTitle:@"设置用户ID" action:@selector(testSetUserId)];
    [self addTestButtonWithTitle:@"获取用户ID" action:@selector(testGetUserId)];
    [self addTestButtonWithTitle:@"清除用户ID" action:@selector(testClearUserId)];
    [self addTestButtonWithTitle:@"设置用户属性" action:@selector(testSetUserProperty)];
    [self addTestButtonWithTitle:@"批量设置用户属性" action:@selector(testSetUserProperties)];
    [self addTestButtonWithTitle:@"获取所有用户属性" action:@selector(testGetAllUserProperties)];
    [self addTestButtonWithTitle:@"清除所有用户属性" action:@selector(testClearAllUserProperties)];
    [self addTestButtonWithTitle:@"上报自定义事件" action:@selector(testTrackEvent)];
    [self addTestButtonWithTitle:@"上报页面访问" action:@selector(testTrackPage)];
    [self addTestButtonWithTitle:@"获取事件队列" action:@selector(testGetEventQueue)];
    [self addTestButtonWithTitle:@"清空事件队列" action:@selector(testClearEventQueue)];
    [self addTestButtonWithTitle:@"获取事件队列大小" action:@selector(testGetEventQueueSize)];
    [self addTestButtonWithTitle:@"获取设备信息" action:@selector(testDeviceInfo)];
    [self addTestButtonWithTitle:@"获取应用信息" action:@selector(testAppInfo)];
    [self addTestButtonWithTitle:@"获取网络状态" action:@selector(testNetworkStatus)];
    [self addTestButtonWithTitle:@"上报用户注册事件" action:@selector(testTrackRegisterEvent)];
    [self addTestButtonWithTitle:@"上报用户充值事件" action:@selector(testTrackRechargeEvent)];
    [self addTestButtonWithTitle:@"上报首次初始化事件" action:@selector(testTrackFirstLaunchEvent)];
    [self addTestButtonWithTitle:@"新增用户属性UserProperty" action:@selector(testAddUserProperty)];
    [self addTestButtonWithTitle:@"删除最后一个用户属性UserProperty" action:@selector(testRemoveLastUserProperty)];
    [self addTestButtonWithTitle:@"新增设备属性DeviceProperty" action:@selector(testAddDeviceProperty)];
    [self addTestButtonWithTitle:@"删除最后一个设备属性DeviceProperty" action:@selector(testRemoveLastDeviceProperty)];
    [self addTestButtonWithTitle:@"显示所有设备属性DeviceProperty" action:@selector(testShowAllDeviceProperties)];
    [self addTestButtonWithTitle:@"显示用户/UA/UTM信息" action:@selector(testShowUserUaUtmInfo)];
    [self addTestButtonWithTitle:@"获取UA" action:@selector(testGetUserAgent)];

    // 约束
    [NSLayoutConstraint activateConstraints:@[
        [self.logTextView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [self.logTextView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.logTextView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.logTextView.heightAnchor constraintEqualToConstant:200],

        [self.scrollView.topAnchor constraintEqualToAnchor:self.logTextView.bottomAnchor],
        [self.scrollView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.scrollView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.scrollView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],

        [self.stackView.topAnchor constraintEqualToAnchor:self.scrollView.topAnchor constant:20],
        [self.stackView.leadingAnchor constraintEqualToAnchor:self.scrollView.leadingAnchor constant:20],
        [self.stackView.trailingAnchor constraintEqualToAnchor:self.scrollView.trailingAnchor constant:-20],
        [self.stackView.bottomAnchor constraintEqualToAnchor:self.scrollView.bottomAnchor constant:-20],
        [self.stackView.widthAnchor constraintEqualToAnchor:self.scrollView.widthAnchor constant:-40]
    ]];
}

- (void)addTestButtonWithTitle:(NSString *)title action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:title forState:UIControlStateNormal];
    button.backgroundColor = [UIColor systemBlueColor];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = 8;
    button.contentEdgeInsets = UIEdgeInsetsMake(12, 24, 12, 24);
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [self.stackView addArrangedSubview:button];
}

#pragma mark - 测试方法

- (void)testSetUserId {
    [[AnalyticsSDK shared] setUserId:@"user_123456"];
    [self appendLog:@"【操作】设置用户ID: user_123456"];
}
- (void)testGetUserId {
    NSString *userId = [[AnalyticsSDK shared] getUserId] ?: @"nil";
    [self appendLog:[NSString stringWithFormat:@"【用户ID】%@", userId]];
}
- (void)testClearUserId {
    [[AnalyticsSDK shared] clearUserId];
    [self appendLog:@"【操作】清除用户ID"];
}
- (void)testSetUserProperty {
    [[AnalyticsSDK shared] setUserProperty:@"vip_level" value:@3];
    [self appendLog:@"【操作】设置用户属性 vip_level: 3"];
}
- (void)testSetUserProperties {
    NSDictionary *props = @{@"age": @28, @"gender": @"male"};
    [[AnalyticsSDK shared] setUserProperties:props];
    [self appendLog:[NSString stringWithFormat:@"【操作】批量设置用户属性: %@", props]];
}
- (void)testGetAllUserProperties {
    NSDictionary *props = [[AnalyticsSDK shared] getAllUserProperties];
    [self appendLog:[NSString stringWithFormat:@"【所有用户属性】%@", props]];
}
- (void)testClearAllUserProperties {
    [[AnalyticsSDK shared] clearAllUserProperties];
    [self appendLog:@"【操作】清除所有用户属性"];
}
- (void)testTrackEvent {
    NSDictionary *params = @{@"method": @"wechat"};
    [[AnalyticsSDK shared] trackEventWithEventName:@"login_success" params:params];
    [self appendLog:@"【操作】上报自定义事件 login_success"];
    
    [[AnalyticsSDK shared] trackEventWithEventName:@"app_wakeup" params:nil];
}
- (void)testTrackPage {
    NSDictionary *params = @{@"from": @"demo"};
    [[AnalyticsSDK shared] trackPageWithPageName:@"HomePage" params:params];
    [self appendLog:@"【操作】上报页面访问 HomePage"];
}
- (void)testGetEventQueue {
    NSArray *queue = [[AnalyticsSDK shared] getEventQueue];
    [self appendLog:[NSString stringWithFormat:@"【事件队列】%@", queue]];
}
- (void)testClearEventQueue {
    [[AnalyticsSDK shared] clearEventQueue];
    [self appendLog:@"【操作】清空事件队列"];
}
- (void)testGetEventQueueSize {
    NSInteger size = [[AnalyticsSDK shared] getEventQueueSize];
    [self appendLog:[NSString stringWithFormat:@"【事件队列大小】%ld", (long)size]];
}
- (void)testDeviceInfo {
    NSDictionary *info = [[AnalyticsSDK shared] getDeviceInfo];
    [self appendLog:[NSString stringWithFormat:@"【设备信息】%@", info]];
}
- (void)testAppInfo {
    NSDictionary *info = [[AnalyticsSDK shared] getAppInfo];
    [self appendLog:[NSString stringWithFormat:@"【应用信息】%@", info]];
}
- (void)testNetworkStatus {
    NSString *status = [[AnalyticsSDK shared] getNetworkStatus];
    [self appendLog:[NSString stringWithFormat:@"【网络状态】%@", status]];
}
- (void)testTrackRegisterEvent {
    NSDictionary *utm = @{@"utm_source": @"demo", @"utm_medium": @"test", @"utm_campaign": @"register"};
    [[AnalyticsSDK shared] trackRegisterEventWithUtmParams:utm];
    [self appendLog:[NSString stringWithFormat:@"【操作】上报用户注册事件 utm: %@", utm]];
}
- (void)testTrackRechargeEvent {
    NSDictionary *utm = @{@"utm_source": @"demo", @"utm_medium": @"test", @"utm_campaign": @"recharge"};
    [[AnalyticsSDK shared] trackRechargeEventWithAmount:99.99 utmParams:utm];
    [self appendLog:[NSString stringWithFormat:@"【操作】上报用户充值事件 amount: 99.99, utm: %@", utm]];
}

#pragma mark - 新增测试方法
- (void)testTrackFirstLaunchEvent {
    [[AnalyticsSDK shared] trackFirstLaunchEvent];
    [self appendLog:@"【操作】首次初始化事件已上报（仅第一次生效）"];
}

- (void)testAddUserProperty {
    // 随机生成 key/value
    NSString *key = [NSString stringWithFormat:@"test_key_%ld", (long)[[NSDate date] timeIntervalSince1970]];
    NSString *value = [NSString stringWithFormat:@"value_%d", arc4random_uniform(9000) + 1000];
    [[AnalyticsSDK shared] setUserProperty:key value:value];
    [self appendLog:[NSString stringWithFormat:@"【操作】新增用户属性: %@ = %@", key, value]];
}

- (void)testRemoveLastUserProperty {
    NSDictionary *props = [[AnalyticsSDK shared] getAllUserProperties];
    NSArray *keys = [props allKeys];
    if (keys.count > 0) {
        NSString *lastKey = [keys lastObject];
        [[AnalyticsSDK shared] clearUserProperty:lastKey];
        [self appendLog:[NSString stringWithFormat:@"【操作】删除最后一个用户属性: %@", lastKey]];
    } else {
        [self appendLog:@"【操作】无用户属性可删除"];
    }
}

- (void)testAddDeviceProperty {
    NSString *key = [NSString stringWithFormat:@"dev_key_%ld", (long)[[NSDate date] timeIntervalSince1970]];
    NSString *value = [NSString stringWithFormat:@"dev_value_%d", arc4random_uniform(9000) + 1000];
    [[AnalyticsSDK shared] setDeviceProperty:key value:value];
    [self appendLog:[NSString stringWithFormat:@"【操作】新增设备属性: %@ = %@", key, value]];
}

- (void)testRemoveLastDeviceProperty {
    NSDictionary *props = [[AnalyticsSDK shared] getAllDeviceProperties];
    NSArray *keys = [props allKeys];
    if (keys.count > 0) {
        NSString *lastKey = [keys lastObject];
        [[AnalyticsSDK shared] clearDeviceProperty:lastKey];
        [self appendLog:[NSString stringWithFormat:@"【操作】删除最后一个设备属性: %@", lastKey]];
    } else {
        [self appendLog:@"【操作】无设备属性可删除"];
    }
}

- (void)testShowAllDeviceProperties {
    NSDictionary *devProps = [[AnalyticsSDK shared] getAllDeviceProperties];
    NSMutableString *logText = [NSMutableString stringWithString:@"【设备属性DeviceProperty】\n"];
    [devProps enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [logText appendFormat:@"%@: %@, ", key, obj];
    }];
    [self appendLog:logText];
}

- (void)testShowUserUaUtmInfo {
    NSString *userId = [[AnalyticsSDK shared] getUserId] ?: @"nil";
    NSString *ua = [[AnalyticsSDK shared] getUserAgentString];
    NSDictionary *utm = [[AnalyticsSDK shared] getUtmParams];
    [self appendLog:[NSString stringWithFormat:@"【用户ID】%@\n【UA】%@\n【UTM】%@", userId, ua, utm]];
}

- (void)testGetUserAgent {
    NSString *ua = [[AnalyticsSDK shared] getUserAgentString];
    NSLog(@" ua: %@",ua);
}

#pragma mark - 日志追加
- (void)appendLog:(NSString *)text {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.logTextView.text = [self.logTextView.text stringByAppendingFormat:@"\n%@", text];
        [self.logTextView scrollRangeToVisible:NSMakeRange(self.logTextView.text.length - 1, 1)];
    });
}

@end
