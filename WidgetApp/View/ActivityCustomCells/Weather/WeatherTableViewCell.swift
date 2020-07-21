//
//  WeatherTableViewCell.swift
//  WidgetApp
//
//  Created by Bassuni on 7/19/20.
//  Copyright © 2020 futureface. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet var headerImageView: UIImageView!
    @IBOutlet var headerTitleLabel: UILabel!
    @IBOutlet var editButton: UIButton!

    @IBOutlet var degreeLabel: UILabel!
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var weatherImgView: UIImageView!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var weatherLabel: UILabel!
    


    var weatherCellViewModel : WeatherCellViewModel? {
              didSet {
                   headerTitleLabel.text = weatherCellViewModel?.titleText
                  headerImageView.image = UIImage(named: weatherCellViewModel?.imageName ?? "")
                degreeLabel.text = weatherCellViewModel?.degree
                dayLabel.text = weatherCellViewModel?.day
                weatherImgView.image = UIImage(named: weatherCellViewModel?.weatherImageName ?? "")
                locationLabel.text = weatherCellViewModel?.location
                weatherLabel.text = weatherCellViewModel?.weatherText

                collectionView.reloadData()
              }
          }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        collectionView.dataSource = self
        collectionView.delegate = self

        let flowLayout = UICollectionViewFlowLayout()
               flowLayout.scrollDirection = .horizontal
               flowLayout.itemSize = CGSize(width: 70, height: 180)
               flowLayout.minimumLineSpacing = 2.0
               flowLayout.minimumInteritemSpacing = 5.0
               self.collectionView.collectionViewLayout = flowLayout
               self.collectionView.showsHorizontalScrollIndicator = false

        

        let cellNib = UINib(nibName: "WeatherCollectionViewCell", bundle: nil)
        self.collectionView.register(cellNib, forCellWithReuseIdentifier: "WeatherCell")
    }    
    
}



extension WeatherTableViewCell : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

       return weatherCellViewModel?.weatherDataCellViewmodel.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = getWeatherCell(indexPath: indexPath)
        cell.weatherDataViewModel = weatherCellViewModel?.weatherDataCellViewmodel[indexPath.row]
        return cell
    }


     func numberOfSections(in collectionView: UICollectionView) -> Int {
        // 1
        return 1
    }

//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        guard let collectionView = collectionView else {
//            return
//        }
//
//
//
//    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {


        cell.alpha = 0.3
          UIView.animate(withDuration: 0.8) {
              cell.alpha = 1
          }


    }

    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 1


    }



    func getWeatherCell(indexPath: IndexPath ) -> WeatherCollectionViewCell{
           guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath) as? WeatherCollectionViewCell else {
           fatalError("Cell not exists in storyboard")}
          return cell
       }
}
