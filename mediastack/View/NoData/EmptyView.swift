//
//  EmptyView.swift
//  mediastack
//
//  Created by Mukesh Lokare on 03/03/22.
//

import UIKit
protocol EmptyViewDelegate: AnyObject{
    func refreshClicked()
}

class EmptyView: UIView {

    //MARK: Outlets
    @IBOutlet weak var noDataImageView: UIImageView!
    @IBOutlet private weak var refreshButton: UIButton!
    @IBOutlet private weak var messageLabel: UILabel!
    
    //MARK: Instances
    var emptyType:EmptyViewType = .noInternet
    
    weak var delegate: EmptyViewDelegate? //Used weak to avoid the retain cycle
    
    //MARK: Fileprivate constant
        fileprivate struct Constant{
            static let emptyViewNib = "EmptyView"
            static let serverGenericMessage = "Something went wrong"
    }
    
    override private init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    
    // MARK: - Private Methods
    
    func commonInit(){
        let viewFromXib = Bundle.main.loadNibNamed(Constant.emptyViewNib, owner: self, options: nil)![0] as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
    }
    
    internal func setUpEmptyView(_ error: ApiError? = nil) {
        self.refreshButton.curveAllCorners(withRadius: 8.0)
        switch emptyType{
        case .noInternet:
            messageLabel.text = AppConstant.noInternet
            self.noDataImageView.image = UIImage(named: AppConstant.noInternetIcon)
            break
        case .noData:
            if let apiError = error{
                messageLabel.text = apiError.message
            }else{
                messageLabel.text = AppConstant.noData
            }
            self.noDataImageView.image = UIImage(named: AppConstant.imagePlaceholder)
            break
        case .serverError:
            if let apiError = error{
                messageLabel.text = apiError.message
            }else{
                messageLabel.text = Constant.serverGenericMessage
            }
            self.noDataImageView.image = UIImage(named: AppConstant.imagePlaceholder)
            break
        }
    }
    
    // MARK: - Button Action

    @IBAction func refreshClicked(_ sender: Any) {
        self.delegate?.refreshClicked()
        self.removeFromSuperview()
    }
}
