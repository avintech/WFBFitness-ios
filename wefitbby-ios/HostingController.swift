//
//  HostingController.swift
//  wefitbby-ios
//
//  Created by Avin Tech on 1/10/20.
//  Copyright © 2020 avintech. All rights reserved.
//

import Foundation
import SwiftUI

class HostingController<ContentView>: UIHostingController<ContentView> where ContentView : View {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
