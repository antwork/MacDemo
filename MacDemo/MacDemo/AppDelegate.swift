//
//  AppDelegate.swift
//  MacDemo
//
//  Created by lunkr on 2021/6/22.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!
    
    @UserDefault("system_mode", defaultValue: "system")
    var systemMode: String {
        didSet {
            print("property setter \(systemMode)")
            updateAppearanceMode()
        }
    }
    
    let prefs = Prefs()
    var prefsView: PrefsView?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        updateAppearanceMode()
        
        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView()

        // Create the window and set the content view.
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.isReleasedWhenClosed = false
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @IBAction func darkModeSelected(_ sender: Any) {
        systemMode = NSAppearance.Name.darkAqua.rawValue
    }
    
    @IBAction func lightModeSelected(_ sender: Any) {
        systemMode = NSAppearance.Name.aqua.rawValue
    }
    
    @IBAction func systemModeSelected(_ sender: Any) {
        systemMode = ""
    }
    
    @IBAction func flipImage(_ sender: Any) {
        NotificationCenter.default.post(name: .flipImage, object: nil)
    }
    
    func updateAppearanceMode() {
        NSApp.appearance = NSAppearance(named: NSAppearance.Name(rawValue: systemMode))
    }
    
    @IBAction func showPrefs(_ sender: Any) {
        if let prefsView = prefsView, prefsView.prefsWindowDelegate.windowIsOpen {
            prefsView.window.makeKeyAndOrderFront(self)
        } else {
            prefsView = PrefsView(prefs: prefs)
        }
    }
}


struct AppDelegate_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello, World!")
    }
}

extension Notification.Name {
    static let flipImage = Notification.Name("flip_image")
    static let saveImage = Notification.Name("save_image")
}

