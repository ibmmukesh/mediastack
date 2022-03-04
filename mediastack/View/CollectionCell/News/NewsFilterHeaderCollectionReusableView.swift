//
//  NewsFilterHeaderCollectionReusableView.swift
//  mediastack
//
//  Created by Mukesh Lokare on 04/03/22.
//

import UIKit

class NewsFilterHeaderCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet weak var filterTypeLabel: UILabel!
    
    //MARK: Property Observer
    var title: String? {
        didSet {
            configureCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func configureCell() {
        guard let title = title else { return }
        self.filterTypeLabel.text = title
    }
}
