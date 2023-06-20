//
//  CreateDraftOrder.swift
//  Shopify
//
//  Created by Mac on 16/06/2023.
//

import Foundation

func createDraftOrder (draftOrderId:Int,lineItems:[LineItems],customer:Customer) ->MyDraftOrder{
    let draftOrder = DraftOrders(id: draftOrderId,lineItems: lineItems,customer: customer)
    let myDraftOrder = MyDraftOrder(myDraftOrder: draftOrder)
    return myDraftOrder
    
}
