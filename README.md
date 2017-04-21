# Crack-lrts--easoubook
破解懒人听书和宜搜小说，去除内置广告，宜搜小说开屏广告也去了，该代码仅供学习使用，如有侵权，我会立马删除

### 破解介绍
- 基于<a href="https://github.com/Naituw/IPAPatch">IPAPatch</a>实现免越狱调试、修改第三方App对项目进行构建。有兴趣的同学可以去看看该项目。

- 主要的自动化过程在 patch.sh 这个脚本里，Xcode 会在把你的代码编译成 Framework 后执行这个脚本：解压 IPA 文件
用 IPA 文件的内容，替换掉 Xcode 生成的 .app 的内容
通过 OPTOOL，将你代码生成的 Framework 及其他外部 Framework，注入到二进制文件中
对这些文件进行重新签名
完成后，Xcode 会自动将修改过的 .app 安装到 iPhone 上。

### 破解去除广告的原理
当基于IPAPatch的基础项目构建成功后，这一步骤才是关键点

- 首先我们需要用到oc的runtime机制，runtime简单点讲就是如何使用它让c实现oc😊，开玩笑了。我们在这里使用runtime来对破解应用的某些方法实现instead，让这些方法返回我们想要的东西。我们自己可以利用runtime来手写方法的交换，这里就不详细介绍了，当然也可以利用<a href="Aspects">Aspects</a>来实现方法的替换，原理也是一样的，利用runtime在运行时做到方法的替换。

- 于是我们需要用到一个叫<a href="https://github.com/stefanesser/dumpdecrypted">dumpdecrypted</a>的工具来把砸壳后的ipa文件导出其头文件。有了这些头文件后，便方便了我们去猜测其使用了哪些方法来显示广告。

- 按照正常的写代码命名逻辑，猜测其方法可能为showAd,我们在所有的这些头文件中全局搜索该方法，果不其然。这里我以宜搜小说app举例子，破解过程中发现破解它广告的难度比较大。列举需要破解的广告(底部web广告，原生范围广告，开屏广告)，任务艰巨呀。

<img src="http://7xsim2.com1.z0.glb.clouddn.com/IMG_01662.PNG" width = 200px />
<img src="http://7xsim2.com1.z0.glb.clouddn.com/IMG_01673.PNG" width = 200px />
<img src="http://7xsim2.com1.z0.glb.clouddn.com/IMG_01654.PNG" width = 200px />

- 定位三个广告视图的类名，我们可以利用Xcode自带的页面调试工具，展开这三个页面。先说说比较容易解决的第二个，中间那个原生的的广告，其使用的类是<code>ESBookConnateView</code>,找到这个类的头文件，直接修改其初始化方法，让其返回一个frame为零的空视图。直接上代码

````
Class cls = NSClassFromString(@"ESBookConnateView");
    [cls aspect_hookSelector:NSSelectorFromString(@"initWithFrame:") withOptions:AspectPositionInstead usingBlock:^id(id<AspectInfo> aspectInfo){
        return [UIView new];
    }error:nil];
````

- 第二个我们来处理掉第一张图里面的底部web广告，这里我们在这个页面的<code>ESBookReadViewController</code>中发现一个名为<code>showAdvertising</code>的方法，直接用一个空方法取代它。修改代码后发现确实底部广告没了，但是底部留白了一大块，很影响阅读体验。思考（宜搜阅读本身提供了点击便隐藏广告的方法，同时下部不会留白，只是每翻一页都需要去手动点，太反人类了。所以想到每次翻页自动去调用该方法，实践发现果然可行。）老规矩，继续上代码

````
	Class cls = NSClassFromString(@"ESBookReadViewController");
    [cls aspect_hookSelector:NSSelectorFromString(@"showAdvertising") withOptions:AspectPositionInstead usingBlock:^(){
        
    }error:nil];
    [cls aspect_hookSelector:NSSelectorFromString(@"getAdvertisingData") withOptions:AspectPositionInstead usingBlock:^(id<AspectInfo> aspectInfo){
        SEL remove = NSSelectorFromString(@"removeAdvertising");
        [aspectInfo.instance performSelector:remove];
        NSLog(@"%@", aspectInfo.instance);
    }error:nil];
````

- 最后来讲讲开屏的那一块让人头疼的大页面广告，利用Xcode的页面分析工具后发现其直接使用的是UIImageView和UIButton实现，根本不知道其视图类是哪个。所以我的解决思路是直接找到该页面的Controller，从Controlleer中找到自己需要的方法。因为基本所有的开屏广告都会提供跳过的按钮选项，所以我们可以直接在<code>-(BOOL)viewWillAppear</code>这个方法中手动调用该方法。...........................................大概找了这么久，终于找到了这个Controller<code>EasouSplashAdVC</code>。既然找到了你，马上写代码。解释一下，aspectInfo.instance为一个类的实例，也就是当前初始化生成的实例。

````
	Class cls = NSClassFromString(@"EasouSplashAdVC");
    [cls aspect_hookSelector:NSSelectorFromString(@"viewWillAppear:") withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo){
        SEL goHomeVC = NSSelectorFromString(@"goHomeVC");
        [aspectInfo.instance performSelector:goHomeVC];
    }error:nil];
````

### 至此，三个烦人的广告终于都没有了

清爽的页面可以让我看小说看个够。同样的，使用这一套东西可以处理很多你觉得某个app中你不满意的地方，举几个小🌰。

- 不喜欢微信tab的样式，可以，咱直接改
- 不喜欢某个app内讨厌的弹窗，可以，直接禁止
- 什么vip才能使用，可以，手动让自己变成vip(只能用在某些vip校验不是那么变态的app内，当然我们还是要支持付费使用优秀内容的)


最后，祝大家玩的愉快，有任何问题都可以直接给我发邮件。
