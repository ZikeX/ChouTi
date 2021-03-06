//
//  Created by Honghao Zhang on 08/16/2016.
//  Copyright © 2018 ChouTi. All rights reserved.
//

import ChouTi
import Foundation

class ViewControllersSection: NSObject, TableViewSectionType {
    var headerTitle: String? = "View Controller Containers"
    var rows: [TableViewRowType] = []

    let animator = FadeInPresentingAnimator()

    override init() {
        super.init()

        rows.append(
            TableViewRow(title: "SlideController",
                         subtitle: "Has Left/Right Menu View Controller",
                         cellSelectAction: { indexPath, cell, tableView in
                            cell?.tableView?.deselectRow(at: indexPath, animated: true)

                            let centerVC = CenterViewController(nibName: "CenterViewController", bundle: nil)
                            centerVC.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Left", style: .done, target: self, action: #selector(ViewControllersSection.expandLeft(_:)))
                            centerVC.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Right", style: .done, target: self, action: #selector(ViewControllersSection.expandRight(_:)))
                            centerVC.title = "Slide Controller"

                            let centerNavi = UINavigationController(rootViewController: centerVC)

                            let leftVC = DummyViewController(label: "Left")
                            let rightVC = DummyViewController(label: "Right")

                            let slideViewController = SlideController(centerViewController: centerNavi, leftViewController: leftVC, rightViewController: rightVC)
                            self.slideViewController = slideViewController

                            slideViewController.animationDuration = 0.25
                            slideViewController.springDampin = 1.0

                            slideViewController.statusBarBackgroundColor = UIColor.white
                            slideViewController.leftRevealWidth = 200
                            slideViewController.rightRevealWidth = 100

                            slideViewController.shouldExceedRevealWidth = false

                            centerVC.slideViewController = slideViewController
                            centerVC.leftViewController = leftVC
                            centerVC.rightViewController = rightVC

                            slideViewController.modalPresentationStyle = .custom
                            slideViewController.transitioningDelegate = self.animator

                            cell?.tableView?.presentingViewController?.present(slideViewController, animated: true, completion: nil)
            })
        )

        rows.append(
            TableViewRow(title: "Page View Controller",
                         subtitle: "Paging View Controller",
                         cellSelectAction: { indexPath, cell, tableView in
                            cell?.tableView?.deselectRow(at: indexPath, animated: true)
                            cell?.tableView?.presentingViewController?.show(PageViewDemoController(), sender: nil)
            })
        )

        rows.append(
            TableViewRow(title: "Menu Page View Controller",
                         subtitle: "Paging View Controller with Top Menus",
                         cellSelectAction: { indexPath, cell, tableView in
                            cell?.tableView?.deselectRow(at: indexPath, animated: true)
                            cell?.tableView?.presentingViewController?.show(MenuPageDemoViewController(), sender: nil)
            })
        )
    }

    var slideViewController: SlideController!

    @objc
    func expandLeft(_ sender: AnyObject) {
        slideViewController.toggleLeftViewController()
    }

    @objc
    func expandRight(_ sender: AnyObject) {
        slideViewController.toggleRightViewController()
    }
}
