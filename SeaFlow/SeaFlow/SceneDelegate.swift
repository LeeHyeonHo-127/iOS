//
//  SceneDelegate.swift
//  SeaFlow
//
//  Created by 이현호 on 2023/10/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene
        
        
        var homeViewController = HomeViewController()
        var showWeatherViewController = ShowWeatherViewController()
        var commerceViewController = CommerceViewController()
        var diaryViewController = DiaryViewController()
        var myPageViewController = MyPageViewController()
        
        var navigationController = UINavigationController(rootViewController: homeViewController)
        var tabBarController = UITabBarController()
        
        tabBarController.setViewControllers([navigationController,showWeatherViewController,commerceViewController,diaryViewController,myPageViewController], animated: false)

        guard let items = tabBarController.tabBar.items else { return }
        tabBarController.tabBar.tintColor = .blue
        tabBarController.tabBar.barTintColor = UIColor(named: "SeaFlowBlue")
        
        items[0].image = UIImage(named: "home")
        items[0].title = "홈"
        items[1].image = UIImage(named: "data")
        items[1].title = "공공정보"
        items[2].image = UIImage(named: "shop")
        items[2].title = "커머스"
        items[3].image = UIImage(named: "diary")
        items[3].title = "다이어리"
        items[4].image = UIImage(named: "profile")
        items[4].title = "MY"
        
        
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

