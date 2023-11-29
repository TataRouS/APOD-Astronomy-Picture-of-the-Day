//
//  FavoriteScreenViewController.swift
//  APOD
//
//  Created by Irina on 11.11.2023.
//
  
import UIKit

class FavoriteScreenViewController: UIViewController {

    //MARK: - Private properties

    private var tableView = UITableView(frame: .zero, style: .grouped)

    //MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        setupViews()
        tableView.dataSource = self
    }

    //MARK: - Functions
    
    //MARK: - Private functions

    private func setupViews() {
        view.addSubview(tableView)
        setupConstraints()
    }

    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

extension FavoriteScreenViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = "Hello"
        cell.detailTextLabel?.text = "Date"
        cell.imageView?.image = UIImage(systemName: "person")
        return cell
    }
}
