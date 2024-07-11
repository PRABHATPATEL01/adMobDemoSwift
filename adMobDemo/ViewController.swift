//
//  ViewController.swift
//  adMobDemo
//
//  Created by Naveen Singh on 15/02/24.
//


import UIKit
import GoogleMobileAds
import UserMessagingPlatform


class ViewController: UIViewController,GADFullScreenContentDelegate,GADBannerViewDelegate , ExitViewControllerDelegate{
   
    func getText(exitText: String) {
        Lbl.text = exitText
        
        let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "next") as? NewViewController
        self.navigationController?.pushViewController(mapViewControllerObj!, animated: true)
    }
    
    
    
  
//    
   

    
    
    @IBOutlet weak var Interstitial: UIButton!
    
    @IBOutlet weak var Rewarded: UIButton!
    
    
    @IBOutlet weak var viewbck: UIView!
    @IBOutlet weak var Lbl: UILabel!
    
    @IBOutlet weak var viewads: UIView!
    private var rewardedA =  RewardedAdHelper()
   
    var bannerView: GADBannerView!
    private var interstitial: GADInterstitialAd?
    let adSize = GADAdSizeFromCGSize(CGSize(width: 300, height: 50))
    override func viewDidLoad() {
        super.viewDidLoad()
        // Create UMPRequestParameters
       

        
        //reward
    
       rewardedA.loadRewardedAd()
        
        
        bannerView = GADBannerView(adSize: GADAdSizeBanner)
        
        addBannerViewToView(bannerView)
        
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID: "ca-app-pub-3940256099942544/4411468910",
                               request: request,
                               completionHandler: { [self] ad, error in
            if let error = error {
                print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                return
            }
            interstitial = ad
            interstitial?.fullScreenContentDelegate = self
        }
        )
        
        
        
        
        
  
        
        
        
    }
    
    
    
  
   
    

    
    
    // banner
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview(bannerView)
           
           // Constraints to position the banner at the bottom center of the screen
           NSLayoutConstraint.activate([
               bannerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               bannerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
               bannerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               bannerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
           ])
           
           bannerView.contentMode = .scaleToFill 
        // Set content mode to scaleAspectFill
    }

//banner
    
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
      print("bannerViewDidReceiveAd")
    }

    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
      print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
      print("bannerViewDidRecordImpression")
    }

    func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
      print("bannerViewWillPresentScreen")
    }

    func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
      print("bannerViewWillDIsmissScreen")
    }

    func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
      print("bannerViewDidDismissScreen")
    }
    

    





    
    
    
   // interstitial
    
    /// Tells the delegate that the ad failed to present full screen content.
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("Ad did fail to present full screen content.")
    }
    
    /// Tells the delegate that the ad will present full screen content.
    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad will present full screen content.")
    }
    
    /// Tells the delegate that the ad dismissed full screen content.
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad did dismiss full screen content.")
        
    }
    
    
 //reward
    @IBAction func rewardbtn(_ sender: Any) {
        rewardedA.delegate = self
        rewardedA.showRewardedAd(viewController: self)
        
    }
    
    
    
    
    
    //interstitial
    
    @IBAction func interads(_ sender: Any) {

            if interstitial != nil {
                interstitial?.present(fromRootViewController: self)
        } else {
          print("Ad wasn't ready")
        }
    }
    
    
}
 
