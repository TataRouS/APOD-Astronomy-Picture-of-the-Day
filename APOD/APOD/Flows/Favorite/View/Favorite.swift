//
//  FavoriteScreenViewController.swift
//  APOD
//
//  Created by Irina on 11.11.2023.
//
  
//import UIKit
//
//class FavoriteScreenViewController: UIViewController {
//
//    //MARK: - Private properties
//
//    private var tableView = UITableView(frame: .zero, style: .grouped)
//
//    //MARK: - Life cycle
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = UIColor.white
//        navigationItem.title = "Table"
//        navigationController?.navigationBar.prefersLargeTitles = true
//
//        setupViews()
//        tableView.dataSource = self
//        //tableView.delegate = self
//    }
//
//    //MARK: - Functions
//
//    //MARK: - Private functions
//
//    private func setupViews() {
//        view.addSubview(tableView)
//        setupConstraints()
//    }
//
//    private func setupConstraints() {
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//        ])
//    }
//}
//
//extension FavoriteScreenViewController: UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        3
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
//        cell.textLabel?.text = "Hello"
//        cell.detailTextLabel?.text = "Date"
//        cell.imageView?.image = UIImage(systemName: "person")
//        return cell
//    }
//}

import UIKit

class Favorite: UITableViewController {
    
    private var models: [DataImage] = []
    private var fileCache = FileFavoriteCache()
    
    override func viewDidLoad() {
        print("TableFavorite")
        super.viewDidLoad()
        models = fileCache.fetchPictures()
        tableView.reloadData()
        title = "Favorite"
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: "Cell")
        
       // refreshControl = UIRefreshControl()
      //  refreshControl?.addTarget(self, action: #selector(update), for: .valueChanged)
    }
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        guard let cell = cell as? FavoriteCell else {
            return UITableViewCell()
        }
        let model = models[indexPath.row]
        DispatchQueue.global ().async {
                        if let url = URL (string: model.hdurl ?? ""), let data = try?
                            Data(contentsOf: url)
                            {
                            DispatchQueue.main.async {
                              //  self.picture.image = UIImage(data: data)
                                let picture =  UIImage(data: data)
                                cell.setupTextLabel(apod: model, picture: ((picture ?? UIImage(systemName: "star"))!))
                            }
                        }
            }
        //   cell.setupTextLabel(apod: model)
        
        return cell
        
    }
    
//    func updateView(friendsList: [DataFriend]) {
//        self.models = friendsList
//        DispatchQueue.main.async {
//            self.tableView.reloadData()
//        }
//        DispatchQueue.main.async {
//            self.refreshControl?.endRefreshing()
//        }
//    }
//
//    func showError(error: Error, date: Date) {
//        print("Error here: ", error)
//        DispatchQueue.main.async {
//            self.showAlert(date: date)
//        }
//    }
//
//    @objc func update() {
//        updateView(friendsList: self.models)
//    }
//
}


