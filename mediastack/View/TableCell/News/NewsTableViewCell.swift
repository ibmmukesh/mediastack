//
//  NewsTableViewCell.swift
//  mediastack
//
//  Created by Mukesh Lokare on 02/03/22.
//

import UIKit

class NewsTableViewCell: UITableViewCell, ViewReusable {

    //MARK: - Outlets
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var sourceImageView: UIImageView!
    @IBOutlet weak var publishedLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    
    //MARK: - Instances
    var newsItem:News?  {
        didSet{
            configureCell()
        }
    }
    
    //MARK: - Fileprivate constant
    fileprivate struct Constant{
        static let author = "Author"
        static let category = "Category"
        static let unknown = "Unknown"
        static let googleFavURL = "https://www.google.com/s2/favicons?sz=64&domain="//Google URL to get fav icon based on site. Because source icon image url not given in API response! :)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        newsImageView.image = UIImage(named: AppConstant.imagePlaceholder)
        super.prepareForReuse()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Populate news cell information
    private func configureCell(){
        newsImageView.image = UIImage(named: AppConstant.imagePlaceholder)

        self.sourceLabel.text = newsItem?.source
        self.titleLabel.text = newsItem?.title
        self.descriptionLabel.text = newsItem?.description
        self.categoryLabel.text = newsItem?.category

        self.publishedLabel.text = newsItem?.published_at?.toDate().convertToUTC()

        if let author = newsItem?.author, let source = newsItem?.source{
            self.authorLabel.text = "\(Constant.author): \(author), \(source)"
        }else{
            self.authorLabel.text = "\(Constant.author): \(newsItem?.source ?? Constant.unknown)"
        }
        
        if let category = newsItem?.category{
            self.categoryLabel.text = "\(Constant.category): \(category)"
        }else{
            self.categoryLabel.text = "\(Constant.category): \(Constant.unknown)"
        }
        
        if let imageURLStr = newsItem?.image{
            self.newsImageView.setImage(url: imageURLStr, placeholderImage: UIImage(named: "ImagePlaceholder"))
        }else{
            self.newsImageView.image = UIImage(named: "ImagePlaceholder")
        }
        
        if let imageURLStr = newsItem?.url{
            self.sourceImageView.setImage(url: "\(Constant.googleFavURL)\(imageURLStr)", placeholderImage: UIImage(named: "MediaIcon"))
        }else{
            self.sourceImageView.image = UIImage(named: "MediaIcon")
        }
    }
}
