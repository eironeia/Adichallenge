//  Source: https://github.com/bhlvoong/LBTAComponents/blob/master/LBTAComponents/Classes/UIView%2BAnchors.swift
import UIKit

extension UIView {
    func addSubviewWithAutolayout(_ view: UIView) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
    }

    func fillSuperview(withEdges edges: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
        guard let superView = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: edges.left),
            trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -edges.right),
            topAnchor.constraint(equalTo: superView.topAnchor, constant: edges.top),
            bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -edges.bottom)
        ])
    }

    func fillSuperview(withPadding padding: CGFloat) {
        guard let superView = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: padding),
            trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -padding),
            topAnchor.constraint(equalTo: superView.topAnchor, constant: padding),
            bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -padding)
        ])
    }

    func anchor(
        top: NSLayoutYAxisAnchor? = nil,
        leading: NSLayoutXAxisAnchor? = nil,
        bottom: NSLayoutYAxisAnchor? = nil,
        trailing: NSLayoutXAxisAnchor? = nil,
        topConstant: CGFloat = 0,
        leadingConstant: CGFloat = 0,
        bottomConstant: CGFloat = 0,
        trailingConstant: CGFloat = 0,
        widthConstant: CGFloat? = nil,
        heightConstant: CGFloat? = nil
    ) {
        translatesAutoresizingMaskIntoConstraints = false
        var anchors = [NSLayoutConstraint]()
        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }
        if let leading = leading {
            anchors.append(leadingAnchor.constraint(equalTo: leading, constant: leadingConstant))
        }
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
        }
        if let trailing = trailing {
            anchors.append(trailingAnchor.constraint(equalTo: trailing, constant: -trailingConstant))
        }
        if let widthConstant = widthConstant {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }
        if let heightConstant = heightConstant {
            anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }

        NSLayoutConstraint.activate(anchors)
    }

    func anchorGreaterThan(
        top: NSLayoutYAxisAnchor? = nil,
        leading: NSLayoutXAxisAnchor? = nil,
        bottom: NSLayoutYAxisAnchor? = nil,
        trailing: NSLayoutXAxisAnchor? = nil,
        topConstant: CGFloat = 0,
        leadingConstant: CGFloat = 0,
        bottomConstant: CGFloat = 0,
        trailingConstant: CGFloat = 0,
        widthConstant: CGFloat? = nil,
        heightConstant: CGFloat? = nil
    ) {
        translatesAutoresizingMaskIntoConstraints = false
        var anchors = [NSLayoutConstraint]()
        if let top = top {
            anchors.append(topAnchor.constraint(greaterThanOrEqualTo: top, constant: topConstant))
        }
        if let leading = leading {
            anchors.append(leadingAnchor.constraint(greaterThanOrEqualTo: leading, constant: leadingConstant))
        }
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(greaterThanOrEqualTo: bottom, constant: -bottomConstant))
        }
        if let trailing = trailing {
            anchors.append(trailingAnchor.constraint(greaterThanOrEqualTo: trailing, constant: -trailingConstant))
        }
        if let widthConstant = widthConstant {
            anchors.append(widthAnchor.constraint(greaterThanOrEqualToConstant: widthConstant))
        }
        if let heightConstant = heightConstant {
            anchors.append(heightAnchor.constraint(greaterThanOrEqualToConstant: heightConstant))
        }

        NSLayoutConstraint.activate(anchors)
    }

    func anchor(
        width: NSLayoutDimension? = nil,
        widthMultiplier: CGFloat = 1,
        widthOffet: CGFloat = 0,
        height: NSLayoutDimension? = nil,
        heightMultiplier: CGFloat = 1,
        heightOffset: CGFloat = 0
    ) {
        translatesAutoresizingMaskIntoConstraints = false

        var anchors = [NSLayoutConstraint]()

        if let width = width {
            anchors.append(widthAnchor.constraint(
                equalTo: width,
                multiplier: widthMultiplier,
                constant: widthOffet
            )
            )
        }

        if let height = height {
            anchors.append(heightAnchor.constraint(
                equalTo: height,
                multiplier: heightMultiplier,
                constant: heightOffset
            )
            )
        }

        NSLayoutConstraint.activate(anchors)
    }

    func anchorCenterXToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }
    }

    func anchorCenterYToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }
    }

    func anchorCenterSuperview() {
        anchorCenterXToSuperview()
        anchorCenterYToSuperview()
    }

    var layoutGuideBottomAnchor: NSLayoutYAxisAnchor {
        var bottomAnchor = layoutMarginsGuide.bottomAnchor

        if #available(iOS 11.0, *) {
            bottomAnchor = self.safeAreaLayoutGuide.bottomAnchor
        }

        return bottomAnchor
    }
}
