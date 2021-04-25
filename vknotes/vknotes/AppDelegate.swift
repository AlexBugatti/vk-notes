//
//  AppDelegate.swift
//  vknotes
//
//  Created by Александр on 25.04.2021.
//

import UIKit
import IQKeyboardManagerSwift
import DropDown

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let categories = DatabaseService.shared.getCategories()
        if categories.count == 0 {
            DatabaseService.shared.addCategory(name: "Mobile")
            DatabaseService.shared.addCategory(name: "MiniApps")
            
            DatabaseService.shared.addNote(title: "20", category: "Mobile", note: "Разработайте мобильное приложение для хранения текстовых заметок, паролей, задач с разбиением на категории. Приложение должно хранить информацию в памяти устройства, позволять добавлять, удалять, редактировать записи, просматривать записи по выбранной категории.")
            
            DatabaseService.shared.addNote(title: "10", category: "Mobile", note: "Реализуйте мобильное приложение с возможность перехода на главный экран только после ввода заданного заранее пин-кода. Пин-код задаётся при первом запуске приложения. Предусмотрите возможность смены пин-кода.")
            DatabaseService.shared.addNote(title: "Визитка вездекода", category: "MiniApps", note: "Создайте сайт-визитку «Вездекода», который расскажет о марафоне в Туле, его организаторах и партнёрах. Захостите этот сайт на любом онлайн-хостинге (например, GitHub Pages или Vercel) и в ответе отправьте ссылку на сайт.")
        }

        IQKeyboardManager.shared.enable = true
        DropDown.startListeningToKeyboard()
        
        let notesVC = NotesViewController(nibName: nil, bundle: nil)
        let navController = UINavigationController.init(rootViewController: notesVC)
        self.window?.rootViewController =  navController
        
        return true
    }


}

