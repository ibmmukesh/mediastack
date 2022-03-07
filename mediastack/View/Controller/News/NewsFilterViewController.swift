//
//  NewsFilterViewController.swift
//  mediastack
//
//  Created by Mukesh Lokare on 04/03/22.
//

import UIKit

class NewsFilterViewController: UIViewController, Storyboarded {
    
    //MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: Instances
    var newsFilterViewModel : NewsFilterViewModelProtocol!
    var arrSelectedCategory = [IndexPath]() // This is selected cell Index array
    var arrSelectedCountry = [IndexPath]() // This is selected cell Index array
    var arrSelectedLanguage = [IndexPath]() // This is selected cell Index array
    
    var onFilterAppy: ((_ category:[String], _ country:[String], _ language:[String]) -> Void)?

    weak var coordinator: MainCoordinator?

    //MARK: - File Constants
    fileprivate struct Constant{
        static let cellIdentifier = "NewsFilterCollectionViewCell"
        static let newsFilterHeaderIdentifier = "NewsFilterHeaderCollectionReusableView"
        static let iPadCellSize = CGSize(width: 200, height: 60)
        static let iPhoneCellSize = CGSize(width: 160, height: 50)
    }
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.configureTableView()
    }
    
    //MARK: - Configure TableView
    
    private func configureTableView(){
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(view: NewsFilterCollectionViewCell.self)
//        self.collectionView.backgroundColor = UIColor.coolWhite
        let filtercell = UINib.init(nibName: Constant.newsFilterHeaderIdentifier, bundle: Bundle.main)
        collectionView.register(filtercell, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.newsFilterHeaderIdentifier)
    }
    
    // MARK: - Navigation
    
    @IBAction func applyButtonClicked(_ sender: Any) {
        
        var category = [String]()
        var country = [String]()
        var language = [String]()
        
        for indexPath in arrSelectedCategory{
            guard let filter = self.newsFilterViewModel.newsFilterModels?[indexPath.section].filters[indexPath.item] else {return}
            category.append(filter)
        }
        
        for indexPath in arrSelectedCountry{
            guard let filter = self.newsFilterViewModel.newsFilterModels?[indexPath.section].filters[indexPath.item] else {return}
            country.append(filter)
        }
        
        for indexPath in arrSelectedLanguage{
            guard let filter = self.newsFilterViewModel.newsFilterModels?[indexPath.section].filters[indexPath.item] else {return}
            language.append(filter)
        }
        self.onFilterAppy?(category,country,language)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func resetButtonClicked(_ sender: Any) {
        
        if arrSelectedCategory.count > 0{
            arrSelectedCategory.removeAll()
        }
        if arrSelectedLanguage.count > 0{
            arrSelectedLanguage.removeAll()
        }
        if arrSelectedCountry.count > 0{
            arrSelectedLanguage.removeAll()
        }
        self.collectionView.reloadData()
    }
}

//MARK: - UICollectionViewDelegate
extension NewsFilterViewController: UICollectionViewDataSource{
   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return newsFilterViewModel.newsFilterModels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsFilterViewModel.newsFilterModels?[section].filters.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:NewsFilterCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.cellIdentifier, for: indexPath) as! NewsFilterCollectionViewCell
        cell.title = self.newsFilterViewModel.detailsForCell(indexPath: indexPath)
        switch indexPath.section{
        case 0:
            if arrSelectedCategory.contains(indexPath){
                cell.subView.backgroundColor = UIColor.coolBlue
            }else{
                cell.subView.backgroundColor = UIColor.clear
            }
            break
        case 1:
            if arrSelectedCountry.contains(indexPath){
                cell.subView.backgroundColor = UIColor.coolBlue
            }else{
                cell.subView.backgroundColor = UIColor.clear
            }
            break
        case 2:
            if arrSelectedLanguage.contains(indexPath){
                cell.subView.backgroundColor = UIColor.coolBlue
            }else{
                cell.subView.backgroundColor = UIColor.clear
            }
            break
        default:
            break
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.collectionView.bounds.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let reusableView: NewsFilterHeaderCollectionReusableView = self.collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.newsFilterHeaderIdentifier, for: indexPath) as! NewsFilterHeaderCollectionReusableView
        reusableView.title = self.newsFilterViewModel.headerTitle(indexPath: indexPath)
        reusableView.backgroundColor = UIColor.lightGray
        return reusableView
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension NewsFilterViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            return Constant.iPadCellSize
        }else{
            return Constant.iPhoneCellSize
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}

//MARK: - UICollectionViewDelegate
extension NewsFilterViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        switch indexPath.section{
        case 0:
            if arrSelectedCategory.contains(indexPath) {
                arrSelectedCategory = arrSelectedCategory.filter { $0 != indexPath}
            }else{
                arrSelectedCategory.append(indexPath)
            }
            break
        case 1:
            if arrSelectedCountry.contains(indexPath) {
                arrSelectedCountry = arrSelectedCountry.filter { $0 != indexPath}
            }else{
                arrSelectedCountry.append(indexPath)
            }
            break
        case 2:
            if arrSelectedLanguage.contains(indexPath) {
                arrSelectedLanguage = arrSelectedLanguage.filter { $0 != indexPath}
            }else{
                arrSelectedLanguage.append(indexPath)
            }
            break
        default:
            break
        }
        self.collectionView.reloadData()
    }
}

