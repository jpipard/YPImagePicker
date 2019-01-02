//
//  Color.swift
//  Peeble
//
//  Created by Julien on 07/10/2017.
//  Copyright © 2017 Julien. All rights reserved.
//

import UIKit

public class Theme {

    public static let current = ThemeName.Dark

    public static var shared: ThemeColor {
        return Theme.themeList[Theme.current]!
    }

    public enum ThemeName {
        case Dark
        case Light
        case Light2
        case DarkLight
        case Debug
    }

    public struct ThemeColor {
        var dark = YPConfig.colors.color1
        var light = UIColor.red
        var text1 = UIColor.lightGray
        var text2 = UIColor.blue
        var borderColor = UIColor.purple
        var navBarColor = UIColor.blue
        var tabBarColor = UIColor.blue
        var shadowImage: UIImage?
        var statusBar: UIStatusBarStyle
        var barStyle: UIBarStyle

        func globalInit() {
            let navigationTitleFont = UIFont(name: "OpenSans-Semibold", size: 17)!
            UINavigationBar.appearance().titleTextAttributes = [
                NSAttributedString.Key.font: navigationTitleFont,
                NSAttributedString.Key.foregroundColor: Theme.shared.text2
            ]
            UINavigationBar.appearance().isTranslucent = false
            UINavigationBar.appearance().barStyle = Theme.shared.barStyle
            UINavigationBar.appearance().tintColor = Theme.shared.text2
            UINavigationBar.appearance().barTintColor = Theme.shared.navBarColor
            UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
            if let _shadowImage = shadowImage {
                UINavigationBar.appearance().shadowImage = _shadowImage
            }
        }
    }

    public static let themeList = [
        ThemeName.Light: ThemeColor(
            dark: UIColor(alpha: 1, red: 248, green: 247, blue: 246),
            light: UIColor(alpha: 1,red: 66, green: 65, blue: 70),
            text1: UIColor(alpha: 1, red: 244, green: 124, blue: 110),
            text2: UIColor(alpha: 1, red: 36, green: 37, blue: 41),
            borderColor: UIColor(alpha: 1, red: 210, green: 210, blue: 210),
            navBarColor: UIColor(alpha: 1, red: 242, green: 242, blue: 242),
            tabBarColor: UIColor(alpha: 1, red: 242, green: 242, blue: 242),
            shadowImage: nil,
            statusBar: .default,
            barStyle: .default
        ),
        ThemeName.DarkLight: ThemeColor(
            dark: UIColor(alpha: 1,red: 240, green: 240, blue: 240),
            light: UIColor(alpha: 1, red: 255, green: 255, blue: 255),
            text1: UIColor(alpha: 1, red: 244, green: 124, blue: 110),
            text2: UIColor(alpha: 1, red: 54, green: 53, blue: 58),
            borderColor: UIColor.clear,
            navBarColor: UIColor(alpha: 1, red: 255, green: 255, blue: 255),
            tabBarColor: UIColor(alpha: 1, red: 54, green: 53, blue: 58),
            shadowImage: UIImage(),
            statusBar: .default,
            barStyle: .black
        ),
        ThemeName.Dark: ThemeColor(
            dark: UIColor(alpha: 1, red: 49, green: 48, blue: 53),
            light: UIColor(alpha: 1,red: 66, green: 65, blue: 70),
            text1: UIColor(alpha: 1, red: 244, green: 124, blue: 110),
            text2: UIColor(alpha: 1, red: 255, green: 255, blue: 255),
            borderColor: UIColor.clear,
            navBarColor: UIColor(alpha: 1,red: 66, green: 65, blue: 70),
            tabBarColor: UIColor(alpha: 1, red: 49, green: 48, blue: 53),
            shadowImage: UIImage(),
            statusBar: .lightContent,
            barStyle: .black
        ),
        ThemeName.Debug: ThemeColor(
            dark: YPConfig.colors.color1,
            light: UIColor.red,
            text1: UIColor.lightGray,
            text2: UIColor.blue,
            borderColor: UIColor.purple,
            navBarColor: UIColor(alpha: 1, red: 242, green: 242, blue: 242),
            tabBarColor: UIColor(alpha: 1, red: 242, green: 242, blue: 242),
            shadowImage: UIImage(),
            statusBar: .lightContent,
            barStyle: .black
        )
    ]
}

extension UIColor {
    convenience init(alpha: CGFloat = 1.0, red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(alpha))
    }

    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }

    public func alpha(_ value: Float) -> UIColor {
        let (red, green, blue, _) = colorComponents()
        return UIColor(red: red, green: green, blue: blue, alpha: CGFloat(value))
    }

    public func red(_ value: Int) -> UIColor {
        let (_, green, blue, alpha) = colorComponents()
        return UIColor(alpha: alpha, red: value/255, green: Int(green), blue: Int(blue))
    }

    public func green(_ value: Int) -> UIColor {
        let (red, _, blue, alpha) = colorComponents()
        return UIColor(alpha: alpha, red: Int(red), green: value/255, blue: Int(blue))
    }

    public func blue(_ value: Int) -> UIColor {
        let (red, green, _, alpha) = colorComponents()
        return UIColor(alpha: alpha, red: Int(red), green: Int(green), blue: value/255)
    }

    public func colorComponents() -> (CGFloat, CGFloat, CGFloat, CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        #if os(iOS)
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        #elseif os(OSX)
        self.usingColorSpaceName(NSColorSpaceName.calibratedRGB)!.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        #endif
        return (red, green, blue, alpha)
    }
}
