#pod 源
source 'https://github.com/CocoaPods/Specs.git'

VERSION = '13.0'

platform :ios, VERSION
target 'app_ios' do
pod 'MJRefresh', '~> 3.1'
pod 'AFNetworking', '~> 3.2'
pod 'MBProgressHUD', '~> 1.0'
pod 'Masonry', '~> 1.1'
pod 'SDWebImage', '~> 3.8'
pod 'Reachability', '~> 3.2'
pod 'NullSafe', '~> 1.2'
pod 'IQKeyboardManager', '~> 6.2'
pod 'pop', '~> 1.0'
pod 'TTTAttributedLabel', '~> 2.0'

# Pods for ObjC
# YYWebImage 会自动引入 YYImage 和 YYCache，所以移除显式声明以避免重复符号
# 如果需要使用 git 版本的 YYImage，则移除 YYWebImage，只保留 YYImage 和 YYCache
pod 'YYImage', :git => 'https://github.com/chong2vv/YYImage.git', :subspecs => ['Core', 'WebP']
pod 'YYCache', '~>1.0.4'
pod 'YDLogger', '~> 0.2.4'
pod 'YDMonitor', '~> 0.1.0'
pod 'YDAlertAction', '~> 0.1.0'
pod 'YDUtilKit', '~> 0.1.6'
pod 'YDAuthorizationUtil', '~> 0.1.0'
pod 'YDClearCacheService', '~> 0.1.0'
pod 'YDWebViewJavascriptBridge', '~> 0.1.0'
#block分类库
pod 'YDBlockKit', '~> 0.1.1'
#文件管理器
pod 'YDFileManager', '~> 0.1.3'
end
