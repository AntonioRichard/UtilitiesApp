//
//  ImagesCollectionViewCell.swift
//  UtilitiesApp
//
//  Created by Antonio - Raul RICHARD on 11.05.2022.
//

import UIKit
import SDWebImage

class ImagesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var pictureForCell: UIImageView!

    func configureWith(image:UIImage){
        pictureForCell.image = image
    }

    func configureWith(imageName:String){
        pictureForCell.image = UIImage(named: imageName)
    }

    func configureWith(url: URL?) {
        pictureForCell.sd_setImage(with: url)
    }


}
