# LLAdmob
自封装自用

### Cocoapods 进行安装
```
pod 'LLAdMob', :git => 'https://github.com/Ruris/LLAdMob.git', :tag => s.version.to_s
```

### 基本配置

在 `Info.plist` 文件中，添加一个字符串值为您的 AdMob 应用 ID 的 GADApplicationIdentifier.
```xml
<key>GADApplicationIdentifier</key>
<string>ca-app-pub-3940256099942544~1458002511</string>
```

### iOS14 SKAdNetwork

在 `Info.plist` 文件中，添加如下字段和值.
```xml
<key>SKAdNetworkItems</key>
  <array>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>cstr6suwn9.skadnetwork</string>
    </dict>
  </array>
```
