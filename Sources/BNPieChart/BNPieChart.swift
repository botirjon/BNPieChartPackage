import UIKit



public class BNPieChart: UIView {
    
    private var data: [BNPieChartSlice] = [] {
        didSet {
            setNeedsDisplay()
        }
    }
    
    public var strokeWidth: CGFloat = 0
    public var borderColor: UIColor = .black
    
    public var thickness: CGFloat = 30 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    public override var backgroundColor: UIColor? {
        set {
            super.backgroundColor = .clear
        }
        get {
            super.backgroundColor
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    public convenience init(data: [String: Float]) {
        self.init()
        self.setData(data)
    }
    
    public convenience init(slices: [BNPieChartSlice]) {
        self.init()
    }
    
    private func initView() {
        isOpaque = false
    }
    
    public func setSlices(_ slices: [BNPieChartSlice]) {
        let sum = slices.compactMap { $0.weight }.reduce(0, +)
        
        let zeroSumData: [BNPieChartSlice] = slices.map {
            .init(
                title: $0.title,
                color: $0.color,
                weight: $0.weight
            )
        }
        
        let nonzeroSumData: [BNPieChartSlice] = slices.map {
            .init(
                title: $0.title,
                color: $0.color,
                weight: $0.weight / sum
            )
        }
        
        self.data = sum == 0 ? zeroSumData : nonzeroSumData
    }
    
    public func setData(_ data: [String: Float]) {
        let sum = data.compactMap { $0.value }.reduce(0, +)
        
        let zeroSumData: [BNPieChartSlice] = data.map {
            .init(
                title: $0.key,
                weight: $0.value
            )
        }
        
        let nonzeroSumData: [BNPieChartSlice] = data.map {
            .init(weight: $0.value / sum)
        }.sorted(by: { $0.weight > $1.weight })
        
        self.data = sum == 0 ? zeroSumData : nonzeroSumData
    }

    public override func draw(_ rect: CGRect) {
        let center = rect.center
        let radius = rect.radius-thickness/2
        
        var lastEndAngle: CGFloat = 3 * .pi / 2 // angle of the current slice
        var i: Int = 0 // Iterator for the current slice
        
        data.forEach { slice in
            let angle = slice.share * 2 * .pi
            let startAngle = lastEndAngle
            let candidateEndAngle = startAngle+angle
            
            let endAngle: CGFloat = candidateEndAngle == 2 * .pi ? 2 * .pi : candidateEndAngle.remainder(dividingBy: 2 * .pi)
            
            let path = UIBezierPath(
                arcCenter: center,
                radius: radius,
                startAngle: startAngle,
                endAngle: endAngle,
                clockwise: true)
            
            // 5
            path.lineWidth = thickness
            slice.color.setStroke()
            path.stroke()
            path.close()
            
            lastEndAngle = endAngle
            i = i >= self.data.count ? 0 : i + 1
        }
    }
    
}
