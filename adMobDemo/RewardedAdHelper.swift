//
//  RewardedAdHelper.swift
//  adMobDemo
//
//  Created by Naveen Singh on 19/02/24.
//

import GoogleMobileAds
protocol ExitViewControllerDelegate:AnyObject{
    func getText(exitText:String)
    
}

class RewardedAdHelper : NSObject, GADFullScreenContentDelegate{
    weak var delegate :ExitViewControllerDelegate?
    private var rewardedAd: GADRewardedAd?

    func loadRewardedAd() {
        let request = GADRequest()
        GADRewardedAd.load(withAdUnitID:"ca-app-pub-3940256099942544/1712485313",
                           request: request,
                           completionHandler: { [self] ad, error in
            if let error = error {
                print("Failed to load rewarded ad with error: \(error.localizedDescription)")
                return
            }
            rewardedAd = ad
            print("Rewarded ad loaded.")
 
            rewardedAd?.fullScreenContentDelegate = self
        }
        )
        
        
       
        
        
        
    }
    func adWillDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        delegate?.getText(exitText: "Reward Colleted Successfully")
        loadRewardedAd()
       
    }
    
    func showRewardedAd(viewController:UIViewController)
    {
        if rewardedAd != nil {
            rewardedAd!.present(fromRootViewController : viewController, userDidEarnRewardHandler:{ let reward = self.rewardedAd!.adReward
                print("\(reward.amount) \(reward.type)")
            })
        }
        else{
            print("RewardedAd wasn't ready")
        }
    }
}
