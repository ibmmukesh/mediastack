//
//  NewsFilterCollectionViewCell.swift
//  mediastack
//
//  Created by Mukesh Lokare on 04/03/22.
//

import UIKit

class NewsFilterCollectionViewCell: UICollectionViewCell, ViewReusable {
    
    @IBOutlet weak var filternameLabel: UILabel!
    @IBOutlet weak var subView: UIView!
    
    //MARK: Property Observer
    var title: String? {
        didSet {
            configureCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setUpView()
    }
    
    private func setUpView(){
        self.filternameLabel.layer.borderWidth = 1.0
        self.filternameLabel.layer.borderColor = UIColor.coolBlue.cgColor
        self.filternameLabel.curveAllCorners(withRadius: 8.0)
        subView.curveAllCorners(withRadius: 8.0)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func configureCell() {
        guard let title = title else { return }
        self.filternameLabel.text = "  \(title)  "
    }
}
