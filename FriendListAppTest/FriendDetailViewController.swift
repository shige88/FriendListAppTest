//
//  DetailViewController.swift
//  FriendListAppTest
//
//  Created by 滋野靖之 on 2017/09/27.
//  Copyright © 2017年 Alternated. All rights reserved.
//

import UIKit
import RealmSwift

class FriendDetailViewController: UIViewController {

    @IBOutlet weak var FriendImageView: UIImageView!
    
    
    //モーダルビューの場合はexitにつなげても戻れない。
//    @IBAction func closeWindow(_ sender: UIBarButtonItem) {
//        self.dismiss(animated: true, completion: nil)
//
//    }
    
    var friend:FriendObject?
    var str=""
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        FriendImageView.isUserInteractionEnabled=true
        FriendImageView.tag=1
        // Do any additional setup after loading the view.
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        for touch: UITouch in touches {
            let tag = touch.view!.tag
            switch tag {
            case 1:
                print("tapped")
                let alert: UIAlertController = UIAlertController(title: "プロフィール", message: self.str, preferredStyle:  UIAlertControllerStyle.alert)
                
                let defaultAction: UIAlertAction = UIAlertAction(title: "編集", style: UIAlertActionStyle.default, handler:{
                    (action: UIAlertAction!) -> Void in
                    print("編集")
                    self.performSegue(withIdentifier: "goEdit", sender: nil)
                })
                let defaultAction2: UIAlertAction = UIAlertAction(title: "削除", style: UIAlertActionStyle.default, handler:{
                    (action: UIAlertAction!) -> Void in
                    print("削除")
                })
                let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.cancel, handler:{
                    (action: UIAlertAction!) -> Void in
                    print("Cancel")
                })
                
                alert.addAction(cancelAction)
                alert.addAction(defaultAction)
                alert.addAction(defaultAction2)
                
                present(alert, animated: true, completion: nil)
            default:
                break
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier=="goEdit"){
            let NextVC:FriendEditViewController=(segue.destination as! FriendEditViewController)
            NextVC.friend=self.friend!
            NextVC.FriendImageView=self.FriendImageView
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate;
        FriendImageView.image=ConvertDataToImage(data: (friend!.image))!
        str="[氏名]:" + friend!.name + "\n" +
            "[性別]:" + friend!.gender + "\n" +
            "[その他1]:" + friend!.other1 + "\n" +
            "[その他2]:" + friend!.other2
        
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
