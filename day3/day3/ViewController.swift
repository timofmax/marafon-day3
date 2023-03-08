//
//  ViewController.swift
//  day3
//
//  Created by Timofey Privalov on 07.03.2023.
//

import UIKit

final class ViewController: UIViewController {
    
    private let slider = UISlider(frame: CGRect(x: 20, y: 20,
                                                width: 40, height: 40))
    
    private let rectangle: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    private var degree = CGFloat(Double.pi/180)
    
    var sliderMaxValue = Float(UIScreen.main.bounds.width)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupSlider()
        setupRectangle()
        animateView()
    }
    
    private func setupSlider() {
        view.addSubview(slider)
        let marginsGuide = view.layoutMarginsGuide
        slider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            slider.leadingAnchor.constraint(equalTo: marginsGuide.leadingAnchor),
            slider.trailingAnchor.constraint(equalTo: marginsGuide.trailingAnchor),
            slider.centerXAnchor.constraint(equalTo: marginsGuide.centerXAnchor),
            slider.centerYAnchor.constraint(equalTo: marginsGuide.centerYAnchor, constant: -UIScreen.main.bounds.height/4.5)
        ])
        slider.minimumValue = 0
        slider.value = 0
        slider.minimumTrackTintColor = .systemBlue
        slider.tintColor = .lightGray
        slider.thumbTintColor = .white
        slider.addTarget(self, action: #selector(animateView), for: .valueChanged)
        slider.addTarget(self, action: #selector(animateSlider), for: [.touchUpInside, .valueChanged])
    }
    
    private func setupRectangle() {
        view.addSubview(rectangle)
        let marginsGuide = view.layoutMarginsGuide
        rectangle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rectangle.leadingAnchor.constraint(equalTo: marginsGuide.leadingAnchor),
            rectangle.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -UIScreen.main.bounds.height/3),
            rectangle.widthAnchor.constraint(equalToConstant: 80),
            rectangle.heightAnchor.constraint(equalToConstant: 80)
        ])
        rectangle.backgroundColor = .systemBlue
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let viewMargins = view.layoutMargins
        slider.minimumValue = Float(viewMargins.left) + Float(rectangle.bounds.width/2)
        slider.maximumValue = sliderMaxValue - Float(viewMargins.right) - Float(rectangle.bounds.width/2)
    }
    
    @objc
    private func animateView(withDuration duration: TimeInterval = 0.7) {

        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 1,
                       initialSpringVelocity: 1, options: .curveEaseInOut) {
            let current = self.rectangle.center
            self.rectangle.center = CGPoint(x: CGFloat(self.slider.value), y: current.y)
        }
    }
    
    @objc
    private func animateSlider() {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1,
                       initialSpringVelocity: 0, options: .curveEaseInOut) {
            let current = self.rectangle.center
            self.slider.setValue(self.sliderMaxValue, animated: true)
            self.rectangle.center = CGPoint(x: CGFloat(self.slider.value), y: current.y)
        }
    }
    
    func applyMultiple() {
        rectangle.transform = CGAffineTransform(rotationAngle: .pi / 2)
            .concatenating(CGAffineTransform(scaleX: 1.5, y: 1.5))
    }
}

