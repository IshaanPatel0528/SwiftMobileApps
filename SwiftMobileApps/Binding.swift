//
//  Binding.swift
//  SwiftMobileApps
//
//  Created by Ishaan A Patel on 11/21/24.
//

import SwiftUI

extension Binding {
    init(_ source: Binding<Value?>, default defaultValue: Value) {
        self.init (
            get: {source.wrappedValue ?? defaultValue},
            set: {source.wrappedValue = $0}
        )
    }
}
