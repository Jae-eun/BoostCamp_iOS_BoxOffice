//
//  BaseViewController.swift
//  Boostcamp_iOS_BoxOffice
//
//  Created by 이재은 on 17/12/2018.
//  Copyright © 2018 이재은. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setOrderTypeUserDefaults(_ order: Int) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(order, forKey: "orderType")
    }
    
    var orderTypeUserDefaults: Int {
        return UserDefaults.standard.integer(forKey: "orderType")
    }

    func setNavigationBarTitle(orderType: Int) {
        let titleArray = ["예매율순", "큐레이션", "개봉일순"]
        navigationItem.title = titleArray[orderType]
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.backBarButtonItem?.tintColor = .white
    }
    
    func changeMoviesOrder(order: Int) {
        self.setOrderTypeUserDefaults(order)
        self.setNavigationBarTitle(orderType: order)
        API.shared.requestMovies(orderType: order)
    }
    
    func presentOrderMoviesActionSheet() {
        let alertController = UIAlertController(title: "정렬방식 선택", message: "영화를 어떤 순서로 정렬할까요?", preferredStyle: .actionSheet)

        let orderAction1 = UIAlertAction(title: "예매율", style: .default) { (UIAlertAction) in
            self.changeMoviesOrder(order: 0)
        }
        let orderAction2  = UIAlertAction(title: "큐레이션", style: .default)  { (UIAlertAction) in
            self.changeMoviesOrder(order: 1)
        }
        let orderAction3 = UIAlertAction(title: "개봉일", style: .default)  { (UIAlertAction) in
            self.changeMoviesOrder(order: 2)
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alertController.addAction(orderAction1)
        alertController.addAction(orderAction2)
        alertController.addAction(orderAction3)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
