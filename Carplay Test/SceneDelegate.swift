//
//  SceneDelegate.swift
//  Carplay Test
//
//  Created by Claudio Barbera on 18/08/22.
//

import UIKit
import Intercom

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        Intercom.setApiKey("your-api-key", forAppId:"your-app-id")
        Intercom.enableLogging()
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }
}

