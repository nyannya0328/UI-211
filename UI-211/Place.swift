//
//  Place.swift
//  UI-211
//
//  Created by にゃんにゃん丸 on 2021/05/29.
//

import SwiftUI
import CoreLocation

struct Place: Identifiable {
    var id = UUID().uuidString
    var placeMark : CLPlacemark
}


