//
//  PictureDetailViewController.swift
//  StickerCove
//
//  Created by Bruce Burgess on 12/24/16.
//  Copyright © 2016 Red Raven Computing Studios. All rights reserved.
//

import UIKit
import PassKit

class PictureDetailViewController: UIViewController, PKPaymentAuthorizationViewControllerDelegate {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var applePayView: UIView!
    
    var email : String? = nil
    
    var picture = Picture()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.nameLabel.text = self.picture.name
        self.priceLabel.text = "$\(self.picture.price)"
        self.imageView.image = self.picture.image
        
        let button : PKPaymentButton
        
        if PKPaymentAuthorizationViewController.canMakePayments() {
            button = PKPaymentButton(type: .buy, style: .black)
        } else {
            button = PKPaymentButton(type: .setUp, style: .black)
        }
        
        self.view.layoutIfNeeded()
        button.addTarget(self, action: #selector(PictureDetailViewController.applePayTapped), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: self.applePayView.frame.size.width, height: self.applePayView.frame.size.height)
        self.applePayView.addSubview(button)
        
        
    }
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, completion: @escaping (PKPaymentAuthorizationStatus) -> Void) {
        //This is where the payment platform is used.
        self.email = payment.shippingContact?.emailAddress
        completion(.success)
    }
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true) {
            if let email = self.email {
                self.performSegue(withIdentifier: "thankYouSegue", sender: email)
                self.email = nil
            }
        }
    }
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didSelect shippingMethod: PKShippingMethod, completion: @escaping (PKPaymentAuthorizationStatus, [PKPaymentSummaryItem]) -> Void) {
        completion(.success, allTheSummaryItems(shippingMethod: shippingMethod))
    }
    
    func allTheSummaryItems(shippingMethod: PKShippingMethod) -> [PKPaymentSummaryItem] {
        let picture = PKPaymentSummaryItem(label: self.picture.name, amount: NSDecimalNumber(string: self.picture.price))
        let shipping = PKPaymentSummaryItem(label: shippingMethod.label, amount: shippingMethod.amount)
        let total = PKPaymentSummaryItem(label: "Sticker Cove", amount: picture.amount.adding(shipping.amount))
        return [picture, shipping, total]
        
    }
    
    func applePayTapped() {
        let request = PKPaymentRequest()
        request.supportedNetworks = [.amex, .visa]
        request.countryCode = "US"
        request.currencyCode = "USD"
        request.merchantIdentifier = "merchant.com.redravencomputing.stickercove"
        request.merchantCapabilities = .capability3DS
        
        request.requiredShippingAddressFields = [.email, .name]
        
        let freeShipping = PKShippingMethod(label: "Free Shipping", amount: NSDecimalNumber(decimal: 0.0))
        freeShipping.identifier = "freeShipping"
        freeShipping.detail = "Usually ships in 5-12 days"
        
        let expressShipping = PKShippingMethod(label: "Expressing Shipping", amount: NSDecimalNumber(decimal: 5.49))
        expressShipping.identifier = "expressShipping"
        expressShipping.detail = "Usually ships in 2-3 days"
        
        let overNightShipping = PKShippingMethod(label: "Overnight Shipping", amount: NSDecimalNumber(decimal: 10.50))
        overNightShipping.identifier = "overNightShipping"
        overNightShipping.detail = "Usually ships in 1 day"
        
        request.shippingMethods = [freeShipping, expressShipping, overNightShipping]

        
        request.paymentSummaryItems = allTheSummaryItems(shippingMethod: freeShipping)
        
        let applePayController = PKPaymentAuthorizationViewController(paymentRequest: request)
        applePayController.delegate = self
        self.present(applePayController, animated: true, completion: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let thankYouVC = segue.destination as? ThankYouViewController {
            if sender != nil {
                if let email = sender as? String {
                    thankYouVC.email = email
                }
            }
        }
    }


}
