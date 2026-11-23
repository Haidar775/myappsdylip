#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

// ================== عدّل بياناتك من هنا فقط ==================
static NSString *const kBrandName       = @"Haidar_sultan";
static NSString *const kEnglishSubtitle = @"ELITE EXPERIENCE";
static NSString *const kWelcomeTitle    = @"أهلاً بك في عالمنا";
static NSString *const kWelcomeMessage  = @"تجربة مميزة صُممت بعناية لتمنحك\nمظهراً استثنائياً وأداءً أنيقاً";
static NSString *const kContinueTitle   = @"ادخل وادعيلي";
static NSString *const kChannelTitle    = @"قناتي";
static NSString *const kChannelURL      = @"https://t.me/AppleW_7X";
static NSString *const kSupportTitle    = @"الدعم الفني";
static NSString *const kSupportURL      = @"https://t.me/H7aidar";
static NSString *const kFooterText      = @"CRAFTED WITH ELEGANCE • Haidar sultan";
// ==============================================================

static UIColor *ColorHex(uint32_t hex, CGFloat alpha) {
    return [UIColor colorWithRed:((hex >> 16) & 0xFF) / 255.0
                           green:((hex >> 8) & 0xFF) / 255.0
                            blue:(hex & 0xFF) / 255.0
                           alpha:alpha];
}

static UIWindow *GetActiveKeyWindow(void) {
    UIWindow *foundWindow = nil;
    for (UIScene *scene in [UIApplication sharedApplication].connectedScenes) {
        if (scene.activationState == UISceneActivationStateForegroundActive &&
            [scene isKindOfClass:[UIWindowScene class]]) {
            UIWindowScene *windowScene = (UIWindowScene *)scene;
            for (UIWindow *window in windowScene.windows) {
                if (window.isKeyWindow) return window;
                if (!foundWindow && !window.isHidden) foundWindow = window;
            }
        }
    }
    if (!foundWindow) {
        for (UIScene *scene in [UIApplication sharedApplication].connectedScenes) {
            if ([scene isKindOfClass:[UIWindowScene class]]) {
                UIWindowScene *windowScene = (UIWindowScene *)scene;
                for (UIWindow *window in windowScene.windows) {
                    if (!window.isHidden) return window;
                }
            }
        }
    }
    if (!foundWindow) {
        id<UIApplicationDelegate> delegate = [UIApplication sharedApplication].delegate;
        if ([delegate respondsToSelector:@selector(window)]) {
            foundWindow = delegate.window;
        }
    }
    return foundWindow;
}

@interface WelcomeOverlayView : UIView
@end

@implementation WelcomeOverlayView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = ColorHex(0x050507, 0.96);
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.layer.zPosition = 9999;
        [self setupUI];
    }
    return self;
}

- (UIButton *)makeSecondaryButtonWithTitle:(NSString *)title action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:ColorHex(0xEBC163, 1.0) forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightSemibold];
    btn.backgroundColor = ColorHex(0x141418, 1.0);
    btn.layer.cornerRadius = 13.0;
    btn.layer.borderWidth = 1.1;
    btn.layer.borderColor = ColorHex(0xC99D47, 0.7).CGColor;
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)setupUI {
    UIView *card = [[UIView alloc] init];
    card.translatesAutoresizingMaskIntoConstraints = NO;
    card.backgroundColor = ColorHex(0x0E0E11, 1.0);
    card.layer.cornerRadius = 26.0;
    card.layer.borderWidth = 1.2;
    card.layer.borderColor = ColorHex(0xC99D47, 0.7).CGColor;
    [self addSubview:card];

    NSLayoutConstraint *prefWidth = [card.widthAnchor constraintEqualToAnchor:self.widthAnchor constant:-44];
    prefWidth.priority = UILayoutPriorityDefaultHigh;

    [NSLayoutConstraint activateConstraints:@[
        [card.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
        [card.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
        [card.widthAnchor constraintLessThanOrEqualToConstant:350],
        [card.leadingAnchor constraintGreaterThanOrEqualToAnchor:self.leadingAnchor constant:22],
        [card.trailingAnchor constraintLessThanOrEqualToAnchor:self.trailingAnchor constant:-22],
        prefWidth
    ]];

    UIStackView *stack = [[UIStackView alloc] init];
    stack.translatesAutoresizingMaskIntoConstraints = NO;
    stack.axis = UILayoutConstraintAxisVertical;
    stack.alignment = UIStackViewAlignmentFill;
    stack.spacing = 12;
    [card addSubview:stack];

    [NSLayoutConstraint activateConstraints:@[
        [stack.topAnchor constraintEqualToAnchor:card.topAnchor constant:30],
        [stack.bottomAnchor constraintEqualToAnchor:card.bottomAnchor constant:-24],
        [stack.leadingAnchor constraintEqualToAnchor:card.leadingAnchor constant:22],
        [stack.trailingAnchor constraintEqualToAnchor:card.trailingAnchor constant:-22]
    ]];

    // 1. أيقونة التاج
    UIImageSymbolConfiguration *iconCfg = [UIImageSymbolConfiguration configurationWithPointSize:26 weight:UIImageSymbolWeightMedium];
    UIImage *crownImg = [UIImage systemImageNamed:@"crown.fill" withConfiguration:iconCfg];
    if (!crownImg) {
        crownImg = [UIImage systemImageNamed:@"sparkles" withConfiguration:iconCfg];
    }
    UIImageView *crownView = [[UIImageView alloc] initWithImage:crownImg];
    crownView.contentMode = UIViewContentModeScaleAspectFit;
    crownView.tintColor = ColorHex(0xEBC163, 1.0);
    [crownView.heightAnchor constraintEqualToConstant:32].active = YES;
    [stack addArrangedSubview:crownView];
    [stack setCustomSpacing:10 afterView:crownView];

    // 2. الاسم الرئيسي المتوهج
    UILabel *brandLabel = [[UILabel alloc] init];
    brandLabel.text = kBrandName;
    brandLabel.textAlignment = NSTextAlignmentCenter;
    brandLabel.font = [UIFont systemFontOfSize:34 weight:UIFontWeightHeavy];
    brandLabel.textColor = ColorHex(0xEBC163, 1.0);
    brandLabel.layer.shadowColor = ColorHex(0xEBC163, 1.0).CGColor;
    brandLabel.layer.shadowRadius = 12.0;
    brandLabel.layer.shadowOpacity = 0.75;
    brandLabel.layer.shadowOffset = CGSizeZero;
    brandLabel.layer.masksToBounds = NO;
    [stack addArrangedSubview:brandLabel];
    [stack setCustomSpacing:6 afterView:brandLabel];

    // 3. النص الإنجليزي الفرعي
    UILabel *subLabel = [[UILabel alloc] init];
    subLabel.textAlignment = NSTextAlignmentCenter;
    subLabel.attributedText = [[NSAttributedString alloc] initWithString:kEnglishSubtitle attributes:@{
        NSFontAttributeName: [UIFont systemFontOfSize:11 weight:UIFontWeightSemibold],
        NSForegroundColorAttributeName: ColorHex(0x8E8E93, 1.0),
        NSKernAttributeName: @3.5
    }];
    [stack addArrangedSubview:subLabel];
    [stack setCustomSpacing:20 afterView:subLabel];

    // 4. الخط الفاصل الذهبي
    UIView *divider = [[UIView alloc] init];
    divider.backgroundColor = ColorHex(0xC99D47, 0.45);
    [divider.heightAnchor constraintEqualToConstant:1.0].active = YES;
    [stack addArrangedSubview:divider];
    [stack setCustomSpacing:20 afterView:divider];

    // 5. العنوان الترحيبي العربي
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = kWelcomeTitle;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.numberOfLines = 0;
    titleLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightBold];
    titleLabel.textColor = [UIColor whiteColor];
    [stack addArrangedSubview:titleLabel];
    [stack setCustomSpacing:8 afterView:titleLabel];

    // 6. الوصف
    UILabel *msgLabel = [[UILabel alloc] init];
    msgLabel.text = kWelcomeMessage;
    msgLabel.textAlignment = NSTextAlignmentCenter;
    msgLabel.numberOfLines = 0;
    msgLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    msgLabel.textColor = ColorHex(0xA1A1AA, 1.0);
    [stack addArrangedSubview:msgLabel];
    [stack setCustomSpacing:26 afterView:msgLabel];

    // 7. زر الاستمرار الذهبي
    UIButton *continueBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    continueBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [continueBtn setTitle:kContinueTitle forState:UIControlStateNormal];
    [continueBtn setTitleColor:ColorHex(0x12100B, 1.0) forState:UIControlStateNormal];
    continueBtn.titleLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightBold];
    continueBtn.backgroundColor = ColorHex(0xE7B955, 1.0);
    continueBtn.layer.cornerRadius = 14.0;
    [continueBtn.heightAnchor constraintEqualToConstant:52].active = YES;
    [continueBtn addTarget:self action:@selector(dismissTapped) forControlEvents:UIControlEventTouchUpInside];
    [stack addArrangedSubview:continueBtn];
    [stack setCustomSpacing:12 afterView:continueBtn];

    // 8. زرا القناة والدعم الفني بجانب بعضهما
    UIStackView *rowStack = [[UIStackView alloc] init];
    rowStack.axis = UILayoutConstraintAxisHorizontal;
    rowStack.distribution = UIStackViewDistributionFillEqually;
    rowStack.spacing = 12;
    [rowStack.heightAnchor constraintEqualToConstant:48].active = YES;

    UIButton *channelBtn = [self makeSecondaryButtonWithTitle:kChannelTitle action:@selector(openChannel)];
    UIButton *supportBtn = [self makeSecondaryButtonWithTitle:kSupportTitle action:@selector(openSupport)];
    [rowStack addArrangedSubview:channelBtn];
    [rowStack addArrangedSubview:supportBtn];
    [stack addArrangedSubview:rowStack];
    [stack setCustomSpacing:22 afterView:rowStack];

    // 9. النص السفلي
    UILabel *footerLabel = [[UILabel alloc] init];
    footerLabel.text = kFooterText;
    footerLabel.textAlignment = NSTextAlignmentCenter;
    footerLabel.font = [UIFont systemFontOfSize:10 weight:UIFontWeightMedium];
    footerLabel.textColor = ColorHex(0x636366, 1.0);
    [stack addArrangedSubview:footerLabel];
}

- (void)dismissTapped {
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0.0;
        self.transform = CGAffineTransformMakeScale(0.96, 0.96);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)openChannel {
    NSURL *url = [NSURL URLWithString:kChannelURL];
    if (url) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }
}

- (void)openSupport {
    NSURL *url = [NSURL URLWithString:kSupportURL];
    if (url) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }
}

@end

static BOOL gWelcomeShown = NO;

static void ShowWelcomeIfNeeded(void) {
    if (gWelcomeShown) return;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (gWelcomeShown) return;
        UIWindow *window = GetActiveKeyWindow();
        if (!window) return;
        gWelcomeShown = YES;

        WelcomeOverlayView *overlay = [[WelcomeOverlayView alloc] initWithFrame:window.bounds];
        overlay.alpha = 0.0;
        [window addSubview:overlay];

        [UIView animateWithDuration:0.3 animations:^{
            overlay.alpha = 1.0;
        }];
    });
}

__attribute__((constructor))
static void WelcomeDylibInit(void) {
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidBecomeActiveNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note) {
        ShowWelcomeIfNeeded();
    }];
}
