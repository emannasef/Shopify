//
//  CreateDraftOrder.swift
//  Shopify
//
//  Created by Mac on 16/06/2023.
//

import Foundation

func createDraftOrder (draftOrderId:Int,lineItems:[LineItems]) ->MyDraftOrder{
    let draftOrder = DraftOrders(id: draftOrderId,lineItems: lineItems)
    let myDraftOrder = MyDraftOrder(myDraftOrder: draftOrder)
    return myDraftOrder
    
}
