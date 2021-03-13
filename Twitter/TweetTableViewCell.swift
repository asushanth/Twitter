//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Adarsh Sushanth on 3/6/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var tweetContentLabel: UILabel!
    
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
    
    var favorited: Bool = false
    var tweetId:Int = -1
    //var retweeted:Bool = false
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            self.setRetweeted(true)
        }, failure: { (error) in
            print("did not retweet \(error)")
        })
    }
    
    func setRetweeted(_ isRetweeted: Bool){
        if(isRetweeted){
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        }
        else{
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
    }
    
    func setFavorite(_ isFavorited: Bool){
        favorited =  isFavorited
        if(favorited){
            likeButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        }
        else{
            likeButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    
    @IBAction func like(_ sender: Any) {
        let tobeFavorited = !favorited
        if(tobeFavorited){
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(true)
            }, failure: { (error) in
                print("favorite did not work \(error)")
            })
        }
        else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(false)
            }, failure: { (error) in
                print("unfavorite did not succeed: \(error)")
            })
        }
    }
}
