//
//  ImagesVC.swift
//  UtilitiesApp
//
//  Created by Antonio - Raul RICHARD on 11.05.2022.
//

import UIKit

class ImagesVC: UIViewController {
    @IBOutlet weak var collectionView:UICollectionView!

    var imageURLs = [
        "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
        "https://thumbs.dreamstime.com/b/fond-de-coeur-d-amour-d-arc-en-ciel-60045149.jpg",
        "https://helpx.adobe.com/content/dam/help/en/photoshop/using/matching-replacing-mixing-colors/jcr_content/main-pars/before_and_after/image-after/match-outcome3.png"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "ImagesCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "ImagesCollectionViewCell")
        collectionView.dataSource = self
    }
    
    @IBAction func goBack(_ sender: UIButton?){
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addImage(_ sender: UIButton?){
        let alert = UIAlertController(title: "Select image source", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { action in
            self.grabImageFromLibrary()
        }))
        alert.addAction(UIAlertAction(title: "URL", style: .default, handler: { action in
            self.addImageUrl()
        }))
        present(alert, animated: true)
    }

    private func grabImageFromLibrary() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }

    private func addImageUrl() {
        let alertImage = UIAlertController(title: "Add Image", message: "Please provide the image URL", preferredStyle: .alert)

        alertImage.addTextField { (textField) in
            textField.placeholder = "URL"
            textField.returnKeyType = UIReturnKeyType.done;
        }

        alertImage.addAction(UIAlertAction(title: "Submit", style: .default, handler: { [weak alertImage] (_) in
            guard let textField = alertImage?.textFields?[0], let userText = textField.text else { return }
            self.imageURLs.append(userText)
            self.collectionView.reloadData()
        }))

        alertImage.addAction(UIAlertAction(title: "Cancel", style: .default))
        self.present(alertImage, animated: true, completion: nil)
    }
}

extension ImagesVC:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImagesCollectionViewCell", for: indexPath)
        if let cell = cell as? ImagesCollectionViewCell{
            let url = URL(string: imageURLs[indexPath.row])
            cell.configureWith(url: url)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageURLs.count
    }
}

extension ImagesVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageURL = info[.imageURL] as? URL {
            imageURLs.append(imageURL.absoluteString)
            collectionView.reloadData()
        }
        picker.dismiss(animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }

}
