//
//  ViewController.swift
//  day3
//
//  Created by Timofey Privalov on 07.03.2023.
//

import UIKit

final class ViewController: UIViewController {
    
    // Create a UISlider
    private let slider = UISlider(frame: CGRect(x: 20, y: UIScreen.main.bounds.width/1.8,
                                        width: UIScreen.main.bounds.width - 40, height: 50))
    private let rectangle: UIView = UIView(frame: CGRect(x: 40, y: 140, width: 50, height: 50))
    private var degree = CGFloat(Double.pi/180)
    
    var sliderMaxValue = Float(UIScreen.main.bounds.width)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSlider()
        rectangle.backgroundColor = .systemBlue
        view.addSubview(rectangle)
        animateView()
    }
    
    private func setupSlider() {
        self.view.addSubview(slider)
        slider.minimumValue = 0
        slider.maximumValue = sliderMaxValue
        slider.value = sliderMaxValue
        slider.minimumTrackTintColor = .systemBlue
        slider.tintColor = .lightGray
        slider.thumbTintColor = .white
        slider.addTarget(self, action: #selector(animateView), for: .valueChanged)
    }
    
    @objc
    private func animateView() {
        UIView.animate(withDuration: 0, delay: 0, usingSpringWithDamping: 0,
                       initialSpringVelocity: 1, options: .curveEaseOut) {
            let current = self.rectangle.center
            self.rectangle.center = CGPoint(x: CGFloat(self.slider.value), y: current.y)
        }
    }
    
    override func viewWillLayoutSubviews() {
        animateView()
    }
}

