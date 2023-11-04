//
//  ViewController.swift
//  APOD
//
//  Created by Nata Kuznetsova on 16.10.2023.
//

import UIKit

class FirstScreenViewController: UIViewController {
    
    private var networkService = NetworkService()
    //   private var models: DataImage
    
    
    private var labelTitle: UILabel = {
        let label = UILabel()
        label.text = "APOD Title"
        label.backgroundColor = .green
        label.textAlignment = .center
        return label
    }()
    
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .yellow
        return imageView
    }()
    
    
    private var labelDescriptions: UILabel = {
        let label = UILabel()
        label.text = "APOD Discription"
        label.backgroundColor = .green
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupViews()
      getImage ()
        networkService.getImage { apod in
            print(apod)
        }
    }
    
        func setupViews() {
            view.addSubview(labelTitle)
            view.addSubview(imageView)
            view.addSubview(labelDescriptions)
            setupConstraints()
        }
       
    

    private func setupConstraints() {
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        labelDescriptions.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            labelTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            labelTitle.widthAnchor.constraint(equalToConstant: 200),
            labelTitle.heightAnchor.constraint(equalToConstant: 200),
            
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 10),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            labelDescriptions.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelDescriptions.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            labelDescriptions.widthAnchor.constraint(equalToConstant: 200),
            labelDescriptions.heightAnchor.constraint(equalToConstant: 200),
            
        ])
    }
    
    func getImage(){
        networkService.getImage(completion: {[weak self] result in
            switch result {
            case .success(let apod):
                DispatchQueue.global ().async {
                    if let url = URL (string: apod.hdurl ?? ""), let data = try? Data(contentsOf: url){
                        DispatchQueue.main.async {
                            self?.imageView.image = UIImage(data: data)
                        }
                    }
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self?.showAlert()
                }
            }
        })
    }
}
                                
private extension FirstScreenViewController {
            func showAlert(){
                let alert = UIAlertController(title: "Не удалось получить данные",
                                              message: "Данные актуальны",
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Закрыть", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
        }
