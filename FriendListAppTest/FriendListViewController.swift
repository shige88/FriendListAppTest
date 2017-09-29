//
//  SecondViewController.swift
//  FriendListAppTest
//
//  Created by 滋野靖之 on 2017/09/23.
//  Copyright © 2017年 Alternated. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift

//オプショナル型宣言の?と!...例えばlet str:String? と宣言した場合、
//このstrには文字列とnilを入力できる。しかし、このままstrを呼び出しても、
//オプショナル型であるため、文字列として操作できない。そこで、呼び出す際は、
//!strとしてアンラップする。（文字列型に戻す）
//宣言時にlet str:String!としていた場合は、呼び出す時に!をつける必要がない
class FriendListViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var FriendListView: UITableView!
   
    //変数FriendObjectsを呼び出すと、DBからFriendObjectの一覧がResults型で返される
    var FriendObjects:Results<FriendObject>?{
        do{
            let dao = RealmBaseDao<FriendObject>()
            return dao.findAll()
        }
    }
    
    //表示するセルの数を指定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FriendObjects!.count
    }
    //セルに値を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得する
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        
        // セルに表示する値を設定する.今回は名前
        cell.textLabel!.text = "  "+FriendObjects![indexPath.row].name
        let FriendImage=ConvertDataToImage(data: FriendObjects![indexPath.row].image)
        cell.imageView?.image = FriendImage?.ResizeÜIImage(width: 80, height: 80)
        return cell
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        FriendListView.delegate=self
        FriendListView.dataSource=self
    }
    override func viewWillAppear(_ animated: Bool) {
        FriendListView.reloadData()
        FriendListView.rowHeight=80
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

