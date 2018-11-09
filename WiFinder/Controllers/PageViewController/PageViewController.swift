//
//  PageViewController.swift
//  WiFinder
//
//  Created by Eduardo Domene Junior on 09/11/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    var controllers = [UIViewController]()
    var selectedMediaType: MediaType?
    var enteredQuery: String?
    
    override func viewDidLoad() {
        self.delegate = self
        self.dataSource = self
        setupViewControllers()
    }
    
    func setupViewControllers() {
        let vc1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FirstScreenViewController") as! FirstScreenViewController
        let vc2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecondScreenViewController") as! SecondScreenViewController
        vc1.delegate = self
        vc2.delegate = self
        controllers.append(contentsOf: [vc1, vc2])
        setViewControllers([controllers[0]], direction: .forward, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ViewController {
            vc.selectedMediaType = selectedMediaType
            vc.enteredQuery = enteredQuery
        }
    }
}

extension PageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
       return self.controllers.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = controllers.index(of: viewController), index > 0 {
            return controllers[index-1]
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = controllers.index(of: viewController), index < (controllers.count-1) {
            return controllers[index+1]
        }
        return nil
    }
}

// MARK: FirstScreenViewControllerDelegate
extension PageViewController: FirstScreenViewControllerDelegate {
    func didClick(action: FirstScreenViewController.Action) {
        setViewControllers([controllers[1]], direction: .forward, animated: true, completion: nil)
        selectedMediaType = action.type
    }
}

// MARK: SecondScreenViewControllerDelegate
extension PageViewController: SecondScreenViewControllerDelegate {
    func didEnter(text: String) {
        enteredQuery = text
        performSegue(withIdentifier: "catalogSegue", sender: nil)
    }
}
