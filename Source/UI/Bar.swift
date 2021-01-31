//
//  Bar.swift
//  RangeUISlider
//
//  Created by Fabrizio Duroni on 29/09/2017.
//  2017 Fabrizio Duroni.
//

import Foundation
import UIKit

class Bar: UIView {
    private(set) var leadingConstraint: NSLayoutConstraint!
    private(set) var trailingConstraint: NSLayoutConstraint!
    private(set) var heightConstraint: NSLayoutConstraint!
    private var knobsHitTest: KnobsHitTest!

    func setup(properties: BarProperties, leftKnob: Knob, rightKnob: Knob) -> [NSLayoutConstraint] {
        accessibilityIdentifier = "Bar"
        translatesAutoresizingMaskIntoConstraints = false
        knobsHitTest = KnobsHitTest(leftKnob: leftKnob, rightKnob: rightKnob, parentView: self)
        return createConstraintsUsing(
            leading: properties.leading,
            trailing: properties.trailing,
            height: properties.height
        )
    }

    private func createConstraintsUsing(leading: CGFloat, trailing: CGFloat, height: CGFloat) -> [NSLayoutConstraint] {
        leadingConstraint = MarginConstraintFactory.leading(
            views: ConstraintViews(target: self, related: superview),
            value: leading
        )
        trailingConstraint = MarginConstraintFactory.trailing(
            views: ConstraintViews(target: self, related: superview),
            value: -1.0 * trailing
        )
        heightConstraint = DimensionConstraintFactory.height(target: self, value: height)
        let barConstraints: [NSLayoutConstraint] = [
            leadingConstraint,
            trailingConstraint,
            heightConstraint,
            PositionConstraintFactory.centerX(views: ConstraintViews(target: self, related: superview)),
            PositionConstraintFactory.centerY(views: ConstraintViews(target: self, related: superview))
        ]
        return barConstraints
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if let knobHitted = knobsHitTest.test(point: point, event: event) {
            return knobHitted
        }
        return self
    }
}
