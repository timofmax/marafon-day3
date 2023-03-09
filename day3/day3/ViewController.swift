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
    private var originViewSize: CGRect = .zero
    private var sliderMaxValue = Float(UIScreen.main.bounds.width)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(slider)
        view.addSubview(rectangle)
        let marginsGuide = view.layoutMarginsGuide
        slider.translatesAutoresizingMaskIntoConstraints = false
        rectangle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            slider.leadingAnchor.constraint(equalTo: marginsGuide.leadingAnchor),
            slider.trailingAnchor.constraint(equalTo: marginsGuide.trailingAnchor),
            slider.centerXAnchor.constraint(equalTo: marginsGuide.centerXAnchor),
            slider.centerYAnchor.constraint(equalTo: marginsGuide.centerYAnchor, constant: -UIScreen.main.bounds.height/7),
            rectangle.leadingAnchor.constraint(equalTo: marginsGuide.leadingAnchor),
            rectangle.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -UIScreen.main.bounds.height/3),
            rectangle.widthAnchor.constraint(equalToConstant: 80),
            rectangle.heightAnchor.constraint(equalToConstant: 80)
        ])
        slider.minimumValue = 0
        slider.value = 0
        slider.minimumTrackTintColor = .systemBlue
        slider.tintColor = .lightGray
        slider.thumbTintColor = .white
        slider.addTarget(self, action: #selector(animateView), for: .valueChanged)
        slider.addTarget(self, action: #selector(animateSlider), for: .touchUpInside)
        rectangle.backgroundColor = .systemBlue
        rectangle.layer.masksToBounds = true
        rectangle.layer.cornerRadius = 10
    }
    
    @objc
    private func animateView() {
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveLinear], animations: { [self] in
            let first = CGAffineTransform(rotationAngle: (.pi / 2) * CGFloat(slider.value))
            let second = CGAffineTransform(scaleX: 1 + CGFloat(slider.value / 2), y: 1 + CGFloat(slider.value / 2))
            let third = CGAffineTransform(translationX: originViewSize.minX + (CGFloat(slider.value) * ((view.frame.width - 8) - rectangle.frame.width)), y: originViewSize.minY + CGFloat(CGFloat(slider.value) * ((rectangle.frame.width - originViewSize.width) / 2)))
            rectangle.transform = CGAffineTransformConcat(CGAffineTransformConcat(second, first), third )
        })
    }
    
    @objc
    private func animateSlider() {
        Timer.scheduledTimer(withTimeInterval: 0.005, repeats: true) { [self] timer in
            let range =  slider.maximumValue - slider.minimumValue
            let step = range/200
            let nextStep = slider.value + step
            if step <= slider.maximumValue && slider.value != slider.maximumValue {
                slider.setValue(nextStep, animated: true)
                animateView()
            } else {
                timer.invalidate()
            }
        }
    }
}

