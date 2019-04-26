//
//  FatherViewController.swift
//  FatherAndSonView
//
//  Created by QDSG on 2019/4/26.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

class FatherViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        updateView()
    }
    
    private func setupView() {
        setupSegmentedControl()
    }
    
    private func setupSegmentedControl() {
        segmentedControl.removeAllSegments()
        segmentedControl.insertSegment(withTitle: "One", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Two", at: 1, animated: false)
        segmentedControl.addTarget(self, action: #selector(selectionDidChange(_:)), for: .valueChanged)
        
        segmentedControl.selectedSegmentIndex = 0
        
    }
    
    @objc private func selectionDidChange(_ sender: UISegmentedControl) {
        updateView()
    }
    
    private func updateView() {
        if segmentedControl.selectedSegmentIndex == 0 {
            remove(asChildVc: twoVc)
            add(asChildVc: oneVc)
        } else {
            remove(asChildVc: oneVc)
            add(asChildVc: twoVc)
        }
    }
    
    // MARK: - 懒加载
    private lazy var oneVc: OneViewController = {
        let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
        var vc = sb.instantiateViewController(withIdentifier: "OneViewController") as! OneViewController
        add(asChildVc: vc)
        return vc
    }()
    
    private lazy var twoVc: TwoViewController = {
        let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
        var vc = sb.instantiateViewController(withIdentifier: "TwoViewController") as! TwoViewController
        add(asChildVc: vc)
        return vc
    }()
}

extension FatherViewController {
    private func add(asChildVc viewController: UIViewController) {
        addChild(viewController)
        view.addSubview(viewController.view)
        
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        viewController.didMove(toParent: self)
    }
    
    private func remove(asChildVc viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
}

