//
//  DetailViewController.swift
//  FriendListAppTest
//
//  Created by 滋野靖之 on 2017/09/27.
//  Copyright © 2017年 Alternated. All rights reserved.
//

import UIKit

class FriendEditViewController: UIViewController {
    
    
    
    

    
    var friend:FriendObject?
    var str=""
    @IBOutlet weak var FriendImageView: UIImageView!
    
    @IBOutlet weak var GenderType: UISegmentedControl!
    
    @IBOutlet weak var Name: UITextField!
    
    @IBOutlet weak var Other1: UITextField!
    
    @IBOutlet weak var Other2: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func editRealm(){
        let dao=RealmBaseDao<FriendObject>()
        self.friend!.image=ConvertImageToData(image: self.FriendImageView.image!)!
        self.friend!.name=self.Name.text!
        self.friend!.other1=self.Other1.text!
        self.friend!.other2=self.Other2.text!
//        newFriend.image=ConvertImageToData(image:self.registImage!)!
        let _ = dao.update(d: self.friend!)
        
    }
  
    @IBAction func editBtn(_ sender: Any) {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.FriendImageView.image=ConvertDataToImage(data: self.friend!.image)
        self.GenderType.selectedSegmentIndex=0
        if(self.friend!.gender=="F"){
            self.GenderType.selectedSegmentIndex=1
        }
        self.Name.text=self.friend!.name
        self.Other1.text=self.friend!.other1
        self.Other2.text=self.friend!.other2
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

