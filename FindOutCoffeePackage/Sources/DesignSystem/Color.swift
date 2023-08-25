//
//  Color.swift
//  
//
//  Created by 10004 on 2023/08/21.
//

import Foundation
import SwiftUI

extension Color {
    public static let mainColor = Color(red: 0.169, green: 0.565, blue: 0.851)
    public static let imagePlaceholderColor = Color(red: 0.96, green: 0.96, blue: 0.96)
    public static let imagePlckerBorderColor = Color(red: 0.92, green: 0.92, blue: 0.92)
    public static let kakaoLogoColor = Color(hex: "#181600")
    public static let kakaoBackgroundColor = Color(hex: "#fee500")
    public static let kakaoTitleColor = Color(hex: "#302e17")
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >>  8) & 0xFF) / 255.0
        let b = Double((rgb >>  0) & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}
