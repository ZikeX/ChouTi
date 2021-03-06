//
//  Created by Honghao Zhang on 09/29/2015.
//  Copyright © 2018 ChouTi. All rights reserved.
//

import ChouTi
import UIKit

class PageViewDemoController: UIViewController {

	let pageViewController = PageViewController()
    let viewControllers: [UIViewController] = {
        [0, 1, 2, 3].map { DummyViewController(label: "vc\($0)") }
    }()

    override func viewDidLoad() {
		super.viewDidLoad()

		self.view.backgroundColor = UIColor.white

        pageViewController.delegate = self

        // 1: Set view controllers directly
//        pageViewController.viewControllers = viewControllers

        // 2: Set view controllers by data source
        pageViewController.dataSource = self

        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
	}
}

extension PageViewDemoController: PageViewControllerDataSource {
	func numberOfViewControllersInPageViewController(_ pageViewController: PageViewController) -> Int {
		return viewControllers.count
	}

	func pageViewController(_ pageViewController: PageViewController, viewControllerForIndex index: Int) -> UIViewController {
		print("asking for index: \(index)")
		return viewControllers[index]
	}
}

extension PageViewDemoController: PageViewControllerDelegate {
	func pageViewController(_ pageViewController: PageViewController, didSelectIndex selectedIndex: Int, selectedViewController: UIViewController) {
		print("did selected: \(selectedIndex)")
	}

	func pageViewController(_ pageViewController: PageViewController, didScrollWithSelectedIndex selectedIndex: Int, offsetPercent: CGFloat) {
//		print("scroll offset: \(offsetPercent)")
	}
}
