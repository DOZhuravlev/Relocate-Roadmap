//
//  CustomSlider.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 27.07.2023.
//

import UIKit

final class CustomSlider: UIControl {

    private let ThumbRadius: CGFloat = 12.0
    private let TrackHeight: CGFloat = 4.0

    private let trackLayer = CALayer()
    private let lowerThumbLayer = CALayer()
    private let upperThumbLayer = CALayer()

    var minimumValue: CGFloat = 0
    var maximumValue: CGFloat = 1
    var lowerValue: CGFloat = 0.2 {
            didSet {
                updateLayerFrames()
            }
        }
        var upperValue: CGFloat = 0.8 {
            didSet {
                updateLayerFrames()
            }
        }

    // Кастомные цвета для слайдера
    var trackTintColor: UIColor = UIColor.lightGray {
            didSet {
                trackLayer.backgroundColor = trackTintColor.cgColor
            }
        }

    var thumbTintColor: UIColor = UIColor.white {
            didSet {
                lowerThumbLayer.backgroundColor = thumbTintColor.cgColor
                upperThumbLayer.backgroundColor = thumbTintColor.cgColor
            }
        }

        override init(frame: CGRect) {
            super.init(frame: frame)
            setupLayers()
        }

        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setupLayers()
        }

        private func setupLayers() {
            // Настройка внешнего вида слайдера
            trackLayer.backgroundColor = trackTintColor.cgColor
            lowerThumbLayer.backgroundColor = thumbTintColor.cgColor
            upperThumbLayer.backgroundColor = thumbTintColor.cgColor

            // Круглые элементы слайдера
            lowerThumbLayer.cornerRadius = ThumbRadius
            upperThumbLayer.cornerRadius = ThumbRadius

            // Добавление слоев в иерархию
            layer.addSublayer(trackLayer)
            layer.addSublayer(lowerThumbLayer)
            layer.addSublayer(upperThumbLayer)

            // Настройка распознавателя жестов для обработки перемещения ползунков
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
            addGestureRecognizer(panGesture)
        }

        override func layoutSubviews() {
            super.layoutSubviews()

            // Обновление фреймов слоев при изменении размеров слайдера
            updateLayerFrames()
            lowerValue = boundValue(lowerValue, toLowerValue: minimumValue, upperValue: maximumValue)
            upperValue = boundValue(upperValue, toLowerValue: minimumValue, upperValue: maximumValue)
        }

        private func updateLayerFrames() {
            // Обновление фреймов слоев на основе текущего значения lowerValue и upperValue
            let trackWidth = bounds.width - 2 * ThumbRadius
            let trackOrigin = CGPoint(x: ThumbRadius, y: bounds.height / 2 - TrackHeight / 2)
            trackLayer.frame = CGRect(origin: trackOrigin, size: CGSize(width: trackWidth, height: TrackHeight))

            let lowerThumbCenter = CGPoint(x: positionForValue(lowerValue),
                                           y: bounds.height / 2)
            lowerThumbLayer.frame = CGRect(origin: CGPoint(x: lowerThumbCenter.x - ThumbRadius, y: lowerThumbCenter.y - ThumbRadius),
                                           size: CGSize(width: 2 * ThumbRadius, height: 2 * ThumbRadius))

            let upperThumbCenter = CGPoint(x: positionForValue(upperValue),
                                           y: bounds.height / 2)
            upperThumbLayer.frame = CGRect(origin: CGPoint(x: upperThumbCenter.x - ThumbRadius, y: upperThumbCenter.y - ThumbRadius),
                                           size: CGSize(width: 2 * ThumbRadius, height: 2 * ThumbRadius))
        }

        private func positionForValue(_ value: CGFloat) -> CGFloat {
            // Конвертация значения в координаты на слайдере
            let trackWidth = bounds.width - 2 * ThumbRadius
            return ThumbRadius + (trackWidth * (value - minimumValue)) / (maximumValue - minimumValue)
        }

    @objc private func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
            // Обработчик перемещения ползунка
            let location = gestureRecognizer.location(in: self)
            var newValue = valueForPosition(location.x)

            // Ограничиваем значения, чтобы lowerValue было меньше или равно upperValue и upperValue было больше или равно lowerValue
            if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
                newValue = boundValue(newValue, toLowerValue: minimumValue, upperValue: maximumValue)
                if abs(newValue - lowerValue) < abs(newValue - upperValue) {
                    lowerValue = newValue
                } else {
                    upperValue = newValue
                }

                sendActions(for: .valueChanged)
            }
        }

        private func valueForPosition(_ position: CGFloat) -> CGFloat {
            // Конвертация координат на слайдере в значение
            let trackWidth = bounds.width - 2 * ThumbRadius
            let percentage = (position - ThumbRadius) / trackWidth
            return minimumValue + percentage * (maximumValue - minimumValue)
        }

    private func boundValue(_ value: CGFloat, toLowerValue lower: CGFloat, upperValue upper: CGFloat) -> CGFloat {
        return min(max(value, lower), upper)
    }
}


