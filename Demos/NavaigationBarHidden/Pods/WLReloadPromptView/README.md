# WLReloadPromptView
一枚弱网络环境下重新加载视图控件, OC 所写, 支持 Swift 和 Storyboard 实时预览.

![](https://img.shields.io/badge/License-MIT-0099ff.svg)
![](https://img.shields.io/badge/Platform-iOS-ff6600.svg)
![](https://img.shields.io/badge/Language-OC-ff69b4.svg)
![](https://img.shields.io/badge/Xcode-7-5cde45.svg)

<img src="images/1.PNG" width="320" style="border:1px solid black" />
<img src="images/2.PNG" width="320" style="border:1px solid black" />


## 软件要求

* Xcode 7
* iOS 7.0 及以上
* ARC


## 用法示例

```swift
reloadPromptView = WLReloadPromptView(coveredView: self.view, reloadActions: {
    // 这里添加你的重新加载相关代码
    // 加载完毕后消失
    self.reloadPromptView.disappear()
})

// 网络不畅时显示
reloadPromptView.appear();
```
> 具体使用参见仓库中的 Demo.

如果需要在项目中每个 View Controller 中实现此功能，建议重载 UIViewController 并将此控件添加至父类控制器中，或者考虑 Method Swizzing.
