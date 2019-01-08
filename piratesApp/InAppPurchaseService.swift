//
//  InAppPurchaseService.swift
//  piratesApp
//
//  Created by Cody Condon on 2019-01-04.
//  Copyright © 2019 Cody Condon. All rights reserved.
//

import Foundation
import StoreKit
import CoreData

class InAppPurchaseService: NSObject {
    private override init() {}
    static let shared = InAppPurchaseService()
    
    var products = [SKProduct]()
    let paymentQueue = SKPaymentQueue.default()
    
    func getProducts() {
        let products: Set = [InAppPurchase.consumable.rawValue]
        
        let request = SKProductsRequest(productIdentifiers: products)
        request.delegate = self
        request.start()
        paymentQueue.add(self)
    }
    
    func purchase(product: InAppPurchase) {
        guard let productToPurchase = products.filter({$0.productIdentifier == product.rawValue}).first  else {
            return
        }
        let payment = SKPayment(product: productToPurchase)
        paymentQueue.add(payment)
    }
    func restorePurchases() {
        print("restoring purchases")
        paymentQueue.restoreCompletedTransactions()
    }
}

extension InAppPurchaseService: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print(response.products)
        self.products = response.products
        for product in response.products {
            print(product.localizedTitle)
        }
    }
}

extension InAppPurchaseService: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            print(transaction.transactionState.status(), transaction.payment.productIdentifier)
            switch transaction.transactionState {
            case .purchasing: break
            default: SKPaymentQueue.default().finishTransaction(transaction)
            }
        }
    }
}

extension SKPaymentTransactionState {
    func status() -> String {
        switch self {
        case .deferred: return "deffered"
        case .failed: return "failed"
        case .purchased: return "purchased"
        case .purchasing: return "purchasing"
        case .restored: return "restored"
        }
    }
}