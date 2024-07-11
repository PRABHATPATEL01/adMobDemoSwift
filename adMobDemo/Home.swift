//
//  Home.swift
//  adMobDemo
//
//  Created by Naveen Singh on 23/02/24.
//

import UIKit
import GoogleMobileAds
import UserMessagingPlatform

class Home: UIViewController {
    
    private var isMobileAdsStartCalled = false
    
    @IBOutlet weak var privacySettingsButton: UIButton!
    
    var isPrivacyOptionsRequired: Bool {
        return UMPConsentInformation.sharedInstance.privacyOptionsRequirementStatus == .required
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    @IBAction func privacySettingsTapped(_ sender: Any) {
        
        let parameters = UMPRequestParameters()
                UMPConsentInformation.sharedInstance.requestConsentInfoUpdate(with: parameters) {_ in
              

                    UMPConsentForm.loadAndPresentIfRequired(from: self) {_ in
                    
                        self.privacySettingsButton.isEnabled = self.isPrivacyOptionsRequired
                  }
                }
                // Example value: "1111111111"
                let purposeConsents = UserDefaults.standard.string(forKey: "IABTCF_PurposeConsents")
                // Purposes are zero-indexed. Index 0 contains information about Purpose 1.
                let hasConsentForPurposeOne = purposeConsents?.first == "1"
                
                //GDPR
                
                // Request an update for the consent information.
                UMPConsentInformation.sharedInstance.requestConsentInfoUpdate(with: nil) {
                    [weak self] requestConsentError in
                    guard let self else { return }
                    
                    if let consentError = requestConsentError {
                        // Consent gathering failed.
                        return print("Error: \(consentError.localizedDescription)")
                    }
                    
                    UMPConsentForm.loadAndPresentIfRequired(from: self) {
                        [weak self] loadAndPresentError in
                        guard let self else { return }
                        
                        if let consentError = loadAndPresentError {
                            // Consent gathering failed.
                            return print("Error: \(consentError.localizedDescription)")
                        }
                        
                        // Consent has been gathered.
                        if UMPConsentInformation.sharedInstance.canRequestAds {
                            self.startGoogleMobileAdsSDK()
                        }
                    }
                    
                    if UMPConsentInformation.sharedInstance.canRequestAds {
                        startGoogleMobileAdsSDK()
                    }
                    
                }
                
            
                let debugSettings = UMPDebugSettings()
                debugSettings.testDeviceIdentifiers = ["TEST-DEVICE-HASHED-ID"]
                debugSettings.geography = .EEA
                parameters.debugSettings = debugSettings
                // Include the UMPRequestParameters in your consent request.
             
                UMPConsentInformation.sharedInstance.reset()
    }
    
    func startGoogleMobileAdsSDK() {
        
        DispatchQueue.main.async {
            guard !self.isMobileAdsStartCalled else { return }
            self.isMobileAdsStartCalled = true
            print("Consent set")
            // Initialize the Google Mobile Ads SDK.
         
            // Instantiate the next view controller from storyboard
            let storyboard = UIStoryboard(name: "Main", bundle: nil) // Replace "Main" with your storyboard name
            let nextViewController = storyboard.instantiateViewController(withIdentifier: "ViewController")
            
            // Present the next view controller
            self.navigationController?.pushViewController(nextViewController, animated: true)
            
    
            
            
        }
    }
    
}
