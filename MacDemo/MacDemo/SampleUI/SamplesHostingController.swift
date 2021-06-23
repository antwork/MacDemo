//
//  SamplesHostingController.swift
//  MacDemo
//
//  Created by lunkr on 2021/6/23.
//

import SwiftUI


class SamplesHostingController: NSHostingController<SamplesView> {
    @objc required dynamic init?(coder: NSCoder) {
        super.init(coder: coder, rootView: SamplesView())
          }
}
