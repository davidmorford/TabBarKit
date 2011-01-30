
# TabBarKit

## Highlights

* No images whatsoever. Bar, tab item selections and arrow indicator are implemented as CALayers.
* Tab bar and tab items support two styles, a standard appearance a la UITabBar or with an arrow indicator a la Tweetie / Twitter)/
* UIImage category takes black images masks and renders with gray and blue selection gradients like UITabBar/UITabBarItem
* Uses UIView block animations to respect the hidesBottomBarWhenPushed property on contained UIViewControllers.
* Uses ObjC associatedObject API to associate tab items and the tab controller with contained view controllers.

## In Progress

* More Tab and customizable view controllers.
* Badge count implementation layer.
* Render Text labels for standard tab bar style.
* Shadows on tab items and arrow indicator selection style.


## Requirements

* SDK : 4.2 or greater
* Set OTHER_CFLAGS to -Xclang -fobjc-nonfragile-abi2. Comment out or remove this flag settin from Configurations/Compiler.xcconfig if building with a recent Xcode 4 DP.

## iPhone

[![](https://github.com/davidmorford/TabBarKit/raw/master/Documents/TabBar-iPhone-Portrait-Arrow.png)](https://github.com/davidmorford/TabBarKit/raw/master/Documents/TabBar-iPhone-Portrait-Arrow.png)
[![](https://github.com/davidmorford/TabBarKit/raw/master/Documents/TabBar-iPhone-Portrait-Arrow.png)](https://github.com/davidmorford/TabBarKit/raw/master/Documents/TabBar-iPhone-Portrait-Standard.png)

[![](https://github.com/davidmorford/TabBarKit/raw/master/Documents/TabBar-iPhone-Landscape-Arrow.png)](https://github.com/davidmorford/TabBarKit/raw/master/Documents/TabBar-iPhone-Landscape-Arrow.png)
[![](https://github.com/davidmorford/TabBarKit/raw/master/Documents/TabBar-iPhone-Landscape-Arrow.png)](https://github.com/davidmorford/TabBarKit/raw/master/Documents/TabBar-iPhone-Landscape-Standard.png)

## iPad

[![](https://github.com/davidmorford/TabBarKit/raw/master/Documents/TabBar-iPad-Portrait-Standard.png)](https://github.com/davidmorford/TabBarKit/raw/master/Documents/TabBar-iPad-Portrait-Standard.png)


## History

### January 30, 2011 - Public release


## License and Copyright

BuildKit is BSD licensed. The full text of the license is located in Documents/License.md
