//
//  MainTabBarController.swift
//  NomikMovieApp
//
//  Created by Nomik on 2025/2/12.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.backgroundColor = .mainColor
        tabBar.tintColor = .systemOrange
        
        let vc1 = HomeViewController()
        let vc2 = SearchViewController()
        let vc3 = WatchListViewController()
        
        vc2.navigationItem.title = "電影搜尋"
        vc3.navigationItem.title = "關注電影"
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        
        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true
        nav3.navigationBar.prefersLargeTitles = true
        
        nav1.navigationBar.backgroundColor = .mainColor
        
        nav1.tabBarItem.image = UIImage(systemName: "movieclapper")
        nav1.tabBarItem.title = "電影首頁"
        
        nav2.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        nav2.tabBarItem.title = "電影搜尋"
        
        nav3.tabBarItem.image = UIImage(systemName: "bookmark")
        nav3.tabBarItem.title = "關注電影"
        
        setViewControllers([nav1, nav2, nav3], animated: true)
    }
}

#Preview {
    MainTabBarController()
}
