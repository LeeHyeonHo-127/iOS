import UIKit

class GradientColorView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradient()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupGradient()
    }

    private func setupGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 1, green: 0, blue: 0, alpha: 1).cgColor,
            UIColor(red: 1, green: 0.54, blue: 0, alpha: 1).cgColor,
            UIColor(red: 1, green: 0.9, blue: 0, alpha: 1).cgColor,
            UIColor(red: 0.08, green: 1, blue: 0, alpha: 1).cgColor,
            UIColor(red: 0, green: 0.64, blue: 1, alpha: 1).cgColor,
            UIColor(red: 0.02, green: 0, blue: 1, alpha: 1).cgColor,
            UIColor(red: 0.68, green: 0, blue: 1, alpha: 1).cgColor,
            UIColor(red: 1, green: 0, blue: 0.78, alpha: 1).cgColor,
            UIColor(red: 1, green: 0, blue: 0, alpha: 1).cgColor
        ]

        // You can customize the start and end points if needed
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)

        gradientLayer.frame = self.bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
