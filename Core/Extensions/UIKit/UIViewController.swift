//
//  UIViewController.swift
//  Core
//
//  Created by Guido Marucci Blas on 5/7/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    /**
     Loads the childViewController into the specified containerView.
     
     It can be done after self's view is initialized, as it uses constraints to determine the childViewController size.
     Take into account that self will retain the childViewController, so if for any other reason the childViewController is retained in another place, this would
     lead to a memory leak. In that case, one should call unloadViewController().
     
     - parameter childViewController: The controller to load.
     - parameter into: The containerView into which the controller will be loaded.
     - parameter viewPositioning: Back or Front. Default: Front
     */
    public func load(childViewController: UIViewController, into containerView: UIView, viewPositioning: ViewPositioning = .front) {
        childViewController.willMove(toParentViewController: self)
        addChildViewController(childViewController)
        childViewController.didMove(toParentViewController: self)
        childViewController.view.add(into: containerView, in: viewPositioning)
    }
    
    /**
     Unloads a childViewController and its view from its parentViewController.
     */
    public func unloadFromParentViewController() {
        view.removeFromSuperview()
        removeFromParentViewController()
    }
    
    /**
     Unloads all childViewController and their view from self.
     */
    public func unloadChildViewControllers() {
        for childController in self.childViewControllers {
            childController.unloadFromParentViewController()
        }
    }
    
}

//MARK: - Navigation Bar

public extension UIViewController {

    /**
     Configures the navigation bar to have a back button with a particular image.
     - parameter backImage: The image of the back button.
     - warning: This function must be called when self is inside a navigation controller. If not it will arise a runtime nil-force-unwrapping error.
     */
    func configureBasicNavigationBarWithBackButton(backImage: UIImage) {
        navigationController!.navigationBar.topItem?.title = ""
        navigationController!.navigationBar.backIndicatorImage = backImage
        navigationController!.navigationBar.backIndicatorTransitionMaskImage = backImage
    }
    
    /**
     Configures the navigation bar color.
     - parameter color: The new color of the navigation bar.
     - warning: This function must be called when self is inside a navigation controller. If not it will arise a runtime nil-force-unwrapping error.
     */
    func configureNavigationBarColor(_ color: UIColor) {
        navigationController!.navigationBar.barTintColor = color
    }
    
    /**
     Sets a collection of buttons as the navigation bar left buttons.
     - parameter buttons: the Array of buttons to use.
     */
    func configureNavigationLeftButtons(_ buttons: [UIBarButtonItem]) {
        navigationItem.leftBarButtonItems = buttons
    }
    
    /**
     Sets a collection of buttons as the navigation bar right buttons.
     - parameter buttons: the Array of buttons to use.
     */
    func configureNavigationRightButtons(_ buttons: [UIBarButtonItem]) {
        navigationItem.rightBarButtonItems = buttons
    }

    /**
     Adds and configures a label to use as title of the navigation bar.
     - parameter title: the string of the label.
     - parameter font: the font to use for the label. Default: .systemFont size 18
     - parameter color: the color of the text. Default: .white
     */
    func setNavBarTitle(_ title: String, font: UIFont, color: UIColor) {
        let label = UILabel(frame: .zero)
        label.backgroundColor = .clear
        label.font = font
        label.textColor = color
        label.adjustsFontSizeToFitWidth = true
        label.text = title
        label.sizeToFit()
        navigationItem.titleView = label
    }
    
}
